/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-27-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ReverseGeoCoding {
    
    public static void reverseGeocodeRequest( String accountId) {
        
        String accId = accountId;
        //* Query the account to get the Lattitude and Longitude
        Account account = [SELECT Id, Location__latitude__s, Location__longitude__s FROM Account WHERE Id =:accId 
                            AND Location__latitude__s != null
                            AND Location__longitude__s != null
                            WITH USER_MODE LIMIT 1];

        String altitudes = account.Location__latitude__s+'%2C'+account.Location__longitude__s;
        System.debug('Alltitudes :' + altitudes);

        try {
        
        //* Set the request 
        HttpRequest httpReq = new HttpRequest();
        
        //?Step 1 : set the end point
        httpReq.setEndpoint(System.Label.GeoCode_URL+'?key='+System.Label.GeoCode_Key+'&q='+altitudes+'&pretty=1');
        //? Step 1.1 : set the headers
        httpReq.setHeader('Content-Type', 'application/json');
        httpReq.setHeader('Accept', 'application/json'); //* Accept the response
        //? Step 1.2 : set the method [GET, POST, PUT, PATCH, DELETE]
        httpReq.setMethod('GET');

        //* Step 2: Send the response
        Http callGeoCode = new Http();
        HttpResponse httpRes = callGeoCode.send(httpReq);

        String responseBody  = httpRes.getBody();
        Integer statusCode   = httpRes.getStatusCode();
        String status        = httpRes.getStatus();
            System.debug('Geo Code Response :'+ httpRes);
            System.debug('Geo Code Response Body :'+ responseBody);
            System.debug('Geo Code Response status code :'+ statusCode);
            System.debug('Geo Code Response status :'+ status);

            if (statusCode == 200) {
                ReverseGeoCodingWrapper wrapper = (ReverseGeoCodingWrapper) System.JSON.deserialize(responseBody, ReverseGeoCodingWrapper.class); //* We are trying to convert the JSON into class format
                if (wrapper?.results?.size() > 0) {

                    ReverseGeoCodingWrapper.results rslt = wrapper.results[0];
                    //* Updating the Billing address
                    account.BillingStreet                = rslt?.components?.road;
                    account.BillingCity                  = rslt?.components?.city;
                    account.BillingCountry               = rslt?.components?.country;
                    account.BillingState                 = rslt?.components?.state;
                    account.BillingPostalCode            = rslt?.components?.postcode;
                    //* Updating the Shipping address
                    account.ShippingStreet               = rslt?.components?.road;
                    account.ShippingCity                 = rslt?.components?.city;
                    account.ShippingCountry              = rslt?.components?.country;
                    account.ShippingState                = rslt?.components?.state;
                    account.ShippingPostalCode           = rslt?.components?.postcode;

                    update as user account;
                }
            } else {
                System.debug('I hit with error');
            }

        } catch (System.CalloutException calloutExp) {

            System.debug('call out get message :' + calloutExp.getMessage());

            if (String.valueOf(calloutExp.getMessage()).startsWith('Unauthorized endpoint')) {
                
                System.debug('Remote Site config is missing in SF');
            } 

        } catch (System.Exception allExp) {
            System.debug('All other exception :' + allExp.getStackTraceString());
        }
        
    }

}