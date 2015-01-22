Global class wsLead{
                  
    Webservice Static String[] updateLead(UpdateLoanStatus vloanOpportunity) {
        string[] response = new string[9];  //Changes by Vimal for the story #B528917 
        try{
            Opportunity TmpOpportunity;
            if(vloanOpportunity.EmpowerID != null){
                 TmpOpportunity = [select Loan_Status__c,Empower_Lead_ID__c,Close_Date__c,CloseDate,
                                  Requested_Loan_Amount__c,Rate_Lock_Exp__c,Value_of_Home__c,Loan_Purpose__c,Loan_Term__c from Opportunity 
                                     where Empower_Lead_ID__c =: vloanOpportunity.EmpowerID];      //Changes by Vimal for the story #B528917                                
             }
            
            if(TmpOpportunity != null){
                TmpOpportunity.Loan_Status__c = vloanOpportunity.OpportunityStatus;

                //Changes by Vimal for the story #B528917 started
                if(vloanOpportunity.ClosingDate!=null)
                TmpOpportunity.Close_Date__c = vloanOpportunity.ClosingDate; 
                if(vloanOpportunity.DisbursementDate!=null)
                TmpOpportunity.CloseDate = vloanOpportunity.DisbursementDate;
                if(vloanOpportunity.LoanAmount!=null)
                TmpOpportunity.Requested_Loan_Amount__c = vloanOpportunity.LoanAmount;
                if(vloanOpportunity.LockExpirationDate!=null)
                TmpOpportunity.Rate_Lock_Exp__c = vloanOpportunity.LockExpirationDate;
                if(vloanOpportunity.AppraisedValue!=null)
                TmpOpportunity.Value_of_Home__c = vloanOpportunity.AppraisedValue;
                if(vloanOpportunity.LoanPurpose!=null)
                TmpOpportunity.Loan_Purpose__c = vloanOpportunity.LoanPurpose;
                if(vloanOpportunity.LoanTerm!=null)
                TmpOpportunity.Loan_Term__c = vloanOpportunity.LoanTerm;
                //Changes by Vimal for the story #B528917 Ended
                
                update TmpOpportunity;                
            }
            response[0] = 'Successful';
            response[1] = 'OpportunityStatus:' + TmpOpportunity.Loan_Status__c;
            
            //Changes by Vimal for the story #B528917 started
            response[2] = 'ClosingDate:' + String.Valueof(TmpOpportunity.Close_Date__c);
            response[3] = 'DisbursementDate:' + String.Valueof(TmpOpportunity.CloseDate);
            response[4] = 'LoanAmount:' + String.Valueof(TmpOpportunity.Requested_Loan_Amount__c);
            response[5] = 'LockExpirationDate:' + String.Valueof(TmpOpportunity.Rate_Lock_Exp__c);
            response[6] = 'AppraisedValue:' + String.Valueof(TmpOpportunity.Value_of_Home__c);
            response[7] = 'LoanPurpose:' + TmpOpportunity.Loan_Purpose__c;
            response[8] = 'LoanTerm:' + TmpOpportunity.Loan_Term__c;
            //Changes by Vimal for the story #B528917 Ended
            
            return response;
        }
        catch(Exception e){
            response[0] = 'Failed to Update';
            response[1] = String.valueof(e);
            return response;
            //
        }
    }


     Global class UpdateLoanStatus{
         webservice String EmpowerID;
         webservice string OpportunityStatus;
         //Changes by Vimal for the story #B528917 started
         webservice Date ClosingDate;
         webservice Date DisbursementDate;
         webservice Decimal LoanAmount;
         webservice Date LockExpirationDate;
         webservice Decimal AppraisedValue;
         webservice String LoanPurpose;
         webservice String LoanTerm;
         //Changes by Vimal for the story #B528917 Ended
     }



    Webservice static String[] updateEID(UpdateeidField vIDOpportunity) {
        string[] response = new string[2];
        Opportunity TmpOpportunity;
        try {
            if (vIDOpportunity.OpportunityId != null ) {
                TmpOpportunity = [select Loan_Status__c,Empower_Lead_ID__c from Opportunity where Empower_Lead_ID__c =: vIDOpportunity.OpportunityId];
            }
     
            if(TmpOpportunity != null) {
                TmpOpportunity.Empower_Lead_ID__c = vIDOpportunity.loanId;
                Update TmpOpportunity;
            }
            response[0] = 'Successfuly Updated EID';
            return response;
        }
        catch (Exception e) {
            response[0] = 'Failed to Update';
            response[1] = string.valueOf(e);
            return response;
        }

    }

    Global class UpdateeidField{
        webservice String OpportunityID;
        webservice String loanID;
    }
   
}