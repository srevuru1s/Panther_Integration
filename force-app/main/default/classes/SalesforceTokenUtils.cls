/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-29-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class SalesforceTokenUtils {

    //* pageReference is a class in VF that will help to redirect from VF to apex class
    
    public PageReference getAuthCode() {
        /*
            TODO: 1. get the Custom Metadata Record
                  2. Crete the Auth URL
                  https://login.salesforce.com/services/oauth2/authorize?
                  client_id=3MVG9jSKmPAPVo2Ia8iyoTjv_ETN5EoA9qqiedN7X1SWYtdyVTWO9_kz1eYWdMbLHO.l335HK1VAD5hPHnzn2&
                  redirect_uri=https://academy.pantherschools.com/&
                  response_type=code           
        */
        Salesforce_Config__mdt config = Salesforce_Config__mdt.getInstance(System.Label.SalesforceTokenLabel);
        if (config != null) {
            
            String orgUrl       = config.Environment__c == 'Production' ? 'https://login.salesforce.com/' : 'https://test.salesforce.com/';
            String redirect_uri = System.URL.getOrgDomainUrl().toExternalForm()+'/apex/'+config.PageName__c;
            String baseUrl      = orgUrl+config.auth_url__c+'?client_id='+config.Client_Id__c+
                                            '&redirect_uri='+redirect_uri+'&response_type=code';

            return new PageReference(baseUrl);
        } else {
            return null;
        }
    }

    public void getAccessToken() {
        //* code=aPrx_dhXWn5fLSI0lqAn89Ayz4SBvQPgsC2DB5pdKhCtrjLIDKr5ruaGXHCp9FyDOJiUz7nihQ%3D%3D
        String code = ApexPages.currentPage().getParameters().get('code');

        Salesforce_Config__mdt config = Salesforce_Config__mdt.getInstance(System.Label.SalesforceTokenLabel);
        if (config != null) {
            
            String orgUrl       = config.Environment__c == 'Production' ? 'https://login.salesforce.com/' : 'https://test.salesforce.com/';
            String tokenUrl     = orgUrl+config.token_url__c;
            String redirect_uri = System.URL.getOrgDomainUrl().toExternalForm()+'/apex/'+config.PageName__c;

            String requestBody  = 'code='+code+'&grant_type=authorization_code&client_id='+config.client_id__c+'&client_secret='
                                  +config.client_secret__c+'&redirect_uri='+redirect_uri;
            
            System.debug('Requested body :' + requestBody);
            HttpRequest httpReq = new HttpRequest();

            httpReq.setEndpoint(tokenUrl);
            httpReq.setMethod('POST');
            httpReq.setBody(requestBody); //* String---> XML/JSON
            httpReq.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            httpReq.setHeader('Accept', 'application/json');
            
            //* Calling the end point through send request 
            Http http = new Http();

            try {
          
                HTTPResponse httpRes = http.send(httpReq);
                
                String responseBody  = httpRes.getBody();
                Integer statusCode   = httpRes.getStatusCode();
                String status        = httpRes.getStatus();
    
                if (httpRes.getStatusCode() == 200) {
                    System.debug('SUCCESS \n' + httpRes.getBody());
                    SalesforceTokenWrapper wrapper = (SalesforceTokenWrapper) System.JSON.deserialize(httpRes.getBody(), SalesforceTokenWrapper.class);
                    /*
                        TODO: Deploy the Custom Metadata
                         ! How to deploy
                          ? Metadata is a name space
                               ?CustomMetadata - class
                               ?CustomMetadataValue- class
                               ?Operations - class
                               ?DeployCallBack - interface
                                
                    */
                    String fullName = 	'Salesforce_Config.'+System.Label.SalesforceTokenLabel;
                    String label    = 'SalesforceToken';
                    Map<String, Object> fieldWithValuesMap = new Map<String, Object>();

                    fieldWithValuesMap.put('access_token__c',wrapper.access_token);
                    fieldWithValuesMap.put('Instance_Url__c',wrapper.instance_url);
                    fieldWithValuesMap.put('refresh_token__c',wrapper.refresh_token);
                    fieldWithValuesMap.put('scope__c',wrapper.scope);
                    fieldWithValuesMap.put('expire_in_time__c', System.now().addHours(2));

                    CreateUpdateMetadataUtils.createUpdateMetadata(fullName, label, fieldWithValuesMap);
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.CONFIRM, 'Succeessfully retrieved access token'));
                    
                } else {
                  System.debug('Error \n' + httpReq.getBody());
                  ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Error retrieved access token'));
                }   
        
            } catch (System.CalloutException calloutExp) {
                System.debug('Exception: ' + calloutExp.getStackTraceString());
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, calloutExp.getMessage()));
            } catch (System.Exception allExp) {

                System.debug('Error \n' + allExp.getStackTraceString());
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, allExp.getMessage()));
            }
            
        }
  
    }

    public static Boolean isValid(Salesforce_Config__mdt config) {
        Boolean isValid  = true;
        if (config.expire_in_time__c < System.now()) {
            
            isValid = false;
        }
        return isValid;
    }

    public static Map<String,Object> refreshToken(Salesforce_Config__mdt config) {
                            
        String orgUrl       = config.Environment__c == 'Production' ? 'https://login.salesforce.com/' : 'https://test.salesforce.com/';
        String tokenUrl     = orgUrl+config.token_url__c;
        String requestBody  = 'grant_type=refresh_token&client_id='+config.client_id__c+'&client_secret='+config.client_secret__c+'&refresh_token='+config.refresh_token__c;
        
        System.debug('Requested body :' + requestBody);
        HttpRequest httpReq = CalloutUtils.prepareRequest(tokenUrl, 'POST', 'application/x-www-form-urlencoded', requestBody, 'application/json');
        httpReq.setHeader('Authorization', 'Bearer '+config.access_token__c);
            // System.debug('HttpRequest :' + httpReq);
            Map<String,Object> fieldWithValuesMap = new Map<String,Object>();
            try {
                HTTPResponse httpRes = (new Http()).send(httpReq);
                if (httpRes.getStatusCode() == 200 || httpRes.getStatusCode() == 201) {
                    
                    String response = httpRes.getBody();
                    System.debug('SUCCESS Response :' + response);

                    SalesforceTokenWrapper wrapper = (SalesforceTokenWrapper) System.JSON.deserialize(httpRes.getBody(), SalesforceTokenWrapper.class);
                    fieldWithValuesMap.put('refresh_token__c',wrapper.refresh_token);
                    fieldWithValuesMap.put('expire_in_time__c', System.now().addHours(2));
                    
                } else {
                    System.debug('ERROR \n ' + httpRes.getBody());
                }

            } catch (System.CalloutException calloutExp) {
                System.debug('Exception: ' + calloutExp.getStackTraceString());

            } catch (System.Exception allExp) {
                System.debug('Error \n' + allExp.getStackTraceString());
                
            }
        return fieldWithValuesMap;
    }
        
}