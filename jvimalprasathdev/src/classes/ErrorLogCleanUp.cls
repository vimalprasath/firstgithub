global class ErrorLogCleanUp implements Schedulable{

    public transient Date currentDate=Date.newInstance(Date.Today().year(), Date.Today().month(), Date.Today().day()-7);
    
    global void execute(SchedulableContext SC) {
        
        List<ErrorLogDetail__c> listELogs=[select id from  ErrorLogDetail__c where CreatedDate<:currentDate limit 10000];
        
        if(listELogs.size()>0)
        {
            database.delete(listELogs);
        }
    }
    
    
}