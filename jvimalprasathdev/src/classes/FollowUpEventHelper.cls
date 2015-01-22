/*
Name: FollowUpEventHelper
Refering Class: Close_LeadOn_eMarketing
Author: Yunus H
Company: Wipro Technologies
Description: Flag for controling the Execution of Lead Conversion.
Last Modified by: Yunus H
*/
public class FollowUpEventHelper {  
  // Static variables are local to the context of a Web request       
  // Therefore, this variable will be initialized as false 
  // at the beginning of each Web request which accesses it.   
  private static boolean alreadyCreatedEvents = false;
  private static boolean alreadyCreatedLeads = false;
  private static boolean EmailSentLeads = false;
  
  public static boolean hasAlreadyCreatedFollowUpEvents() {
     return alreadyCreatedEvents ;
  } 
  public static boolean hasAlreadyCreatedFollowUpLeads() {
     return alreadyCreatedLeads ;
  } 
  public static boolean hasAlreadyEmailSentLeads() {
     return EmailSentLeads;
  }  
  // By setting the variable to true, it maintains this 
  // new value throughout the duration of the request               
  public static void setAlreadyCreatedFollowUpEvents() {
     alreadyCreatedEvents = true;
  } 
  public static void setAlreadyCreatedFollowUpLeads() {
     alreadyCreatedLeads = true;
  } 
  public static void setAlreadyEmailSentLeads() {
     EmailSentLeads = true;
  }   
   
}