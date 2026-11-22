local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_EXODII_MISSION_WAREHOUSE",
    line = {
        joined = {
            ccb.content.text("&You describe the warehouse to the best of your ability.  The teamster considers for a moment"),
            {
            when = predicates.any_equal({ "no", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            yes = ccb.content.gendered_line(", then frowns.  \"I don't believe I've heard about anything like that, no.  Sorry.\"", { "interlocutor" }),
            no = ccb.content.gendered_line(", looking thoughtful.  \"Hmm.  I'm not sure, but I've heard of an odd building that's a bit like you're describing.\"", { "interlocutor" }),
        },
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "asked_about_exodii_warehouse_mission", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Oh well.  Thanks anyway.  I'll go ask around."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "no", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            actions = { actions.handler("dlg_a_dda_399f0cdb5f50") },
        },
    },
}
