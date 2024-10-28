/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-10-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OrderTriggerHandler {
    public static void publishEvent(List<Order> newRecords){

        List<Order_Status__e> events = new List<Order_Status__e>();

        if (newRecords?.size() > 0) {
            //* List of orders to publish 
            List<Order> ordersToPublish = [SELECT Id, OrderNumber FROM Order WHERE Id IN: newRecords];
            //* List of orders to insert

            if (ordersToPublish?.size() > 0) {
                
                for (Order order : ordersToPublish) {
                    
                    Order_Status__e orderStatus = new Order_Status__e();
                    orderStatus.Order_Number__c = order.OrderNumber;
                    orderStatus.Total_Amount_in_USD__c = 0.00;
                    
                    events.add(orderStatus); //* add to the list 
                    
                }
            }
                
        }

        //* check the events before publish
        if (events?.size() > 0) {
            EventBus.publish(events);
            // Integer i = 10/0; //* to introduce the error
        }
    }
}