local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Flavor
ccb.content.define_npc {
    id = "ranch_farmer_2",
    suffix = ccb.content.text("Farmer"),
    class = "NC_HUNTER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_FARMER_2",
    faction = "tacoma_commune",
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FARMER_2_JOB",
    line = ccb.content.text("I'm just a lucky guy that went from being chased by the undead to the noble life of a dirt farmer.  We get room and board, but won't see a share of our labor unless the crop is a success."),
    replies = { { text = ccb.content.text("It could be worse…"), next_topic = "TALK_RANCH_FARMER_2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FARMER_2_HIRE",
    line = ccb.content.text("I've got no time for you.  If you want to make a trade or need a job, look for the foreman or crop overseer."),
    replies = { { text = ccb.content.text("I'll talk with them then…"), next_topic = "TALK_RANCH_FARMER_2" } },
}
