/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 10-28-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
Order_Status__e platform1 = new Order_Status__e();
platform1.Order_Number__c = 'ORD-443';
platform1.Total_Amount_in_USD__c = 9695689.358;

Database.SaveResult sr = EventBus.publish(platform1);
System.debug('Database Results:' + sr.getErrors());
String uuid = EventBus.getOperationId(sr);
System.debug('UUID :' + uuid);

Order_Status__e event = (Order_Status__e) Order_Status__e.SObjectType.newSObject(null, true);
System.debug('Euid :'+ event.EventUuid);

List<Contact> myCon = ContactService.getContactList('Rose Gonzalez');
System.debug('MyCOntac:' + myCon.size());


Account myAccount = new Account(Name = 'LWC1',
                Industry = 'Education',
                Phone    = '573-200-0694',
                Website  = 'www.salesforce.com');

insert myAccount;

System.debug('Inserted Account :'+ [SELECT Id FROM Account WHERE Name = 'LWC']);


parksServices.ParksImplPort parkName = new parksServices.ParksImplPort();
List<String> parkDetails = parkName.byCountry('USA');
System.debug('Parks in USA:' + parkDetails);