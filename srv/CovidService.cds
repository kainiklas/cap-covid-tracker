namespace srv;

using {db} from '../db/Covid';

service CovidService {

    @readonly
    entity Countries             as projection on db.Countries;

    @readonly
    entity CountryHistoryDetails as projection on db.CountryHistoryDetails;
    
}
