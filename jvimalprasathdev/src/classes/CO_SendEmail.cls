/*
Description: 
-Send email Button Controller.
-Email Template of 3 Emails.
-Sends emails to Leads and CC's MC users. 
-Emails will be captured in Activity History for reference.

Created by: Leena (Wipro Technologies Pvt Ltd)
Last Modified by: Yunus (Wipro Technologies Pvt Ltd) 

*/


public class CO_SendEmail{

    public List<SelectOption> options {get; set;}
    public List<SelectOption> Folderoptions {get; set;}
    public string SelectedEmailid {get; set;}
    public string SelectedFoldername {get; set;}
    public EmailTemplate emailtemp1{get; set;}
    public boolean showemail{get; set;}
    public boolean showemailoptions{get; set;}
    public Lead lea {get; set;}
    public string emailTempbody {get; set;}
    public brandTemplate btemp {get; set;}
    public boolean showpreapp {get; set;}
    public boolean showapp {get; set;}
    public boolean showloanapp {get; set;}
    public boolean showclose {get; set;}
    public boolean showcongrats {get; set;}
    public boolean showtempdetails {get; set;}
    public boolean showemailchecker {get; set;}
    public boolean showdates {get; set;}
    public boolean showclosingdates {get; set;}
    public User MC {get;set;}
    public string subject {get; set;}
    public boolean showhcmail {get; set;}
    public string Emailname {get; set;}
    public string fname{get; set;}
    List<Document> doc = new List<Document>();
    Map<string,id> mapdoc = new map<string,id>();    
    public Blob b {get; set;}
    public List<attachment> attachments {get; set;}
    public boolean showattach {get; set;}    
    Id id;
    User u;
        
    public CO_SendEmail(ApexPages.StandardController controller){
        id = apexpages.currentpage().getparameters().get('id');
        Folderoptions = new List<SelectOption>();
        Folderoptions.add(new SelectOption('','None'));
        Folderoptions.add(new SelectOption('Transactional Emails','Transactional Emails'));
        Folderoptions.add(new SelectOption('Marketing Emails','Marketing Emails'));
        lea=[select id,name,email,Your_Loan_Is_In_Closing__c,Next_Steps_After_Loan_Submission__c,Document_Deadline__c,Closing_Date__c,We_Need_Info_From_You__c,Realtor_Note_After_Closing__c, 
            pay_stub__c,Most_recent_W_2__c,Most_recent_W_2_2_years__c,Personal_tax_return__c,Personal_tax_return_2_years__c,Business_tax_return__c,Business_tax_return_2_years__c,
            owner.name,owner.phone,owner_fax__c,owner.email,NMLS__c,owner_street__c,owner_city__c,owner_state__c,owner_postal_code__c,owner_country__c,Social_Security_award_letter__c,
            Pension_Annuity_Statements__c,Cancelled_checks__c,Bank_Statements__c,Stocks_IRA_401k_Statements__c,Outstanding_Mortgages__c,HUD_1_Settlement_Statement__c,
            Intened_use_of_Cash_Out_funds__c,Sales_Contract__c,Divorce_Separation_decree__c,Driver_s_License__c,Homeowner_s_insurance_policy__c,Homeowner_s_Condo_Association__c,
            Documentation_of_credit_dispute__c,Property_Survey__c,Irrevocable_Trust__c,RESPA_documents__c,Documents_for_Non_US_Citizens__c,Other__c,Statement_s_of_debts__c,
            Made_Payable_To__c,Closing_Costs__c from Lead where id=:id limit 1];
        
       // if(lea.Owner.Id!=null)
         //   MC=[select nmls_id__c,Email, City,State,Street,Country,postalcode, Phone,Fax from User where id= :lea.Owner.Id limit 1];         
        u = [select name,nmls_id__c,Email, City,State,Street,Country,postalcode, Phone,Fax,MobilePhone from User where id=:userinfo.getuserid()];        
        Doc = [select id,name,developername from Document];
        for(Document d:doc){
            mapdoc.put(d.developername,d.id);
        }
    }
    
