local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates



ccb.content.define_mapgen {
    kind = "update",
    id = "shopkeep_lobby_cleanup1",
    layout = {
        tile_edits = {
            {
                shape = "rectangle",
                operation = "remove_items",
                x = 5,
                y = 22,
                end_x = 18,
                end_y = 23,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "shopkeep_lobby_cleanup2",
    layout = {
        tile_edits = { { shape = "rectangle", operation = "remove_items", x = 5, y = 0, end_x = 18, end_y = 2 } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }),
        yes = {
            choices = {
                ccb.content.text("Welcome back."),
                ccb.content.text("Hello again.  What do you need?"),
                ccb.content.text("*looks up.  \"Hey.\""),
            },
        },
        no = ccb.content.text("*waves you over.  \"I haven't seen you before.  Welcome to our little homely house.\""),
    },
    replies = {
        {
            text = ccb.content.text("Who are you?  This is a refugee center, right?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Intro",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } })),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_Gavin", "yes") },
        },
        {
            text = ccb.content.text("I'm looking for a specific, strange building.  I wonder if you've heard anything about it, maybe from some of the traders coming through?"),
            next_topic = "TALK_EVAC_MERCHANT_EXODII_MISSION_WAREHOUSE",
            when = predicates.all({ predicates.has_mission("EXODII_MISSION_WAREHOUSE"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "asked_about_exodii_warehouse_mission" } })) }),
            actions = { actions.handler("w16b_a_dda_9812bef589e2") },
        },
        {
            text = ccb.content.text("Just passing through, don't mind me."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } })),
        },
        {
            text = ccb.content.text("I wanted to talk."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }),
        },
        {
            text = ccb.content.text("Let's trade."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }),
            trial = { kind = "condition", when = predicates.handler("w16b_p_dda_8b2c9e90f0af") },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_DoneTrading", actions = { "start_trade" } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_CANNIBAL_GTFO" },
        },
        {
            text = ccb.content.text("Just saying hello.  Keep safe."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }),
        },
    },
}
