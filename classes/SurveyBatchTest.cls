@isTest
private class SurveyBatchTest {
	@isTest 
    static void testBatch() {
        Account acc = Test_DataFactory.createAccount('test');
        Contact con1 = Test_DataFactory.createContact(acc.Id, 'firstName1', 'lastName1', 'email1@email.test', 'en', Date.today() - 1, null, '');
        Contact con2 = Test_DataFactory.createContact(acc.Id, 'firstName2', 'lastName2', 'email2@email.test', 'en', null, null, '');
        Contact con3 = Test_DataFactory.createContact(acc.Id, 'firstName3', 'lastName3', null, 'en', Date.today() - 1, null, '');

        Test.startTest();
        Database.executeBatch(new SurveyBatch(), 100);
        Test.stopTest();

        System.assertEquals(null, [SELECT Survey_Date__c FROM Contact WHERE Id = :con1.Id].Survey_Date__c);
        System.assertEquals(1, [SELECT Id FROM Task WHERE WhoId = :con1.Id].size());

        System.assertEquals(0, [SELECT Id FROM Task WHERE WhoId = :con2.Id].size());

        System.assertNotEquals(null, [SELECT Survey_Date__c FROM Contact WHERE Id = :con3.Id].Survey_Date__c);
        System.assertEquals(0, [SELECT Id FROM Task WHERE WhoId = :con3.Id].size());
    }
}