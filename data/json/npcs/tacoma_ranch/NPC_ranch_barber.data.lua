local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates

-- Provides hair cuts
ccb.content.define_npc {
    id = "ranch_barber",
    suffix = ccb.content.text("Barber"),
    class = "NC_HUNTER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_BARBER",
    faction = "tacoma_commune",
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_BARBER_JOB",
    line = ccb.content.text("What?  I'm a barber… I cut hair.  There's demand for cheap cuts and a shave out here."),
    replies = { { text = ccb.content.text("Sorry."), next_topic = "TALK_RANCH_BARBER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_BARBER_HIRE",
    line = ccb.content.text("I can't imagine what I'd need your assistance with."),
    replies = { { text = ccb.content.text("Fine."), next_topic = "TALK_RANCH_BARBER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_BARBER_CUT",
    line = ccb.content.text("Stand still while I get my clippers…"),
    replies = { { text = ccb.content.text("Thanks…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_BARBER",
    line = ccb.content.text("Can I interest you in a trim?  It'll cost you 6 merch for a haircut or 3 for a beard trim.  I can do color and styling too."),
    replies = {
        {
            text = ccb.content.text("The doctor needs some help building an anesthetic machine.  Do you have anything that could help?"),
            next_topic = "TALK_RANCH_GENERIC_ANESTHETIC_FOR_DOCTOR",
            when = predicates.all({ predicates.has_mission("MISSION_RANCH_DOCTOR_MEDICAL_ANESTHETIC"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_tacoma_ranch_doctor_anesthetic_asked" } })) }),
            actions = { actions.set_actor_value("interlocutor", "mission_tacoma_ranch_doctor_anesthetic_asked", "yes") },
        },
        {
            text = ccb.content.text("What is your job here?"),
            next_topic = "TALK_RANCH_BARBER_JOB",
        },
        {
            text = ccb.content.text("Do you need any help?"),
            next_topic = "TALK_RANCH_BARBER_HIRE",
        },
        {
            text = ccb.content.text("[3 merch] I'll have a shave."),
            next_topic = "TALK_RANCH_BARBER_CUT",
            when = predicates.has_inventory("speaker", "FMCNote", 3),
            actions = { actions.handler("w16b_a_dda_59c325f690c7") },
        },
        {
            text = ccb.content.text("[6 merch] I'll get a haircut."),
            next_topic = "TALK_RANCH_BARBER_CUT",
            when = predicates.has_inventory("speaker", "FMCNote", 6),
            actions = { actions.handler("w16b_a_dda_bf2f802de4c4") },
        },
        {
            text = ccb.content.text("Maybe another time…"),
            next_topic = "TALK_DONE",
        },
    },
}
