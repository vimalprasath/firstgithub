public with sharing class ImageUrlController {

public string imgname {get; set;}
//public boolean showtopimage{get; set;}
list<Document> imgDoc = new List<Document>();
   
    public string getimgurl(){
    if(imgname!=null){
            imgDoc =[select id,DeveloperName,Name from Document where DeveloperName=:imgname];
            if(imgdoc!=null && imgdoc.size()>0)                
                return URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+imgdoc[0].id+'&oid='+UserInfo.getOrganizationId();
            else
                return null;
    }
    return null;
    }
    public boolean getshowtopimage(){
        if(imgname!='Equal_Housing_Lender') 
                return true;
        else
            return false;
    }
// Use this SOQL  (Please substitute {Applicatiobn Logo) with the component attribute value
// [SELECT Id FROM Document where Name = 'Application logo' limit 1]

// Use imgURL = URL.getSalesforceBaseUrl().toExternalForm() + id + organization id + height & width

//return imgURL;

}