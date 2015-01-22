/**
 * An apex page controller that takes the user to the right start page based on credentials or lack thereof
 */
@IsTest public with sharing class CommunitiesLandingControllerTest {
    @IsTest public static void testCommunitiesLandingController() {
        // Instantiate a new controller with all parameters in the page
        CommunitiesLandingController controller = new CommunitiesLandingController();
        
        // 25-Jun-2013 Manu Erwin - Fixing insufficient code coverage for default Communities Apex Tests
    PageReference pageRef = controller.forwardToStartPage();

      }
}