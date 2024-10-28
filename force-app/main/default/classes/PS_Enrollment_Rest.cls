/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-26-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
/** how the url will be accessed
 * Org Base url - Instance url (always the classic) + services/apexrest/v1/AccountManger/
 * ? https://pantherschool-a-dev-ed.develop.my.salesforce.com/v1/PSEnrollment/
 */
@RestResource(urlMapping = '/v1/PSEnrollment/*')
global with sharing class PS_Enrollment_Rest {
    /**
     * @httpGet-GET
     */
    @httpPost
    global static String getEnrollmentDetails() {
        
        /**Calling the get method */
        List<Account> myReturnedAccounts = AccountManager.getAccountList();
        System.debug('My size of accounts 💰'+ myReturnedAccounts.size());
        /**
         * Collect the request
         */
        RestRequest req = RestContext.request;
        System.debug(JSON.serializePretty(req));
        String jsonBody = req.requestBody?.toString(); //* convert blob into string format
        System.debug('The String of request 🔖:'+ jsonBody);

        //* Deserialise the request 
        PS_Enrollment_Rest.PSEnrollment userDetials = (PS_Enrollment_Rest.PSEnrollment) System.JSON.deserialize(jsonBody, PS_Enrollment_Rest.PSEnrollment.class);
        System.debug('The Deserialised user info 💁:'+ userDetials);

        /** 
         * ?Preparing the account and contcat information
         */
        Account userAccount       = new Account();
        userAccount.Name          = userDetials.first_name + userDetials.last_name;
        userAccount.AccountNumber = userDetials.user_name.toString();
        userAccount.Website       = userDetials.e_mail;

        insert as user userAccount;

        Contact userContact = new Contact();
        userContact.AccountId = userAccount.Id;
        userContact.FirstName = userDetials.first_name;
        userContact.LastName  = userDetials.last_name;
        userContact.Email     = userDetials.e_mail;

        insert as user userContact;

        String userDetails = 'User Details Created:' +userContact.Id + '#' + userDetials.user_name.toString();
        
        /**Sending an email to user */
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{userDetials.e_mail};
        String[] CCAddresses = new String[]{System.Label.CCPantherEmail};
        
        mail.setToAddresses(toAddresses);
        mail.setCcAddresses(CCAddresses);
        mail.setSubject('Welcome to Panther Schools');
        mail.setPlainTextBody('Please find your user name :'+userDetials.user_name.toString());

        Messaging.SendEmailResult [] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        System.debug('Email Results 📧:' + results);

        /**Response from the apex */
        RestContext.response.statusCode = 200; //* Send response with a success code
        RestContext.response.responseBody = Blob.valueOf('Successfully Created the Account');
        System.debug(JSON.serializePretty(RestContext.response));

        return userDetails;
    }
    
    global class PSEnrollment { 

        public String first_name;	//Michaela
        public String last_name;	//Streich
        public String user_name;	//Jamel_Tremblay54
        public String e_mail;	//Kiana_DuBuque@gmail.com
        public String password;
    }
}