({
	doInit : function(component, event, helper) {
		console.log(component.get('v.recordId'));
              
    	var toastEvent = $A.get("e.force:showToast");
    	toastEvent.setParams({
        	"title": "Success!",
            "message": "Id do registro: " + component.get('v.recordId')
    	});
    	toastEvent.fire();		       
	}
})