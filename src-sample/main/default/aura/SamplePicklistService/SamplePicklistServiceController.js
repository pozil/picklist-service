({
    loadEntries : function(component, event, helper) {
		component.set('v.entries', null);
		const objectName = component.get('v.objectName');
		const fieldName = component.get('v.fieldName');
		component.find('picklistService').getEntries(objectName, fieldName, entries => {
			component.set('v.entries', entries);
			component.set('v.entriesAsJson', JSON.stringify(entries, null, 4));
			// Select default value
			const selectedEntries = entries.filter(entry => entry.isDefaultValue);
			if (selectedEntries.length > 0) {
				component.set('v.selectedEntry', selectedEntries[0].value);
			}
		});
	}
})