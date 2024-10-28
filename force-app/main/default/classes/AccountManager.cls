/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-26-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/

/** how the url will be accessed
 * Org Base url - Instance url (always the classic) + services/apexrest/v1/AccountManger/
 * https://pantherschool-a-dev-ed.develop.my.salesforce.com/v1/AccountManger/
 */
@RestResource(urlMapping = '/v1/AccountManger/*')
global with sharing class AccountManager {
    /** on call can have only one methods of below
     * @httpGet-GET
     * @httpPost-POST
     * @httpPut-PUT
     * @httpPatch-PATCH
     * @httpDelete-DELETE
     */
    
    /** List all the salesforce accounts -GET */
    @httpGet 
    global static List<Account> getAccountList() {

        /**
         * ! Getting the request and response
         * ! RestContext.request        : RestRequest
         * ! RestContext.response       : RestResponse
         */
        RestRequest req  = RestContext.request;
        System.debug(System.JSON.serializePretty(req));

        RestResponse res = RestContext.response;
        System.debug(System.JSON.serializePretty(res));
        System.debug('I have been called by other class 🧲');

        return [SELECT Id, Name, Industry, Phone FROM Account WITH USER_MODE];
    }
    /** Creat an accounts -POST */
    @httpPost
    global static String createAccount() {

        /** Get information about the body */
        RestRequest req  = RestContext.request;
        System.debug(System.JSON.serializePretty(req));

        String jsonBody = req.requestBody?.toString(); //* convert blob into string format
        System.debug('jsonBody-📪' + jsonBody);

        Account fillDetails = (Account) Json.deserialize(jsonBody, Account.class);
        System.debug('Full Details after deserialize 🎨'+ System.JSON.serializePretty(fillDetails));


        /**Prepare account record */
        Account accountRecord = new Account();
        accountRecord.Name    = UUID.randomUUID()+fillDetails.Name;
        accountRecord.Rating  = fillDetails.Rating;
        accountRecord.Phone   = fillDetails.Phone;
        accountRecord.Active__c = fillDetails.Active__c;

        insert as user accountRecord;

        /**
         * ? Sending the response
         */
        RestResponse res = RestContext.response;
        
        res.statusCode = 200;
        res.responseBody = Blob.valueOf('Successfully Created the Account');
        res.headers.put('Content-Type', 'application/json');
        System.debug(System.JSON.serializePretty(res));

        return JSON.serializePretty(accountRecord);
    }
}