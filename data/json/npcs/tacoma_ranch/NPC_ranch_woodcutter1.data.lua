local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Can purchase wood
ccb.content.define_npc {
    id = "ranch_woodcutter_1",
    suffix = ccb.content.text("Lumberjack"),
    class = "NC_COWBOY",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_WOODCUTTER",
    faction = "tacoma_commune",
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_WOODCUTTER",
    line = ccb.content.text("You need something?"),
    replies = {
        {
            text = ccb.content.text("The doctor needs some help building an anesthetic machine.  Do you have anything that could help?"),
            next_topic = "TALK_RANCH_GENERIC_ANESTHETIC_FOR_DOCTOR",
            when = predicates.all({ predicates.has_mission("MISSION_RANCH_DOCTOR_MEDICAL_ANESTHETIC"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_tacoma_ranch_doctor_anesthetic_asked" } })) }),
            actions = {
                actions.set_actor_value("interlocutor", "mission_tacoma_ranch_doctor_anesthetic_asked", "yes"),
            },
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_RANCH_WOODCUTTER_JOB",
        },
        {
            text = ccb.content.text("I'd like to hire your services."),
            next_topic = "TALK_RANCH_WOODCUTTER_HIRE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_WOODCUTTER_JOB",
    line = ccb.content.gendered_line("I'm one of the migrants that got diverted to this outpost when I arrived at the refugee center.  They said I was big enough to swing an axe, so my profession became lumberjack… didn't have any say in it.  If I want to eat, then I'll be cutting wood from now till kingdom come.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Oh."), next_topic = "TALK_RANCH_WOODCUTTER" } },
}

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
