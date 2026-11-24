local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Construction skill trainer
ccb.content.define_npc {
    id = "ranch_construction_2",
    suffix = ccb.content.text("Carpenter"),
    class = "NC_THUG",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_CONSTRUCTION_2",
    faction = "tacoma_commune",
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CONSTRUCTION_2",
    line = ccb.content.text("Howdy."),
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
            next_topic = "TALK_RANCH_CONSTRUCTION_2_JOB",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CONSTRUCTION_2_JOB",
    line = ccb.content.gendered_line("I was among one of the first groups of immigrants sent here to fortify the outpost.  I might have exaggerated my construction skills to get the hell out of the refugee center.  Unless you are a trader, there isn't much work there and food was really becoming scarce when I left.", { "interlocutor" }),
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_RANCH_CONSTRUCTION_2" } },
}
