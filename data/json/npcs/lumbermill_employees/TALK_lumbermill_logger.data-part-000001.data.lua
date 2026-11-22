local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_LUMBERMILL_LOGGER_MISSION_WAREHOUSE",
    line = {
        joined = {
            ccb.content.text("&You describe the warehouse to the best of your ability.  The logger considers for a moment"),
            {
            when = predicates.any_equal({ "no", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            yes = ccb.content.gendered_line(", then frowns.  \"I think I'd remember something like that, no.  Sorry.\"", { "interlocutor" }),
            no = ccb.content.gendered_line(", looking thoughtful.  \"You know, around the time things really went bad, I remember a really awful portal storm.  A while later, I saw something like that in the distance.  Could be what you're talking about.\"", { "interlocutor" }),
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
