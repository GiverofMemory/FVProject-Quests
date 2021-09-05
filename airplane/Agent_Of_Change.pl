my $LockoutTime = 604800;

sub EVENT_SAY {
        if ($text=~/hail/i) {
                $raid = $client->GetRaid();
                if ($ulevel < 46) {
			$client->Message(15,"Much to learn you still have… padawan. Return once your power has increased!");
		}
		elsif ($raid > 0) {
                        $key = $name . "-airplane-instance";
                        if (!quest::get_data($key)) {
                                $key = $name . "-airplane-raid";
                                if (!quest::get_data($key)) {
                                        $key = $raid->GetID() . "-airplane-raid";
                                        if (!quest::get_data($key)) {
                                                if ($raid->IsLeader($name)) {
                                                        $client->Message(15, "Agent of Change says, 'Hello, $name.  Would you like to [create] a raid instance?'");
                                                }
                                                else {
                                                      	$client->Message(15, "Agent of Change says, 'Hello, $name.  It looks like your raid leader needs to create a raid instance.'");
                                                }
                                        }
                                        else {
                                              	$client->Message(15, "Agent of Change says, 'Hello, $name. Let me know when you are [ready] to join the raid instance.'");
                                        }
                                }
                                else {
					my $LockoutTime = quest::get_data_expires($key) - time();
                                        $key = $raid->GetID() . "-airplane-raid";
                                        if (!quest::get_data($key)) {
						$client->Message(15, "Agent of Change says, 'Hello, $name.  It looks like your raid instance expired.  You can rejoin another in $LockoutTime seconds.'");
	                                }
					else {
	                                      	$client->Message(15, "Agent of Change says, 'Hello, $name.  Let me know when you are [ready] to join the raid instance.'");
					}
                                }
                        }
                        else {
                              	my $LockoutTime = quest::get_data_expires($key) - time();
                                $key = $name . "-airplane-raid";
                                if (!quest::get_data($key)) {
                                        $client->Message(15, "Agent of Change says, 'Hello, $name.  It looks like your raid instance expired.  You can rejoin another in $LockoutTime seconds.'");
                                }
                                else {
					$value = quest::get_data($key);
					$key = $raid->GetID() . "-airplane-raid";
					if (!quest::get_data($key)) {
                                                if ($raid->IsLeader($name)) {
                                                        $client->Message(15, "Agent of Change says, 'Hello, $name.  Would you like to [create] a raid instance?'");
                                                }
                                                else {
                                                      	$client->Message(15, "Agent of Change says, 'Hello, $name.  It looks like your raid leader needs to create a raid instance.'");
                                                }
					}
					elsif ($value == quest::get_data($key)) {
	                                      	$client->Message(15, "Agent of Change says, 'Hello, $name.  Let me know when you are [ready] to join the raid.'");
					}
					else {
						$client->Message(15, "Agent of Change says, 'Hello, $name.  It looks like your raid instance expired.  You can rejoin another in $LockoutTime seconds.'");
					}
                                }
                        }
                }
                else {
                      	$client->Message(15, "Agent of Change says, 'You must be in a raid before you can join a raid instance.'");
                }
        }
	elsif ($text=~/create/i) {
                $raid = $client->GetRaid();
                if ($ulevel < 46) {
			$client->Message(15,"Much to learn you still have… padawan. Return once your power has increased!");
		}
		elsif ($raid > 0) {
                        if ($raid->IsLeader($name)) {
                                $key = $name . "-airplane-instance";
                                if (!quest::get_data($key)) {
                                        $key = $name . "-airplane-raid";
                                        if (!quest::get_data($key)) {
                                                $key = $raid->GetID() . "-airplane-raid";
                                                if (!quest::get_data($key)) {
                                                        $Instance = quest::CreateInstance("airplane", 0, 345600);
                                                        quest::set_data($key, $Instance, 43200);
                                                        $client->Message(15, "Agent of Change says, 'Your instance ( $Instance ) has been created. Let me know when you are [ready] to go to the Plane of Sky.'");
                                                }
                                        }
                                        else {
                                              	$client->Message(15, "Agent of Change says, 'You already have instance. Let me know when you are [ready] to go to the Plane of Sky.'");
                                        }
                                }
                                else {
                                      	$client->Message(15, "Agent of Change says, 'You already have instance. Let me know when you are [ready] to go to the Plane of Sky.'");
                                }
                        }
                        else {
                              	$client->Message(15, "Agent of Change says, 'Sorry $name, but only a raid leader can create an instance.'");
                        }
                }
                else {
                      	$client->Message(15, "Agent of Change says, 'You must be in a raid before you can join a raid instance.'");
                }
        }
	elsif ($text=~/ready/i) {
                $raid = $client->GetRaid();
                if ($ulevel < 46) {
			$client->Message(15,"Much to learn you still have… padawan. Return once your power has increased!");
		}
		elsif ($raid > 0) {
                        $key = $raid->GetID() . "-airplane-raid";
                        if (!quest::get_data($key)) {
                                $client->Message(15, "Agent of Change says, 'Sorry, but your raid does not have an instance.  Ask your raid leader to make one.'");
                        }
                        else {
                              	$InstanceTime = quest::get_data_expires($key) - time();
                                $Instance = quest::get_data($key);
                                $key = $name . "-airplane-raid";
                                if (!quest::get_data($key)) {
					$key = $name . "-airplane-instance";					
	                                if (!quest::get_data($key)) {
						quest::set_data($key, $Instance, $LockoutTime);
						$key = $name . "-airplane-raid";
	                                        quest::set_data($key, $raid->GetID(), $InstanceTime);
						$client->AssignToInstance($Instance);
						$client->MovePCInstance(71, $Instance, 539, 1384, -664, 0);
						plugin::RandomSay(100, "Kiss those buffs goodbye!", "Watch that first step!");
                                	}
					else {
						if ($Instance == quest::get_data($key)) {
							$client->MovePCInstance(71, $Instance, 539, 1384, -664, 0);
							plugin::RandomSay(100, "Kiss those buffs goodbye!", "Watch that first step!");
						}
						else {
							my $LockoutTime = quest::get_data_expires($key) - time();
							quest::say("Sorry $name, but you still have an active instance " . quest::get_data($key) . ", and your raid is in instance $Instance.  You can join another Airplane instance in $LockoutTime seconds.");
						}
					}
				}
                        }
                }
                else {
                        $client->Message(15, "Agent of Change says, 'You must be in a raid before you can join a raid instance.'");
                }
        }
}
