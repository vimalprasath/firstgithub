global class scheduledRoundRobin implements Schedulable {
   global void execute(SchedulableContext SC) {
      RoundRobinScheduler RR = new RoundRobinScheduler(); 
      rr.batchRR();
   }
   
   
}