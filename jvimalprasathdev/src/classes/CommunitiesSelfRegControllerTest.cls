/**
 * An apex page controller that supports self registration of users in communities that allow self registration
 */
@IsTest public with sharing class CommunitiesSelfRegControllerTest {
    @IsTest
    public static void testCommunitiesSelfRegController() {
    	Account acc = new Account(name='testaccount');  //Changes made by Vimal for the story B-653680
              insert acc;  //Changes made by Vimal for the story B-653680
        CommunitiesSelfRegController controller = new CommunitiesSelfRegController();
        
        // 25-Jun-2013 Manu Erwin - Fixing insufficient code coverage for default Communities Apex Tests
    controller.firstName = 'Bob';
    controller.lastName = 'Jones';
    controller.email = 'bob@jones.com';
    controller.password = '8yhMsHDN&ituQgO$WO';
    controller.confirmPassword = '8yhMsHDN&ituQgO$WO';
    controller.communityNickname = 'bob-jones-testing';
 	
    PageReference pageRef = controller.registerUser();

    }    
    
    // 25-Jun-2013 Manu Erwin - Fixing insufficient code coverage for default Communities Apex Tests
  @IsTest
  public static void testInvalidPassword() {
    CommunitiesSelfRegController controller = new CommunitiesSelfRegController();
    controller.firstName = 'Bob';
    controller.lastName = 'Jones';
    controller.email = 'bob@jones.com';
    controller.password = '8yhMsHDN&ituQgO$WO';
    controller.confirmPassword = 'not the same';
    controller.communityNickname = 'bob-jones-testing';

    PageReference pageRef = controller.registerUser();
    System.assert(pageRef == null, 'The returned page reference should be null');
  }
  // 25-Jun-2013 Manu Erwin - Fixing insufficient code coverage for default Communities Apex Tests
  @IsTest
  public static void testNullPassword() {
  	Account acc = new Account(name='testaccount');  //Changes made by Vimal for the story B-653680
              insert acc;  //Changes made by Vimal for the story B-653680
    CommunitiesSelfRegController controller = new CommunitiesSelfRegController();
    controller.firstName = 'Bob';
    controller.lastName = 'Jones';
    controller.email = 'bob@jones.com';
    controller.communityNickname = 'bob-jones-testing';
    

    PageReference pageRef = controller.registerUser();
    //System.assert(pageRef == null, 'The returned page reference should be null');
  }

}