    public Component.Apex.OutputText getPreview() {    
        Component.Apex.OutputText detail = new Component.Apex.OutputText();
        emailtemp1 = new Emailtemplate();
         if(SelectedEmailid!=null && SelectedEmailid!=''){
             if(SelectedEmailid!='Weneedinfo' && SelectedEmailid!='NextSteps' && SelectedEmailid!='loanclosing'){
                   emailtemp1=[select id,name,body,subject,DeveloperName,brandtemplateid,htmlvalue,markup from EmailTemplate where id=:SelectedEmailId];                                           
                  //  detail.value = emailtemp1.htmlvalue;
                  //  detail.escape = false;                                 
                   emailTempBody = emailtemp1.markup;
                   Pattern nonWordChar = Pattern.compile('[Rr][Ee][Cc][Ii][Pp][Ii][Ee][Nn][Tt]');
                   emailTempBody = nonWordChar.matcher(emailTempBody).replaceAll('Lea'); 
                   if(u.phone==null){
                       Pattern phone = Pattern.compile('[Oo][Ff][Ff][Ii][Cc][Ee]');
                       emailTempBody = phone.matcher(emailTempBody).replaceAll(''); 
                   }
                   if(u.mobilephone==null){
                       Pattern Cell = Pattern.compile('[Cc][Ee][Ll][Ll]');
                       system.debug('fffffffffccccccc'+Cell);
                       emailTempBody = Cell.matcher(emailTempBody).replaceAll(''); 
                   }
                   if(u.fax==null){
                       Pattern fax1 = Pattern.compile('[Ff][Aa][Xx][ ]');
                       system.debug('fffffffff'+fax1);
                       system.debug('fffffffffbefore'+emailTempBody);
                       emailTempBody = fax1.matcher(emailTempBody).replaceAll(''); 
                       system.debug('fffffffffafter'+emailTempBody);
                   }
                   detail.expressions.value = emailtempbody;         
                   detail.escape = false;
              }
         }
         return detail;
    }
    
    public void Selectedfolderemails(){
         if(SelectedFoldername!=null && SelectedFoldername!=''){
            showemailoptions=true;            
            List<EmailTemplate> emailTemp = new List<EmailTemplate>();
            options = new List<SelectOption>();
            emailTemp = [select id,name from EmailTemplate where IsActive=true and folder.name=:SelectedFoldername];                    
            options.add(new SelectOption('','None'));
            for(EmailTemplate et:emailTemp){
                options.add(new SelectOption(et.id,et.name)); 
            } 
            if(SelectedFoldername=='Transactional Emails'){
                options.add(new SelectOption('Weneedinfo','We Need Info From You'));  
                      // options.add(new SelectOption('NextSteps','Application Welcome Letter'));
                options.add(new SelectOption('loanclosing','Your Loan Is In Closing'));                 
            }                        
        }else
            showemailoptions=false;
        showemail=false; 
        SelectedEmailid=null;
    }
    
