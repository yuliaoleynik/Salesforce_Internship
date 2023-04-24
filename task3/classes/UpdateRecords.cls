public class UpdateRecords implements Database.Batchable<SObject>
{
    Map<Id, Contact> contactById = new Map<Id, Contact>();
    List<Contact> toUpdate = new List<Contact>();

    public UpdateRecords(Map<Id, Contact> contacts)
    {
        this.contactById = contacts;
    }

    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        Set<Id> Ids = contactById.keySet();
        String query = 'SELECT Id, StatusColor__c FROM Contact WHERE isDeleted=false AND Id IN:Ids';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Contact> records)
    {
        for (Contact c : records)
        {
            c.StatusColor__c = 'green';
            toUpdate.add(c);
        }
        update toUpdate;
    }

    public void finish(Database.BatchableContext bc)
    {
		AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed
                FROM AsyncApexJob WHERE Id =:bc.getJobId()];

        System.abortJob(a.Id);
    }
}