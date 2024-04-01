/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-14-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ZendeskTicketUtils {
    /*
    ZendeskTicketUtils.TicketWrapper wrapper = new ZendeskTicketUtils.TicketWrapper();
    wrapper.body = 'Dynamic Body';
    wrapper.priority = 'Urgent';
    wrapper.subject = 'Testing through Apex';
    wrapper.name = 'Panther Integration';
    wrapper.email = 'panther@intergration.com';

    ZendeskTicketUtils.createTicket(wrapper);
    */

    public class TicketWrapper {
        
        public String body;
        public String priority;
        public String subject;
        public String name;
        public String email;
        
    }
    public static void createTicket(TicketWrapper wrapper) {

        String header = System.label.Zendesk_Username+':'+System.label.Zendesk_api_token;

        Blob headerValue = Blob.valueOf(header);
        String jsonBody  ='{'+
		'    "ticket": {'+
		'        "comment": {'+
		'            "body": "'+wrapper.body+'"'+
		'        },'+
		'        "priority": "'+wrapper.priority+'",'+
		'        "subject": "'+wrapper.subject+'",'+
		'        "requester": {'+
		'            "locale_id": 8,'+
		'            "name": "'+wrapper.name+'",'+
		'            "email": "'+wrapper.email+'"'+
		'        }'+
		'    }'+
		'}';
        System.debug('The Json body --->' + jsonBody);
        
        HttpRequest httpReq = new HttpRequest();    

        httpReq.setEndpoint('https://panther5590.zendesk.com/api/v2/tickets');
        httpReq.setBody(jsonBody); //* String---> XML/JSON
        httpReq.setHeader('Content-Type', 'application/json');
        httpReq.setHeader('Accept', 'application/json');
        httpReq.setHeader('Authorization', 'Basic '+EncodingUtil.base64Encode(headerValue));
        httpReq.setMethod('POST');
        
        //* Calling the end point through send request 
        Http http = new Http();
        try {
            System.debug('The Http Req is :' + httpReq);
            
            HTTPResponse httpRes = http.send(httpReq);
            
            String responseBody  = httpRes.getBody();
            Integer statusCode   = httpRes.getStatusCode();
            String status        = httpRes.getStatus();

            if (httpRes.getStatusCode() == 201) {
                
                //*parse the JSON response to wrapper class*//
                
                ZendeskWrapper zenResponse = (ZendeskWrapper) System.JSON.deserialize(responseBody, ZendeskWrapper.class);
                Integer zenId = zenResponse.ticket.id;

                //* get the case Id
                String caseId = wrapper.name;
                Case cs = [SELECT Id FROM Case WHERE Id =: caseId WITH USER_MODE LIMIT 1];

                //* Update the case
                cs.Zendesk_Reference__c = zenId;
                update as USER cs;
            } else {
                 //* get the case Id
                 String caseId = wrapper.name;
                // * If the status code is not 201 then update the case with error message
                Case cs = [SELECT Id FROM Case WHERE Id =: caseId WITH USER_MODE LIMIT 1];
                cs.Zendesk_Error__c = 'Error while integrating with  Zendesk';
                update as USER cs;
            
                System.debug('Error \n' + httpReq.getBody());
            }   
    
        } catch (System.CalloutException calloutExp) {
            System.debug('Exception: ' + calloutExp.getStackTraceString());
        } catch (System.Exception allExp) {
            System.debug('Error \n' + allExp.getStackTraceString());
        }
        
    }
}