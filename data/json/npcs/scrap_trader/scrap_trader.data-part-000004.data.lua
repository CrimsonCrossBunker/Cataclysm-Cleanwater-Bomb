local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_SCRAP_TRADER_HOME_STAY",
    line = ccb.content.text("Sure, I'm fine with it.  There's a spare bed in the shed next door for anyone who needs it.  Just don't hog it.  Someone else might come along."),
    replies = {
        {
            text = ccb.content.text("Thanks, <name_g>."),
            next_topic = "TALK_NPC_SCRAP_TRADER_INTRO",
            actions = { actions.handler("dlg_a_dda_ce94fef0571f") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_SCRAP_TRADER_EXODII_MISSION_WAREHOUSE",
    line = {
        joined = {
            ccb.content.text("&You describe the warehouse to the best of your ability.  The scrap trader nods along, listening"),
            {
            when = predicates.any_equal({ "no", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            yes = ccb.content.text(", then shrugs.  \"No, sorry, not ringing any bells.\""),
            no = ccb.content.text(", then raises one eyebrow.  \"Not making any promises, but I did catch just a glimpse of a weird building one time that might be what you're looking for.\""),
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
