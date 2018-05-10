sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::say("Welcome to the Bank of Erudin. I am Agryn, the bank manager. How may I be of service to you?");
	}
	if ($text=~/vasty deep water/i) {
		quest::say("You must have been sent by one of the guilds. All you need to do is give me your guild coin and I shall exchange it for the Vasty Deep water.");
	}
}

sub EVENT_ITEM {
	#:: Match 13989 - Peacekeeper Token
	if (plugin::check_handin(\%itemcount, 13989 => 1)) {
		quest::say("Ah!! A Peacekeeper. I have some Vasty Deep water sitting out already. Here you are. Do not let it fall into the wrong hands.");
		#:: Give a 13939 - Clear Water
		quest::summonitem(13939);
		quest::ding();
		quest::exp(100);
	}
	plugin::return_items(\%itemcount);
}
