local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Flavor
ccb.content.define_npc {
    id = "ranch_woodcutter_2",
    suffix = ccb.content.text("Woodworker"),
    class = "NC_COWBOY",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_WOODCUTTER_2",
    faction = "tacoma_commune",
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_WOODCUTTER_2",
    line = ccb.content.text("Don't have much time to talk."),
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
            text = ccb.content.text("What is your job here?"),
            next_topic = "TALK_RANCH_WOODCUTTER_2_JOB",
        },
        {
            text = ccb.content.text("Do you need any help?"),
            next_topic = "TALK_RANCH_WOODCUTTER_2_HIRE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_WOODCUTTER_2_JOB",
    line = ccb.content.text("I turn the logs that laborers bring in into lumber to expand the outpost.  Maintaining the saw is a chore, but breaks the monotony."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_RANCH_WOODCUTTER_2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_WOODCUTTER_2_HIRE",
    line = ccb.content.text("Bringing in logs is one of the few tasks we can give to the unskilled, so I'd be hurting them if I outsourced it.  Ask around though, I'm sure most people could use a hand."),
    replies = { { text = ccb.content.text("Oh."), next_topic = "TALK_RANCH_WOODCUTTER_2" } },
}
