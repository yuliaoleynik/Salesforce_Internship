public class ScheduleUpdateRecords implements Schedulable
{
    Map<Id, Contact> contactsForBatch = new Map<Id, Contact>();

    public ScheduleUpdateRecords(Map<Id, Contact> contacts)
    {
        this.contactsForBatch = contacts;
    }

    public void execute(SchedulableContext sc)
    {
        UpdateRecords obj = new UpdateRecords(contactsForBatch);
        Database.executeBatch(obj,200);
    }
}