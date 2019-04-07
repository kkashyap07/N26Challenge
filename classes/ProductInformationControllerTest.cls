@isTest
private class ProductInformationControllerTest {
	@isTest 
    static void testGetProductInfo() {
        Product2 testProduct = Test_DataFactory.createProduct('Test Product', 'USD', 'ABC');
        PricebookEntry testPricebookEntry = Test_DataFactory.createPricebookEntry(testProduct, 'USD', 0, 9.9, 6, 1.7);

        Account acc = Test_DataFactory.createAccount('test');
        Contact con = Test_DataFactory.createContact(acc.Id, 'first', 'last', 'test@email.dummy', 'en', Date.today() - 1, testProduct.Id, 'UK');
        Case c = Test_DataFactory.createCase(acc.Id, con.Id, 'test');

        System.assertEquals(true, ProductInformationController.getContactProductInformation(c.Id)!=null);
    }
}