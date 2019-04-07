({
	getContactProductInfo : function(component) {
		var action = component.get('c.getContactProductInformation'); 
        action.setParams({
            "caseId" : component.get('v.recordId') 
        });
        action.setCallback(this, function(response) {
			var state = response.getState();
            console.log(state);
			if (state == 'SUCCESS') {
                console.log('response.getReturnValue()===='+response.getReturnValue());
				component.set('v.prodInfo', response.getReturnValue());					
			}
		});
		$A.enqueueAction(action);
	}
})