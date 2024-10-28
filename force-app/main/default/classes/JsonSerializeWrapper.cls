/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-19-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class JsonSerializeWrapper {
	//* Example for Serialize 
	public integer rollNumber;
    public ticket ticket;
	
	public class ticket {
		public comment comment;
		public String priority;	//urgent
		public String subject;	//My printer is on fire!
		public requester requester;
	}
	public class comment {
		public String body;	//The smoke is very colorful.
	}
	public class requester {
		public Integer locale_id;	//8
		public String name;	//Pablo
		public String email;	//pablito@example.org
	}
}