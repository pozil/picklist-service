({
    getEntriesMethod : function(component, event, helper) {
        const params = event.getParam('arguments');
        const action = component.get('c.getEntries');
        action.setParams({
            objectName : params.objectName,
            fieldName : params.fieldName,
        });
        action.setCallback(this, function(response) {
            const state = response.getState();
            if (state === 'SUCCESS') {
                params.callback(response.getReturnValue());
            }
            else if (state === 'ERROR') {
                console.error('Failed to retrieve picklist values for '+ params.objectName +'.'+ params.fieldName);
                const errors = response.getError();
                if (errors) {
                    console.error(JSON.stringify(errors));
                } else {
                    console.error('Unknown error');
                }
            }
        });
        action.setStorable();
        $A.enqueueAction(action);
    }
})
