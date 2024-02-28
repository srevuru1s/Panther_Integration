/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-27-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ForwardGeoCodingWrapper {
    public results[] results;
	public class results {
		public components components;
		public Integer confidence;	//9
		public String formatted;	//Goethe-Nationalmuseum, Frauenplan 1, 99423 Weimar, Germany
		public geometry geometry;
	}
	public class components {
		public String category;	//outdoors/recreation
		public String normalized_city;	//Weimar
		public String type;	//museum
		public String continent;	//Europe
		public String country;	//Germany
		public String country_code;	//de
		public String house_number;	//1
		public String museum;	//Goethe-Nationalmuseum
		public String political_union;	//European Union
		public String postcode;	//99423
		public String road;	//Frauenplan
		public String state;	//Thuringia
		public String state_code;	//TH
		public String suburb;	//Altstadt
		public String town;	//Weimar
	}
	public class geometry {
		public Double lat;	//50.9775106
		public Double lng;	//11.3285424
	}
	
}