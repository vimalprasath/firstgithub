public class ResetDailyCount {

public void reset(){

List<User> listUsers = [Select id,name,count__c,Lead_limit__c,Unlimited_Leads__c From User where id in (Select User__c From RRB_Queue_Member__c)];

for(user u : listUsers ){
u.count__c = 0;
if(u.Lead_limit__c == null)
 u.Lead_limit__c = 10;
if(u.Unlimited_Leads__c == true)
 u.Lead_limit__c = null;
 
}

List<RRB_Queue_Matrix__c> listQueueUpdate = new List<RRB_Queue_Matrix__c>();
List<RRB_Queue_Matrix__c> listQueue = [Select id,name,Next_assigned_user__c,Current_queue_proficiency_level__c FROM RRB_Queue_Matrix__c where id in (Select Queue_Name__c from Scheduler__c)];

for(RRB_Queue_Matrix__c Q : listQueue) {
system.debug('******QName'+Q.Name);
//if(Q.Next_assigned_user__c == '' ||Q.Next_assigned_user__c == null){
system.debug('******QName'+Q.Name);
List<Scheduler__c> scheduler = [Select id,name,User_Proficiency_Level__c,Queue_Name__r.Name FROM Scheduler__c Where Queue_Name__r.Name = :Q.name  order by id];
system.debug('******scheduler[0].name'+scheduler[0].name);
Q.Next_assigned_user__c = scheduler[0].name;
Q.Current_queue_proficiency_level__c = scheduler[0].User_Proficiency_Level__c;
system.debug('******Q.Next_assigned_user__c'+Q.Next_assigned_user__c);
system.debug('******Q.Current_queue_proficiency_level__c'+Q.Current_queue_proficiency_level__c);
listQueueUpdate.add(Q);
//}

}

update listUsers; 
update listQueueUpdate;
}
}