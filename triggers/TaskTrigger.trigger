trigger TaskTrigger on Task (after insert) {
	if (Trigger.isAfter && Trigger.isInsert) {
        TaskHandler.updateContactSurveyDate(Trigger.new);
    }
}