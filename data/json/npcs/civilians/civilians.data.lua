local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_PANIC",
    line = ccb.content.text("&You see this crazed fellows eyes darting around anxiously, always anticipating impending doom.  Every now and then you can even hear them whimper in fear.  Although they do not seem aggressive, they definitely are out of their mind."),
    replies = {
        {
            text = ccb.content.text("You need to get to safety!"),
            next_topic = "TALK_CIVILIAN_PANIC_EVAC",
        },
        { text = ccb.content.text("[Awkwardly distance yourself.]"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_PANIC_EVAC",
    line = ccb.content.text("&They shriek and stumble backwards, as if you just became a threat."),
    replies = { { text = ccb.content.text("[Awkwardly distance yourself.]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_FIGHTER",
    line = {
        choices = {
            ccb.content.text("I'm gonna kill all these <freaking> things!"),
            ccb.content.text("&They let out a bellowing warcry and wave their knife."),
            ccb.content.text("I'M INVINCIBLE!"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Are you crazy?  Get out of here!"),
            next_topic = "TALK_CIVILIAN_FIGHTER_EVAC",
        },
        { text = ccb.content.text("[Leave them to their futile fight.]"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_FIGHTER_EVAC",
    line = {
        choices = {
            ccb.content.text("Like hell I will!"),
            ccb.content.text("Fuck that, I'm not going out like a coward!"),
        },
    },
    replies = { { text = ccb.content.text("[Leave them to their futile fight.]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_OFFICER",
    line = {
        choices = {
            ccb.content.text("Stand aside citizen, I'll handle this!"),
            ccb.content.text("Don't worry, I'm with the police<punc>"),
            ccb.content.text("&The officer scans the area, looking for trouble.  They have a dangerous glint in their eyes."),
        },
    },
    replies = { { text = ccb.content.text("[Back away.]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_GUNNER",
    line = {
        choices = {
            ccb.content.text("I'm gonna kill all these <freaking> things!"),
            ccb.content.text("&They let out a bellowing warcry and wave their gun."),
            ccb.content.text("I'M INVINCIBLE!"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Are you crazy?  Get out of here!"),
            next_topic = "TALK_CIVILIAN_FIGHTER_EVAC",
        },
        { text = ccb.content.text("[Leave them to their futile fight.]"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_ICU",
    line = ccb.content.text("&They are still breathing but unable to move and speak.  You are unsure if they are even fully conscious and yet shudder at the thought of being trapped inside your body."),
    replies = {
        {
            text = ccb.content.text("[Leave them to their ultimate fate.]"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_PARENT_EVAC",
    line = ccb.content.text("No!  I just know it, they are still alive!"),
    replies = { { text = ccb.content.text("[Let them keep on searching.]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CIVILIAN_PARENT",
    line = {
        choices = {
            ccb.content.text("Have you seen my child?"),
            ccb.content.text("I am not leaving without my little one!"),
            ccb.content.text("Where is my kid?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Your child is likely dead by now and you should get to safety!"),
            next_topic = "TALK_CIVILIAN_PARENT_EVAC",
        },
        { text = ccb.content.text("[Let them keep on searching.]"), next_topic = "TALK_DONE" },
    },
}
