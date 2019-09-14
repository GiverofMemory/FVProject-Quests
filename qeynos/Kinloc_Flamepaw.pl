sub EVENT_SPAWN {
	#:: Create a proximity, 50 units across, 50 units tall, without proximity say
	quest::set_proximity($x - 25, $x + 25, $y - 25, $y + 25, $z - 25, $z + 25, 0);
}

sub EVENT_ENTER {
	#:: Match a 18719 - Tattered Note
	if (plugin::check_hasitem($client, 18719)) {
		$client->Message(15,"As you glance about the crowded room, Kinloc Flamepaw greets you. 'Why hello there. Are you perhaps a new recruits? If you wish to learn the ways of the Magician, read the note in your inventory and hand me your note to start your training.'");
	}
}

sub EVENT_SAY {
	#:: Made up
	if ($text=~/hail/i) {
		quest::say("Welcome to the Order of Three. I am Kinloc, Guild Master of the Magicians. Do you have a note for me?");
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
	#:: Match a 18719 - Tattered Note
	if (plugin::takeItems(18719 => 1)) {
		#:: Made up
		quest::say("Welcome to the Order of Three. I am Kinloc, Guild Master of the Magicians. This tunic of the Order is for you, wear it with honour. Study hard and master your skills, and you will become an important part of our Order. Yestura shall help introduce you to the ways of magic.  Return to me when you have become more experienced in our art, I will be able to further instruct you on how to progress through your early ranks, as well as in some of the various [" . quest::saylink("trades") . "] you will have available to you.");
		#:: Give a 13543 - Used Blue Robe*
		quest::summonitem(13543);
		#:: Ding!
		quest::ding();
		#:: Set factions
		quest::faction(342, 100);		#:: + Order of Three
		quest::faction(221, -25);		#:: - Bloodsabers
		quest::faction(262, 15);		#:: + Guards of Qeynos
		quest::faction(291, 15);		#:: + Merchants of Qeynos
		quest::faction(296, -15);		#:: - Opal Darkbriar
		#:: Grant a small amount of experience
		quest::exp(100);
	}
	#:: Return unused items
	plugin::returnUnusedItems();
}
