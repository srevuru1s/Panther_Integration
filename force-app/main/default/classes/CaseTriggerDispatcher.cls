/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-11-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class CaseTriggerDispatcher {
  
    public static void dispatcher(System.TriggerOperation operationType) {
        switch on operationType {

            when  BEFORE_INSERT {
                
            }
            when AFTER_INSERT {
                CaseTriggerHandler.afterInsert(Trigger.new);
            }
            when BEFORE_UPDATE {
            
            }
            when AFTER_UPDATE {
                
            }
            when BEFORE_DELETE {
                
            }
            when AFTER_DELETE {
                
            }
            when AFTER_UNDELETE {
                
            } 
            when else {
                
            }  
        }
    }    
}