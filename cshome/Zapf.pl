my $number;

EVENT_SPAWN {
	$number = quest::ChooseRandom(17..23);
	quest::npctexture($number)
}