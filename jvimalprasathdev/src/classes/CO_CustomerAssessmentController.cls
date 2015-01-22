public with sharing class CO_CustomerAssessmentController {

Public String SelectedBr;
Public String SelectedDist;
Public String SelectedCostCenter;

public CO_CustomerAssessmentController(){
     SelectedBr = System.currentPagereference().getParameters().get('branch');
     SelectedDist = System.currentPagereference().getParameters().get('district');
     SelectedCostCenter = System.currentPagereference().getParameters().get('costCenter');
}

//Next Button from Customer Assessement Page.
 Public PageReference toNext(){
        PageReference pageRef= new PageReference('/apex/CO_REProductPath_VF');
        pageRef.getParameters().put('branch',SelectedBr);
        pageRef.getParameters().put('district',SelectedDist);
        pageRef.getParameters().put('costCenter',SelectedCostCenter);
        pageRef.setredirect(true);        
        return pageRef;    
    }
//Continue Button from Customer Assessment Page.
 Public PageReference toContinue(){
        PageReference pageRef= new PageReference('/apex/CO_HEProductpath_VF');
        pageRef.getParameters().put('branch',SelectedBr);
        pageRef.getParameters().put('district',SelectedDist);
        pageRef.getParameters().put('costCenter',SelectedCostCenter);
        pageRef.setredirect(true);        
        return pageRef;    
    }
//Previous Button from Home Equity Page 
    public PageReference toHEPrevious() {
        PageReference pageRef= new PageReference('/apex/CO_CustomerAssessment_VF');
        pageRef.getParameters().put('branch',SelectedBr);
        pageRef.getParameters().put('district',SelectedDist);
        pageRef.getParameters().put('costCenter',SelectedCostCenter);
        pageRef.setredirect(true);        
        return pageRef;
     }
//Previous Button from Referral Page   
     
     public PageReference toREPrevious(){
        PageReference pageRef= new PageReference('/apex/CO_CustomerAssessment_VF');
        pageRef.getParameters().put('branch',SelectedBr);
        pageRef.getParameters().put('district',SelectedDist);
        pageRef.getParameters().put('costCenter',SelectedCostCenter);
        pageRef.setredirect(true);        
        return pageRef;
     }
     
//Next button from Referral page
 public PageReference toReferral(){
        PageReference pageRef= new PageReference('/apex/CO_Referral_VF');
        pageRef.getParameters().put('branch',SelectedBr);
        pageRef.getParameters().put('district',SelectedDist);
        pageRef.getParameters().put('costCenter',SelectedCostCenter);
        pageRef.setredirect(true);        
        return pageRef;
     }
   //Next button from HE page 
 public PageReference toHomeEquity(){
        PageReference pageRef= new PageReference('/apex/CO_RBHomeEquityLoan_VF');
        pageRef.getParameters().put('branch',SelectedBr);
        pageRef.getParameters().put('district',SelectedDist);
        pageRef.getParameters().put('costCenter',SelectedCostCenter);
        pageRef.setredirect(true);        
        return pageRef;
     }    
  
//Cancel button from Home Equity page
 public PageReference toCancel(){
     
        PageReference pageRef= new PageReference('/apex/RB_Portal_List_View');
        pageRef.getParameters().put('branch',SelectedBr);
        pageRef.getParameters().put('district',SelectedDist);
        pageRef.getParameters().put('costCenter',SelectedCostCenter);
        pageRef.setredirect(true);        
        return pageRef;
     }
//From ReferralInfo Page     
    public PageReference toBack(){
        PageReference pageRef= new PageReference('/apex/CO_CustomerAssessment_VF');
        pageRef.getParameters().put('branch',SelectedBr);
        pageRef.getParameters().put('district',SelectedDist);
        pageRef.getParameters().put('costCenter',SelectedCostCenter);
        pageRef.setredirect(true);        
        return pageRef;
     }

}