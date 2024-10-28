/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-02-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class JsonDeserializeWrapper {
        public invoiceList[] invoiceList;
        public class invoiceList {
            public Double totalPrice;	//5.5
            public String statementDate;	//2011-10-04T16:58:54.858Z
            public lineItems[] lineItems;
            public Integer invoiceNumber;	//1
        }
        public class lineItems {
            public Decimal UnitPrice;	//1
            public Decimal Quantity;	//5
            public String ProductName;	//Pencil
            public Integer Rollnumber;
        }
}