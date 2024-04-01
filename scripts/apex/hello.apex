// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

String json='{"invoiceList":[{"totalPrice":5.5,"statementDate":"2011-10-04T16:58:54.858Z","lineItems":[{"UnitPrice":1.0,"Quantity":5.0,"ProductName":"Pencil"},{"UnitPrice":0.5,"Quantity":1.0,"ProductName":"Eraser"}],"invoiceNumber":1}'+
		',{"totalPrice":11.5,"statementDate":"2011-10-04T16:58:54.858Z","lineItems":[{"UnitPrice":6.0,"Quantity":1.0,"ProductName":"Notebook"},{"UnitPrice":2.5,"Quantity":1.0,"ProductName":"Ruler"},{"UnitPrice":1.5,"Quantity":2.0,"ProductName":"Pen"}],"invoiceNumber":2}]}'+
		'';

JsonDeserializeWrapper obj = (JsonDeserializeWrapper) System.JSON.deserialize(json, JsonDeserializeWrapper.class);
System.debug('The Object 🥸'+ obj);
System.debug('The Invoice List ✅'+ obj.invoiceList[0]);


for (JsonDeserializeWrapper.invoiceList listValues : obj.invoiceList) {
    System.debug('List of values 🐣:'+listValues);
    
    for (JsonDeserializeWrapper.lineItems listLine : listValues.lineItems) {
        System.debug('List of line Items 🦁:'+listLine);
        System.debug('List of Price 🦁💰:'+listLine.UnitPrice);
        System.debug('List of Quantity 🦁🦆:'+listLine.Quantity);
    }
}


JsonDeserializeWrapper.invoiceList myInvoice = obj.invoiceList[0];
System.debug('My invoice :🚀'+myInvoice.totalPrice);
    

JsonDeserializeWrapper.lineItems myLineItems = myInvoice.lineItems[0];
System.debug('My LineItems :🚀'+myLineItems.Quantity);



JsonSerializeWrapper wrapper = new JsonSerializeWrapper();

JsonSerializeWrapper.comment comment = new JsonSerializeWrapper.comment();
comment.body='Body of the comment';

JsonSerializeWrapper.requester requester = new JsonSerializeWrapper.requester();
requester.name = 'Ava';
requester.email = 'ava@mail.com';
requester.locale_id = 20;

JsonSerializeWrapper.ticket ticket = new JsonSerializeWrapper.ticket();
ticket.priority = 'High';
ticket.subject = 'Test Serialize';
ticket.comment = comment;
ticket.requester = requester;

wrapper.ticket = ticket; 

String stringOfObj = System.JSON.serialize(wrapper);
System.debug('Serialized string 🚀'+stringOfObj);