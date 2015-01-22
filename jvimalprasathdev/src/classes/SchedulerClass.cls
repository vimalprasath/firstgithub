public class SchedulerClass {


public void TestRun(){

list<scheduler__c> sh = [select id from scheduler__c];
delete sh;

List<RRB_Queue_Matrix__c> listQueues = [SELECT Current_queue_proficiency_level__c,Id,Name,Next_assigned_user__c,Round_robin_status__c,Round_robin_time__c,SystemModstamp FROM RRB_Queue_Matrix__c];

List<RRB_Queue_Member__c> listMem = [SELECT name,Id,Queue_member_proficiency__c,RRB_Queue_Matrix__c,RRB_Queue_Matrix__r.Name,User__c,user__r.id,user__r.name,user__r.OOO__c,user__r.Lead_limit__c,user__r.Count__c,user__r.Last_assigned__c 
FROM RRB_Queue_Member__c  WHERE RRB_Queue_Matrix__c in :listQueues 
ORDER BY RRB_Queue_Matrix__r.Name,Queue_member_proficiency__c,user__r.Last_assigned__c];

Integer memSize = listMem.size();

For(Integer i=0; i<memSize; i++) 
system.debug('*****************listMem'+i+listMem[i].user__r.name+listMem[i].RRB_Queue_Matrix__r.Name);

List<Scheduler__c> sched = new List<Scheduler__c>();

RRB_Queue_Member__c firstmem = listMem[0];


For(Integer i=0; i<memSize-1; i++){
Scheduler__c tempSch =  new Scheduler__c();
system.debug('*****************listMem[i].user__r.name'+i+listMem[i].user__r.name);
system.debug('*****************listMem[i].RRB_Queue_Matrix__c'+i+listMem[i].RRB_Queue_Matrix__c);
system.debug('*****************firstmem.user__r.name'+firstmem.user__r.name);
tempSch.Name = listMem[i].user__r.name;
tempSch.Count__c = 0;
tempSch.Lead_Limit__c = listMem[i].user__r.Lead_limit__c;
tempSch.OOO__c = listMem[i].user__r.OOO__c;
tempSch.Last_Assigned__c = listMem[i].user__r.Last_assigned__c;
tempSch.Queue_Name__c = listMem[i].RRB_Queue_Matrix__c;
tempSch.Current_User_Name__c = listMem[i].user__r.name;
tempSch.Current_User_ID__c = listMem[i].user__r.id;
tempSch.User_Proficiency_Level__c = listMem[i].Queue_member_proficiency__c;

if(listMem[i].Queue_member_proficiency__c == listMem[i+1].Queue_member_proficiency__c && listMem[i].RRB_Queue_Matrix__r.Name == listMem[i+1].RRB_Queue_Matrix__r.Name){
system.debug('*****************entered if same proficiency');
tempSch.Next_User_Name__c = listMem[i+1].user__r.name;
tempSch.Next_User_Id__c = listMem[i+1].user__r.id;
}
else{
system.debug('*****************entered else next proficiency');
tempSch.Next_User_Name__c = firstmem.user__r.name;
tempSch.Next_User_Id__c = firstmem.user__r.id;
firstmem = listMem[i+1];

}

sched.add(tempSch);
}
//for last user
Scheduler__c tempSch =  new Scheduler__c();
tempSch.Name = listMem[memSize-1].user__r.name;
tempSch.Count__c = 0;
tempSch.Lead_Limit__c = listMem[memSize-1].user__r.Lead_limit__c;
tempSch.OOO__c = listMem[memSize-1].user__r.OOO__c;
tempSch.Last_Assigned__c = listMem[memSize-1].user__r.Last_assigned__c;
tempSch.Queue_Name__c = listMem[memSize-1].RRB_Queue_Matrix__c;
tempSch.Current_User_Name__c = listMem[memSize-1].user__r.name;
tempSch.Current_User_ID__c = listMem[memSize-1].user__r.id;
tempSch.User_Proficiency_Level__c = listMem[memSize-1].Queue_member_proficiency__c;
if(memSize>1 && listMem[memSize-1].Queue_member_proficiency__c == listMem[memSize-2].Queue_member_proficiency__c && listMem[memSize-1].RRB_Queue_Matrix__r.Name == listMem[memSize-2].RRB_Queue_Matrix__r.Name){
tempSch.Next_User_Name__c = firstmem.user__r.name;
tempSch.Next_User_Id__c = firstmem.user__r.id;
}
else{
tempSch.Next_User_Name__c = listMem[memSize-1].user__r.name;
tempSch.Next_User_Id__c = listMem[memSize-1].user__r.id;
}
sched.add(tempSch);
insert(sched);

}
}