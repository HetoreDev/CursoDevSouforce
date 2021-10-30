trigger AccountTrigger on Account (before insert, after insert) {
    if(Trigger.operationType == System.TriggerOperation.BEFORE_INSERT){
        // Essa condição dá no mesmo que uma condição igual a (Trigger.isBefore && Trigger.isAfter)
        AccountTriggerHandler.onbeforeInsert(Trigger.new, Trigger.newMap);
    }

    if(Trigger.operationType == System.TriggerOperation.AFTER_INSERT){
        // Essa condição dá no mesmo que uma condição igual a (Trigger.isInsert && Trigger.isAfter)
        AccountTriggerHandler.onAfterInsert(Trigger.new, Trigger.newMap);
    }
}