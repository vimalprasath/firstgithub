/**
 Description: Test Class for ErrorLogHandler.
 Author - Richard Joseph
 Created Date- March, 2014            

 */
 @istest(seeAllData = true)
 private class TestClass_ErrorLogHandler {

    static testMethod void ErrorLogHandlerTest() {
    
    Test.startTest();
    ErrorLogHandler ErrObj = new ErrorLogHandler ();
    
    ErrObj.createLog('TestId', 'Test Source','Test Type','Test Message','Test Sev');
    List<ErrorLogHandler.batchErrorLogWrapper> TestExceptionList = new List<ErrorLogHandler.batchErrorLogWrapper>();
    
    Apex_Job_Master__c TestJobDetail = new Apex_Job_Master__c ( Name='test '+ System.now(), Start_Time__c = System.now());
    insert TestJobDetail ;
    
    
    TestExceptionList .add(new ErrorLogHandler.batchErrorLogWrapper ( 'Test Id','Test Class','Test Desc'))  ;
    TestExceptionList .add(new ErrorLogHandler.batchErrorLogWrapper ( 'Test Id','Test Class','Test Desc',TestJobDetail .id))  ;
    TestExceptionList .add(new ErrorLogHandler.batchErrorLogWrapper ( null,'Test Class','Test Desc'))  ;
    TestExceptionList .add(new ErrorLogHandler.batchErrorLogWrapper ( 'Test Id','Test Class','Test Desc','Business'))  ;
    TestExceptionList .add(new ErrorLogHandler.batchErrorLogWrapper ( 'Test Id','Test Class','Test Desc','Business',TestJobDetail .id))  ;
    
    ErrObj .batchSendEmailException(TestExceptionList );
    ErrObj .batchCreateLog(TestExceptionList );
    
    Test.StopTest();
    
    }
    }