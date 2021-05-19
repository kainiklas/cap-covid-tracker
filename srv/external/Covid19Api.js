const cds = require("@sap/cds");

class Covid19Api extends cds.RemoteService {
  async init() {
    this.reject(["CREATE", "UPDATE", "DELETE"], "*");

    this.before("READ", "*", async (req) => {
      if (req.target.name === "srv.CovidService.Countries") {
        req.myQuery = req.query;
        req.query = "GET /summary";
      }

      if (req.target.name === "srv.CovidService.CountryHistoryDetails") {
        req.myQuery = req.query;

        var country = req.myQuery.SELECT.from.ref[0].where[2].val;
        let { Slug } = await SELECT.one
          .from(this.entities.Countries)
          .where({ Country: country });

        var timerange = getTimerangeQueryString();

        req.query = "GET /total/country/" + Slug + timerange;
      }
    });

    this.on("READ", "*", async (req, next) => {
      if (req.target.name === "srv.CovidService.Countries") {
        const response = await next(req);
        var items = parseResponseCountries(response);
        return items;
      }

      if (req.target.name === "srv.CovidService.CountryHistoryDetails") {
        const response = await next(req);
        var items = parseResponseCountryHistoryDetails(response);
        return items;
      }
    });

    super.init();
  }
}

function parseResponseCountries(response) {
  var countries = [];

  response.Countries.forEach((c) => {
    var i = new Object();

    i.Country = c.Country;
    i.Slug = c.Slug;
    i.CountryCode = c.CountryCode;
    i.NewConfirmed = c.NewConfirmed;
    i.TotalConfirmed = c.TotalConfirmed;
    i.NewDeaths = c.NewDeaths;
    i.TotalDeaths = c.TotalDeaths;
    i.NewRecovered = c.NewRecovered;
    i.TotalRecovered = c.TotalRecovered;
    i.Date = c.Date;

    countries.push(i);
  });

  return countries;
}

function parseResponseCountryHistoryDetails(response) {
  var historyDetails = [];

  response.forEach((r) => {
    var i = new Object();

    i.ID = uuidv4();
    i.Country = r.Country;
    i.CountryCode = r.CountryCode;
    i.Lat = r.Lat;
    i.Lon = r.Lon;
    i.Confirmed = r.Confirmed;
    i.Deaths = r.Deaths;
    i.Recovered = r.Recovered;
    i.Active = r.Active;
    i.Date = r.Date;

    historyDetails.push(i);
  });

  return historyDetails;
}

function uuidv4() {
  return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, function (c) {
    var r = (Math.random() * 16) | 0,
      v = c == "x" ? r : (r & 0x3) | 0x8;
    return v.toString(16);
  });
}

function getTimerangeQueryString() {
  var endDT = new Date();
  endDT.setUTCHours(0, 0, 0, 0);

  var startDT = new Date();
  startDT.setUTCHours(0, 0, 0, 0);
  startDT.setDate(startDT.getDate() - 14);

  var timerange = `?from=${startDT.toISOString()}&to=${endDT.toISOString()}`;

  return timerange;
}

module.exports = Covid19Api;
