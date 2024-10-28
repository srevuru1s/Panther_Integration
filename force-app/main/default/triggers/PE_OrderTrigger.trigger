/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-14-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger PE_OrderTrigger on Order_Status__e (after insert) {
    System.debug('PE for Order Trigger');
    System.debug('Order Data:'+ JSON.serializePretty(Trigger.new));
}