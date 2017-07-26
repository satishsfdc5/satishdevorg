trigger accountIndustry on Account (before insert) {
	for(Account acc :trigger.new){
		acc.Industry = 'Test Satish Industry';
	}
}