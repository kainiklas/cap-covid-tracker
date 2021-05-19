const cds = require("@sap/cds");

module.exports = cds.service.impl(function () {
  this.before("READ", "Countries", async (req, next) => {
    const { Migrations, Countries } = this.entities;

    // check if filled; then no need to execute
    let migrations = await SELECT.from(Migrations).where({
      table: "Countries",
      selector: "summary",
    });

    if (migrations.length !== 0) {
      return;
    }

    // delete all countries
    await DELETE.from(Countries);

    // fetch daily summary from covid API
    const Covid19Api = await cds.connect.to("Covid19Api");
    var countries = await Covid19Api.run(req.query);

    // insert summary into Countries table
    await INSERT.into(Countries).entries(countries);

    // remember the data fetch
    await INSERT.into(Migrations).entries({
      table: "Countries",
      selector: "summary",
      date: Date.now(),
    });

    return;
  });

  this.before("READ", "Countries/CountryHistoryDetails", async (req) => {
    const { Migrations, CountryHistoryDetails } = this.entities;

    let country = req.params[0].Country;

    // check if filled; then no need to execute
    let migrations = await SELECT.from(Migrations).where({
      table: "CountryHistoryDetails",
      selector: country,
    });

    if (migrations.length !== 0) {
      return;
    }

    // delete all history information
    try {
      await DELETE.from(CountryHistoryDetails).where({ Country: country });
    } catch (e) {}

    // fetch daily summary from covid API
    const Covid19Api = await cds.connect.to("Covid19Api");
    var countryHistoryDetails = await Covid19Api.run(req.query);

    // insert history entries from API
    await INSERT.into(CountryHistoryDetails).entries(countryHistoryDetails);

    // remember the data fetch
    await INSERT.into(Migrations).entries({
      table: "CountryHistoryDetails",
      selector: country,
      date: Date.now(),
    });

    return;
  });
});
