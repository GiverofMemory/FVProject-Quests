sub EVENT_SPAWN {
	#:: Set up a 50 unit distance
	$x = $npc->GetX();
	$y = $npc->GetY();
	quest::set_proximity($x - 50, $x + 50, $y - 50, $y + 50);
}

sub EVENT_ENTER {
	#:: Check for 18433 - Gnome Paladin Note
	if (plugin::check_hasitem($client, 18433)) { 
		$client->Message(15,"An older, male gnome addresses you as you attempt to get your bearings. 'Welcome young apprentice to the Abbey of Deep Musings. I am Lewis Reldnok. Read the note in your inventory and hand it to me when you wish to begin your training.");
	}
}

sub EVENT_SAY {
	if ($text=~/trades/i) {
		quest::say("I thought you might be one who was interested in the various different trades, but which one would suit you? Ahh, alas, it would be better to let you decide for yourself, perhaps you would even like to master them all! That would be quite a feat. Well, lets not get ahead of ourselves, here, take this book. When you have finished reading it, ask me for the [" . quest::saylink("second book") . "], and I shall give it to you. Inside them you will find the most basic recipes for each trade. These recipes are typically used as a base for more advanced crafting, for instance, if you wished to be a smith, one would need to find some ore and smelt it into something usable. Good luck!");
	}
	if ($text=~/second book/i) { 
		quest::say("Here is the second volume of the book you requested, may it serve you well!");
	}
}

sub EVENT_ITEM {
	#:: Check for 18433 - Gnome Paladin Note
	if (plugin::check_handin(\%itemcount, 18433 => 1)) {
		quest::Say("Welcome to the Abbey of Deep Musing, $name! Here is a tunic that you may wear to announce the beginning of your training as a Paladin of Brell Serilis! Be warned that the only dangers do not lie without Ak'Anon. There is an evil society that lurks in the deepest recesses and shadows of our magnificent city. When you are ready to begin your training, let me know. I will be able to further instruct you on how to progress through your early ranks, as well as in some of the various [" . quest::saylink("trades") . "] you will have available to you.");
		#:: Give a 13517 - Worn Felt Tunic reward
		quest::summonitem(13517);
		#:: Set factions
		quest::faction(76,100); 	# Deep Muses
		quest::faction(210,15); 	# Merchants of Ak'Anon
		quest::faction(71,-15); 	# Dark Reflection
		quest::faction(115,15); 	# Gem Choppers
		quest::ding();
		quest::exp(100);
	}
	plugin::return_items(\%itemcount); # return unused items
}

# converted to Perl by SS
