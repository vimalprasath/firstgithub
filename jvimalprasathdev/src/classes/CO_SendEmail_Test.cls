@isTest
public class CO_SendEmail_Test{
    Static TestMethod Void TestCO_SendEmail(){
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User u = new User(alias = 'jsmtih', email='jsmith@acme.com',
                        emailencodingkey='UTF-8', lastname='Smith',firstname='John',
                        languagelocalekey='en_US',
                        localesidkey='en_US', profileid = p.Id,
                        timezonesidkey='America/Los_Angeles',
                        username='jsmith@acme2345.com',isactive=true,street='asds',city='asfd',
                        postalcode='23445',phone='',mobilephone='',fax='',nmls_id__c=65789,state='ka');
        insert u;
         
        System.runAs ( u ) {
        Lead new_ld1 = new Lead();
        new_ld1.Status='New';
        new_ld1.ownerid=u.id;
        new_ld1.Applicant_Type__c='individual';
        new_ld1.Channel__c='Home Equity';
        new_ld1.Channel_Sources__c='Bank';
        new_ld1.Channel_Values__c='NCFR';
        new_ld1.FirstName='ROSY';
        new_ld1.LastName='DANIAL';
        new_ld1.Borrowers_Country__c='Hong Kong';
        new_ld1.Borrowers_City__c='Netherlands';
        new_ld1.Borrowers_Address_1__c='A-12 Lonley Road';
        new_ld1.Time_Zone__c='EST';
        new_ld1.Borrowers_Current_Residence__c='Own';
        new_ld1.Company='XXXX';
        new_ld1.Loan_Approved__c=True;
        new_ld1.Borrowers_Zip_Postal_Code__c='32412';
        new_ld1.Borrowers_Home_Phone__c='(033) 246-3970';
        new_ld1.Occupancy_Code__c='Second Home';
        new_ld1.Notes__c='Tomorrow is Saturday';
        new_ld1.Property_State__c='CA';
        new_ld1.Email='ak@gmail.com';
        new_ld1.Phone='(033) 246-3970';
        new_ld1.Borrowers_Apt__c='Test';
        insert new_ld1;
        
        Folder fdr = [Select id,AccessType,Name,Type,developername from Folder where name='Transactional Emails'];
        EmailTemplate et = new EmailTemplate(markup='<messaging:emailTemplate subject="Loan terms update" recipientType="Lead" replyTo="{!$User.Email}"><messaging:htmlEmailBody ></messaging:htmlEmailBody></messaging:emailTemplate>',name='asdm',TemplateType='Visualforce',Folderid=fdr.id,Developername='newtemplate'); 
        insert et;
        Emailtemplate et1= new Emailtemplate(body='dsfsdf',developername='testolp',subject='test',folderid=fdr.id,templatetype='custom',name='testopli');
        insert et1;
        apexpages.currentpage().getparameters().put('id',new_ld1.id);
        ApexPages.StandardController sc = new ApexPages.standardController(new_ld1);
        CO_SendEmail Cntlr = new CO_SendEmail(sc);
        Cntlr.selectedfoldername=fdr.name;
        Cntlr.SelectedEmailId=et.id;
        Cntlr.Selectedfolderemails();
        Cntlr.Selectedemailmethod();
        Cntlr.getPreview();
        Cntlr.sendmail();
        Cntlr.SelectedEmailId='Weneedinfo';
        Cntlr.Selectedemailmethod();
        Cntlr.sendmail();
        Cntlr.SelectedEmailid='NextSteps';
        Cntlr.Selectedemailmethod();
        Cntlr.sendmail();
        Cntlr.SelectedEmailid='loanclosing';
        Cntlr.Selectedemailmethod();
        Cntlr.sendmail();
        /*Cntlr.SelectedEmailid='';
        Cntlr.Selectedemailmethod();*/
        Cntlr.lea.Closing_Date__c=system.today();
        Cntlr.lea.Document_Deadline__c=system.today();
            
        u.Phone='1234567890';
        u.MobilePhone='1234567890';
        u.Fax='1234567890';
        Cntlr.Urloanclosing();
        Cntlr.weneedinfo();
        Cntlr.NextStepsAfterLoanSubmission();
        Cntlr.lea.pay_stub__c=true;
        Cntlr.lea.Most_recent_W_2__c=true;
        Cntlr.lea.Most_recent_W_2_2_years__c=true;
        Cntlr.lea.Personal_tax_return__c=true;
        Cntlr.lea.Personal_tax_return_2_years__c=true;
        Cntlr.lea.Business_tax_return__c=true;
        Cntlr.lea.Business_tax_return_2_years__c=true;
        Cntlr.lea.Social_Security_award_letter__c=true;
        Cntlr.lea.Pension_Annuity_Statements__c=true;
        Cntlr.lea.Cancelled_checks__c=true;
        Cntlr.lea.Cancelled_checks__c=true;
        Cntlr.lea.Stocks_IRA_401k_Statements__c=true;
        Cntlr.lea.Outstanding_Mortgages__c=true;
        Cntlr.lea.HUD_1_Settlement_Statement__c=true;
        Cntlr.lea.Intened_use_of_Cash_Out_funds__c=true;
        Cntlr.lea.Sales_Contract__c=true;
        Cntlr.lea.Divorce_Separation_decree__c=true;
        Cntlr.lea.Driver_s_License__c=true;
        Cntlr.lea.Homeowner_s_insurance_policy__c=true;
        Cntlr.lea.Homeowner_s_Condo_Association__c=true;
        Cntlr.lea.Documentation_of_credit_dispute__c=true;
        Cntlr.lea.Property_Survey__c=true;
        Cntlr.lea.RESPA_documents__c=true;
        Cntlr.lea.Irrevocable_Trust__c=true;
        Cntlr.lea.Documents_for_Non_US_Citizens__c='sfdfgfh';
        Cntlr.lea.Statement_s_of_debts__c='sffgh';
        Cntlr.lea.Other__c='fdfgth';
        Cntlr.lea.Bank_Statements__c=true;
        Cntlr.SelectedEmailid='NextSteps';
        Cntlr.Selectedemailmethod();
        Cntlr.sendmail();
        Cntlr.SelectedEmailId='Weneedinfo';
        Cntlr.Selectedemailmethod();
        Cntlr.sendmail();
        Cntlr.lea.Made_Payable_To__c='fhfgjgh';
        Cntlr.SelectedEmailid='loanclosing';
        Cntlr.Selectedemailmethod();
        Cntlr.sendmail();
        Cntlr.Cancel();
        Cntlr.SelectedEmailId=et.id;
        Cntlr.getPreview();
        Cntlr.Selectedfolderemails();
        Cntlr.Selectedemailmethod();
        Cntlr.SelectedEmailid='loanclosing';
        Cntlr.lea.closing_date__c=system.today();
        Cntlr.lea.Closing_Costs__c=545;
        Cntlr.lea.Made_Payable_To__c='dsgfdr';
        Cntlr.sendmail();
        string s='sfsdg';
        blob b=blob.valueof(s);
        Attachment a= new Attachment(name='qqq.pdf', body=b);
        Cntlr.attachments.add(a);
        Cntlr.sendmail();
            
        string k='';
        blob d=blob.valueof(k);
        Attachment c= new Attachment(name='', body=d);
        Cntlr.attachments.add(c);
        Cntlr.sendmail();
        //Cntlr.attachments[0].name='qqq.pdf';
        //Cntrl.attachments[0].body=b;
        
        }
    }
}