local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_INTRODUCTION",
    line = ccb.content.text("I'm the most senior member at this point, so I'm what passes for the leader here now.  I'm just trying to make plans to keep us alive since everything fell apart."),
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_BACKGROUND",
    line = ccb.content.text("Well, that's a long story.  We are what's left of the Grey Moose militia.  We had plans for when things went south cause of crazy politicians or war, but we didn't expect people to go crazy then turn zombie.  Only a handful of our members actually made it through all that madness.  What's worse is that we lost so much of our supplies and gear due to military checkpoints and trigger happy soldiers.  It didn't matter that half of us were former military, the checkpoint guards just saw weapons, panicked and then confiscated everything but the clothes on our back.  So here we are, at our planned escape location, with not even a fraction of our manpower or supplies."),
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_HELP",
    line = ccb.content.text("I can't say I can think of anything at the moment.  Our remoteness is our defense.  We want to keep a low profile and try to keep out of any trouble in this isolated location.  We are willing to trade for weapons and ammo though.  Keeping the nearby area clear and hunting is always eating away at our supplies."),
    replies = { { text = ccb.content.text("Keeping a low profile is good."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_TRADE",
    line = ccb.content.text("Let's trade then."),
    replies = {
        {
            text = ccb.content.text("…"),
            native_actions = { "start_trade" },
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MILITIA_BYE",
    line = ccb.content.text("Stay safe out there.  Not enough of us are around anymore."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
