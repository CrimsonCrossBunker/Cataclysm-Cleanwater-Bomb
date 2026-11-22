local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_FREE_MERCHANT_TEAMSTER_CHAT" },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Boris_Mission_1",
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
        },
        {
            text = ccb.content.text("So, have your caravans seen anything interesting out there in the wasteland?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS",
            when = predicates.handler("w16b_p_dda_8fcd96d5462f"),
            actions = { actions.handler("w16b_a_dda_6f156aa98a67") },
            switch = true,
        },
        {
            text = ccb.content.text("So, have your caravans seen anything interesting out there in the wasteland?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS",
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("I'm looking for a specific, strange building.  I wonder if you've heard anything about it?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_EXODII_MISSION_WAREHOUSE",
            when = predicates.all({ predicates.has_mission("EXODII_MISSION_WAREHOUSE"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "asked_about_exodii_warehouse_mission" } })) }),
            actions = { actions.handler("w16b_a_dda_9812bef589e2") },
        },
        {
            text = ccb.content.text("Do you know anything about a trader near the New England Church Community, claims to be from here?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader",
            when = predicates.handler("w16b_p_dda_eab15290189e"),
        },
        {
            text = ccb.content.text("I think I've got the evidence you were looking for."),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Mission_Success",
            when = predicates.handler("w16b_p_dda_62e742a59346"),
        },
        {
            text = ccb.content.text("I think I've got the evidence you were looking for."),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Mission_Fail",
            when = predicates.handler("w16b_p_dda_9a64a4490965"),
        },
        {
            text = ccb.content.text("I wanted to tell you about a potential new trading partner I met recently."),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_FACTION_INTRO",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }),
        },
    },
}
