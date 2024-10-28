/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 10-28-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
//* Scenario 1 for the SF_Exclusive
public with sharing class ApexRestCalloutSenario1 {

    public static void getUserDetails() {

        Http httpObj = new Http();

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://reqres.in/api/users');
        req.setHeader('Content-Type', 'applicarion/json');
        req.setMethod('GET');
        //req.setBody(''); //{}

        HttpResponse response = httpObj.send(req);
        System.debug('@@@Response Body: '+ response.getBody());
    }
    
    public static void createUsers() {

        Http httpObj = new Http();

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://reqres.in/api/users');
        req.setHeader('Content-Type', 'applicarion/json');
        req.setMethod('POST');
        req.setBody('{"name": "Sagar", "job": "leader"}');

        HttpResponse response = httpObj.send(req);
        System.debug('@@@Response Body: '+ response.getBody());
    }
}