    public void Selectedemailmethod(){
        showpreapp = false;
        showapp = false;
        showloanapp = false;
        showclose = false;
        showcongrats = false;
        showemailchecker = false;
        showclosingdates=false;
        showtempdetails = false;                
        emailtempbody = '';
        emailtemp1 = new EmailTemplate();
        showattach=false;
        integer countlead=0;        
        attachments= new list<attachment>();
        for(integer i=0; i<4; i++){
            attachment a = new attachment();            
            attachments.add(a);
        }        
        try{            
            if(SelectedEmailid!=null && SelectedEmailid!=''){
                if(SelectedEmailid!='Weneedinfo' && SelectedEmailid!='NextSteps' && SelectedEmailid!='loanclosing'){
                    showtempdetails = true;
                }
            }       
            if(SelectedEmailid=='Weneedinfo' || SelectedEmailid=='NextSteps'){
                showtempdetails = false;
                showemailchecker = true;                
                showpreapp = false;
                showapp = false;
                showloanapp = false;
                showclose = false;
                showcongrats = false;
                showclosingdates=false;
                if(SelectedEmailid=='Weneedinfo') { 
                    showdates=true; 
                    Emailname = 'We Need Info From You';
                }
                if(SelectedEmailid=='NextSteps')  {
                    showdates=false; 
                    Emailname = 'Application Welcome Letter';
                }            
            }
            if(SelectedEmailid=='loanclosing'){
                showpreapp = false;
                showapp = false;
                showloanapp = false;
                showclose = false;
                showcongrats = false;
                showemailchecker = false;
                showclosingdates=true;
                showtempdetails = false;
                Emailname = 'Your Loan Is In Closing';
            }                                             
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,e.getmessage()));
        }
    }
    
    public Pagereference sendmail(){ 
        system.debug('bbbbbbbbbbbbbbbbbb'+b);
        boolean boolchecker;
        integer count=0;
        if(SelectedEmailid=='Weneedinfo'){
            subject = 'Still need some documents';            
            if(lea.pay_stub__c==false && lea.Most_recent_W_2__c==false && lea.Most_recent_W_2_2_years__c==false && lea.Personal_tax_return__c==false && lea.Personal_tax_return_2_years__c==false && lea.Business_tax_return__c==false
               && lea.Business_tax_return_2_years__c==false && lea.Social_Security_award_letter__c==false && lea.Pension_Annuity_Statements__c==false && lea.Cancelled_checks__c==false && lea.Bank_Statements__c==false && lea.Stocks_IRA_401k_Statements__c==false && 
               lea.Outstanding_Mortgages__c==false && lea.HUD_1_Settlement_Statement__c==false && lea.Intened_use_of_Cash_Out_funds__c==false && lea.Sales_Contract__c==false && lea.pay_stub__c==false && lea.Divorce_Separation_decree__c==false && lea.Driver_s_License__c==false && lea.Homeowner_s_insurance_policy__c==false
               && lea.Homeowner_s_Condo_Association__c==false && lea.Documentation_of_credit_dispute__c==false && lea.Property_Survey__c==false && lea.RESPA_documents__c==false && lea.Irrevocable_Trust__c==false && lea.Documents_for_Non_US_Citizens__c==null && lea.Statement_s_of_debts__c==null && lea.Other__c==null){ 
               
               boolchecker=false;
               }
            if(boolchecker==false || lea.Document_Deadline__c==null || lea.Closing_Date__c==null){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Please ensure that the relevant fields are filled in the "Financial Documents Needed" section'));
                count++;
                return null;
            }
            else{
                emailTempbody = weneedinfo();
            }
        }
        if(SelectedEmailid=='NextSteps'){
            subject = 'Thank you for applying';            
            if(lea.pay_stub__c==false && lea.Most_recent_W_2__c==false && lea.Most_recent_W_2_2_years__c==false && lea.Personal_tax_return__c==false && lea.Personal_tax_return_2_years__c==false && lea.Business_tax_return__c==false
               && lea.Business_tax_return_2_years__c==false && lea.Social_Security_award_letter__c==false && lea.Pension_Annuity_Statements__c==false && lea.Cancelled_checks__c==false && lea.Bank_Statements__c==false && lea.Stocks_IRA_401k_Statements__c==false && 
               lea.Outstanding_Mortgages__c==false && lea.HUD_1_Settlement_Statement__c==false && lea.Intened_use_of_Cash_Out_funds__c==false && lea.Sales_Contract__c==false && lea.pay_stub__c==false && lea.Divorce_Separation_decree__c==false && lea.Driver_s_License__c==false && lea.Homeowner_s_insurance_policy__c==false
               && lea.Homeowner_s_Condo_Association__c==false && lea.Documentation_of_credit_dispute__c==false && lea.Property_Survey__c==false && lea.RESPA_documents__c==false && lea.Irrevocable_Trust__c==false && lea.Documents_for_Non_US_Citizens__c==null && lea.Statement_s_of_debts__c==null && lea.Other__c==null){                
                   boolchecker=false;
               }
               if(boolchecker==false){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Please ensure that the relevant fields are filled in the "Financial Documents Needed" section'));
                    count++;
                    return null;
                }else{
                    emailTempbody = NextStepsAfterLoanSubmission();
                }
        }
        if(SelectedEmailid!='Weneedinfo' && SelectedEmailid!='NextSteps'){
            if(SelectedEmailid=='loanclosing'){
                //if(emailtemp1.DeveloperName=='Your_Loan_Is_In_Closing'){
                    if(lea.closing_date__c==null || lea.Closing_Costs__c==null || lea.Made_Payable_To__c==null){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Please enter all the below fields'));
                        count++;
                        return null;
                    }else{
                        subject = 'Your closing date is set!';
                        emailTempbody = Urloanclosing();                       
                    }                   
                //}
            }
        }
              
        if(count==0){
            try{
                List<Messaging.EmailFileAttachment> listatt = new List<Messaging.EmailFileAttachment>();
                System.Debug('******attachments*******'+attachments);
                for(Attachment a:attachments){
                     if(a.body!=null && a.name!=null){
                         if(a.name.contains('pdf') || a.name.contains('doc') || a.name.contains('xls')){
                            Messaging.EmailFileAttachment attach1 = new Messaging.EmailFileAttachment();
                            attach1.setContentType(a.contentType);
                            system.debug('cccccccccccc'+a.contentType);
                            attach1.setFileName(a.name);
                            attach1.setInline(false);
                            attach1.Body = a.Body;
                            system.debug('***************EmailFileAttachment***************'+attach1);
                            listatt.add(attach1);
                                //email.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });                            
                        }else{
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Please attach files of the following type only: xls, xlsx, doc, docx, pdf'));
                            attachments.clear();
                            for(integer i=0; i<4; i++){
                                attachment a1 = new attachment();            
                                attachments.add(a1);
                            }
                            return null;
                        }
                     }                         
                }
                if(emailtemp1!=null && SelectedEmailid!='Weneedinfo' && SelectedEmailid!='NextSteps' && SelectedEmailid!='loanclosing'){
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();              
                    mail.setTargetObjectId(lea.id);
                    mail.setTemplateId( emailtemp1.id);
                            /* if(emailtemp1.DeveloperName=='Your_Loan_Is_In_Closing'){
                            subject = 'Your closing date is set!';
                            mail.setSubject(subject );
                            mail.sethtmlBody(emailTempbody );
                            }
                            else{                    
                            }*/                
                            //mail.setCcAddresses(lea.owner.Email);
                    mail.setCcAddresses(new String[]{lea.owner.Email});
                    mail.setSaveAsActivity(true);
                            //mail.setFileAttachments(listatt);           
                            //mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach1 });
                    Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                    return (new pagereference('/'+lea.id));
                }else{
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();               
                    email.setTargetObjectId(lea.id);
                    email.setCcAddresses(new String[]{lea.owner.Email});
                    email.setSubject( subject );                
                    email.sethtmlBody(emailTempbody );
                            /* if(SelectedEmailid=='loanclosing'){
                            Document doc = [select id, name, body, contenttype, developername, type 
                            from Document where developerName = 'Tips_for_Successful_Closing'];                                 
                            Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
                            attach.setContentType(doc.contentType);
                            system.debug('cccccccccccc'+doc.contentType);
                            attach.setFileName(doc.name);
                            attach.setInline(false);
                            attach.Body = doc.Body;
                            listatt.add(attach);                                   
                            }*/
                            //    email.setFileAttachments(listatt);
                    email.setsaveasactivity(true);                
                    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email}); 
                    return (new pagereference('/'+lea.id));  
                } 
            }
            catch(Exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,e.getmessage()));
            }      
        }
        return null;
    }
    public PageReference Cancel(){
        return (new pageReference('/' +lea.id));
    }
  
    public string Urloanclosing(){
        string docid;
        string bottomdocid;
        if(mapdoc.containsKey('Closing_Logo'))
            docid = mapdoc.get('Closing_Logo');
        if(mapdoc.containsKey('Equal_Housing_Lender'))
            bottomdocid = mapdoc.get('Equal_Housing_Lender');
        String orgId = UserInfo.getOrganizationId();        
        string s=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+docid+'&oid='+orgId;
        string bottomurl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+bottomdocid+'&oid='+orgId;
        emailTempbody ='<html><style type="text/css">table {width: 792px;}body {font-family: Arial;}ul {font-size: 12px;}ol {font-size: 12px;}p {font-size: 12px;}p.disclaimer {font-size: 10px;}</style><body><table><tr><td>'; 
        emailTempbody +='<img src="'+s+'"/><br><br>';
        emailTempbody +='<p>Dear '+lea.name+',</p>';
        emailTempbody +='<p>I\'m very pleased to tell you that your closing date is set for '+lea.Closing_Date__c.format()+'</p>';
        emailTempbody +='<p>To prepare for a successful closing, please do the following:</p>';
        emailTempbody +='<ol><li>Please let me know if you’d like to schedule a review of your HUD1—your final closing document that lists out all the numbers, such as fees, credits, and the cost of your property.</li>';                                                                                                                   
        emailTempbody +='<li>Bring a cashier’s check for $'+lea.Closing_Costs__c+' to cover your closing costs made payable to '+lea.Made_Payable_To__c+'</li></ol>';                                                                                                                      
        emailTempbody +='<p><b>Once you review the closing documents, let me know if you find inaccuracies or if you would like to schedule a review with me.</b></p>';
        emailTempbody +='<p>Here are a few tips we’ve learned over the years to ensure a successful closing:</p>';
        emailTempbody +='<ul><li>Respond quickly to additional documentation requests</li>';
        emailtempbody +='<li>Obtain homeowner’s insurance at least one week prior to your closing date. This required insurance protects you against loss or damage due to theft, fire, or certain weather-related hazards. In some areas, it will also be necessary to obtain flood insurance.</li>';
        emailTempbody +='<li>Conduct a final walk-through (if buying a house) to ensure any agreed upon repairs have been made.</li>';
        emailtempbody +='<li>Confirm the final details of your loan—review the closing cost estimates as well as loan amount, rate, term, possible escrows, and any additional costs.</li>';
        emailtempbody +='<li>Follow your attorney’s or closing agent’s payment instructions for your down payment and closing costs.</li>';
        emailtempbody +='<li>Bring a photo ID with you to your closing.</li></ul>';                
        emailTempbody +='<p>Thanks,</p>';
        emailTempbody +='<p>'+u.Name+'<br>';
        if(u.Street!= null)
            emailTempbody +=u.Street+'<br>';
        if(u.city!= null)      
            emailTempbody +=u.city+', ';
        if(u.state!= null)   
            emailTempbody +=u.state+' ';    
        if(u.postalcode!= null)                     
            emailTempbody +=u.postalcode+'<br>';
        if(u.MobilePhone!= null)
            emailTempbody +='Cell '+u.MobilePhone+'<br>';                                                                                
        if(u.Phone!=null)
            emailTempbody +='Phone '+u.Phone+'<br>';
        if(u.Fax!= null)       
            emailTempbody +='Fax '+u.Fax+'<br>';
        if(u.Email!= null)            
            emailTempbody +=u.Email+'<br>';
        if(u.nmls_id__c!= null)   
            emailTempbody +='NMLS '+u.nmls_id__c+'</p>';  
        emailTempbody +='<p> </p>';
        emailTempbody +='<p class="disclaimer">This e-mail contains information directly related to your account with us. Capital One and its service providers are committed to protecting your privacy and ask you not to send sensitive account information through e-mail.<br>Normal credit qualifications and other terms and conditions apply. This does not represent a commitment to lend. Rates subject to change without notice. This e-mail contains information directly related to your account with us. Products and services are offered by Capital One, N.A., NMLS ID 453156, Equal Housing Lender and Member FDIC. © 2012 Capital One. All rights reserved.</p>';        
        emailTempbody +='<img src="'+bottomurl+'"/>';
        emailTempbody +='</td></tr></table></body></html>';
        system.debug('**********Urloanclosing emailTempbody***********'+emailTempbody);
        return emailTempbody;
    }

    public string weneedinfo(){    
        string docid;
        string bottomdocid;
        if(mapdoc.containsKey('Application_Logo'))
            docid = mapdoc.get('Application_Logo');
        if(mapdoc.containsKey('Equal_Housing_Lender'))
                    bottomdocid = mapdoc.get('Equal_Housing_Lender');
        String orgId = UserInfo.getOrganizationId();
        string s=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+docid+'&oid='+orgId;
        string bottomurl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+bottomdocid+'&oid='+orgId;
        emailTempbody ='<html><style type="text/css">table {width: 792px;}body {font-family: Arial;}p {font-size: 12px;}ul {font-size: 12px;}p.disclaimer {font-size: 10px;}</style><body><table height="250" width="650"><tr><td>';        
        emailTempbody +='<img src="'+s+'"/><br><br>';
        emailTempbody +='<p>Dear '+lea.name+',</p>';
        emailTempbody +='<p>I tried to reach you by phone. Looks like we still need some documents from you and can’t move forward on your loan until we receive them.</p>';
        emailTempbody +='<p><b>Please send me the following by '+lea.Document_Deadline__c.format() +' in order to close on your loan by '+lea.Closing_Date__c.format()+':  </b></p>';       
        emailTempbody +='<ul>';
        if(lea.Pay_stub__c == true){
            emailTempbody +='<li>Most recent pay stub(s) for each applicant, reflecting at least 30 days’ earnings history</li>';
        }
        if(lea.Most_recent_W_2__c == true || lea.Most_recent_W_2_2_years__c == true){
            emailTempbody +='<li>Most recent W-2</li>';
        }
        if(lea.Personal_tax_return__c == true || lea.Personal_tax_return_2_years__c == true){
            emailTempbody +='<li>Signed and dated personal tax returns with all schedules for last year</li>';
        }
        if(lea.Business_tax_return__c == true || lea.Business_tax_return_2_years__c == true){
            emailTempbody +='<li>Signed and dated business tax returns with all schedules for last year</li>';
        }
        if(lea.Social_Security_award_letter__c == true){
            emailTempbody +='<li>Social Security award letter</li>';
        }
        if(lea.Pension_Annuity_Statements__c == true){
            emailTempbody +='<li>Pension/annuity income letter/statement or 1099</li>';
        }
        if(lea.Cancelled_Checks__c == true){
            emailTempbody +='<li>12 months of cancelled checks and lease agreement for rental property</li>';
        }
        if(lea.Bank_Statements__c == true){
            emailTempbody +='<li>Bank statements for the previous 30 days(all pages)</li>';
        }
        if(lea.Stocks_IRA_401k_Statements__c == true){
            emailTempbody +='<li>Most recent statements (all pages) for stocks, mutual funds, IRA, Keogh, and 401k</li>';
        }
        if(lea.Outstanding_Mortgages__c == true){
            emailTempbody +='<li>Most recent statement for all outstanding mortgages</li>';
        }
        if(lea.Statement_s_of_debts__c != null){
            emailTempbody +='<li>Most recent statement(s) for the following debts: '+lea.Statement_s_of_debts__c+'</li>';  
        }
        if(lea.HUD_1_Settlement_Statement__c == true){
            emailTempbody +='<li>Copy of HUD-1 Settlement Statement for the purchase of current property</li>';                                       
        }
        if(lea.Intened_use_of_Cash_Out_funds__c == true){
            emailTempbody +='<li>Signed and dated letter detailing the intended use of “cash out” funds</li>';                                             
        }
        if(lea.Sales_Contract__c == true){
            emailTempbody +='<li>Clear copy of sales contract with any addendum</li>';                                             
        }
        if(lea.Divorce_Separation_decree__c == true){
            emailTempbody +='<li>Copy of divorce decree and/or separation agreement</li>';                                             
        }
        if(lea.Driver_s_License__c == true){
            emailTempbody +='<li>Copy of driver’s license or government issued ID for each applicant</li>';                                      
        }
        if(lea.Homeowner_s_insurance_policy__c == true){
            emailTempbody +='<li>Copy of homeowner’s insurance policy and agent information (and/or condominium certificate of insurance)</li>';                                            
        }
        if(lea.Homeowner_s_Condo_association__c      == true){
            emailTempbody +='<li>Homeowner’s or condo association name and phone number</li>';                                                
        }
        if(lea.Documentation_of_credit_dispute__c == true){
            emailTempbody +='<li>Documentation of any credit dispute to show resolution</li>';                                        
        }
        if(lea.Property_Survey__c == true){
            emailTempbody +='<li>Copy of Property Survey</li>';                                       
        }
        if(lea.Irrevocable_Trust__c == true){
            emailTempbody +='<li>Full copy of your Irrevocable trust</li>';                                     
        }
        if(lea.RESPA_documents__c == true){
            emailTempbody +='<li>Signed Borrower\'s certification, Intent to proceed, Social security authorization, IRS 4506-T</li>';                                       
        }
        if(lea.RESPA_documents__c == true){
            emailTempbody +='<li>Signed Borrower\'s certification, Intent to proceed, Social security authorization, IRS 4506-T</li>';                                       
        }
        if(lea.Documents_for_Non_US_Citizens__c != null){
            emailTempbody +='<li>Documents needed for Non US Citizen/Permanent Resident: '+lea.Documents_for_Non_US_Citizens__c+'</li>';                                    
        }                                
        if(lea.Other__c != null){
            emailTempbody +='<li>Other Documents: '+lea.Other__c+'</li>';                                        
        }
        emailTempbody +='</ul>';
        emailTempbody +='<p>If you\'re having problems locating these documents, I may be able to help. Don\'t hesitate to email or call me with questions. Please be sure to send your documents in a secure method.</p>'; 
        emailTempbody +='<p>'+u.Name+'<br>';
        if(u.Street!= null)
            emailTempbody +=u.Street+'<br>';
        if(u.city!= null)      
            emailTempbody +=u.city+', ';
        if(u.state!= null)   
            emailTempbody +=u.state+' ';    
        if(u.postalcode!= null)                     
            emailTempbody +=u.postalcode+'<br>';
        if(u.MobilePhone!= null)
            emailTempbody +='Cell '+u.MobilePhone+'<br>';                                                                                
        if(u.Phone!=null)
            emailTempbody +='Phone '+u.Phone+'<br>';
        if(u.Fax!= null)       
            emailTempbody +='Fax '+u.Fax+'<br>';
        if(u.Email!= null)            
            emailTempbody +=u.Email+'<br>';
        if(u.nmls_id__c!= null)   
            emailTempbody +='NMLS '+u.nmls_id__c+'</p>';  
        emailTempbody +='<p> </p>';
        emailTempbody +='<p class="disclaimer">This e-mail contains information directly related to your account with us. Capital One and its service providers are committed to protecting your privacy and ask you not to send sensitive account information through e-mail.<br>Normal credit qualifications and other terms and conditions apply. This does not represent a commitment to lend. Rates subject to change without notice. This e-mail contains information directly related to your account with us. Products and services are offered by Capital One, N.A., NMLS ID 453156, Equal Housing Lender and Member FDIC. © 2012 Capital One. All rights reserved.</p>';
        emailTempbody +='<img src="'+bottomurl+'"/>';
        emailTempbody +='</td></tr></table></body></html>';
        system.debug('**********weneedinfo emailTempbody***********'+emailTempbody);
        return emailTempbody;
    }
    
    
    public string NextStepsAfterLoanSubmission(){   
        string docid;
        string bottomdocid;
        if(mapdoc.containsKey('Application_Logo'))
            docid = mapdoc.get('Application_Logo');
        if(mapdoc.containsKey('Equal_Housing_Lender'))
            bottomdocid = mapdoc.get('Equal_Housing_Lender');
        String orgId = UserInfo.getOrganizationId();
        string s=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+docid+'&oid='+orgId;
        string bottomurl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+bottomdocid+'&oid='+orgId;
        emailTempbody ='<html><style type="text/css">table {width: 792px;}body {font-family: Arial;}p {font-size: 12px;}ul {font-size: 12px;}p.disclaimer {font-size: 10px;}</style><body><table height="250" width="650"><tr><td>'; 
        emailTempbody +='<img src="'+s+'"/><br><br>';
        emailTempbody +='<p>Good news, '+lea.name+',</p>';
        emailTempbody +='<p>Your application for a Home Loan with Capital One Bank® has been successfully submitted.</p>';
        emailTempbody +='<p>To ensure your application moves forward, please return the following documents either by mail or by another secure method to my contact information below as soon as possible:</p>';
        emailTempbody +='<p><b>1. Personal financial documents that support your application:  </b></p>';                                                                                                                       
        emailTempbody +='<ul>';
        if(lea.Pay_stub__c == true){
            emailTempbody +='<li>Most recent pay stub(s) for each applicant, reflecting at least 30 days’ earnings history</li>';
        }
        if(lea.Most_recent_W_2__c == true || lea.Most_recent_W_2_2_years__c == true){
            emailTempbody +='<li>Most recent W-2</li>';
        }
        if(lea.Personal_tax_return__c == true || lea.Personal_tax_return_2_years__c == true){
            emailTempbody +='<li>Signed and dated personal tax returns with all schedules for last year</li>';
        }
        if(lea.Business_tax_return__c == true || lea.Business_tax_return_2_years__c == true){
            emailTempbody +='<li>Signed and dated business tax returns with all schedules for last year</li>';
        }
        if(lea.Social_Security_award_letter__c == true){
            emailTempbody +='<li>Social Security award letter</li>';
        }
        if(lea.Pension_Annuity_Statements__c == true){
            emailTempbody +='<li>Pension/annuity income letter/statement or 1099</li>';
        }
        if(lea.Cancelled_Checks__c == true){
            emailTempbody +='<li>12 months of cancelled checks and lease agreement for rental property</li>';
        }
        if(lea.Bank_Statements__c == true){
            emailTempbody +='<li>Bank statements for the previous 30 days(all pages)</li>';
        }
        if(lea.Stocks_IRA_401k_Statements__c == true){
            emailTempbody +='<li>Most recent statements (all pages) for stocks, mutual funds, IRA, Keogh, and 401k</li>';
        }
        if(lea.Outstanding_Mortgages__c == true){
            emailTempbody +='<li>Most recent statement for all outstanding mortgages</li>';
        }
        if(lea.Statement_s_of_debts__c != null){
            emailTempbody +='<li>Most recent statement(s) for the following debts: '+lea.Statement_s_of_debts__c+'</li>';  
        }
        if(lea.HUD_1_Settlement_Statement__c == true){
            emailTempbody +='<li>Copy of HUD-1 Settlement Statement for the purchase of current property</li>';                                       
        }
        if(lea.Intened_use_of_Cash_Out_funds__c == true){
            emailTempbody +='<li>Signed and dated letter detailing the intended use of “cash out” funds</li>';                                             
        }
        if(lea.Sales_Contract__c == true){
            emailTempbody +='<li>Clear copy of sales contract with any addendum</li>';                                             
        }
        if(lea.Divorce_Separation_decree__c == true){
            emailTempbody +='<li>Copy of divorce decree and/or separation agreement</li>';                                             
        }
        if(lea.Driver_s_License__c == true){
            emailTempbody +='<li>Copy of driver’s license or government issued ID for each applicant</li>';                                      
        }
        if(lea.Homeowner_s_insurance_policy__c == true){
            emailTempbody +='<li>Copy of homeowner’s insurance policy and agent information (and/or condominium certificate of insurance)</li>';                                            
        }
        if(lea.Homeowner_s_Condo_association__c      == true){
            emailTempbody +='<li>Homeowner’s or condo association name and phone number</li>';                                                
        }
        if(lea.Documentation_of_credit_dispute__c == true){
            emailTempbody +='<li>Documentation of any credit dispute to show resolution</li>';                                        
        }
        if(lea.Property_Survey__c == true){
            emailTempbody +='<li>Copy of Property Survey</li>';                                       
        }
        if(lea.Irrevocable_Trust__c == true){
            emailTempbody +='<li>Full copy of your Irrevocable trust</li>';                                     
        }
        if(lea.RESPA_documents__c == true){
            emailTempbody +='<li>Signed Borrower\'s certification, Intent to proceed, Social security authorization, IRS 4506-T</li>';                                       
        }
        if(lea.RESPA_documents__c == true){
            emailTempbody +='<li>Signed Borrower\'s certification, Intent to proceed, Social security authorization, IRS 4506-T</li>';                                       
        }
        if(lea.Documents_for_Non_US_Citizens__c != null){
            emailTempbody +='<li>Documents needed for Non US Citizen/Permanent Resident: '+lea.Documents_for_Non_US_Citizens__c+'</li>';                                    
        }                
        if(lea.Other__c != null){
            emailTempbody +='<li>Other Documents: '+lea.Other__c+'</li>';                                        
        }
        emailTempbody +='</ul>';
        emailTempbody +='<p><b>2. Signed loan application.</b>Please E-sign your application when notified by email. Otherwise, you’ll be mailed a copy to hand-sign and return.</p>';
        emailTempbody +='<p><b>3. Signed copies of the 4 attached Program Disclosures.</b>Please print, review, hand-sign and return.</p>';
        emailTempbody +='<p>If you have any questions or would like to review these documents together, please don’t hesitate to contact me. I’m happy to explain everything to you.</p>';
        emailTempbody +='<p>Thanks,</p>';
        emailTempbody +='<p>'+u.Name+'<br>';
        if(u.Street!= null)
            emailTempbody +=u.Street+'<br>';
        if(u.city!= null)      
            emailTempbody +=u.city+', ';
        if(u.state!= null)   
            emailTempbody +=u.state+' ';    
        if(u.postalcode!= null)                     
            emailTempbody +=u.postalcode+'<br>';
        if(u.MobilePhone!= null)
            emailTempbody +='Cell '+u.MobilePhone+'<br>';                                                                                
        if(u.Phone!=null)
            emailTempbody +='Phone '+u.Phone+'<br>';
        if(u.Fax!= null)       
            emailTempbody +='Fax '+u.Fax+'<br>';
        if(u.Email!= null)            
            emailTempbody +=u.Email+'<br>';
        if(u.nmls_id__c!= null)   
            emailTempbody +='NMLS '+u.nmls_id__c+'</p>';          
        emailTempbody +='<p> </p>';
        emailTempbody +='<p class="disclaimer">This e-mail contains information directly related to your account with us. Capital One and its service providers are committed to protecting your privacy and ask you not to send sensitive account information through e-mail.<br>Normal credit qualifications and other terms and conditions apply. This does not represent a commitment to lend. Rates subject to change without notice. This e-mail contains information directly related to your account with us. Products and services are offered by Capital One, N.A., NMLS ID 453156, Equal Housing Lender and Member FDIC. © 2012 Capital One. All rights reserved.</p>';
        emailTempbody +='<img src="'+bottomurl+'"/>';
        emailTempbody +='</td></tr></table></body></html>';
        system.debug('**********NextStepsAfterLoanSubmission emailTempbody***********'+emailTempbody);
        return emailTempbody;
    }
}