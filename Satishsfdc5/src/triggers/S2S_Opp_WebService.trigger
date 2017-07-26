trigger S2S_Opp_WebService on Opportunity (after insert) {
	Consumer_Opp_Invoke.Consumer_Opp_Invoke_record(Trigger.new[0].id);
}