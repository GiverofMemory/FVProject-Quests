sub EVENT_SAY {   
    if($text=~/hail/i){
        quest::say("Hey you!  You watch yourself.  These items are priceless.  You break it. you buy it!");
    }
}
