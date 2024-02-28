// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

Account accList = [SELECT Id, Type FROM Account WHERE TYPE = null LIMIT 1];

String nullType1 = null;
String nullType2 = null;
String nullType3 = 'N/A';
accList.Type = accList.Type ?? nullType1 ?? nullType2 ?? nullType3;

System.debug('Null collation :' + accList.Type);

List<Account> acc1 = new List<Account>();
List<Account> accList = [SELECT Id, Type FROM Account WHERE TYPE = null LIMIT 1];

if (!acc1.isEmpty()) {
    System.debug('Im not empty');
}

Account acc = null;

String myName = acc?.Name;

System.debug('My Name :' + myName);