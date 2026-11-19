local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Knit_Time",
    line = ccb.content.text("I can knit a scarf ready by tomorrow, a blanket in two days, and a quilt in a week."),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_GODCO_Theresa_Knit_Something" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Knit_Done",
    line = ccb.content.text("I hope you like it <granny_name_g>.  If you want anything else, just come back."),
    replies = {
        {
            text = ccb.content.text("Thank you, Theresa.  I'll put it to good use."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Cataclysm",
    line = ccb.content.text("I've grown tired, <granny_name_g>.  I haven't left here since we came, and things outside are getting worse each day.  All my old aches and pains have come back too; I can't see too good, and my muscles are always sore.  I don't like where my niece is going either; she's ever more fanatical, and taking my dear husband's prophecy to the extreme.  I'm content with my life, though.  I've lived long and prospered by the grace of the Lord."),
    replies = {
        {
            text = ccb.content.text("Is there anything I can do to help?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_You_Mutant",
    line = ccb.content.text("You clearly have the mark of a sinner.  I've seen your kind out and about after the Flood, killing and maiming like wild animals.  None of you are any good, not even to God, and you're of no good to me either.  Run on back to your sinful ways, now.  God has judged you already."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Anger",
    line = ccb.content.text("You've done me poorly enough times now, I won't have any more of it.  Get out of here."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
