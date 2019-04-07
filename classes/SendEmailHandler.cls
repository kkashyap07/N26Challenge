public with sharing class SendEmailHandler {

    public static final String GERMAN_LANG = 'DE';
    public static final String DEFAULT_LANG = 'EN';

    @TestVisible
    private List<Messaging.SingleEmailMessage> messages;
    private Integer emailCount;

    public SendEmailHandler(Integer emailCount) {
        this.messages = new List<Messaging.SingleEmailMessage>();
        this.emailCount = emailCount;
    }

    public void clearMessages() {
        this.messages = new List<Messaging.SingleEmailMessage>();
    }

    public void prepareSurveyEmail(Contact surveyContact) {
        try {
            if (this.messages.size() >= this.emailCount || surveyContact == null || String.isEmpty(surveyContact.Email)) {
                return;
            }

            String language = (GERMAN_LANG.equalsIgnoreCase(surveyContact.Language__c)) ? GERMAN_LANG : DEFAULT_LANG;
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setTargetObjectId(surveyContact.Id);
            message.setTemplateId(SendEmailHandler.getSurveyTemplateId(language));
            message.setWhatId(surveyContact.AccountId);
            message.setSaveAsActivity(true);
            this.messages.add(message);
        } catch(Exception e) {
            System.debug('>>> ' + e.getMessage());
            System.debug('>>> ' + e.getStackTraceString());
        }
    }

    public List<Messaging.SendEmailResult> sendEmails() {
        List<Messaging.SendEmailResult> result = new List<Messaging.SendEmailResult>();
        try {
            //going to send up to 100 emails in a single .sendEmail invocation
            //so this is the count of .sendEmail invocations
            Integer sendEmailCount = this.messages.size() /100 + 1;
            //available count of .sendEmail invocations for current transaction
            Integer availableSendEmailCount = Limits.getLimitEmailInvocations() - Limits.getEmailInvocations();

            sendEmailCount = (availableSendEmailCount > sendEmailCount) ? sendEmailCount : availableSendEmailCount;
            //split this.messages array to sub-arrays of 100 elements and send these sub-arrays
            for (Integer batchIntd = 0; batchIntd < sendEmailCount; batchIntd++) { //send up to 100 emails per .sendEmail invocation
                Integer startIndex = batchIntd * 100;
                Integer endIndex = (batchIntd + 1) * 100;
                endIndex = (endIndex > this.messages.size()) ? this.messages.size() : endIndex;
                result.addAll(Messaging.sendEmail(this.getMessagesToSend(startIndex, endIndex)));
            }
        } catch(Exception e) {
            System.debug('>>> ' + e.getMessage());
            System.debug('>>> ' + e.getStackTraceString());
        }
        return result;
    }

    public static Id getSurveyTemplateId(String language) {
        String templateName = 'Survey_Email_' + language;
        return [SELECT Id FROM EmailTemplate WHERE DeveloperName = :templateName].Id;
    }

    private List<Messaging.SingleEmailMessage> getMessagesToSend(Integer startInd, Integer endInd) {
        List<Messaging.SingleEmailMessage> messagesToSend = new List<Messaging.SingleEmailMessage>();
        for (Integer i = startInd; i < endInd; i++) {
            messagesToSend.add(this.messages[i]);
        }
        return messagesToSend;
    }
}