global class scheduleReset implements Schedulable {
   global void execute(SchedulableContext SC) {
      SchedulerClass sh = new SchedulerClass(); 
      sh.TestRun();
      ResetDailyCount rc = new ResetDailyCount();
      rc.reset();
   }
    
}