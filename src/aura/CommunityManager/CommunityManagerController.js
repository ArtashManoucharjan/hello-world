({
    navigate : function(component, event, helper) {
        //Find the text value of the component with aura:id set to "address"
        var address = component.get("v.supportURL");
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": address,
            "isredirect" :false
        });
        urlEvent.fire();
    },
    
    doInit: function(component, event, helper) {      
        // Fetch the Manager Info   
        var action = component.get('c.getManagerUser');
        
        // Set up the callback
        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.manager', actionResult.getReturnValue());            
        });
        $A.enqueueAction(action);
    }

})