local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_ELECTROKINETIC",
    line = {
        choices = {
            ccb.content.text("I am the heart of the storm!"),
            ccb.content.text("&They smile as lightning crackles over their skin."),
        },
    },
    replies = {
        {
            text = ccb.content.text("How are you doing that?"),
            next_topic = "TALK_CIVILIAN_ELECTROKINETIC_HOW",
        },
        { text = ccb.content.text("*Back away slowly*"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_ELECTROKINETIC_HOW",
    line = {
        choices = {
            ccb.content.text("I have the power of the storm!  I will save this world!"),
            ccb.content.text("&They say nothing, merely looking at you with glowing eyes."),
        },
    },
    replies = { { text = ccb.content.text("*Back away slowly*"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_PHOTOKINETIC",
    line = {
        choices = {
            ccb.content.text("This isn't real…  It's just tricks right?  Haha.  It's just tricks and lights…"),
        },
    },
    replies = {
        {
            text = ccb.content.text("It's not like any tricks I've ever seen…"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_PYROKINETIC",
    line = {
        choices = {
            ccb.content.text("Hahaha!!  Burn!  BURN!!"),
            ccb.content.text("&They cackle loudly as flames burst from their outstretched hand."),
            ccb.content.text("All will burn!"),
        },
    },
    replies = {
        {
            text = ccb.content.text("How are you doing that?"),
            next_topic = "TALK_CIVILIAN_PYROKINETIC_HOW",
        },
        { text = ccb.content.text("*Back away slowly*"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_PYROKINETIC_HOW",
    line = {
        choices = {
            ccb.content.text("Isn't it beautiful?  BURN THEM ALL!"),
            ccb.content.text("The flames have chosen me!"),
        },
    },
    replies = { { text = ccb.content.text("*Back away slowly*"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_TELEKINETIC",
    line = { choices = { ccb.content.text("Get out of here!"), ccb.content.text("No, no no!  Go away!") } },
    replies = {
        {
            text = ccb.content.text("How are you doing that?"),
            next_topic = "TALK_CIVILIAN_TELEKINETIC_HOW",
        },
        { text = ccb.content.text("*Back away slowly*"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_TELEKINETIC_HOW",
    line = {
        choices = { ccb.content.text("*doesn't look at you at all.  They just keep yelling at the horde.") },
    },
    replies = { { text = ccb.content.text("*Back away slowly*"), next_topic = "TALK_DONE" } },
}
