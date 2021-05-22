namespace srv;

using {db} from '../db/Covid';

service AdminCovidService @(requires: 'authenticated-user') {
    entity Countries as projection on db.Countries;
    entity CountryHistoryDetails as projection on db.CountryHistoryDetails;
    entity Migrations as projection on db.Migrations;
}

