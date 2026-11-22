local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_WOODCUTTER_HIRE",
    line = {
        when = predicates.has_effect("interlocutor", "currently_busy"),
        yes = ccb.content.text("Come back later, I need to take care of a few things first."),
        no = ccb.content.text("The rate is a bit steep, but I still have my quotas that I need to fulfill.  The logs will be dropped off in the garage at the entrance to the camp.  I'll need a bit of time before I can deliver another load."),
    },
    replies = {
        {
            text = ccb.content.text("[800 merch, 1d] 10 logs"),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "FMCNote", 800),
            actions = { actions.handler("dlg_a_dda_ff51821394a0"), actions.update_map("tacoma_commune_woodcutter_10_logs", "ranch_camp_67"), actions.handler("dlg_a_dda_1229c4bb1f11"), actions.add_effect("interlocutor", "currently_busy", { turns = 86400 }) },
        },
        {
            text = ccb.content.text("[4800 merch, 7d] 100 logs"),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "FMCNote", 4800),
            actions = { actions.handler("dlg_a_dda_7e3a40e0c789"), actions.update_map("tacoma_commune_woodcutter_100_logs", "ranch_camp_67"), actions.handler("dlg_a_dda_1229c4bb1f11"), actions.add_effect("interlocutor", "currently_busy", { turns = 604800 }) },
        },
        {
            text = ccb.content.text("<end_talking_later>"),
            next_topic = "TALK_RANCH_WOODCUTTER",
            when = predicates.actor_state("interlocutor", "available"),
        },
        {
            text = ccb.content.text("<end_talking_later> <end_talking_bye>"),
            next_topic = "TALK_RANCH_WOODCUTTER",
        },
    },
}
