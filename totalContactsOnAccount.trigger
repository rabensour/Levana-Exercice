trigger totalContactsOnAccount on Contact (after insert, after update, after delete, after undelete) {
    
    if (trigger.isAfter)
    {
        if (trigger.isInsert || trigger.isUpdate || trigger.isDelete || trigger.isUndelete)
        {
            totalContactHandler.countContacts(Trigger.new, Trigger.old);
        }
    }
}