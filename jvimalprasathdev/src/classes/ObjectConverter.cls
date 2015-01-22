/**
 * Object Converter can convert any standard or custom object to one or more standard or custom objects 
 *
 * Author: Sunil Nautiyal
 **/


public with sharing class ObjectConverter {
	public static boolean isRunning = false;
	public String errorMessage='';
	public String targetId = '';

	private static ObjectConverter instance = null;
	
	// Map of mapping name and list of mapping object
	private static Map<String, List<ObjectConvertorMapping__c>> objConSettingDet = new Map<String, List<ObjectConvertorMapping__c>>();
	// source and target api fields name
	private static Map<List<String>,List<String>> source_target_field_List = new Map<List<String>,List<String>>();
	
	private static Map<String,List<String>> source_field_List = new Map<String,List<String>>();
	private static Map<String,List<String>> target_field_List = new Map<String,List<String>>();
	private static String source_Object_Name;
	private static String target_Object_Name;
	
	private ObjectConverter(){
		getSettingInfo();
	}
	
	
	
	public static ObjectConverter getInstance(){
        if(instance == null) instance = new ObjectConverter();
        return instance;
    }
	
	
	
	public boolean getConverter(String mappingSettingName, String recId){
		try{
			isRunning = true;
			List<ObjectConvertorMapping__c> objConMappingList  = objConSettingDet.get(mappingSettingName.tolowerCase().trim());
  	    	System.debug('objConMappingList >>>>> ' + objConMappingList);

			getSourceTargetDetails(objConMappingList);
			String query = 'select ' + joinList(source_field_List.get(source_Object_Name),',') + ' from ' + source_Object_Name +  ' Where id = \'' + recId + '\'';
  	    	System.debug('Query >>>>> ' + query);

  	    	Sobject LeadList = Database.Query(query);
    		createTargetObject(LeadList, objConMappingList);
    		isRunning = false;
    		return true;
		}catch(Exception e){
			System.debug('Error: ' + e.getMessage());
			errorMessage = e.getMessage();
		}
		isRunning = false;
		return false;	
	}
	
	private  void getSettingInfo(){
		for(ObjectConvertorMapping__c objConMap : ObjectConvertorMapping__c.getall().values()){
			if(objConSettingDet.containsKey(objConMap.Mapping_Name__c.tolowercase().trim())){
				objConSettingDet.get(objConMap.Mapping_Name__c.tolowercase().trim()).add(objConMap);
			}else{
				List<ObjectConvertorMapping__c> mappingList = new List<ObjectConvertorMapping__c>();
				mappingList.add(objConMap);
				objConSettingDet.put(objConMap.Mapping_Name__c.tolowercase().trim(),mappingList);
			}
		}
	}


	private  void getSourceTargetDetails(List<ObjectConvertorMapping__c> objConMappingList){
		List<String> sourceApi = new List<String>();
		List<String> targetApi = new List<String>();
		
		for(ObjectConvertorMapping__c mappingRec : objConMappingList){
			source_Object_Name = mappingRec.Source_Object_Name__c.trim();
			target_Object_Name = mappingRec.Target_Object_Name__c.trim();

			//source_target_objectName.put(sourceObjName,targetObjName);
			sourceApi.add(mappingRec.Source_Api_Name__c);
			targetApi.add(mappingRec.Target_API_Name__c);
						
		}
		source_target_field_List.put(sourceApi, targetApi);
		source_field_List.put(source_Object_Name,sourceApi);
		target_field_List.put(target_Object_Name,targetApi);
	}

	private  void createTargetObject(Sobject sourceRecord, List<ObjectConvertorMapping__c> objConMappingList){
		
		sObject dynObject= Schema.getGlobalDescribe().get(target_Object_Name).newSObject();
    	Schema.sObjectType objectDef = Schema.getGlobalDescribe().get(target_Object_Name).getDescribe().getSObjectType();
    	Map<String, Schema.SobjectField> objectFieldsMap = objectDef.getDescribe().fields.getMap(); 
    	
    	Schema.sObjectType objectDef_source = Schema.getGlobalDescribe().get(source_Object_Name).getDescribe().getSObjectType();
    	Map<String, Schema.SobjectField> objectFieldsMap_source = objectDef_source.getDescribe().fields.getMap(); 
    	
		 
		for(ObjectConvertorMapping__c mappingRec : objConMappingList){
			if(mappingRec.Is_Static__c && !mappingRec.Source_Object_Action__c){
				dynObject.put(mappingRec.Target_API_Name__c , mappingRec.Static_Value__c) ;
			}else if(!mappingRec.Source_Object_Action__c){
				if((objectFieldsMap_source.get(mappingRec.Source_API_Name__c).getDescribe().getType().name().ToLowerCase()).equalsIgnoreCase(objectFieldsMap.get(mappingRec.Target_API_Name__c).getDescribe().getType().name().ToLowerCase())){
    				dynObject.put(mappingRec.Target_API_Name__c , sourceRecord.get(mappingRec.Source_Api_Name__c)) ;
    			}else{
		        	convertToFieldType(dynObject,mappingRec.Target_API_Name__c,objectFieldsMap.get(mappingRec.Target_API_Name__c).getDescribe().getType().name().ToLowerCase() , sourceRecord, mappingRec.Source_Api_Name__c);
    			}
			}
	    }
	     
		insert dynObject;
		targetId = dynObject.Id;
		updateSourceObject(sourceRecord, dynObject, objConMappingList);
	}

	private  void updateSourceObject (Sobject sourceRecord, Sobject target_dynObject, List<ObjectConvertorMapping__c> objConMappingList){
		
		//sObject updateObj;      
    	Schema.sObjectType objectDef = Schema.getGlobalDescribe().get(Source_Object_Name).getDescribe().getSObjectType();
    	Map<String, Schema.SobjectField> objectFieldsMap = objectDef.getDescribe().fields.getMap();
    	
    	Schema.sObjectType objectDef_target = Schema.getGlobalDescribe().get(Target_Object_Name).getDescribe().getSObjectType();
    	Map<String, Schema.SobjectField> objectFieldsMap_target = objectDef_target.getDescribe().fields.getMap(); 
    	
    	//updateObj = objectDef.newSobject(sourceRecord.Id);
    	
   		 for(ObjectConvertorMapping__c mappingRec : objConMappingList){
			if(mappingRec.Is_Static__c && mappingRec.Source_Object_Action__c){
				sourceRecord.put(mappingRec.Source_API_Name__c , mappingRec.Static_Value__c) ;
			}else if(mappingRec.Source_Object_Action__c){
				
    			if((objectFieldsMap_target.get(mappingRec.Target_Api_Name__c).getDescribe().getType().name().ToLowerCase()).equalsIgnoreCase(objectFieldsMap.get(mappingRec.Source_API_Name__c).getDescribe().getType().name().ToLowerCase())){
    				sourceRecord.put(mappingRec.Source_API_Name__c , target_dynObject.get(mappingRec.Target_Api_Name__c)) ;
    			}else{
	        		convertToFieldType(sourceRecord,mappingRec.Source_API_Name__c,objectFieldsMap.get(mappingRec.Source_API_Name__c).getDescribe().getType().name().ToLowerCase() , target_dynObject, mappingRec.Target_Api_Name__c);
    			}
			}
	    }
	    update sourceRecord;
	}
	
	private  void convertToFieldType(sObject dynObject,String apiName, String fieldType, Sobject sourceRecord, String sourceApiName ){
			
        if(fieldType == 'double' || fieldType == 'percent' || fieldType == 'decimal' ){
        	String str = (String) sourceRecord.get(sourceApiName);
        	if(str !=null)
	     	dynObject.put(apiName , Decimal.valueOf(str)) ;
        }else if(fieldType == 'boolean'){
        	dynObject.put(apiName , Boolean.valueOf(sourceRecord.get(sourceApiName))) ;
        }else if(fieldType == 'date'){
        	dynObject.put(apiName , Date.valueOf(sourceRecord.get(sourceApiName))) ;
        }else{
            dynObject.put(apiName , sourceRecord.get(sourceApiName)) ;
        }
    }
    
    
    private String joinList(List<String> theList, String separator) {

        if (theList == null)   { return null; }
        if (separator == null) { separator = ''; }

        String joined = '';
        Boolean firstItem = true;
        for (String item : theList) {
            if(null != item) {
                if(firstItem){ firstItem = false; }
                else { joined += separator; }
                joined += item;
            }
        }
        return joined;
    }

}