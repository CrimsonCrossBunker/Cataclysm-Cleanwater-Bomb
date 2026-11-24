local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Flavor
ccb.content.define_npc {
    id = "ranch_farmer_1",
    suffix = ccb.content.text("Farmer"),
    class = "NC_THUG",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_FARMER_1",
    faction = "tacoma_commune",
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FARMER_1",
    line = ccb.content.text("…"),
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
            next_topic = "TALK_RANCH_FARMER_1_JOB",
        },
        {
            text = ccb.content.text("I'd like to hire your services."),
            next_topic = "TALK_RANCH_FARMER_1_HIRE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FARMER_1_JOB",
    line = ccb.content.text("I was sent here to assist in setting up the farm.  Most of us have no real skills that transfer from before the Cataclysm, so things are a bit of trial and error."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_RANCH_FARMER_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FARMER_1_HIRE",
    line = ccb.content.text("I'm sorry, I don't have anything to trade.  The work program here splits what we produce between the refugee center, the farm, and ourselves.  If you are a skilled laborer, then you can trade your time for a bit of extra income on the side.  Not much I can do to assist you as a farmer though."),
    replies = { { text = ccb.content.text("Oh."), next_topic = "TALK_RANCH_FARMER_1" } },
}
