using {srv} from '../srv/CovidService';

annotate srv.CovidService.Countries with @(UI : {
    Identification  : [{Value : Country}],
    SelectionFields : [
        Country
    ],
    PresentationVariant : {
        SortOrder : [
            {
                Property : NewConfirmed,
                Descending : true
            },
        ],
        Visualizations : [ ![@UI.LineItem] ]
    },
    LineItem        : [
        {Value : Country},
        {Value : NewConfirmed},
        {Value : TotalConfirmed},
        {Value : NewDeaths},
        {Value : TotalDeaths}
    ],
    HeaderInfo      : {
        TypeName       : 'Country',
        TypeNamePlural : 'Countries',
        Title          : {Value : Country},
    },
    DataPoint#TotalConfirmed  : {
        $Type : 'UI.DataPointType',
        Value : TotalConfirmed,
        Title : 'Total Confirmed',
    },
    DataPoint#TotalDeaths  : {
        $Type : 'UI.DataPointType',
        Value : TotalDeaths,
        Title : 'Total Deaths',
    },
    DataPoint#Date  : {
        $Type : 'UI.DataPointType',
        Value : Date,
        Title : 'Last Update',
    },
    HeaderFacets  : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#TotalConfirmed'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#TotalDeaths'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Date'
        }
    ],
    Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : 'CountryHistoryDetails/@UI.Chart',
            Label : 'Total Numbers Chart',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : 'CountryHistoryDetails/@UI.LineItem',
            Label : 'Total Numbers Table',
        }
    ],
});

annotate srv.CovidService.CountryHistoryDetails with @(UI : {
    Identification  : [{Value : Country}],
    HeaderInfo      : {
        TypeName       : 'Country History',
        TypeNamePlural : 'Country History',
        Title          : {Value : Country},
    },
    SelectionFields : [
        Country
    ],
    LineItem        : [
        {Value : Date},
        {Value : Confirmed},
        {Value : Deaths},
        {Value : Active},
        {Value : Recovered}
    ],
    PresentationVariant : {
        SortOrder : [
            {
                Property : Date,
                Descending : true
            },
        ],
        Visualizations : [ ![@UI.LineItem] ]
    },
    Chart : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Line,
        Dimensions : [
            Date
        ],
        Measures : [
            deaths, confirmed
        ],
        Title : 'Total Numbers Chart',
    },
});

annotate srv.CovidService.CountryHistoryDetails with @( 
    Aggregation.ApplySupported.PropertyRestrictions: true,
    Analytics.AggregatedProperties : [ 
        { 
            Name : 'deaths', 
            AggregationMethod : 'sum', 
            AggregatableProperty : 'Deaths', 
            ![@Common.Label] : 'Deaths' 
        },
        { 
            Name : 'active', 
            AggregationMethod : 'sum', 
            AggregatableProperty : 'Active', 
            ![@Common.Label] : 'Active' 
        },
        { 
            Name : 'confirmed', 
            AggregationMethod : 'sum', 
            AggregatableProperty : 'Confirmed', 
            ![@Common.Label] : 'Confirmed' 
        },
        { 
            Name : 'recovered', 
            AggregationMethod : 'sum', 
            AggregatableProperty : 'Recovered', 
            ![@Common.Label] : 'Recovered' 
        } 
    ] 
);