@IsTest
private class DeleteRecordsTest
{
    @IsTest
    static void testBatchApexWith200Contacts()
    {
        TestDataFactory.createContacts(200, 1, false);

        Test.startTest();
        DeleteRecords uca = new DeleteRecords();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();

        List<Account> result = [SELECT Id, (SELECT Id, Age__c FROM Contacts) FROM Account];
        for (Account acc : result)
        {
            if (acc.Contacts.size() > 0)
            {
                System.assertEquals(true, acc.Contacts.get(0).Age__c <= 30);
            }
        }
    }
}