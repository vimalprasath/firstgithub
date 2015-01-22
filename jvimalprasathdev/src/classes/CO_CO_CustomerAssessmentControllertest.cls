@istest

public with sharing class CO_CO_CustomerAssessmentControllertest {

  static testmethod void customerAssessmentControllertest(){
          PageReference ref= new PageReference('/apex/CO_CustomerAssessmentController');
          Test.setCurrentPage(ref);
          CO_CustomerAssessmentController c= new CO_CustomerAssessmentController();
          c.toNext();
          c.toContinue();
          c.toHEPrevious();
          c.toREPrevious();
          c.toReferral();
          c.toHomeEquity();
          c.toCancel();
          c.toBack(); 
   
           
  }


}