@isTest
public class XMLDom_Test{
    public static testmethod void XMLDom_method(){
    
    XMLDom testxmldom =  new XMLDom();
    string xmlstring = '<books xmlns="www.salesforce.com" title="Database.com for Dummies"><book>My Book</book><book>Your Book</book></books>';
    string xmlstring2= '<books xmlns="www.salesforce.com" title="Database.com for Dummies"></books>';
    XMLDom testxmldom2 =  new XMLDom(xmlstring);
    testxmldom.parseFromString(xmlstring);
    testxmldom.dumpall();
    testxmldom.getElementsByTagName(xmlstring);
    testxmldom.getElementByTagName(xmlstring);
    testxmldom.ownerDocument();
    testxmldom.toxmlstring();
    XMLDom.element element1 =  new XMLDom.element();
    XMLDom.element element2 =  new XMLDom.element();
    XMLDom.element[] element3 =  new XMLDom.element[]{};
    testxmldom.dumpList(element3);
    element2.parentnode=element1;
    element2.childnodes=element3;
    element2.path();
    element1.getElementByTagName(xmlstring);
    element1.getattribute(xmlstring);
    element1.getvalue(xmlstring);
    element1.dump();
    element1.dump(xmlstring);
    element1.path();
    element1.getElementsByPath(xmlstring);
    element1.firstChild();
    element1.textcontent();
    element1.hasChildNodes();
    element1.isEqualNode(element2);
    element1.cloneNode();
    element1.hasAttributes();
    element1.isSameNode(element2);
    element1.ownerDocument();
    element1.removeChild(element2);
    testxmldom.parseFromString(xmlstring2);
  }
}