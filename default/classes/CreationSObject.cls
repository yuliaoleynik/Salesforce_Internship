public with sharing class CreationSObject {

    public SObject newSObject(String typeName, Map<String, String> fieldToValue)
    {
        String typeNameErrorLable = Label.invalidTypeNameErrorMesagge;
        String fieldNameErrorLable = Label.invalidFieldNameErrorMessage;

        SObject newObject;
        try
        {
            newObject = (SObject) Type.forName(typeName).newInstance();
        }
        catch (NullPointerException ex)
        {
            throw new InvalidTypeNameException(typeNameErrorLable);
        }

        for(String field: fieldToValue.keySet())
        {
            try
            {
                newObject.put(field, fieldToValue.get(field));
            }
            catch (SObjectException ex)
            {
                throw new InvalidTypeNameException(fieldNameErrorLable);
            }
        }

        insert newObject;
        return newObject;
    }

    public class InvalidTypeNameException extends Exception {}
}