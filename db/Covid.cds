using {cuid} from '@sap/cds/common';

namespace db;

entity Countries {
    key Country               : String;
        CountryCode           : String;
        Slug                  : String;
        NewConfirmed          : Integer;
        TotalConfirmed        : Integer;
        NewDeaths             : Integer;
        TotalDeaths           : Integer;
        NewRecovered          : Integer;
        TotalRecovered        : Integer;
        Date                  : DateTime;

        CountryHistoryDetails : Association to many CountryHistoryDetails
                                    on $self.Country = CountryHistoryDetails.Country;
}

entity CountryHistoryDetails {
    key Country     : String;
    key ID          : String;
        CountryCode : String;
        Lat         : Double;
        Lon         : Double;
        Confirmed   : Integer;
        Deaths      : Integer;
        Recovered   : Integer;
        Active      : Integer;
        Date        : DateTime;
}

entity Migrations {
    key table    : String;
    key selector : String;
        date     : DateTime;
}
