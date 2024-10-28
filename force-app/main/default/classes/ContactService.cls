/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 10-23-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ContactService {

    @AuraEnabled(cacheable = true)
    public static List<Account> getAccount(String search){
        
        return [SELECT Id, Name, Rating, AnnualRevenue, Phone, CreatedDate, OwnerId, Owner.Name, Active__c, Website FROM Account WHERE Name LIKE : '%'+search+'%' LIMIT 10];
    }


    @AuraEnabled(cacheable = true)
    public static List<Contact> getContactList(String firstName) {
        //* returning 10 contacts
        List<Contact> contactList = [SELECT Id, Name, Email, Phone, AccountId, Account.Name FROM Contact WHERE Name LIKE :'%'+firstName+'%' WITH USER_MODE LIMIT 10];
        return contactList;
    }

    @AuraEnabled
    public static List<Account> getAccountList(String key){
        //* returning 10 account records
        List<Account> accountList = [SELECT Id, Name, Industry, Phone FROM Account WHERE Name LIKE : '%'+key+'%' WITH USER_MODE LIMIT 10];
        return accountList;
    }

    @AuraEnabled
    public static Account createAccount( String params){
        
        //* Deserializing the JSON string
        Map<String, Object> paramsMap = (Map<String, Object>)JSON.deserializeUntyped(params);
        //* Creating the Account
        System.debug('The values comming from LWC:' + paramsMap);

        AccountWrapper wrapper = new AccountWrapper();
        wrapper.name = (String)paramsMap.get('name');
        wrapper.industry = (String)paramsMap.get('industry');
        wrapper.phone = (String)paramsMap.get('phone');

        Account acc = wrapper.getAccountInstance(wrapper);       
        insert acc;
        Account insertedacc = [SELECT Id, Name, Industry, Phone FROM Account WHERE Name LIKE '%JSON%' WITH USER_MODE LIMIT 1];
        return insertedacc;
    }

    public class AccountWrapper {
        @AuraEnabled
        public String name {get;set;}
        @AuraEnabled
        public String industry {get;set;}
        @AuraEnabled
        public String phone {get;set;}

        // Method to convert AccountWrapper to an Account instance
        public Account getAccountInstance(AccountWrapper wrapper) {
            Account acc = new Account();
            acc.Name = wrapper.name;
            acc.Industry = wrapper.industry;
            acc.Phone = wrapper.phone;
            return acc;
        }
    }
}