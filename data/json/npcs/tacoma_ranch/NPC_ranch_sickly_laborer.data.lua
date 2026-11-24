local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Flavor
ccb.content.define_npc {
    id = "ranch_ill_1",
    suffix = ccb.content.text("Laborer"),
    class = "NC_HUNTER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_ILL_1",
    faction = "tacoma_commune",
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_ILL_1",
    line = ccb.content.text("Please leave me alone…"),
    replies = {
        {
            text = ccb.content.text("The doctor needs some help building an anesthetic machine.  Do you have anything that could help?"),
            next_topic = "TALK_RANCH_SICKLY_LABORER_ANESTHETIC_FOR_DOCTOR",
            when = predicates.all({ predicates.has_mission("MISSION_RANCH_DOCTOR_MEDICAL_ANESTHETIC"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_tacoma_ranch_doctor_anesthetic_asked" } })) }),
            actions = {
                actions.set_actor_value("interlocutor", "mission_tacoma_ranch_doctor_anesthetic_asked", "yes"),
            },
        },
        { text = ccb.content.text("What is your job here?"), next_topic = "TALK_RANCH_ILL_1_JOB" },
        { text = ccb.content.text("Do you need any help?"), next_topic = "TALK_RANCH_ILL_1_HIRE" },
        { text = ccb.content.text("What's wrong?"), next_topic = "TALK_RANCH_ILL_1_SICK" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_ILL_1_JOB",
    line = ccb.content.gendered_line("I was just a laborer till they could find me something a bit more permanent, but being constantly sick has prevented me from doing much of anything.", { "interlocutor" }),
    replies = { { text = ccb.content.text("That's sad."), next_topic = "TALK_RANCH_ILL_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_ILL_1_HIRE",
    line = ccb.content.gendered_line("I don't know what you could do.  I've tried everything.  Just give me time…", { "interlocutor" }),
    replies = { { text = ccb.content.text("OK."), next_topic = "TALK_RANCH_ILL_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_ILL_1_SICK",
    line = ccb.content.gendered_line("I keep getting sick!  At first I thought it was something I ate, but now it seems like I can't keep anything down…", { "interlocutor" }),
    replies = { { text = ccb.content.text("Uhm."), next_topic = "TALK_RANCH_ILL_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_SICKLY_LABORER_ANESTHETIC_FOR_DOCTOR",
    line = ccb.content.text("What could I possibly have that could help?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_RANCH_ILL_1",
        },
    },
}
