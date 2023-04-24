public with sharing class AccountsSelector{

    public Account getByID(Id accountId, Set<String> accountFields)
    {
        String errorLable = Label.getByIDError;

        String query = 'SELECT ';
        query += String.join(new List<String>(accountFields), ', ');
        query += ' FROM Account WHERE Id =: accountId LIMIT 1';

        try
        {
            return Database.query(query);
        }
        catch (QueryException ex)
        {
            throw new NotFoundAccountException(errorLable);
        }
        catch (StringException ex)
        {
            throw new NotFoundAccountException(errorLable);
        }
    }

    public List<Account> getByName(String accountName, Set<String> accountFields)
    {
        String query = 'SELECT ';
        query += String.join(new List<String>(accountFields), ', ');
        query += ' FROM Account WHERE Name =: accountName';

        return Database.query(query);
    }

    public List<Account> getWithContacts(Set<String> accountFields)
    {
        String query = 'SELECT ';

        query += String.join(new List<String>(accountFields), ', ');
        query += ' FROM Account WHERE Id IN (SELECT AccountId FROM Contact)';

        return Database.query(query);
    }

    public class NotFoundAccountException extends Exception {}
}