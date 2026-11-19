local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_SOMESHIT",
    line = ccb.content.gendered_line("Yeah.  I really did.  It took me two days to make it across the city on foot, camping out in dumpsters and places like that.  I started moving more by night, and I learned right away to avoid the military.  They were a magnet for the <zombies>, and they were usually stationed where the monsters were coming.  Some parts of the city were pretty tame at first.  There were a few chunks where people had been evacuated or cleared out, and the <zombies> didn't really go there.  Later on, others like me started moving into those neighborhoods, so I switched and started running through the blasted out downtown.  I had to anyway, to get home.  By the time I made the switch though, the fighting was starting to die off, and I was mostly just avoiding attention from zombies and other things.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("I take it home was bad."),
            next_topic = "BGSS_LOST_PARTNER_2_HOME1",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LOST_PARTNER_2_HOME1",
    line = ccb.content.gendered_line("The first warning was that I had to move from the preserved parts of the city to the burnt out ones to get home.  It only got worse.  There was a police barricade right outside my house, with a totally useless pair of automated turrets sitting in front just idly watching the zombies lurch by.  That was before someone switched them to kill everybody, back when it only killed trespassing humans.  Good times, you can always trust bureaucracy to fuck things up in the most spectacular way possible.  Anyway, the house itself was half collapsed, a SWAT van had plowed into it.  I think I knew what I was going to see in there, but I had made it that far and I wasn't going to turn back.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("You must have seen some shit on the way there."),
            next_topic = "BGSS_LOST_PARTNER_2_SOMESHIT",
        },
        {
            text = ccb.content.text("Did you make it into the house?"),
            next_topic = "BGSS_LOST_PARTNER_2_HOME2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
