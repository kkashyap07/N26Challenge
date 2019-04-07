public class SurveyBatch implements Database.Batchable<Contact>, Schedulable {
	public void execute(SchedulableContext context) {
        Database.executeBatch(this, 100); //going to send up to 100 emails in a single batch
    }
        
    public List<Contact> start(Database.BatchableContext BC) {
        return [SELECT Id, FirstName, LastName, Email, Language__c, Survey_Date__c, AccountId from Contact where Survey_Date__c < TODAY];
    }

    public void execute(Database.BatchableContext BC, List<Contact> contacts) {
        SendEmailHandler emailHandler = new SendEmailHandler(100);
        for (Contact surveyContact : Contacts) {
            emailHandler.prepareSurveyEmail(surveyContact);
        }
        List<Messaging.SendEmailResult> sendEmailResults = emailHandler.sendEmails();
    }

    public void finish(Database.BatchableContext BC) {
    
    }
}