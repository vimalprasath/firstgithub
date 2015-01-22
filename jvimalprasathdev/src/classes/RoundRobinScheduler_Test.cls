@istest
public class RoundRobinScheduler_Test{
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
u.Lead_limit__c = 1;
update u;

Profile dmc = [select profile.Id from profile where profile.Name = 'Centralized Loan Officer' limit 1];

User u2 = new user();
u2.FirstName = 'test';
u2.LastName = 'last';
u2.email = 'test@test.com';
u2.ProfileId = dmc.id;
u2.Username = 'testuser@tst.com';
u2.Alias = 'test';
u2.CommunityNickname = 'testtesttest';
u2.TimeZoneSidKey = 'America/Chicago';
u2.LocaleSidKey = 'en_US';
u2.EmailEncodingKey = 'ISO-8859-1';
u2.LanguageLocaleKey = 'en_US';
//u2.IsActive = true;
//u2.Unlimited_Leads__c = true;
u2.Lead_limit__c = 1;
insert u2;



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

RRB_Queue_Member__c testMember3 = new RRB_Queue_Member__c();
testMember3.name = u2.name;
testMember3.Queue_member_proficiency__c =2;
testMember3.RRB_Queue_Matrix__c = testQueue.id;
testMember3.user__c = u2.id;
insert testMember3;

testMember3 =  [SELECT name,Id,Queue_member_proficiency__c,RRB_Queue_Matrix__c,RRB_Queue_Matrix__r.Name,User__c,user__r.id,user__r.name,user__r.OOO__c,user__r.Lead_limit__c,user__r.Count__c,user__r.Last_assigned__c 
                FROM RRB_Queue_Member__c  WHERE id =: testMember3.id];
system.debug('***********member3Queue'+testMember3.RRB_Queue_Matrix__r.name);
system.debug('***********member3User'+testMember3.user__r.name);


SchedulerClass sc = new SchedulerClass();
sc.TestRun();

ResetDailyCount rdc= new ResetDailyCount();
rdc.reset();

List<Scheduler__c> TSchedule = [SELECT Count__c,Current_User_ID__c,Current_User_Name__c,Id,Last_Assigned__c,Lead_Limit__c,Name,Next_User_Id__c,Next_User_Name__c,OOO__c,Queue_Name__c,User_Proficiency_Level__c FROM Scheduler__c];

Lead l = new lead(ownerid = q.id);
l.Channel__c = 'Centralized Retail';
l.Channel_Sources__c = 'Bank';
l.Channel_Values__c = 'RB Portal';
l.FirstName='test';
l.LastName= 'Lead' ;
l.Email='test@test.com';
l.Borrowers_Current_Residence__c='Own';
l.Company='NA';
l.Property_State__c='CA';
l.Loan_Type__c='Conventional';
l.Occupancy_Code__c='Owner Occupied';
l.Property_Type__c='SFR Detached';
l.Value_of_Home__c=300000;
l.loan_Purpose__c='Purchase';
l.Requested_Loan_Amount__c=100000;
l.Department__c ='South-Central';
l.Is_assigned_already__c = false;
insert l;


l = [SELECT Id,Name,OwnerId,Owner.Name,Is_assigned_already__c,CreatedDate  From Lead Where id =:l.id];
system.debug('***********leadOwnerName'+l+'The owner name is' +l.owner.name);

RoundRobinScheduler rrc = new RoundRobinScheduler();
rrc.testMethodRun();

Lead l2 = new lead(ownerid = q.id);
l2.Channel__c = 'Centralized Retail';
l2.Channel_Sources__c = 'Bank';
l2.Channel_Values__c = 'RB Portal';
l2.FirstName='test';
l2.LastName= 'Lead' ;
l2.Email='test@test.com';
l2.Borrowers_Current_Residence__c='Own';
l2.Company='NA';
l2.Property_State__c='CA';
l2.Loan_Type__c='Conventional';
l2.Occupancy_Code__c='Owner Occupied';
l2.Property_Type__c='SFR Detached';
l2.Value_of_Home__c=300000;
l2.loan_Purpose__c='Purchase';
l2.Requested_Loan_Amount__c=100000;
l2.Department__c ='South-Central';
//l2.ownerid = q.id;
l2.Is_assigned_already__c = false;
insert l2;

l2 = [SELECT Id,Name,OwnerId,Owner.Name,Is_assigned_already__c,CreatedDate  From Lead Where id =:l2.id];
system.debug('***********leadOwnerName'+l2+'The owner name is' +l2.owner.name);


u.count__c = 12;
update u;

RoundRobinScheduler rrc2 = new RoundRobinScheduler();
rrc2.testMethodRun();
 }
}