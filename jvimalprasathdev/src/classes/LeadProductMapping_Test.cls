/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class LeadProductMapping_Test {

    static testMethod void myUnitTestWithMapping() {
        Test.startTest();
        insert new Product_Preference_Mapping__c(name='7', Mapping_Value__c='FHA');
        insert new Product_Preference_Mapping__C(name='51', Mapping_Value__c='HEL 5');
        Lead testLead = new Lead(LastName='Test1', Property_State__c='TX', Product_Preferences__c='7;51');
        insert testLead;
        testLead = [select Product_Preferences__c from Lead where id =: testLead.id];
        System.assertEquals(testLead.Product_Preferences__c,'FHA;HEL 5');
        testLead.Product_Preferences__c='HEL 10;HEL 15';
        update testLead;
        testLead = [select Product_Preferences__c from Lead where id =: testLead.id];
        System.assertEquals(testLead.Product_Preferences__c,'HEL 10;HEL 15');
        Test.stopTest();
    }
    
    static testMethod void myUnitTestWithOutMapping() {
        Test.startTest();
        Lead testLead = new Lead(LastName='Test1', Property_State__c='TX', Product_Preferences__c='FHA;HEL 5');
        insert testLead;
        testLead = [select Product_Preferences__c from Lead where id =: testLead.id];
        System.assertEquals(testLead.Product_Preferences__c,'FHA;HEL 5');
        testLead.Product_Preferences__c='HEL 10;HEL 15';
        update testLead;
        testLead = [select Product_Preferences__c from Lead where id =: testLead.id];
        System.assertEquals(testLead.Product_Preferences__c,'HEL 10;HEL 15');
        Test.stopTest();
    }
    
    static testMethod void myUnitTestWithOutProduct() {
        Test.startTest();
        Lead testLead = new Lead(LastName='Test1', Property_State__c='TX');
        insert testLead;
        testLead = [select Product_Preferences__c from Lead where id =: testLead.id];
        System.assertEquals(testLead.Product_Preferences__c,null);
        testLead.Product_Preferences__c='7;51';
        insert new Product_Preference_Mapping__c(name='7', Mapping_Value__c='FHA');
        insert new Product_Preference_Mapping__C(name='51', Mapping_Value__c='HEL 5');
        update testLead;
        testLead = [select Product_Preferences__c from Lead where id =: testLead.id];
        System.assertEquals(testLead.Product_Preferences__c,'FHA;HEL 5');
        Test.stopTest();
    }
}