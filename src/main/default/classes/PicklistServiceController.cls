public with sharing class PicklistServiceController {
    
    private class PicklistServiceException extends Exception {}

    @AuraEnabled
    public static List<Map<String,Object>> getEntries(String objectName, String fieldName) {
        // Get entries from object and field names
        List<Schema.PicklistEntry> allEntries;
        try {
            Schema.DescribeSobjectResult[] objDescriptions = Schema.describeSObjects(new String[]{objectName});
            Schema.SObjectField field = objDescriptions[0].fields.getMap().get(fieldName);
            if (field == null) {
                throw new PicklistServiceException('No such field.');
            }
            Schema.DescribeFieldResult fieldDescription = field.getDescribe();
            allEntries = fieldDescription.getPicklistValues();
        } catch (Exception e) {
            throw new AuraHandledException('Failed to retrieve entries for picklist '+ objectName +'.'+ fieldName +': '+ e.getMessage());
        }
        
        // Filter active entries and convert output (AuraEnabled methods cannot return List<Schema.PicklistEntry>)
        List<Map<String,Object>> activeEntries = new List<Map<String,Object>>();
        for(Schema.PicklistEntry entry : allEntries) {
            if (entry.isActive()) {
                Map<String,Object> entryData = new Map<String,Object>();
                entryData.put('value', entry.getValue());
                entryData.put('label', entry.getLabel());
                entryData.put('isDefaultValue', entry.isDefaultValue());
                activeEntries.add(entryData);
            }
        }
        return activeEntries;
    }
}
