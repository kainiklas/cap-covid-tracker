using {db} from '../db/Covid';

annotate db.Countries with @title : '{i18n>Country}' {
    Country               @(
        title       : '{i18n>Country}',
        description : '{i18n>Country}'
    );
    CountryCode           @(
        title       : '{i18n>CountryCode}',
        description : '{i18n>CountryCode}'
    );
    Slug                  @(
        title       : '{i18n>Slug}',
        description : '{i18n>Slug}'
    );
    NewConfirmed          @(
        title       : '{i18n>NewConfirmed}',
        description : '{i18n>NewConfirmed}'
    );
    TotalConfirmed        @(
        title       : '{i18n>TotalConfirmed}',
        description : '{i18n>TotalConfirmed}'
    );
    NewDeaths             @(
        title       : '{i18n>NewDeaths}',
        description : '{i18n>NewDeaths}'
    );
    TotalDeaths           @(
        title       : '{i18n>TotalDeaths}',
        description : '{i18n>TotalDeaths}'
    );
    NewRecovered          @(
        title       : '{i18n>NewRecovered}',
        description : '{i18n>NewRecovered}'
    );
    TotalRecovered        @(
        title       : '{i18n>TotalRecovered}',
        description : '{i18n>TotalRecovered}'
    );
    Date                  @(
        title       : '{i18n>Date}',
        description : '{i18n>Date}'
    );

    CountryHistoryDetails @(
        title       : '{i18n>CountryHistoryDetails}',
        description : '{i18n>CountryHistoryDetails}'
    );
}

annotate db.CountryHistoryDetails with @title : '{i18n>Country}' {
    Country     @(
        title       : '{i18n>Country}',
        description : '{i18n>Country}'
    );
    ID          @(UI.Hidden : true);
    CountryCode @(
        title       : '{i18n>CountryCode}',
        description : '{i18n>CountryCode}'
    );
    Lat         @(
        title       : '{i18n>Lat}',
        description : '{i18n>Lat}'
    );
    Lon         @(
        title       : '{i18n>Lon}',
        description : '{i18n>Lon}'
    );
    Confirmed   @(
        title       : '{i18n>Confirmed}',
        description : '{i18n>Confirmed}'
    );
    Deaths      @(
        title       : '{i18n>Deaths}',
        description : '{i18n>Deaths}'
    );
    Recovered   @(
        title       : '{i18n>Recovered}',
        description : '{i18n>Recovered}'
    );
    Active      @(
        title       : '{i18n>Active}',
        description : '{i18n>Active}'
    );
    Date        @(
        title       : '{i18n>Date}',
        description : '{i18n>Date}'
    );
}
