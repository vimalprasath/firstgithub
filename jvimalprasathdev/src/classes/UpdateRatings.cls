public with sharing class UpdateRatings {

private static Map<String,String> mappings_Map = new Map<String,String>();
    
    public static void getOppRatings(List<Opportunity> opps){
        init();
        for(Opportunity opp: opps){
            obj = opp;
            initFieldDetails(opp,null);
            updateRating();
            opp.Rating__c = ratingValue;
            ratingValue = null;
            //updateOppRating(opp);
        }
    }
    
    
    public static void getLeadRatings(List<Lead> leads){
        init();
        for(Lead ld: leads){
            obj = ld;
            initFieldDetails(null,ld);
            updateRating();
            ld.Rating = ratingValue;
            ratingValue = null;
        }
    }
    
    private static sObject obj;
    private static String objName;
    private static String loanPurpose;
    private static String status;
    private static String stage;
    private static String timeToApply;
    private static String ratingValue;
    //private static Map<String, StatusRatingMapping__c> cs;
    private static Map<Integer, StatusRatingMapping__c> cs_int;
    private static List<Integer> keys;
    //private static Pattern objectName_p,loanPurpose_p,status_p,stage_p,timeToApply_p;
    
    private static  void init(){
        Map<String, StatusRatingMapping__c> cs = StatusRatingMapping__c.getAll();

        cs_int = new Map<Integer, StatusRatingMapping__c>();
        for(String key : cs.keySet()){
            cs_int.put(Integer.valueOf(key), cs.get(key));
        }
        
        keys = new List<Integer>(cs_int.keySet());
        keys.sort();
        
    }
    private static void initFieldDetails(Opportunity opp, Lead ld){
        
        objName = (ld!=null)? 'Lead':'Opportunity';
        loanPurpose = (ld!=null)? ld.Loan_Purpose__c:opp.Loan_Purpose__c;
        status = (ld!=null)? ld.status:opp.Loan_Status__c;
        stage = (ld!=null)? ld.Lead_Stage__c :opp.StageName;
        timeToApply = (ld!=null)? ld.Shopping_Stage__c:opp.Shopping_Stage__c;
    }
    
    private static void updateRating(){
            
        for(Integer key : keys){
            StatusRatingMapping__c srm = cs_int.get(key);
            if(!srm.Is_Default__c ){
            
            Pattern objectName_p  = Pattern.compile('(?i)' + String.join(new List<String>(srm.Object_Name__c.split(';')),'|'));
            Pattern loanPurpose_p = Pattern.compile('(?i)' + String.join(new List<String>(srm.LoanPurpose__c.split(';')),'|').replace('+','\\+'));
            Pattern status_p = Pattern.compile('(?i)' + String.join(new List<String>(srm.Status__c.split(';')),'|').replace('+','\\+'));
            Pattern stage_p = Pattern.compile('(?i)' + String.join(new List<String>(srm.stage__c.split(';')),'|').replace('+','\\+'));
            Pattern timeToApply_p = Pattern.compile('(?i)' + String.join(new List<String>(srm.Time_To_Apply__c.split(';')),'|').replace('+','\\+'));
               
               if(  
                   objectName_p.matcher(objName).matches() &&
                   ( (srm.LoanPurpose__c.trim()).equalsIgnoreCase('Any')  || loanPurpose_p.matcher(loanPurpose).find() ) &&
                   ( (srm.Status__c.trim()).equalsIgnoreCase('Any') || status_p.matcher(status).matches() ) &&
                   ( (srm.stage__c.trim()).equalsIgnoreCase('Any')  || stage_p.matcher(stage).matches() ) &&
                   ( (srm.Time_to_Apply__c.trim()).equalsIgnoreCase('Any') ||  timeToApply_p.matcher(timeToApply).matches())
                  )
                   
                {
                    
                    ratingValue = srm.Rating__c;
                    break;
                }
                ratingValue = '';
            }
        }
        
        if(ratingValue==''){
            for(Integer key : Keys){
                StatusRatingMapping__c srm = cs_int.get(key);
                Pattern objectName_p  = Pattern.compile('(?i)' + String.join(new List<String>(srm.Object_Name__c.split(';')),'|'));
                
                if(srm.Is_Default__c && objectName_p.matcher(objName).matches()){
                    List<String> fields = srm.Default_Mapping_Fields_Name__c.split(';');
                     String rating = '';
                     for(String fld : fields){
                        String[] str = fld.split('=');
                        
                        Pattern defaultPattern = Pattern.compile('(?i)' + String.join(new List<String>(String.valueOf(srm.get(str[0].trim())).split(';')),'|').replace('+','\\+'));
                        if(!( (String.valueOf(srm.get(str[0].trim()))).equalsIgnoreCase('Any') ||  defaultPattern.matcher(String.valueOf(obj.get(str[1].trim()))).find()   ) ){
                            ratingValue ='';
                            break;
                        }
                        ratingValue = srm.Rating__c;
                     }
                     
                     if(!ratingValue.equalsIgnoreCase('')){
                        break;
                     }
                }
            }
        }   
            
    }
    
    

}