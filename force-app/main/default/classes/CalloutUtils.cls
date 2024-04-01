/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-21-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class CalloutUtils {
    
    public static HttpRequest prepareRequest(String endPoint, String method, String contentType, String body, String accept) {
       
        HttpRequest httpReq = new HttpRequest();
        httpReq.setEndpoint(endpoint);
        httpReq.setMethod(method);
        httpReq.setHeader('Content-Type', contentType);
       
        if (String.isNotBlank(body)) {
            httpReq.setBody(body);
        }
        if (String.isNotBlank(accept)) {
            httpReq.setHeader('Accept', accept);
        }

        return httpReq;
    }    
}