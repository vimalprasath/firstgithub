/**
 * An apex page controller that exposes the site login functionality
 */
@IsTest global with sharing class CommunitiesLoginControllerTest {
    @IsTest
    global static void testCommunitiesLoginController () {
        CommunitiesLoginController controller = new CommunitiesLoginController ();
        
        // 25-Jun-2013 Manu Erwin - Fixing insufficient code coverage for default Communities Apex Tests
    PageReference pageRef = controller.forwardToAuthPage();

    }    
}