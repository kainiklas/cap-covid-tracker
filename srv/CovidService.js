const cds = require("@sap/cds");
const DEBUG = cds.debug("covid-service");

module.exports = cds.service.impl(async function () {
  const db = await cds.connect.to("db");
  const { Migrations, Countries, CountryHistoryDetails } = db.entities;

  function getYesterdayDate() {
    return new Date(Date.now() - 86400000).toISOString(); // 24 * 60 * 60 * 1000 milliseconds
  }

  this.before("READ", "Countries", async (req, next) => {
    let migrations = await db.read(Migrations).where({
      table: "Countries",
      selector: "summary",
      date: { ">=": getYesterdayDate() },
    });

    // check for cached values
    if (migrations.length !== 0) {
      DEBUG && DEBUG("Countries - Cache Hit");
      return;
    }

    // delete cache
    await db.delete(Migrations).where({
      table: "Countries",
      selector: "summary",
    });

    // delete all countries
    await db.delete(Countries);

    // fetch daily summary from covid API
    const Covid19Api = await cds.connect.to("Covid19Api");
    var countries = await Covid19Api.run(req.query);

    // insert summary into Countries table
    await db.create(Countries).entries(countries);

    await db.create(Migrations).entries({
      table: "Countries",
      selector: "summary",
      date: Date.now(),
    });

    return;
  });

  this.before("READ", "Countries/CountryHistoryDetails", async (req) => {
    let country = req.params[0].Country;

    // check if filled; then no need to execute
    let migrations = await db.read(Migrations).where({
      table: "CountryHistoryDetails",
      selector: country,
      date: { ">=": getYesterdayDate() },
    });

    if (migrations.length !== 0) {
      DEBUG && DEBUG("Countries/CountryHistoryDetails - Cache Hit - ", country);
      return;
    }

    // delete cache
    await db.delete(Migrations).where({
      table: "CountryHistoryDetails",
      selector: country,
    });

    // delete all history information
    try {
      await db.delete(CountryHistoryDetails).where({ Country: country });
    } catch (e) {}

    // fetch daily summary from covid API
    const Covid19Api = await cds.connect.to("Covid19Api");
    var countryHistoryDetails = await Covid19Api.run(req.query);

    // insert history entries from API
    await db.create(CountryHistoryDetails).entries(countryHistoryDetails);

    // remember the data fetch
    await db.create(Migrations).entries({
      table: "CountryHistoryDetails",
      selector: country,
      date: Date.now(),
    });

    return;
  });
});
