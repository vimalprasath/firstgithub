@istest
global class teststartherecontroller{
    
    testmethod static void testmethod1(){
           
        startHereController controller =  new startHereController();
        controller.init();
        controller.getHTMLHeader();
        controller.getBannerURL();
        controller.getBannerImageURL();
        controller.getTracker();
        controller.getSideBar();
        controller.getMainBody();
        controller.getFooter();
        controller.initPageAction();
        
        
        
 
    }
        

}