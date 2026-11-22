local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CROP_OVERSEER",
    line = ccb.content.text("I hope you are here to do business."),
    replies = {
        {
            text = ccb.content.text("The doctor needs some help building an anesthetic machine.  Do you have anything that could help?"),
            next_topic = "TALK_RANCH_GENERIC_ANESTHETIC_FOR_DOCTOR",
            when = predicates.all({ predicates.has_mission("MISSION_RANCH_DOCTOR_MEDICAL_ANESTHETIC"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_tacoma_ranch_doctor_anesthetic_asked" } })) }),
            actions = { actions.set_actor_value("interlocutor", "mission_tacoma_ranch_doctor_anesthetic_asked", "yes") },
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_RANCH_CROP_OVERSEER_JOB",
        },
        {
            text = ccb.content.text("I figured you might be looking for some help…"),
            next_topic = "TALK_RANCH_CROP_OVERSEER",
            actions = { actions.handler("dlg_a_dda_7768cd91cb4b") },
        },
        {
            text = ccb.content.text("I'm interested in investing in agriculture…"),
            next_topic = "TALK_RANCH_CROP_OVERSEER_FIELD",
            when = predicates.all({ predicates.negate(predicates.has_trait("interlocutor", "NPC_CONSTRUCTION_LEV_1")), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_purchased_field_1" } })) }),
        },
        {
            text = ccb.content.text("I'd like to discuss my field…"),
            next_topic = "TALK_RANCH_CROP_OVERSEER_FIELD",
            when = predicates.any({ predicates.has_trait("interlocutor", "NPC_CONSTRUCTION_LEV_1"), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_purchased_field_1" } }) }),
        },
        {
            text = ccb.content.text("What do you need done?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_CROP_OVERSEER_JOB",
    line = ccb.content.text("My job is to manage our outpost's agricultural production.  I'm constantly searching for trade partners and investors to increase our capacity.  If you are interested, I typically have tasks that I need assistance with."),
    replies = {
        {
            text = ccb.content.text("I'll keep that in mind."),
            next_topic = "TALK_RANCH_CROP_OVERSEER",
        },
    },
}
