/*
*   @desc
*   Class responsible to handle only callouts, no logic
*   Ideal to use NamedCredentials to handle endpoints/auth
*   TODO: Add validations on type of responses, create a layer above this class to handle generic methods like "build/send" request and extend this class on it
*/
public class AddressValidationCallout implements Database.AllowsCallouts {
	// private static final String BASE_INTERNATIONAL_URL = 'callout:InternationalAddressValidation';
    // private static final String BASE_US_URL = 'callout:USAddressValidation';
    // private static final String STREET_ADDRESS_ENDPOINT = '/street-address';
    private static final String STREET_ADDRESS_ENDPOINT = 'https://us-street.api.smarty.com/street-address?auth-id=338aa982-f682-804c-2fdf-2e10ae8c473f&auth-token=paaMbMNUZTNbYQ881atu&match=enhanced&license=us-core-cloud';
    private static final String INTERNATIONAL_ADDRESS_ENDPOINT = 'https://international-street.api.smarty.com/verify?auth-id=338aa982-f682-804c-2fdf-2e10ae8c473f&auth-token=paaMbMNUZTNbYQ881atu';

    public static String buildRequest(String endpoint) {
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(endpoint);
            request.setMethod('GET');
            HttpResponse response = http.send(request);

            return (response.getStatusCode() == 200) 
                ? response.getBody()
                : null;

        } catch(Exception e) {
            System.debug('Error: ' + e.getMessage());
            return null;
        }
    }

    public static IAddressEntity validateAddressUS(String street, String city, String state) {
        try{
            // String endpoint = BASE_US_URL + STREET_ADDRESS_ENDPOINT;
            USAddressEntity addressEntity;
            String endpoint = STREET_ADDRESS_ENDPOINT;

            street = EncodingUtil.urlEncode(street, 'UTF-8');
            city = EncodingUtil.urlEncode(city, 'UTF-8');
            state = EncodingUtil.urlEncode(state, 'UTF-8');
            String requestUrl = endpoint + '&street=' + street + '&city=' + city + '&state=' + state;

            List<USAddressEntity> addressEntities = (List<USAddressEntity>) JSON.deserialize(buildRequest(requestUrl), List<USAddressEntity>.class);
            if(addressEntities != null && addressEntities.size() > 0) {
                addressEntity = addressEntities.get(0);
            }

            return addressEntity;        
        } catch(Exception e) {
            System.debug('Error: ' + e.getMessage());
            return null;
        }

    }
    
    public static IAddressEntity validateAddressITL(String address1, String postal_code, String country) {
        try{
            InternationalAddressEntity addressEntity;
            address1 = EncodingUtil.urlEncode(address1, 'UTF-8');
            postal_code = EncodingUtil.urlEncode(postal_code, 'UTF-8');
            country = EncodingUtil.urlEncode(country, 'UTF-8');

            String requestUrl = INTERNATIONAL_ADDRESS_ENDPOINT + '&address1=' + address1 + '&postal_code=' + postal_code + '&country=' + country;

            List<InternationalAddressEntity> addressEntities = 
                (List<InternationalAddressEntity>) JSON.deserialize(buildRequest(requestUrl), List<InternationalAddressEntity>.class);

            if(addressEntities != null && addressEntities.size() > 0) {
                addressEntity = addressEntities.get(0);
            }            

            return addressEntity;
        } catch(Exception e) {
            System.debug('Error: ' + e.getMessage());
            return null;
        }
    }
}