public class TotalActiveContactHelper
{
    public Set<Id> forInsertAndDelete(List<Contact> contactList)
    {
        Set<Id> accountIdSet = new Set<Id>();

        for (Contact contact : contactList)
        {
            if (contact.AccountId != null && contact.Active__c)
            {
                accountIdSet.add(contact.AccountId);
            }
        }
        return accountIdSet;
    }

    public Set<Id> forUpdate(List<Contact> contactList, Map<Id, Contact> oldMap)
    {
        Set<Id> accountIdSet = new Set<Id>();

        Boolean activeChange = false;
        Boolean accountChange = false;

        for (Contact contact: contactList)
        {
            activeChange = (contact.Active__c != oldMap.get(contact.Id).Active__c);  // check if field "active" is changed
            accountChange = (contact.AccountId != oldMap.get(contact.Id).AccountId); // check if changed account for contact

            if (activeChange || accountChange)
            {
                if (contact.AccountId != null && contact.Active__c)  // account will be update in both cases(account or active field changed)
                {
                    accountIdSet.add(contact.AccountId);
                }
                if (oldMap.get(contact.Id).AccountId != null && accountChange)  // but if contact changed account the past account will be updated as well
                {
                    if (oldMap.get(contact.Id).Active__c) accountIdSet.add(oldMap.get(contact.Id).AccountId);  // if account and active field changed but previous field was false so previous account won't update
                }
            }
        }
        return accountIdSet;
    }

    public void updateAccount(Set<Id> accountIdSet)
    {
        List<Account> accountList = [SELECT Id, Active_Contacts__c, (SELECT Id FROM Contacts WHERE Active__c = TRUE) FROM Account WHERE Id IN :accountIdSet];
        List<Account> accountListToUpdate = new List<Account>();

        if (accountList.size() > 0)
        {
            for (Account acc : accountList)
            {
                acc.Active_Contacts__c = acc.Contacts.size();
                accountListToUpdate.add(acc);
            }
            if (accountListToUpdate.size() > 0)
            {
                update accountListToUpdate;
            }
        }
    }

    public void updateColorStatus(Map<Id, Contact> newContactsMap)
    {
        ScheduleUpdateRecords obj = new ScheduleUpdateRecords(newContactsMap);
        System.schedule('update ColorStatus for Contact' + System.now(), '0 0 0 /10 * ?', obj);
    }
}