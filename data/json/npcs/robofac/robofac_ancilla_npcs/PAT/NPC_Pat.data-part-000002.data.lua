local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_GREETING_4",
    line = ccb.content.text("Hey, before ya take off… if ya happen ta run inta any smokes out theah, maybe bring 'em by, yeah?  Don't mattah what kind.  I got a little rum tucked away we can split, call it a trade."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "robofac_pat_met", "yes") } } },
    replies = {
        {
            text = ccb.content.text("Absolutely.  I'll come back when I find some cigarettes."),
            next_topic = "TALK_DONE",
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_1") },
        },
        {
            text = ccb.content.text("I'll think about it.  See you around."),
            next_topic = "TALK_DONE",
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_1") },
        },
        {
            text = ccb.content.text("I don't smoke, but I'll keep an eye out.  See you around."),
            next_topic = "TALK_DONE",
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_1") },
        },
        {
            text = ccb.content.text("I don't drink, but I'll keep an eye out.  See you around."),
            next_topic = "TALK_DONE",
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_1") },
        },
    },
}
