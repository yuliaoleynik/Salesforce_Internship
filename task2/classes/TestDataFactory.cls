@IsTest
public with sharing class TestDataFactory
{
    public static void createContacts(Integer numAccts, Integer numContPerAcct, Boolean activeValue)
    {
        List<Account> accts = new List<Account>();
        for(Integer i = 0; i < numAccts; i++)
        {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }
        insert accts;

        List<Contact> conts = new List<Contact>();
        for (Integer j = 0; j < numAccts; j++)
        {
            Account acct = accts[j];

            for (Integer k = 0; k < numContPerAcct; k++)
            {
                conts.add(new Contact(LastName = acct.Name + ' Contact ' + k,
                        Age__c = j,
                        Active__c = activeValue,
                        AccountId = acct.Id));
            }
        }
        insert conts;
    }
}