/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-27-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ReverseGeoCodingWrapper {
    public results[] results;
	public class results {
		public components components;
		public Integer confidence;	//10
		public distance_from_q distance_from_q;
		public String formatted;	//Design Offices, Philipsbornstraße 2, 30165 Hanover, Germany
		public geometry geometry;
	}
	public class components {

		public String city;	//Hanover
		public String city_district;	//Vahrenwald-List
		public String continent;	//Europe
		public String country;	//Germany
		public String country_code;	//de
		public String county;	//Region Hannover
		public String house_number;	//2
		public String office;	//Design Offices
		public String political_union;	//European Union
		public String postcode;	//30165
		public String road;	//Philipsbornstraße
		public String state;	//Lower Saxony
		public String state_code;	//NI
		public String suburb;	//Vahrenwald
	}
	public class distance_from_q {
		public Integer meters;	//0
	}
	public class geometry {
		public Double lat;	//52.387783
		public Double lng;	//9.7334394
	}

}