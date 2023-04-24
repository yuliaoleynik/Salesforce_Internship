public with sharing class TotalActiveContactHandler
{
    public TotalActiveContactHelper helper;

    public TotalActiveContactHandler()
    {
        this.helper = new TotalActiveContactHelper();
    }

    public void afterInsert(Map<Id, Contact> newContactsMap)
    {
        if(newContactsMap.size() > 0)
        {
            List<Contact> newContacts = newContactsMap.values();

            Set<Id> accountsId = helper.forInsertAndDelete(newContacts);
            helper.updateAccount(accountsId);
            helper.updateColorStatus(newContactsMap);
        }
    }

    public void afterUpdate(List<Contact> newContacts, Map<Id, Contact> oldContactsMap)
    {
        Set<Id> accountsId = helper.forUpdate(newContacts, oldContactsMap);
        helper.updateAccount(accountsId);
    }

    public void afterDelete(List<Contact> oldContacts)
    {
        Set<Id> accountsId = helper.forInsertAndDelete(oldContacts);
        helper.updateAccount(accountsId);
    }

    public void afterUndelete(List<Contact> newContacts)
    {
        Set<Id> accountsId = helper.forInsertAndDelete(newContacts);
        helper.updateAccount(accountsId);
    }
}