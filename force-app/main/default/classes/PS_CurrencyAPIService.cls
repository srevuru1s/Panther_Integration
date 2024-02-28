/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-26-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class PS_CurrencyAPIService {
   
    public static void getExchangeRate() {
        //! Callouts Only
        //? Step1 - Prepare the Request 

        HttpRequest httpReq = new HttpRequest();
        try {
            
        httpReq.setEndpoint('https://open.er-api.com/v6/latest/USD');

        //? Step1.2 - Set the Headers 

        httpReq.setHeader('Content-Type', 'application/json');
        httpReq.setHeader('Accept', 'application/json'); //? accepting only JSON

        //? Step1.3 - Set the Method [GET, POST, PUT, PATCH, DELETE]
        httpReq.setMethod('GET');

        //? Step2 - Send the Request

        Http http = new Http();
        HttpResponse httpRes = http.send(httpReq);

        //? Step3 - Print the Information
        /*
             getStatus()
             getStatusCode()
             getBody()
             getXmkStreamReader() --> SOAP
             getBodyAsBlod()       
        */
        String responseBody  = httpRes.getBody();
        Integer statusCode   = httpRes.getStatusCode();
        String status        = httpRes.getStatus();
        System.debug('The response from Http :' + httpRes);
            
        } catch (System.CalloutException calloutEx) {
            
            System.debug('Call Exception occured ***: '+calloutEx.getStackTraceString());
            if (String.valueOf(calloutEx).startsWith('System.CallOutException: Unauthorized end point')) {
                
                System.debug('CalloutException due to remote site missing');
            }
            
        } catch (System.Exception ex) {

            System.debug('All Exception occured ***: '+ ex.getStackTraceString());
            if (String.valueOf(ex).startsWith('System')) {
                System.debug('This is other exception than remote site');
            }
        }
        

    }

}