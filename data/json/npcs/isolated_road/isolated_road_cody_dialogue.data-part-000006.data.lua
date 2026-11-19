local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_JAY",
    line = {
        choices = {
            ccb.content.text("Yeah, we've always got along great.  He comes over for supper every Friday.  Have a few drinks, maybe take some guns out.  Or, well… we used to.  A little while ago, we had a huge fight.  It was right after this stuff got real bad… I'm fuzzy on the details or what I said, all I remember was being so angry that I could kill him.  We haven't talked much since."),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_mentioned_fight", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Have you apologized?"),
            next_topic = "TALK_BLACKSMITH_JAY_NOT_ENOUGH",
        },
        { text = ccb.content.text("I'm sorry."), next_topic = "TALK_BLACKSMITH_SERVICES" },
        {
            text = ccb.content.text("Is there anything I can do?"),
            next_topic = "TALK_BLACKSMITH_JAY_QUEST",
        },
        { text = ccb.content.text("…"), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}
