sub EVENT_SAY { 
	if ($text=~/Hail/i) {
		quest::say("I have no time to answer questions. whelp!  Now. leave this place before the sting of death finds the life in your veins!");
	}
}
