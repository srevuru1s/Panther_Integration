/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-30-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountUtils {

    public static void createAccount(String name, String rating) {
        
        Salesforce_Config__mdt config = Salesforce_Config__mdt.getInstance(System.Label.SalesforceTokenLabel);
        Map<String,Object> fieldsWithValuesMap = new Map<String,Object>();
        String accessToken = config.access_token__c;
        if (config != null) {

            Boolean isValid = SalesforceTokenUtils.isValid(config);
            if (!isValid) {
                //* get the access token using refresh token
                fieldsWithValuesMap = SalesforceTokenUtils.refreshToken(config);
                accessToken = (string) fieldsWithValuesMap.get('access_token__c');
            }

            String endpoint = config.instance_url__c+'/services/data/v60.0/sobjects/Account';
            String requestBody = '{'+
            '    "Name" : "'+name+'",'+
            '    "Rating" : "'+rating+'",'+
            '    "Phone" : "8752001245",'+
            '    "Industry": "Education",'+
            '    "Active__c": "Yes"'+
            '}';
            
            HttpRequest httpReq = CalloutUtils.prepareRequest(endPoint, 'POST', 'application/json', requestBody, 'application/json');
            httpReq.setHeader('Authorization', 'Bearer '+accessToken);
            // System.debug('HttpRequest :' + httpReq);

            try {
                HTTPResponse httpRes = (new Http()).send(httpReq);
                if (httpRes.getStatusCode() == 200 || httpRes.getStatusCode() == 201) {
                    
                    String response = httpRes.getBody();
                    System.debug('SUCCESS Response :' + response);
                    
                } else {
                    System.debug('ERROR \n ' + httpRes.getBody());
                }

            } catch (System.CalloutException calloutExp) {
                System.debug('Exception: ' + calloutExp.getStackTraceString());
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, calloutExp.getMessage()));
            } catch (System.Exception allExp) {

                System.debug('Error \n' + allExp.getStackTraceString());
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, allExp.getMessage()));
            }
            /*
                TODO : 
                1. Update the Custom Metadata with new values
                ! update the new Access Token
            */
            if (fieldsWithValuesMap?.size() > 0) {
                String fullName = 'Salesforce_Config.'+System.Label.SalesforceTokenLabel;
                String label    = 'SalesforceToken';
                CreateUpdateMetadataUtils.createUpdateMetadata(fullName, label, fieldsWithValuesMap);
            }
        }
    }
}