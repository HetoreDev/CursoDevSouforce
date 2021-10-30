public with sharing class AccountActivitiesSchedule implements Schedulable{
    public AccountActivitiesSchedule() {
        //commit on master
    }

    public void execute(SchedulableContext sc){
        List<Opportunity> Opportunities = [SELECT AccountId, OwnerId FROM Opportunity WHERE LastModifiedDate <= LAST_N_DAYS:2 and StageName != 'Closed'];
        List<Task> taskToInsert = new List<Task>();

        for(Opportunity opp : Opportunities){
            taskToInsert.add(
                new Task(
                    WhatId = opp.AccountId,
                    OwnerId = opp.OwnerId,
                    ActivityDate = System.now().addDays(1).date(),
                    Subject = 'Follow-up'
                )
            );
        }

        insert taskToInsert;

    }
}

/* 
Como realizar um agendamento por Apex

Datetime cronTriggerTimer = System.now().addMinutes(2);
String cronTriggerStr = '0 ' + cronTriggerTime.time().minute() + ' ' + cronTrigger.time().hour() + ' * * ?';

System.Schedule('Activities Job', cronTriggerStr, new AccountActivitiesSchedule());

O limite de Jobs agendados por Org é de 100, cuidado para não gerar um Loop ao chamar um schedule dentro de uma trigger
*/
