local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND_FOLLOWER_CAST_SPELL_FAIR_FOLK_GIFT_OF_WARM_BLOOD" },
    line = ccb.content.text("*<npc_name> sings a few scraps of a half-familiar melody and a cool breeze blows past you."),
    replies = {
        {
            text = ccb.content.text("Much better, thank you."),
            next_topic = "TALK_FRIEND",
            actions = { actions.handler("w16b_a_xedra_evolved_db67e96e1c73") },
        },
    },
}
