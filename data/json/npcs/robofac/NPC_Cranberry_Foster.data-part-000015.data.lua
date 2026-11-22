local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_MERC_1_GOLD_MISSION_QUERY", "TALK_ROBOFAC_MERC_1_GOLD_MISSION_TRADE" },
    line = ccb.content.text("Got some gold for me?"),
    replies = {
        {
            text = ccb.content.text("[200 gold] Here's a batch for you."),
            next_topic = "TALK_ROBOFAC_MERC_1_GOLD_MISSION_TRADE",
            when = predicates.has_inventory("speaker", "gold_small", 200),
            actions = { actions.handler("dlg_a_dda_33259372cede") },
        },
        {
            text = ccb.content.text("I don't have 200 gold for you right now."),
            next_topic = "TALK_ROBOFAC_MERC_1_MAIN",
        },
    },
}
