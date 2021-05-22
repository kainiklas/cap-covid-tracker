const cds = require("@sap/cds");

module.exports = cds.service.impl(async function () {
  this.before("READ", "Countries", async (req, next) => {
    const adminSrv = await cds.connect.to("srv.AdminCovidService");
    const { Migrations, Countries } = adminSrv.entities;

    // check if filled; then no need to execute
    let migrations = await adminSrv.run(
      SELECT.from(Migrations).where({
        table: "Countries",
        selector: "summary",
      })
    );

    if (migrations.length !== 0) {
      return;
    }

    // delete all countries
    await adminSrv.run(DELETE.from(Countries));

    // fetch daily summary from covid API
    const Covid19Api = await cds.connect.to("Covid19Api");
    var countries = await Covid19Api.run(req.query);

    // insert summary into Countries table
    await adminSrv.run(INSERT.into(Countries).entries(countries));

    // remember the data fetch
    await adminSrv.run(
      INSERT.into(Migrations).entries({
        table: "Countries",
        selector: "summary",
        date: Date.now(),
      })
    );

    return;
  });

  this.before("READ", "Countries/CountryHistoryDetails", async (req) => {
    const adminSrv = await cds.connect.to("srv.AdminCovidService");
    const { Migrations, CountryHistoryDetails } = adminSrv.entities;

    let country = req.params[0].Country;

    // check if filled; then no need to execute
    let migrations = await adminSrv.run(
      SELECT.from(Migrations).where({
        table: "CountryHistoryDetails",
        selector: country,
      })
    );

    if (migrations.length !== 0) {
      return;
    }

    // delete all history information
    try {
      await adminSrv.run(
        DELETE.from(CountryHistoryDetails).where({ Country: country })
      );
    } catch (e) {}

    // fetch daily summary from covid API
    const Covid19Api = await cds.connect.to("Covid19Api");
    var countryHistoryDetails = await Covid19Api.run(req.query);

    // insert history entries from API
    await adminSrv.run(
      INSERT.into(CountryHistoryDetails).entries(countryHistoryDetails)
    );

    // remember the data fetch
    await adminSrv.run(
      INSERT.into(Migrations).entries({
        table: "CountryHistoryDetails",
        selector: country,
        date: Date.now(),
      })
    );

    return;
  });
});
