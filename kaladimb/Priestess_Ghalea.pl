#####################################################################
#  NPC:  Priestess Ghalea
#  Zone: North Kaladim
#  Quests: Multiple --> Soil of Underfoot
#####################################################################

sub EVENT_SPAWN {
	$x = $npc->GetX();
	$y = $npc->GetY();
	quest::set_proximity($x - 50, $x + 50, $y - 50, $y + 50);
}

sub EVENT_ENTER {
	#:: Match 18765 - Dirt Covered Letter
	if (plugin::check_hasitem($client, 18765)) {
		$client->Message(15,"High Priestess Ghalea greets you with genuine enthusiasm. 'Hello there! Welcome to the Underfoot Cathedral! Read the note in your inventory and when you are ready to begin your training, hand me your note! May Brell bless us all!'");
	}
}

sub EVENT_SAY { 
	if ($text=~/hail/i) {
		quest::say("Welcome to the Church of Underfoot. Please open your soul to the greatness of Brell Serilis. May he guide you in all your future endeavors. And may your soules long for the [" . quest::saylink("soil of underfoot") . "].");
	} 
	elsif ($text=~/soil of underfoot/i) {
		#:: Check faction--must be amiable or better to get quest.
		if ($faction >=5 ) {
			quest::say("The Clerics of Underfoot have yet to see your faith directed towards our wills. Perhaps you should assist Master Gunlok Jure in the crusade against the undead.");
		} else {
			quest::say("I can trust you with the soil of Underfoot, but first you must obtain four portions of fairy dust. Return them to me and I shall mix it and pray over it. Then I shall give you a pouch of soil of Underfoot.");
		}
	} 
	elsif ($text=~/candle of bravery/i) {
		quest::say("The Candle of Bravery is used for temple ceremonies here in Kaladim. When the candle burns out, I must venture to the frigid village of Halas far to the north of the continent of Antonica. There I will take the candlestick and the [" . quest::saylink("soil of underfoot") . "] to Dok. He must create the candle in the very ornate candlestick.");
	}
	elsif ($text=~/trades/i) {
		quest::say("I thought you might be one who was interested in the various different trades, but which one would suit you? Ahh, alas, it would be better to let you decide for yourself, perhaps you would even like to master them all! That would be quite a feat. Well, lets not get ahead of ourselves, here, take this book. When you have finished reading it, ask me for the [" . quest::saylink("second book") . "], and I shall give it to you. Inside them you will find the most basic recipes for each trade. These recipes are typically used as a base for more advanced crafting, for instance, if you wished to be a smith, one would need to find some ore and smelt it into something usable. Good luck!");
		#:: Give a 51121 - Tradeskill Basics : Volume I
		quest::summonitem(51121);
	}
	elsif ($text=~/second book/i) {
		quest::say("Here is the second volume of the book you requested, may it serve you well!");
		#:: Give a 51122 - Tradeskill Basics : Volume II
		quest::summonitem(51122);
	}   
}

sub EVENT_ITEM { 
	#:: Match a 18765 - Dirt Covered Letter
	if (plugin::check_handin(\%itemcount, 18765 => 1)) {
		quest::say("Welcome to the Underfoot Cathedral. I am High Priestess Ghalea. Here is your guild tunic. Now. let's get you started helping us spread the will of Brell. Once you are ready to begin your training plese make sure that you see Haldorak, he can assist you in developing your hunting and gathering skills. Return to me when you have become more experienced in our art, I will be able to further instruct you on how to progress through your early ranks, as well as in some of the various [" . quest::saylink("trades") . "] you will have available to you.");
		#:: Give a 13514 - Dusty Tunic*
		quest::summonitem(13514);
		#:: Set Faction
		quest::faction(44,100); 	# Clerics of Underfoot
		quest::faction(169,100); 	# Kazon Stormhammer
		quest::faction(219,75); 	# Miners Guild 249
		quest::exp(100);
	}
	#:: Match for 12106 - Fairy Dust
	elsif (plugin::check_handin(\%itemcount, 12106 => 4) && ($faction < 5)) {
		quest::say("May the mighty power of Brell saturate this soil with his divinity.  Here you are, my noble friend.  You may have a pouch of the soil of Underfoot.");
		#:: Give a 12282 - Soil of Underfoot
		quest::summonitem(12282);
		#:: Set Faction
		quest::faction(44,2);		# Clerics of Underfoot
		quest::faction(169,2); 		# Kazon Stormhammer
		quest::faction(219,2); 		# Miners Guild 249
	}
	#:: Return unused items
	plugin::return_items(\%itemcount);
}

#END of FILE Zone:kaladimb  ID:67024 -- Priestess_Ghalea
#edited by SS
