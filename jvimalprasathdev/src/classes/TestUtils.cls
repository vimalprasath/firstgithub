// Potential limitation: Total number of fields calls allowed is 10

public with sharing class TestUtils {

    public static String EMAIL_SUFFIX = '@company.com';

    public static String URL_PREFIX = 'http://www.google.com/';

    //method takes an object name as a parameter and returns a record of that object with
    //all required fields populated, based on the data type

    public static SObject createSObjectRecord(String sObjectName){
        Map<String, Schema.SObjectType> sObjMap= Schema.getGlobalDescribe();
        Schema.SObjectType sObjectToken = sObjMap.get(sObjectName);
        System.debug('sObjectToken= ' + sObjectToken);

        SObject sObjectRecord = sObjectToken.newSObject();
        System.debug('sObjectRecord= ' + sObjectRecord);

        Map<String,Schema.SObjectField> sObjectFieldsMap = sObjectToken.getDescribe().fields.getMap();
        sObject sObjRec=createSObjectRecordPrivate(sObjectRecord,sObjectFieldsMap);
        return sObjRec;
    }
    
    private static SObject createSObjectRecordPrivate(SObject sObjectRecord, Map<String,Schema.SObjectField> sObjectFieldsMap){
        //iterate through fields to assign them proper values
        Integer Count=0;
        for(String fieldName: sObjectFieldsMap.keySet()){
            if (count>=10){
                break;
            }else{
                if (fieldName.contains('__c')){//note only custom fields can be set to required.  However doesn't account for validation rules...
                    SObjectField fieldToken = sObjectFieldsMap.get(fieldName);
                    DescribeFieldResult fieldDescribe = fieldToken.getDescribe();
                    count+=assignFieldValue(sObjectRecord,fieldDescribe);
                }//if
            }//if
        }//for    
        return sObjectRecord;
    }
    /**
    * Fields that can be unique in SFDC:
    * 1. email
    * 2. number
    * 3. text
    */
    
    public static Integer assignFieldValue(SObject sObjectRecord, DescribeFieldResult fieldDescribe){
        Schema.DisplayType fType=fieldDescribe.getType();
        String fName=fieldDescribe.getName();
        Integer count=0;
        /*
        System.debug('FIELD NAME: ' + fName);
        System.debug('FIELD TYPE: ' + fType);
        System.debug('fieldDescribe.isCreateable(): ' + fieldDescribe.isCreateable());
        System.debug('fieldDescribe.isNillable(): ' + fieldDescribe.isNillable());
        System.debug('fieldDescribe.isDefaultedOnCreate(): ' + fieldDescribe.isDefaultedOnCreate());
        System.debug('fieldDescribe.isAutoNumber(): ' + fieldDescribe.isAutoNumber());
        System.debug('fieldDescribe.isCalculated(): ' + fieldDescribe.isCalculated());
        */
        //if a field is required, specify value:
        //only add 1 to count if: creatable, not nillable, not defaulted, not an auto number, and not calculated
        if( fieldDescribe.isCreateable() && !fieldDescribe.isNillable() && !fieldDescribe.isDefaultedOnCreate()&& !fieldDescribe.isAutoNumber() && !fieldDescribe.isCalculated()){
            count++;//increment as the # fieldDescribe results is limited
            //check if field is unique
            if(fieldDescribe.isUnique()){
            //text fields: String, TextArea, EncryptedString
                if(fType == Schema.DisplayType.STRING || fType == Schema.DisplayType.TEXTAREA ||fType == Schema.DisplayType.ENCRYPTEDSTRING){
                    sObjectRecord.put(fName, constructUniqueText(fieldDescribe.getLength()));
                } //number fields
            else if(fType == Schema.DisplayType.DOUBLE){
                sObjectRecord.put(fName,constructUniqueNumber(fieldDescribe.getPrecision() - fieldDescribe.getScale(),fieldDescribe.getScale()));
            }//number fields
            else if(fType == Schema.DisplayType.INTEGER){
                sObjectRecord.put(fName,constructUniqueInteger(fieldDescribe.getDigits()));
            }
            else if(fType == Schema.DisplayType.EMAIL){
                sObjectRecord.put(fName, constructUniqueText(fieldDescribe.getLength()) + EMAIL_SUFFIX);
            }//if 2
        }else{
        //just give it a value
        //text fields
            if(fType == Schema.DisplayType.STRING || fType == Schema.DisplayType.TEXTAREA ||fType == Schema.DisplayType.ENCRYPTEDSTRING){
                sObjectRecord.put(fName, constructUniqueText(fieldDescribe.getLength()));
            }else if(fType == Schema.DisplayType.DOUBLE || fType == Schema.DisplayType.CURRENCY|| fType == Schema.DisplayType.PERCENT){
                System.debug('GENERATION OF A DOUBLE NUMBER START ...');
                System.debug('fName ' + fName);
                System.debug('fieldDescribe.getPrecision() ' + fieldDescribe.getPrecision());
                System.debug('fieldDescribe.getScale() ' + fieldDescribe.getScale());
                sObjectRecord.put(fName,constructUniqueNumber(fieldDescribe.getPrecision() - fieldDescribe.getScale(),fieldDescribe.getScale()));
                System.debug('GENERATION OF A DOUBLE NUMBER END ...');
            }else if(fType == Schema.DisplayType.INTEGER){
                sObjectRecord.put(fName,constructUniqueNumber(fieldDescribe.getDigits(),0));
            }else if(fType == Schema.DisplayType.EMAIL){
                sObjectRecord.put(fName, constructUniqueText(fieldDescribe.getLength()) + EMAIL_SUFFIX);
            }else if(fType == Schema.DisplayType.URL){
                sObjectRecord.put(fName, URL_PREFIX + constructUniqueText(fieldDescribe.getLength()));
            }else if(fType == Schema.DisplayType.DATE){
                sObjectRecord.put(fName, System.today());
            }else if(fType == Schema.DisplayType.DATETIME){
                sObjectRecord.put(fName, System.now());
            }else if(fType == Schema.DisplayType.PHONE){
                System.debug('GENERATION OF A PHONE NUMBER START ...');
                sObjectRecord.put(fName, constructUniqueText(fieldDescribe.getLength()));
                System.debug('GENERATION OF A PHONE NUMBER END ...');
            }else if(fType == Schema.DisplayType.COMBOBOX){
                sObjectRecord.put(fName, constructUniqueText(fieldDescribe.getLength()));
            }else if(fType == Schema.DisplayType.MULTIPICKLIST){
                sObjectRecord.put(fName, constructUniqueText(fieldDescribe.getLength()));
            }else if(fType == Schema.DisplayType.PICKLIST){
                sObjectRecord.put(fName, constructUniqueText(fieldDescribe.getLength()));
            }else if(fType == Schema.DisplayType.TIME){
                sObjectRecord.put(fName, System.now());
            }else if(fType == Schema.DisplayType.REFERENCE){
                List<Schema.sObjectType> referenceToList = fieldDescribe.getReferenceTo();
                String referenceSObjectName;
                if(referenceToList != null && referenceToList.size()>0){
                    referenceSObjectName = referenceToList[0].getDescribe().getName();
                }//if 3
                String Id = findReference(referenceSObjectName);
                if(Id != null)
                    sObjectRecord.put(fName, Id);
                }//if 3
            }//if 2
        }//some fields are nillable, but ARE required! for now only reference type of fields are handled below:
            // else if(fieldDescribe.isCreateable() ){
            // if(fType == Schema.DisplayType.REFERENCE){
                // List referenceToList = fieldDescribe.getReferenceTo();
                // String referenceSObjectName;
                // System.debug('referenceToList: ' + referenceToList);
                //
                // //skip polymorphic references
                // if(referenceToList != null && referenceToList.size()>0 && referenceToList.size() < 2){
                    // referenceSObjectName = referenceToList[0].getDescribe().getName();
                    // System.debug('referenceSObjectName: ' + referenceSObjectName);
                    // String Id = findReference(referenceSObjectName);
                // if(Id != null)
                    // sObjectRecord.put(fName, Id);
                // }
            // }
        // }
        return count;
    }
 
    private static String findReference(String referenceSObjectName){
    //get any record of type 'referenceSObjectName'
        SObject[] obj = Database.query('SELECT ID FROM ' + referenceSObjectName + ' LIMIT 1');
        if(obj != null && obj.size()> 0){
            return obj[0].Id;
        }else{
            return null;
        }//if    
    }//findReference
 
    private static Integer constructUniqueInteger(Integer intSize){
        String uniqueKey = String.valueOf(System.now().getTime());
        System.debug('uniqueKey: ' + uniqueKey);
        String intPart = '';
        //if it is Integer
        if(intSize != null && intSize != 0){
            if(intSize < uniqueKey.length()){
                intPart = uniqueKey.substring(uniqueKey.length() - intSize,uniqueKey.length());
            }else{
                intPart = uniqueKey;
            }//if 2
        }//if 1
        System.debug('uniqueKey: ' + uniqueKey);
        System.debug('intPart: ' + intPart);
        return Integer.valueOf(intPart);
    }//constructUniqueInteger
    
    private static Double constructUniqueNumber(Integer intSize, Integer fractSize){
        String uniqueKey = String.valueOf(System.now().getTime());
        System.debug('uniqueKey: ' + uniqueKey);
        String fractPart = '';
        String intPart = '';

        //if it is double
        if(fractSize != null && fractSize != 0){
            if(fractSize < uniqueKey.length()){
                fractPart = '.' + uniqueKey.substring(uniqueKey.length() - fractSize,uniqueKey.length());
            }else{
                fractPart = uniqueKey;
            }//if 2
        }//if 1
            
        System.debug('fractPart: ' + fractPart);
        if(intSize != null && intSize != 0){
            if(intSize < uniqueKey.length()){
                intPart = uniqueKey.substring(uniqueKey.length() - intSize,uniqueKey.length());
            }else{
                intPart = uniqueKey;
            }//if 2
        }//if 1
        System.debug('uniqueKey: ' + uniqueKey);
        System.debug('intPart + fractPart: ' + (intPart + fractPart));
    
        if(!fractPart.contains('.')){
            return Double.valueOf(intPart + fractPart + '.0');
        }else{
            return Double.valueOf(intPart + fractPart);
        }//if    
    }//constructUniqueNumber

    private static String constructUniqueText(Integer fieldSize){
        String uniqueKey = String.valueOf(System.now().getTime());
        if(fieldSize < uniqueKey.length()){
            return uniqueKey.substring(uniqueKey.length() - fieldSize,uniqueKey.length());
        }
        else
            return uniqueKey;
    //return null;
    }//constructUniqueText
}