local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND_FOLLOWER_CAST_SPELL" },
    line = ccb.content.text("Which spell did you want?"),
    replies = {
        {
            text = ccb.content.text("Could you cure my illnesses?"),
            next_topic = "TALK_FRIEND_FOLLOWER_CAST_SPELL_FAIR_FOLK_SPRING_CLEANSING",
            when = predicates.handler("dlg_p_xedra_evolved_bc1fa17bc005"),
        },
        {
            text = ccb.content.text("Could you heal my wounds?"),
            next_topic = "TALK_FRIEND_FOLLOWER_CAST_SPELL_FAIR_FOLK_NEW_GROWTH",
            when = predicates.handler("dlg_p_xedra_evolved_5106e877ba81"),
        },
        {
            text = ccb.content.text("Could you help me deal with these hot temperatures?"),
            next_topic = "TALK_FRIEND_FOLLOWER_CAST_SPELL_FAIR_FOLK_GIFT_OF_WARM_BLOOD",
            when = predicates.handler("dlg_p_xedra_evolved_17d6465e06c8"),
        },
        {
            text = ccb.content.text("Never mind"),
            next_topic = "TALK_FRIEND",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND_FOLLOWER_CAST_SPELL_FAIR_FOLK_SPRING_CLEANSING" },
    line = ccb.content.text("*<npc_name> mutters something under <mypronoun> breath and a green glow surrounds you."),
    replies = {
        {
            text = ccb.content.text("Much better, thank you."),
            next_topic = "TALK_FRIEND",
            actions = { actions.handler("dlg_a_xedra_evolved_15ba983fa683") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND_FOLLOWER_CAST_SPELL_FAIR_FOLK_NEW_GROWTH" },
    line = ccb.content.text("*<npc_name> puts a hand on you and you feel a warmth spread across your entire body.  \"But remember, stay outside or the glamour won't work.\""),
    replies = {
        {
            text = ccb.content.text("Much better, thank you."),
            next_topic = "TALK_FRIEND",
            actions = { actions.handler("dlg_a_xedra_evolved_9f14d06f8544") },
        },
    },
}
