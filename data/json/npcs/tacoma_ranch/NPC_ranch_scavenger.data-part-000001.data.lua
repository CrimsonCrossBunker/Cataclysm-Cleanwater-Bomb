local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_SCAVENGER_1",
    line = ccb.content.text("Welcome to the junk shop."),
    replies = {
        {
            text = ccb.content.text("The doctor needs some help building an anesthetic machine.  Do you have anything that could help?"),
            next_topic = "TALK_RANCH_SCAVENGER_ANESTHETIC_FOR_DOCTOR",
            when = predicates.all({ predicates.has_mission("MISSION_RANCH_DOCTOR_MEDICAL_ANESTHETIC"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_tacoma_ranch_doctor_anesthetic_scavengers_helped" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_tacoma_ranch_scavenger_hospital_raid_started" } })) }),
            actions = {
                actions.set_actor_value("speaker", "mission_tacoma_ranch_scavenger_hospital_raid", "yes"),
            },
        },
        {
            text = ccb.content.text("What is your job here?"),
            next_topic = "TALK_RANCH_SCAVENGER_1_JOB",
        },
        {
            text = ccb.content.text("Do you need any help?"),
            next_topic = "TALK_RANCH_SCAVENGER_1_HIRE",
        },
        {
            text = ccb.content.text("Let's see what you've managed to find."),
            next_topic = "TALK_RANCH_SCAVENGER_1",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Any lucky find?"),
            next_topic = "TALK_RANCH_SCAVENGER_ASK_RESTOCK",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
