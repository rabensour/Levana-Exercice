// This line declares the class "totalContactsHandler" as public, which means it can be accessed outside of the class itself.
public class totalContactsHandler {

    // This line declares a public static method named "countContacts" that takes two lists of Contact objects as parameters (newList and oldList).
    public static void countContacts(List<Contact> newList, List<Contact> oldList) {

        // This line declares a Set named "accountIds" to store unique Account Ids related to the Contacts.
        Set<Id> accountIds = new Set<Id>();

        // This block of code checks if the "newList" parameter is not null and loops through each Contact in the list.
        if (newList != null) {
            for (Contact c : newList) {
                // This inner block checks if the Contact has a non-null AccountId and adds it to the "accountIds" set.
                if (c.AccountId != null) {
                    accountIds.add(c.AccountId);
                }
            }
        }

        // This block of code checks if the "oldList" parameter is not null and loops through each Contact in the list.
        if (oldList != null) {
            for (Contact c : oldList) {
                // This inner block checks if the Contact has a non-null AccountId and adds it to the "accountIds" set.
                if (c.AccountId != null) {
                    accountIds.add(c.AccountId);
                }
            }
        }

        // This line queries the related Accounts (with the "Total_Contacts__c" field) based on the Account Ids in the "accountIds" set.
        List<Account> accounts = [
            SELECT Id, Total_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds
        ];

        // This block of code checks if the "accounts" list is not empty and loops through each Account.
        if (!accounts.isEmpty()) {
            for (Account acc : accounts) {
                // This inner block sets the "Total_Contacts__c" field of the Account to the number of related Contacts (Contacts are available in the "Contacts" subquery).
                acc.Total_Contacts__c = acc.Contacts.size();
            }
        }

        // This line updates the modified Accounts in the Salesforce database.
        update accounts;
    }
}
