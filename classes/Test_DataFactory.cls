@isTest
public class Test_DataFactory {
    public static Account createAccount(String accName) {
        Account testAccount = new Account(
            Name = accName
        );
        insert testAccount;
        return testAccount;
    }

    public static Contact createContact(Id accId, String firstName, String lastName, String email, String language, Date surveyDate, Id productId, String homeCountry) {
        Contact testContact = new Contact(
            AccountId = accId,
            FirstName = firstName,
            LastName = lastName,
            Email = email,
            Language__c = language,
            Survey_Date__c = surveyDate,
            Product__c = productId,
            Home_Country__c = homeCountry
        );
        insert testContact;
        return testContact;
    }

    public static Case createCase(Id accId, String conId, String subject) {
        Case testCase = new Case(
            AccountId = accId,
            ContactId = conId,
            Subject = subject
        );
        insert testCase;
        return testCase;
    }

    public static Task createTask(Id whatId, Id whoId, String taskSubtype) {
        Task testTask = new Task(
            WhatId = whatId,
            WhoId = whoId,
            TaskSubtype = taskSubtype
        );
        insert testTask;
        return testTask;
    }

    public static Product2 createProduct(String name, String currencyIsoCode, String productCode) {
        Product2 testProduct = new Product2(
            IsActive = true,
            Name = name,
            CurrencyIsoCode = currencyIsoCode,
            ProductCode = productCode
        );
        insert testProduct;
        return testProduct;
    }

    public static PricebookEntry createPricebookEntry(Product2 product, String currencyIsoCode, Decimal unitPrice, Decimal costPerCal, Decimal cardReplacement, Decimal atmFee) {
        PricebookEntry testPricebookEntry = new PricebookEntry(
            IsActive = true,
            Product2Id = product.Id,
            CurrencyIsoCode = currencyIsoCode,
            Pricebook2Id = Test.getStandardPricebookId(),
            UnitPrice = unitPrice,
            ATM_Fee__c = atmFee,
            Card_Replacement_Cost__c = cardReplacement,
            Cost_per_Calendar_Month__c = costPerCal
        );
        insert testPricebookEntry;
        return testPricebookEntry;
    }
}