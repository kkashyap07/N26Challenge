public class ProductInformationController {
	
    @AuraEnabled
    public static PricebookEntry getContactProductInformation(Id caseId){
        List<Case> caseList = new List<Case>();
        System.debug('case id='+caseId);
        if(caseId!=null){
			caseList = [Select id, ContactId, Contact.Product__c, Contact.Home_Country__c from Case where id=:caseId];
        }
        System.debug('caseList='+caseList);
        if(caseList.size()>0){
            Case c = caseList[0];
            List<PricebookEntry> pbeList = [Select id, Product2.Name, Pricebook2.Name, Cost_per_Calendar_Month__c, ATM_Fee__c, 
                                            Card_Replacement_Cost__c from PricebookEntry where Product2Id = :c.Contact.Product__c 
                                            AND Pricebook2.Name=:c.Contact.Home_Country__c];
            System.debug('pbeList='+pbeList);
            return pbeList.size()>0?pbeList[0]:null;
        }else{
        	return null;
        }
    }
}