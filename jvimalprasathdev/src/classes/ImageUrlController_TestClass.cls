@isTest
public class ImageUrlController_TestClass{ 
    Static TestMethod Void Test_ImageUrlController(){
         ImageUrlController img= new  ImageUrlController();
         img.getimgurl();
         img.imgname='Equal_Housing_Lender';
         img.getimgurl();
         img.getshowtopimage();
         img.imgname='Pre_Application_Logo';
         img.getshowtopimage();
         string s='errett';
         Blob myBlob = Blob.valueof(s);
         folder f=[select id from folder where name='Shared Documents'];
         Document d= new document(name='tests',body=myBlob,folderid=f.id);
         insert d;
         img.imgname='tests';
         img.getimgurl();
    }
}