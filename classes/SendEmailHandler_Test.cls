@isTest
private class SendEmailHandler_Test {

    @isTest static void testSendSurveyEmail() {
        Account acc = Test_DataFactory.createAccount('test');
        Contact conWithEmail1 = Test_DataFactory.createContact(acc.Id, 'firstName1', 'lastName1', 'email1@email.test', 'en', Date.today() - 1, null, '');
        Contact conWithEmail2 = Test_DataFactory.createContact(acc.Id, 'firstName2', 'lastName2', 'email2@email.test', 'en', Date.today() - 1, null, '');
        Contact conWithoutEmail = Test_DataFactory.createContact(acc.Id, 'firstName3', 'lastName3', null, 'en', Date.today() - 1, null, '');

        Test.startTest();
        //successful scenario
        SendEmailHandler sehSuccess = new SendEmailHandler(1);
        sehSuccess.prepareSurveyEmail(conWithEmail1);
        List<Messaging.SendEmailResult> sendEmailResultsSucess = sehSuccess.sendEmails();
        System.assertNotEquals(null, sehSuccess.messages);
        System.assertEquals(1, sehSuccess.messages.size());
        System.assertEquals(true, sendEmailResultsSucess[0].isSuccess());

        //try to send email for contact with empty email
        SendEmailHandler sehFail = new SendEmailHandler(1);
        sehFail.prepareSurveyEmail(conWithoutEmail);
        List<Messaging.SendEmailResult> sendEmailResultsFail = sehFail.sendEmails();
        System.assertNotEquals(null, sehFail.messages);
        System.assertEquals(0, sehFail.messages.size());
        System.assertEquals(true, sendEmailResultsFail.isEmpty());

        //try to send more than allowed emails
        SendEmailHandler sehMoreTanAllowed = new SendEmailHandler(1);
        sehMoreTanAllowed.prepareSurveyEmail(conWithEmail1);
        sehMoreTanAllowed.prepareSurveyEmail(conWithEmail2);
        List<Messaging.SendEmailResult> sendEmailResults = sehMoreTanAllowed.sendEmails();
        System.assertNotEquals(null, sehMoreTanAllowed.messages);
        System.assertEquals(1, sehMoreTanAllowed.messages.size());
        System.assertEquals(true, sendEmailResults[0].isSuccess());
        sehMoreTanAllowed.clearMessages();
        Test.stopTest();
    }

}