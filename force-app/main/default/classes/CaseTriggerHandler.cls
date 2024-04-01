/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-15-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class CaseTriggerHandler {

    //* After Inser
    public static void afterInsert (List<Case> listOfCases) {
        
        if (listOfCases?.size() > 0) {
            
            for (Case zenCase : listOfCases) {
                //* Calling the Zen Desk wrapper Method from a Trigger
                ZendeskTicketUtils.TicketWrapper wrapper = new ZendeskTicketUtils.TicketWrapper();
                wrapper.body     = zenCase.Description;
                wrapper.priority = zenCase.Priority.toLowerCase() == 'high' ? 'urgent' : 'low';
                wrapper.subject  = zenCase.Subject;
                wrapper.name     = zenCase.Id;
                wrapper.email    = 'Panther.IntegrationTest@mail.com'; //*zenCase.Contact.Email
                System.debug('The email Id of the case ---->🧪' + zenCase.Contact.Email);
                //* we need to pass the sting format to future method
                String ticketDetials = JSON.serialize(wrapper);
                makeCallout(ticketDetials);
            }
        }
    }

    @future(callout = true)
    public static void makeCallout(String ticketDetials) {
        //* convert Sting to Object 
        ZendeskTicketUtils.TicketWrapper wrapper = (ZendeskTicketUtils.TicketWrapper) JSON.deserialize(ticketDetials, ZendeskTicketUtils.TicketWrapper.class);
        System.debug('The Wrapper details 🐣 :'+ wrapper);
        ZendeskTicketUtils.createTicket(wrapper);
    }
}