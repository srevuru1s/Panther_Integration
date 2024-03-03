/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-03-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ForwardGeoCoding {

    public static void forwardGeocodeRequest(String accountID) {
        //* Query the account
        String accId = accountID;
        Account account = [SELECT Id, BillingStreet, BillingCity,BillingCountry, BillingState, BillingPostalCode   FROM Account 
                            WHERE Id =: accId 
                            AND 
                            BillingStreet != null AND BillingCity != null AND BillingState != null AND
                            BillingCountry != null AND BillingPostalCode != null 
                            WITH USER_MODE LIMIT 1];
        //* Query encoding
        String newQuery    = account.BillingStreet+','+account.BillingCity+','+account.BillingState+','+account.BillingPostalCode+','+account.BillingCountry;
        //String queryParam  = account.BillingStreet+'1%2C'+account.BillingPostalCode+account.BillingCity+'%2C'+account.BillingCountry; 
        String encoded     = EncodingUtil.urlEncode(newQuery, 'UTF-8');
        String completeUrl = System.Label.GeoCode_URL+'?key='+System.Label.GeoCode_Key+'&q='+'&pretty=1';
        
        try {
            //* Send the Request 
        //? Step 1 : Prepare the httpRequest 
        HttpRequest httpReq = new HttpRequest();
        //? Step 1.1 : set the end point URL
        httpReq.setEndpoint(completeUrl);
        //? Step 1.2 : set the headder
        httpReq.setHeader('Content-Type', 'application/json');
        httpReq.setHeader('Accept', 'application/json');
        //? Step 1.3 : set the API methos [GET, POST, PUT, PATCH, DELETE]
        httpReq.setMethod('GET'); 

        //* Send the Request
        Http http = new Http();
        HttpResponse httpRes = http.send(httpReq);
        
        String responseBody  = httpRes.getBody();
        Integer statusCode   = httpRes.getStatusCode();
        String status        = httpRes.getStatus();
        System.debug('Geo Code Response :'+ httpRes);
        System.debug('Geo Code Response Body :'+ responseBody);
        System.debug('Geo Code Response status code :'+ statusCode);
        System.debug('Geo Code Response status :'+ status);

            if (statusCode == 200) {
                
                ForwardGeoCodingWrapper wraper = (ForwardGeoCodingWrapper) System.JSON.deserialize(responseBody, ForwardGeoCodingWrapper.class);
                if (wraper?.results?.size() > 0) {
        
                    ForwardGeoCodingWrapper.results rslt = wraper.results[0];
                    //* Updating the account
                    account.Location__latitude__s  = rslt?.geometry?.lat;
                    account.Location__longitude__s = rslt?.geometry?.lng;
                    update as user account;
                } 
            }
            
        
            else {
                
                account.Geo_Code_Error__c = 'We hit with bad error response' + statusCode;
                
                update as user account;
            } 
        } catch (System.CalloutException calloutExp) {
            
            System.debug('Call out Exception occured :' + calloutExp.getMessage());
            if (String.valueOf(calloutExp.getMessage()).startsWith('Unauthorized endpoint')) {
                        
                System.debug('Missing Remote site config in salesforce');
            }
        } catch (System.Exception allExp) {

            System.debug('Exception hit :' + allExp.getStackTraceString());
        }
        
    }
}