local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_DOCTOR",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_provides_aid" } }),
        yes = ccb.content.text("How can I help you today?"),
        no = ccb.content.text("I'm sorry, I don't have time to help you at the moment."),
    },
    replies = {
        {
            text = ccb.content.text("Is there anything else I can help with?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_tacoma_ranch_doctor_completed_supplies" } }) }),
        },
        {
            text = ccb.content.text("Maybe I could help you with something?"),
            next_topic = "TALK_RANCH_DOCTOR_SUPPLIES",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_tacoma_ranch_doctor_completed_supplies" } })), predicates.negate(predicates.has_mission("MISSION_RANCH_DOCTOR_SUPPLIES")) }),
            actions = { actions.offer_mission("MISSION_RANCH_DOCTOR_SUPPLIES"), actions.set_actor_value("interlocutor", "mission_tacoma_ranch_doctor_completed_supplies", "no") },
        },
        {
            text = ccb.content.text("I couldn't find any crutches, but I made these.  Will they work?"),
            next_topic = "TALK_RANCH_DOCTOR",
            when = predicates.all({ predicates.has_inventory("speaker", "makeshift_crutches", 1), predicates.has_mission("MISSION_RANCH_DOCTOR_CRUTCHES") }),
            actions = { actions.handler("dlg_a_dda_d1e14371ac3a"), "mission_success", "clear_mission" },
        },
        {
            text = ccb.content.text("Could you help me with some bionics?"),
            next_topic = "TALK_RANCH_DOCTOR_BIONICS",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodization_u_knows_exodiilore" } }),
        },
        {
            text = ccb.content.text("I could use your medical assistance."),
            next_topic = "TALK_RANCH_DOCTOR_AID",
        },
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_DOCTOR_AID",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_provides_aid" } }),
        yes = {
            when = predicates.has_effect("interlocutor", "currently_busy"),
            yes = ccb.content.text("I have other patients to attend to.  Come back later."),
            no = ccb.content.text("What can I help you with?"),
        },
        no = ccb.content.text("I can't right now, I have other matters to attend to."),
    },
    replies = {
        {
            text = ccb.content.text("[80 merch, 30m] I need you to patch me up."),
            next_topic = "TALK_RANCH_DOCTOR_AID_DONE",
            when = predicates.all({ predicates.has_inventory("speaker", "FMCNote", 80), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_provides_aid" } }) }),
            actions = { actions.handler("dlg_a_dda_c9a8f16599db"), "give_aid" },
        },
        {
            text = ccb.content.text("[200 merch, 1h] I need you to patch my friends up."),
            next_topic = "TALK_RANCH_DOCTOR_AID_DONE",
            when = predicates.all({ predicates.has_inventory("speaker", "FMCNote", 200), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_tacoma_ranch_provides_aid" } }) }),
            actions = { actions.handler("dlg_a_dda_4e70409e125d"), "give_all_aid" },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_DOCTOR_AID_DONE",
    line = ccb.content.gendered_line("Take it easy now.  Wouldn't want you coming back here too soon.", { "speaker" }),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
