/**
    Name: UpdateOPUS
    Description: when an LO is updated for a specific opportunity in Salesforce, their contact information is updated in OPUS
    Story # B411330
**/

public with sharing class UpdateOPUSInfo {
    public static Integer batchSizeLimit = 10;
    private static boolean isRunning = false;
    public static void setAlreadyDone() {  
          isRunning = true; 
    }
     public static boolean hasAlreadyDone(){ 
       return isRunning;
    }
    
    @future(callout=true)
    public static void updateLOService(Set<Id> oppIds){
        if(oppIds.size()>0){
            List<Opportunity> oppDetails = init(oppIds);
            Integer requestNo = 0;
            for(Opportunity opp: oppDetails){
                if(!sendHTTPSRequest(opp.Id, opp.OwnerId, constructXML(opp))){
                    System.debug('Send to OPUS Failed for Opportunity Id' +  opp.Id);
                }
                requestNo++;
                if(requestNo == batchSizeLimit) break;
            }
        }
    }
    
    private static List<Opportunity> init(Set<Id> oppids){
        
        return [select id,ownerId, Empower_Lead_ID__c, owner.FirstName,owner.LastName,owner.Email,owner.Fax,owner.Phone,owner.NMLS_ID__c,owner.Alias,owner.Extension from opportunity where id = :oppids];
        
    }

   private static String constructXML(Opportunity oppDetail){
        try{
            String xmlHeader = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:gw-headers-100" xmlns:urn1="urn:gw-loanserviceenvelope-100" xmlns:urn2="urn:gw-ingdirect-services-lendingservices-contracts-common-100" xmlns:urn3="urn:gw-loanapplication-common-100">' +
                               '<soapenv:Header><urn:Requester_Application>SalesForce</urn:Requester_Application><urn:MinorVersion>14.08.100</urn:MinorVersion><urn:MajorVersion>1</urn:MajorVersion><urn:Service>loan.UpdateLoanOfficerDetails</urn:Service></soapenv:Header>' +
                               '<soapenv:Body><urn1:LoanUpdateLoanOfficerDetailsRequest>';
            
                                
            String xmlFooter =   '</urn1:LoanUpdateLoanOfficerDetailsRequest></soapenv:Body></soapenv:Envelope>';
                
           return       (xmlHeader + getLoanNumber(oppDetail) + getLoanOfficerDetails(oppDetail) +  xmlFooter);
           
        }catch(Exception e){
            System.debug('constrcutXML Error: '+ e);   
            //Changed by Vimal for the Story B-617510 Starts here
           //  createLog(''+oppDetail.id, oppDetail.ownerId, e.getStackTraceString(),e.getMessage());
             ErrorLogHandler ErrObj = new ErrorLogHandler();
             ErrObj.createLog('UpdateOPUSInfo',oppDetail.id, 'OPUS Error','Message: '+ e.getmessage()+ ' Line Number: '+ e.getLineNumber()+' Stack Trace: '+ e.getStackTraceString() ,'' );
             //Changed by Vimal for the Story B-617510 Ends here
        }
        return null;
   }
   
   private static String getLoanNumber(Opportunity oppDetail){
        return '<urn3:loanNumber>'+oppDetail.Empower_Lead_ID__c+'</urn3:loanNumber>';
   }

   private static String getLoanOfficerDetails(Opportunity oppDetail){
    
         String loDetails =  '<urn2:MortgageConsultant>'+
                               '<urn2:Email>'+(string.isblank(String.valueOf(oppDetail.owner.Email))?'':String.valueOf(oppDetail.owner.Email))+'</urn2:Email>'+
                               '<urn2:Extension>'+(string.isblank(String.valueOf(oppDetail.owner.Extension))?'':String.valueOf(oppDetail.owner.Extension))+'</urn2:Extension>'+
                               '<urn2:FaxNumber>'+(string.isblank(String.valueOf(oppDetail.owner.Fax))?'':String.valueOf(oppDetail.owner.Fax))+'</urn2:FaxNumber>'+
                               '<urn2:FirstName>'+(string.isblank(String.valueOf(oppDetail.owner.FirstName))?'':String.valueOf(oppDetail.owner.FirstName))+'</urn2:FirstName>'+
                               '<urn2:LastName>'+(string.isblank(String.valueOf(oppDetail.owner.LastName))?'':String.valueOf(oppDetail.owner.LastName))+'</urn2:LastName>'+
                               '<urn2:MloId>'+(string.isblank(String.valueOf(oppDetail.owner.NMLS_ID__c))?'':String.valueOf(oppDetail.owner.NMLS_ID__c))+'</urn2:MloId>'+
                               '<urn2:PhoneNumber>'+(string.isblank(String.valueOf(oppDetail.owner.Phone))?'':String.valueOf(oppDetail.owner.Phone))+'</urn2:PhoneNumber>'+
                               '</urn2:MortgageConsultant>';
    
        return loDetails;
    
   }    
   
   private static Boolean sendHTTPSRequest(String oppId, String ownerId, String xmlRequest){
    
        if(xmlRequest == null ) return false;
        
        System.debug('HTTP Request: '+ xmlRequest);
        HttpRequest req = new HttpRequest();    
        req.setEndpoint(Label.OPUS_URL); 
        try{
            req.setClientCertificateName(Label.OPUS_Certificate);
        }catch (Exception ex){
            System.debug('CERTIFICATION error: ' + ex);
            //return false;
            //Changed by Vimal for the Story B-617510 Starts here
           // createLog(oppId,ownerId,ex.getStackTraceString(),ex.getMessage());
            ErrorLogHandler ErrObj = new ErrorLogHandler();
            ErrObj.createLog('UpdateOPUSInfo',oppId, 'OPUS Error','Message: '+ ex.getmessage()+ ' Line Number: '+ ex.getLineNumber()+' Stack Trace: '+ ex.getStackTraceString() ,'' );
             //Changed by Vimal for the Story B-617510 Ends here
        } 
           
        req.setMethod('POST');
        req.setHeader('SOAPAction','Invoke');      
        req.setHeader('Content-Type','text/xml;charset=UTF-8');     
        req.setHeader('User-Agent','Jakarta Commons-HttpClient/3.1');   
        req.setBody(xmlRequest);              
        
        Http http = new Http();     
        String bodyRes = '';            


        try {           
            System.debug('CALL Lead Service');
            HttpResponse res;
          
             if(!Test.isRunningTest())
             {
                 res = http.send(req);
             }
             else
             {
                 res = UpdateOPUSInfo.respond(req);
               //  createLog(oppId,ownerId,'Send','Successfully Send');
             }
             
             bodyRes = res.getBody();            
             System.debug('Response Received' + bodyRes); 
              //Changed by Vimal for the Story B-617510 Starts here
              if(String.valueOf(res.getStatusCode()).startswith('4'))
             {
             ErrorLogHandler ErrObj = new ErrorLogHandler();
             ErrObj.createLog('UpdateOPUSInfo',oppId, 'OPUS Error','Unable Connect to the mentioned URL','' );
             }   
               //Changed by Vimal for the Story B-617510 Ends here   
        }  catch(System.CalloutException e) {            
                 System.debug('CALLOUT error: '+ e);   
                //Changed by Vimal for the Story B-617510 Starts here
               //  createLog(oppId,ownerId,e.getStackTraceString(),e.getMessage());
                  ErrorLogHandler ErrObj = new ErrorLogHandler();
                  ErrObj.createLog('UpdateOPUSInfo',oppId, 'OPUS Error','Message: '+ e.getmessage()+ ' Line Number: '+ e.getLineNumber()+' Stack Trace: '+ e.getStackTraceString() ,'' );
                   //Changed by Vimal for the Story B-617510 Ends here
                  return false;  
        }   
          
        String status = bodyRes.substringBetween('saveSuccessful>','</');  
        system.debug('$$$$$$$$$$$$$$$$$$$$'+Status);
        if(status !=null && status.equalsIgnoreCase('true')){
            //createLog(oppId,ownerId,bodyRes,bodyRes.substringBetween('saveSuccessful>','</'));
            return Boolean.valueOf(Status);
        }else{
            //Changed by Vimal for the Story B-617510 
            // createLog(oppId,ownerId,bodyRes,bodyRes.substringBetween('saveSuccessful>','</'));
            return false;
        }
   }
   
    public static HTTPResponse respond(HTTPRequest req) {
        System.assertEquals(Label.OPUS_URL, req.getEndpoint());
        
        System.assertEquals('POST', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('<saveSuccessful>true</saveSuccessful>');
        res.setStatusCode(200);
        return res;
    }
    
    //Changed by Vimal for the Story B-617510 Starts here
 /*   private static void createLog(String Source,String ownerId,String response,String Message){
    
        Opus_Log_Detail__c opusErrLogDetailObj = new Opus_Log_Detail__c(Opportunity_Id__c=Source, Owner_Id__c= ownerId, Error_Response__c=response, Error_Message__c=Message);

        insert  opusErrLogDetailObj;
    } */  //Changed by Vimal for the Story B-617510 Ends here
    

}