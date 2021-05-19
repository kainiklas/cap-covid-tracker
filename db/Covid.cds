using {cuid} from '@sap/cds/common';

namespace db;

entity Countries {
    key Country               : String   @(
            title       : '{i18n>Country}',
            description : '{i18n>Country}'
        );
        CountryCode           : String   @(
            title       : '{i18n>CountryCode}',
            description : '{i18n>CountryCode}'
        );
        Slug                  : String   @(
            title       : '{i18n>Slug}',
            description : '{i18n>Slug}'
        );
        NewConfirmed          : Integer  @(
            title       : '{i18n>NewConfirmed}',
            description : '{i18n>NewConfirmed}'
        );
        TotalConfirmed        : Integer  @(
            title       : '{i18n>TotalConfirmed}',
            description : '{i18n>TotalConfirmed}'
        );
        NewDeaths             : Integer  @(
            title       : '{i18n>NewDeaths}',
            description : '{i18n>NewDeaths}'
        );
        TotalDeaths           : Integer  @(
            title       : '{i18n>TotalDeaths}',
            description : '{i18n>TotalDeaths}'
        );
        NewRecovered          : Integer  @(
            title       : '{i18n>NewRecovered}',
            description : '{i18n>NewRecovered}'
        );
        TotalRecovered        : Integer  @(
            title       : '{i18n>TotalRecovered}',
            description : '{i18n>TotalRecovered}'
        );
        Date                  : DateTime @(
            title       : '{i18n>Date}',
            description : '{i18n>Date}'
        );

        CountryHistoryDetails : Association to many CountryHistoryDetails
                                    on $self.Country = CountryHistoryDetails.Country;
}

entity CountryHistoryDetails {
    key Country     : String   @(
            title       : '{i18n>Country}',
            description : '{i18n>Country}'
        );
    key ID          : String;
        CountryCode : String   @(
            title       : '{i18n>CountryCode}',
            description : '{i18n>CountryCode}'
        );
        Lat         : Double   @(
            title       : '{i18n>Lat}',
            description : '{i18n>Lat}'
        );
        Lon         : Double   @(
            title       : '{i18n>Lon}',
            description : '{i18n>Lon}'
        );
        Confirmed   : Integer  @(
            title       : '{i18n>Confirmed}',
            description : '{i18n>Confirmed}'
        );
        Deaths      : Integer  @(
            title       : '{i18n>Deaths}',
            description : '{i18n>Deaths}'
        );
        Recovered   : Integer  @(
            title       : '{i18n>Recovered}',
            description : '{i18n>Recovered}'
        );
        Active      : Integer  @(
            title       : '{i18n>Active}',
            description : '{i18n>Active}'
        );
        Date        : DateTime @(
            title       : '{i18n>Date}',
            description : '{i18n>Date}'
        );
}

entity Migrations {
    key table    : String;
    key selector : String;
        date     : DateTime;
}
