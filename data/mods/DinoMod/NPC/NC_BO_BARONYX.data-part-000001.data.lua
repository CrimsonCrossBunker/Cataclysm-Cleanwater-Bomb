local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_EATING",
    line = ccb.content.text("The great eaters have returned, along with the false ones.  We must feed the eaters and destroy the pretenders, child."),
    replies = {
        {
            text = ccb.content.text("Who are you talking about?"),
            next_topic = "TALK_SWAMPER_EATING2",
        },
        {
            text = ccb.content.text("No thank you, I'd like to leave now."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_EATING2",
    line = ccb.content.text("This Cataclysm has woken the great eaters, lost in time, returned them to the world to do their great work, to multiply and fill the land with their song.  The time of man is over, but we few who remain can do our part to protect this new world from the pretenders, who would steal the meat."),
    replies = {
        {
            text = ccb.content.text("So what do you do with the meat?"),
            next_topic = "TALK_SWAMPER_MEAT",
        },
        {
            text = ccb.content.text("Who are the great eaters and the pretenders?"),
            next_topic = "TALK_SWAMPER_EATING3",
        },
        {
            text = ccb.content.text("Are there any others left?"),
            next_topic = "TALK_SWAMPER_OTHERS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_EATING3",
    line = ccb.content.text("The great eaters are the ones that were lost, what we call dinosaurs, whose meat we took and who are taking it back.  The pretenders are those others that have come to steal the meat of this world.  It does not belong to them and we will take it from their mouths."),
    replies = {
        {
            text = ccb.content.text("Okay, so you worship dinosaurs.  Understood."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_OTHERS",
    line = ccb.content.text("The Swampers knew these times would return and we prepared for them.  When others wasted their time and meat, we fed and grew strong, and we filled our stores with meat for this day."),
    replies = {
        { text = ccb.content.text("Yes, very good."), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text("You keep talking about meat.  Why is meat so important?"),
            next_topic = "TALK_SWAMPER_MEAT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_MEAT",
    line = ccb.content.text("The meat makes the great eaters strong.  We gather the meat and feed them, and in the end we too will serve the eaters in death as we do in life.  This was always our purpose and we lucky few have lived to see it."),
    replies = {
        {
            text = ccb.content.text("Our purpose?  How do you know?"),
            next_topic = "TALK_SWAMPER_END",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_END",
    line = ccb.content.text("The return of the great eaters was foretold by a prophet.  We faithful have been waiting and preparing since the revelation."),
    replies = {
        {
            text = ccb.content.text("I guess it must be nice to be proven right."),
            next_topic = "TALK_SWAMPER_JOIN",
        },
        { text = ccb.content.text("This is crazy."), next_topic = "TALK_SWAMPER_INSULT" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_JOIN",
    line = ccb.content.text("You understand our purpose.  I welcome you to this work, all are needed to feed the eaters."),
    replies = { { text = ccb.content.text("Thank you."), next_topic = "TALK_SWAMPER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SWAMPER_INSULT",
    line = ccb.content.text("You deny what you see right in front of you.  This world is what was foretold."),
    replies = { { text = ccb.content.text("Yeah, alright."), next_topic = "TALK_SWAMPER" } },
}
