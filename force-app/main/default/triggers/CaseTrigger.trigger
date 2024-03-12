/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-11-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger CaseTrigger on Case (before insert, after insert, before update, after update, before delete, after delete, after undelete) {

    CaseTriggerDispatcher.dispatcher(Trigger.operationType) ;
}