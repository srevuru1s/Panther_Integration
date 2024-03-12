/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-12-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ZendeskWrapper {

	public ticket ticket;
	public class ticket {
		public String url;	//https://panther5590.zendesk.com/api/v2/tickets/38.json
		public Integer id;	//38
		public external_id external_id;
		public via via;
	}
    public class external_id {
	}
	public class via {
		public String channel;	//api
		
    }

}