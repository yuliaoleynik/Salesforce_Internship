public with sharing class GetRecordDataController
{
    @AuraEnabled(Cacheable=true)
    public static List<Car__c> getCars()
    {
        try
        {
            return [
                    SELECT Id, Name, MSRP__c, Picture_URL__c,
                            Make__c, Category__c, Number_of_Seats__c,
                            Fuel_Type__c, Control__c
                    FROM Car__c
            ];
        }
        catch (Exception ex)
        {
            throw new AuraHandledException(ex.getMessage());
        }
    }

    @AuraEnabled(Cacheable=true)
    public static List<Car__c> getCarsWithFilters(String[] category, String[] make, String keyWord, Integer price)
    {   
        Set<Id> recordsId = new Set<Id>();
        List<Car__c> carsList = getCarsWithoutCheckboxFilter(keyWord, price);

        recordsId = (new Map<Id,Car__c>(carsList)).keySet();      // id of records(allcars) that can be filtered by checkbox settings

        if (category.size() != 0 && make.size() != 0)
        {   
            return [
                    SELECT Id, Name, MSRP__c, Picture_URL__c,
                            Make__c, Category__c, Number_of_Seats__c,
                            Fuel_Type__c, Control__c
                    FROM Car__c
                    WHERE ((Category__c IN :category AND Make__c IN :make) AND Id IN :recordsId)
            ];
        }
        else if (category.size() == 0 && make.size() == 0) 
        { 
            return carsList;
        }
        else 
        {
            return [
                    SELECT Id, Name, MSRP__c, Picture_URL__c,
                            Make__c, Category__c, Number_of_Seats__c,
                            Fuel_Type__c, Control__c
                    FROM Car__c
                    WHERE ((Category__c IN :category OR Make__c IN :make) AND Id IN :recordsId)
            ];
        }    
    }

    public static List<Car__c> getCarsWithoutCheckboxFilter(String keyWord, Integer price)   // dont know how to make this method shorter 
    {
        if(String.isBlank(keyWord))
        {
            return [
                    SELECT Id, Name, MSRP__c, Picture_URL__c,
                            Make__c, Category__c, Number_of_Seats__c,
                            Fuel_Type__c, Control__c
                    FROM Car__c
                    WHERE MSRP__c <= :price
                ];
        }
        else 
        {
            String key = '%' + keyWord + '%';
            return [
                    SELECT Id, Name, MSRP__c, Picture_URL__c,
                            Make__c, Category__c, Number_of_Seats__c,
                            Fuel_Type__c, Control__c
                    FROM Car__c
                    WHERE (Name LIKE :key AND MSRP__c <= :price)
                ];
        }
    }
}