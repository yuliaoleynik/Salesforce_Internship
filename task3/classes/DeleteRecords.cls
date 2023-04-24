public class DeleteRecords implements Database.Batchable<SObject>
{
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        String query = 'SELECT Id, Age__c FROM Contact WHERE WHERE isDeleted=false AND Age__c > 30 LIMIT 400';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Contact> records)
    {
        delete records;
    }

    public void finish(Database.BatchableContext bc)
    {

    }
}