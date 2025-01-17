sub EVENT_SPAWN {
	#:: Create a timer 'falorn_depop' that triggers every 300 seconds (5 min)
	quest::settimer("falorn_depop", 300);
	quest::say("I am Falorn. Good day to thee.");
}

sub EVENT_TIMER {
	#:: Match the timer 'falorn_depop'
	if ($timer eq "falorn_depop") {
		quest::stoptimer("depop"); 
		quest::depop();
	}
}

sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::say("Do not waste my time, $name.  Do you wish to take the test of blades or not?");
	}
	elsif ($text=~/blades/i) {
		quest::say("The test of blades is not easy.  I hope you are as powerful as you are brave.  What do you wish to strive for? Strength, force, or skill?");
	}
	elsif ($text=~/strength/i) {
		quest::say("Remember, true strength lies not only in the body, but in the mind as well. Return to me a bronze disc, a small pick and a stone amulet. If you manage to do this my runed wind amulet will be yours.");
	}
	elsif ($text=~/force/i) {
		quest::say("Foolishness or bravery Gendal?  We shall see. Return to me a pearlescent globe, a silver mesh and a spiroc air totem  In return, you will receive both my deepest respect and the aerated pauldrons.");
	}
	elsif ($text=~/skill/i) {
		quest::say("The test of skill it is. Go upward and retrieve these three items: an ivory tessera, a tiny ruby, and an azure ring. Return these to me and the azure ruby ring shall be yours.");
	}
}

sub EVENT_ITEM {
	#:: Match a 20935 - Bronze Disc, a 20972 - Small Pick, and a 20973 - Stone Amulet
	if (plugin::takeItems(20935 => 1, 20972 => 1, 20973 => 1)) {		#:: Warrior Test of Strength
		quest::say("You have proven yourself worthy.");
		#:: Give a 14569 - Runed Wind Amulet
		quest::summonitem(14569);
		#:: Ding!
		quest::ding();
		#:: Grant a huge amount of experience
		quest::exp(100000);
		quest::depop();
	}
	#:: Match a 20942 - Pearlescent Globe, a 20974 - Silver Mesh, and a 20975 - Spiroc Air Totem
	elsif (plugin::takeItems(20942 => 1, 20974 => 1, 20975 => 1)) {		#:: Warrior Test of Force
		quest::say("You have proven yourself worthy.");
		#:: Give a 4321 - Aerated Pauldrons
		quest::summonitem(4321);
		#:: Ding!
		quest::ding();
		#:: Grant a huge amount of experience
		quest::exp(100000);
		quest::depop();
	}
	#:: Match a 20928 - Ivory Tessera, a 20970 - Small Ruby, and a 20971 - Azure Ring
	elsif (plugin::takeItems(20928 => 1, 20970 => 1, 20971 => 1)) {		#:: Warrior Test of Skill
		quest::say("You have proven yourself worthy.");
		#:: Give a 14551 - Azure Ruby Ring
		quest::summonitem(14551);
		#:: Ding!
		quest::ding();
		#:: Grant a huge amount of experience
		quest::exp(100000);
		quest::depop();
	}
	#:: Return unused items
	plugin::returnUnusedItems();
}
