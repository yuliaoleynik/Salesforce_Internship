public class ScheduleDeleteRecords implements  Schedulable
{
    public void execute(SchedulableContext sc)
    {
        DeleteRecords obj = new DeleteRecords();
        Database.executeBatch(obj,200);
    }
}