@IsTest
private with sharing class TestActiveContactTrigger
{
    @IsTest
    static void insertActiveContactsTest()
    {
        TestDataFactory.createContacts(2, 2, true);

        List<Account> accts = [SELECT Id, Active_Contacts__c, (SELECT Active__c FROM Contacts) FROM Account];
        for (Account acct: accts)
        {
            System.assertEquals(2, acct.Active_Contacts__c);
            for(Contact cont: acct.Contacts)
            {
                System.assertEquals(true, cont.Active__c);
            }
        }
    }

    @IsTest
    static void insertInactiveContactsTest()
    {
        TestDataFactory.createContacts(2, 2, false);

        List<Account> accts = [SELECT Id, Active_Contacts__c, (SELECT Active__c FROM Contacts) FROM Account];
        for (Account acct: accts)
        {
            System.assertEquals(null, acct.Active_Contacts__c);
            for(Contact cont: acct.Contacts)
            {
                System.assertEquals(false, cont.Active__c);
            }
        }
    }

    @IsTest
    static void updateContactWithoutChangesTest()
    {
        TestDataFactory.createContacts(2, 1, true);

        List<Contact> conts = [SELECT Id, Active__c FROM Contact];
        for(Contact cont: conts)
        {
            cont.Active__c = true;
        }
        update conts;
    }

    @IsTest
    static void updateContactWithChangesTest()
    {
        TestDataFactory.createContacts(2, 1, false);

        List<Contact> conts = [SELECT Id, Active__c FROM Contact];
        for(Contact cont: conts)
        {
            cont.Active__c = true;
        }
        update conts;

        List<Account> accts = [SELECT Id, Active_Contacts__c, (SELECT Active__c FROM Contacts) FROM Account];
        for (Account acct: accts)
        {
            System.assertEquals(1, acct.Active_Contacts__c);
            for(Contact cont: acct.Contacts)
            {
                System.assertEquals(true, cont.Active__c);
            }
        }
    }

    @IsTest
    static void updateContactWithAccountChangingTest()
    {
        TestDataFactory.createContacts(1, 1, true);

        Account acc = new Account(Name = 'Test New Account');
        insert acc;

        Contact cont = [SELECT Id, AccountId FROM Contact LIMIT 1];
        cont.AccountId = acc.Id;
        update cont;

        List<Account> accts = [SELECT Id, Name, Active_Contacts__c FROM Account];
        for(Account acct: accts)
        {
            if(acct.Name == 'TestAccount0') System.assertEquals(0, acct.Active_Contacts__c);
            if(acct.Name == 'Test New Account') System.assertEquals(1, acct.Active_Contacts__c);
        }
    }

    @IsTest
    static void deleteContactsTest()
    {
        TestDataFactory.createContacts(2, 2, true);

        Database.delete([SELECT Id FROM Contact]);

        List<Account> accts = [SELECT Id, Active_Contacts__c FROM Account];
        for (Account acct: accts)
        {
            System.assertEquals(0, acct.Active_Contacts__c);
        }
    }
}