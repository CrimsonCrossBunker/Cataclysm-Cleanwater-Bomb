local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FARMER_2",
    line = ccb.content.text("You mind?"),
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
            next_topic = "TALK_RANCH_FARMER_2_JOB",
        },
        {
            text = ccb.content.text("I'd like to hire your services."),
            next_topic = "TALK_RANCH_FARMER_2_HIRE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
