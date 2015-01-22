/* 
Description: Scheduler for MDWReportGeneration.
 Author - Richard Joseph
 Created Date- March 20th, 2014            
 User Story - B-316184 
*/
global class Scheduler_MDWReportGeneration implements Schedulable {
   global void execute(SchedulableContext SC) {
      BatchClass_MDWReportGeneration MDMReportObj  = new BatchClass_MDWReportGeneration ();
		Database.executeBatch(MDMReportObj);
   }
   
   
}