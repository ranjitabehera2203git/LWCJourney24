public with sharing class customLookupController {

    @AuraEnabled(cacheable=true)
    public static List<SObject> searchRecords(String objectName, String searchKey )
    {
        List<SObject> sobjectRecords = new List<SObject>();
        if(String.isNotBlank(searchKey))
        {
            String key = '%'+ searchKey +'%';
            String queryInput = 'Select Id, Name from '+ objectName +' Where Name Like : Key';
            sobjectRecords = Database.query(queryInput, AccessLevel.USER_MODE);
        }
        return sobjectRecords;
    }
}