public with sharing class TestUtility {
    static Integer s_num = 43;
    public static String getFakeId(Schema.SObjectType sot)
    {
        String result = String.valueOf(s_num++);
        return sot.getDescribe().getKeyPrefix() +
                '0'.repeat(12-result.length()) + result;
    }

    public static Set<String> stringFieldsForTest()
    {
        return new Set<String>{'Name', 'Id'};
    }

}