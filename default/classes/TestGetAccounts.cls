@IsTest
public with sharing class TestGetAccounts {

    @TestSetup static void setup()
    {
        String insertObjectErrorLable = System.Label.insertObjectOnSetupMethodErrorMessage;

        try
        {
            List<Account> testAccts = new List<Account>();
            for (Integer i = 0; i < 4; i++)
            {
                testAccts.add(new Account(Name = 'TestAcct' + i));
            }
            insert testAccts;

            List<Contact> testCntcs = new List<Contact>();
            for (Integer i = 0; i < 2; i++)
            {
                testCntcs.add(new Contact(LastName = 'testCntcs' + i,
                        AccountId = testAccts[i].Id));
            }
            insert testCntcs;
        }
        catch (Exception ex) {
            throw new TestGetAccountException(insertObjectErrorLable);
        }
    }

    @IsTest public static void testGetById()
    {
        AccountsSelector inst = new AccountsSelector();
        Id accountId = [SELECT Id FROM Account WHERE Name = 'TestAcct2'].Id;
        Account acc;
        Boolean checkException = true;

        Test.startTest();
        try
        {
            acc = inst.getByID(accountId,
                    TestUtility.stringFieldsForTest());
        }
        catch(AccountsSelector.NotFoundAccountException ex)
        {
            checkException = false;
        }
        Test.stopTest();

        System.assertEquals('TestAcct2', acc.Name);
        System.assert(checkException);
    }

    @IsTest public static void testGetByFakeId()
    {
        AccountsSelector inst = new AccountsSelector();
        Boolean checkException = false;

        Test.startTest();
        try
        {
            Account acc = inst.getByID(TestUtility.getFakeId(Account.SObjectType),
                    TestUtility.stringFieldsForTest());
        }
        catch(AccountsSelector.NotFoundAccountException ex)
        {
            checkException = true;
        }
        Test.stopTest();

        System.assert(checkException);
    }

    @IsTest public static void testGetByName()
    {
        AccountsSelector inst = new AccountsSelector();
        String accountName = [SELECT Name FROM Account LIMIT 1].Name;

        Test.startTest();
        List<Account> acts = inst.getByName(accountName, TestUtility.stringFieldsForTest());
        Test.stopTest();

        if(acts.size() > 0)
        {
            for(Account act: acts)
            {
                System.assertEquals(accountName,act.Name);
            }
        }
    }

    @IsTest public static void testGetWithContacts()
    {
        AccountsSelector inst = new AccountsSelector();

        Test.startTest();
        List<Account> acts = inst.getWithContacts(TestUtility.stringFieldsForTest());
        System.debug(acts);
        Test.stopTest();

        System.assertEquals('TestAcct0', acts[0].Name);
        System.assertEquals('TestAcct1', acts[1].Name);
    }

    public class TestGetAccountException extends Exception {}
}