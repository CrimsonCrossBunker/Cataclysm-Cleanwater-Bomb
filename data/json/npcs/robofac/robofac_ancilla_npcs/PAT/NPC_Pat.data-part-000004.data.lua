local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_SMOKES_NO",
    line = ccb.content.text("No worries.  Good ta see you're still kickin', anyway."),
    replies = { { text = ccb.content.text("See you around."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_SMOKES_YES",
    line = ccb.content.text("They smile and produce a very small bottle of rum and a red plastic lighter.  \"Wicked.  It ain't much and it ain't good, and I ain't got glasses, but it's what I got.  Have a seat?"),
    replies = {
        {
            text = ccb.content.text("Enjoy.  I have to go."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_SMOKES_LEAVE_EARLY",
        },
        {
            text = ccb.content.text("Absolutely."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_SMOKES_MAKE_FRIENDS_1",
        },
        {
            text = ccb.content.text("No smokes for me, but I'll take a drink."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_SMOKES_MAKE_FRIENDS_1",
        },
        {
            text = ccb.content.text("No drink for me, but I'll take a smoke."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_SMOKES_MAKE_FRIENDS_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_SMOKES_LEAVE_EARLY",
    line = ccb.content.text("You're a bit of a mystery, but yeah, alright, let's wrap this up.  Far as I'm concerned, you're a friend a mine now, whether ya' like it or not.  Swing by sometime, maybe we can shoot the shit or work on somethin' togethah."),
    replies = { { text = ccb.content.text("See you around."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_SMOKES_MAKE_FRIENDS_1",
    line = ccb.content.text("You and Pat sit together for a long while, the room filled with smoke.  You learn that they're a bit of a weather nerd, and they like drinking, smoking, and baseball.  The topic inevitably turns to the cataclysm and how the first few days went for you both."),
    replies = {
        {
            text = ccb.content.text("[You enjoy the companionship and think this person could be a friend]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_SMOKES_MAKE_FRIENDS_2",
        },
        {
            text = ccb.content.text("[You enjoy the companionship but think making friends is futile]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_SMOKES_LEAVE_EARLY",
        },
        {
            text = ccb.content.text("[You're uncomfortable with this situation and try to end things early]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_SMOKES_LEAVE_EARLY",
        },
    },
}
