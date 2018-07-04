@isTest
public class PicklistServiceControllerTest {
    static testMethod void getEntries_should_work() {
        Test.startTest();
        List<Map<String,Object>> entries = PicklistServiceController.getEntries('Account', 'Industry');
        Test.stopTest();

        System.assert(entries.size() > 0);
        Map<String,Object> entry = entries[0];
        System.assert(entry.get('label') != null);
        System.assert(entry.get('value') != null);
        System.assert(entry.get('isDefaultValue') != null);
    }

    static testMethod void getEntries_should_fail_when_invalid_objectName() {
        Test.startTest();
        try {
            PicklistServiceController.getEntries('Unknown', 'Industry');
            System.assert(false, 'Exception was expected');
        } catch (Exception e) {
            System.assert(e instanceof AuraHandledException);
        }
        Test.stopTest();
    }

    static testMethod void getEntries_should_fail_when_invalid_fieldtName() {
        Test.startTest();
        try {
            PicklistServiceController.getEntries('Account', 'Unknown');
            System.assert(false, 'Exception was expected');
        } catch (Exception e) {
            System.assert(e instanceof AuraHandledException);
        }
        Test.stopTest();
    }
}
