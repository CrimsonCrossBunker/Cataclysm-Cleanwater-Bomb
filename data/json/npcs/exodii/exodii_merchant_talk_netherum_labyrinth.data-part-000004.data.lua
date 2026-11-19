local ccb = require("ccb")

-- Well, that'll happen.  The entrances to those places aren't particularly stable.  Like I said, we only spotted it and recorded its location on its way in.  It's likely to have moved.  But, I'll say, I'm surprised to see you back after you went in.  Maybe you've got some promise in you, yet.  You sure you want to go back?
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_netherum_labyrinth_exodii_wrist_computer",
    line = ccb.content.text("Ah, well now, at'll happen.  The apples n' pears - the ol' wobbly stairs to labyrinths - that is to say, how you got in, aren't stable.  Like this'n yarked, we only spotted the one on our way in.  She's likely moved.  But, I'm chuffed as a squeek to see you back after divin' in.  Maybe ye've some promise, yet.  Sure ye'll be keen to go back to the Labyrinths?  S'not a good idea."),
    replies = {
        {
            text = ccb.content.text("So the way in has shut?  Or, moved, rather?  Yes, I want to go back."),
            next_topic = "TALK_EXODII_MERCHANT_netherum_labyrinth_exodii_wrist_computer_2",
        },
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_EXODII_MERCHANT_Jobs",
        },
    },
}

-- &Rubik considers you a very moment, their metal finger tapping the counter.  Then, Rubik produces a dusty electronic device.  In juxtaposition to the stare just moments ago, Rubik unceremoniously gives you the device.  "This was mine, some time ago.  I also found that place pretty curious, and spent too much time delving into it.  We have Exodii who do it, now and again, when we need the supplies.  Not in places like this, so rich in plastics and metals, but in others, like the one we just came from.  Anyhow, I've not used this in a long time.  It's yours now."
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_netherum_labyrinth_exodii_wrist_computer_2",
    line = ccb.content.text("&Rubik considers you a very moment, their metal finger tapping the counter.  Then, Rubik produces a dusty electronic device.  In juxtaposition to the stare just moments ago, Rubik unceremoniously gives you the device.  \"This'n was ol' Rubiks, some time gone by.  Also found the Labyrinths curious, and spent a lick and a split delving.  In fact, we got Exodii'll do it, now and then, when we need it.  But ken, not places like this'n - green and brown, rich in plastic n' trinkets.  But others.  Darker places.  Anyhow, this'n hasn't used that there in  a spell.  S'yours, now.\""),
    replies = {
        {
            text = ccb.content.text("What is this thing?"),
            next_topic = "TALK_EXODII_MERCHANT_netherum_labyrinth_exodii_wrist_computer_3",
        },
    },
}
