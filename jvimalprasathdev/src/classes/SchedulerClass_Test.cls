@isTest
public class SchedulerClass_Test{
Static TestMethod Void Test_SchedulerClass_Test(){
    
Group q = new Group();
q.Name = 'South-Central – Purchase';
q.type = 'Queue';
insert q;
QueueSobject testSQueue = new QueueSObject(QueueId = q.Id, SobjectType = 'Lead');

    System.runAs(new User(Id = UserInfo.getUserId())) {   
    insert testSQueue;
    }
    
User u = [Select id,name,OOO__c,Lead_limit__c,Count__c,Last_assigned__c from user where id =: userInfo.getUserid() limit 1];

RRB_Queue_Matrix__c testQueue = new RRB_Queue_Matrix__c();
testQueue.name = 'South-Central – Purchase';
testQueue.Round_robin_status__c = 'W';
testQueue.Round_robin_time__c = 0; 
insert testQueue ;

RRB_Queue_Member__c testMember1 = new RRB_Queue_Member__c();
testMember1.name = u.name;
testMember1.Queue_member_proficiency__c =1;
testMember1.RRB_Queue_Matrix__c = testQueue.id;
testMember1.user__c = u.id;
insert testMember1;

testMember1 =  [SELECT name,Id,Queue_member_proficiency__c,RRB_Queue_Matrix__c,RRB_Queue_Matrix__r.Name,User__c,user__r.id,user__r.name,user__r.OOO__c,user__r.Lead_limit__c,user__r.Count__c,user__r.Last_assigned__c 
                FROM RRB_Queue_Member__c  WHERE id =: testMember1.id];
system.debug('***********memberQueue'+testMember1.RRB_Queue_Matrix__r.name);
system.debug('***********memberQueue'+testMember1.user__r.name);

RRB_Queue_Member__c testMember2 = new RRB_Queue_Member__c();
testMember2.name = u.name;
testMember2.Queue_member_proficiency__c =2;
testMember2.RRB_Queue_Matrix__c = testQueue.id;
testMember2.user__c = u.id;
insert testMember2;

testMember2 =  [SELECT name,Id,Queue_member_proficiency__c,RRB_Queue_Matrix__c,RRB_Queue_Matrix__r.Name,User__c,user__r.id,user__r.name,user__r.OOO__c,user__r.Lead_limit__c,user__r.Count__c,user__r.Last_assigned__c 
                FROM RRB_Queue_Member__c  WHERE id =: testMember2.id];
system.debug('***********member2Queue'+testMember2.RRB_Queue_Matrix__r.name);
system.debug('***********member2User'+testMember2.user__r.name);


SchedulerClass sc = new SchedulerClass();
sc.TestRun();

ResetDailyCount rdc= new ResetDailyCount();
rdc.reset();

RRB_Queue_Member__c testMember3 = new RRB_Queue_Member__c();
testMember3.name = u.name;
testMember3.Queue_member_proficiency__c =2;
testMember3.RRB_Queue_Matrix__c = testQueue.id;
testMember3.user__c = u.id;
insert testMember3;

testMember3 =  [SELECT name,Id,Queue_member_proficiency__c,RRB_Queue_Matrix__c,RRB_Queue_Matrix__r.Name,User__c,user__r.id,user__r.name,user__r.OOO__c,user__r.Lead_limit__c,user__r.Count__c,user__r.Last_assigned__c 
                FROM RRB_Queue_Member__c  WHERE id =: testMember3.id];
system.debug('***********member3Queue'+testMember3.RRB_Queue_Matrix__r.name);
system.debug('***********member3User'+testMember3.user__r.name);

SchedulerClass sc1 = new SchedulerClass();
sc1.TestRun();

u.unlimited_leads__c = true;
update u;

rdc.reset();

u.Lead_limit__c = null;
update u;  
rdc.reset(); 
    
Lead l44 = new lead(ownerid = q.id);
l44.Channel__c = 'Centralized Retail';
l44.Channel_Sources__c = 'Bank';
l44.Channel_Values__c = 'RB Portal';
l44.FirstName='test';
l44.LastName= 'Lead' ;
l44.Email='test@test.com';
l44.Borrowers_Current_Residence__c='Own';
l44.Company='NA';
l44.Property_State__c='CA';
l44.Loan_Type__c='Conventional';
l44.Occupancy_Code__c='Owner Occupied';
l44.Property_Type__c='SFR Detached';
l44.Value_of_Home__c=300000;
l44.loan_Purpose__c='Purchase';
l44.Requested_Loan_Amount__c=100000;
l44.Department__c ='South-Central';
//l3.ownerid = q.id;
l44.Is_assigned_already__c = false;
insert l44;
    
    
    
u.ooo__c = false;
update u;
testQueue.Current_queue_proficiency_level__c = 2;
testQueue.Next_assigned_user__c = [Select id,name from user where id =: userInfo.getUserid() limit 1].name;    
update testQueue;
RoundRobinScheduler rrc5 = new RoundRobinScheduler();
rrc5.testMethodRun();
    
}
}