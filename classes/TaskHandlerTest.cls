@isTest
private class TaskHandlerTest {

    @isTest 
    static void testUpdateContactSurveyDate() {
        Account acc = Test_DataFactory.createAccount('test');
        Contact con = Test_DataFactory.createContact(acc.Id, 'firstName1', 'lastName1', 'email1@email.test', 'en', Date.today() - 1, null, '');

        Test.startTest();
        Test_DataFactory.createTask(acc.Id, con.Id, 'Email');
        System.assertEquals(null, [SELECT Survey_Date__c FROM Contact].Survey_Date__c);
        Test.stopTest();
    }

}