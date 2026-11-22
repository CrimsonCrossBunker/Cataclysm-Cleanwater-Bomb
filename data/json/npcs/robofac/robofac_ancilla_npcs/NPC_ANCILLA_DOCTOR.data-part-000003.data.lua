local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_AID",
    line = {
        when = predicates.has_effect("interlocutor", "currently_busy"),
        yes = ccb.content.text("Come back later, I need to take care of a few things first."),
        no = ccb.content.text("I can take a look at you or your companions if you have any injuries.  It'll cost you, of course."),
    },
    replies = {
        {
            text = ccb.content.text("[4 HGC, 30m] I need you to patch me up."),
            next_topic = "TALK_ANCILLA_DOCTOR_AID_DONE",
            when = predicates.has_inventory("speaker", "RobofacCoin", 4),
            actions = { actions.handler("dlg_a_dda_4a00e32b9c37"), "give_aid" },
        },
        {
            text = ccb.content.text("[8 HGC, 1h] I need you to patch my friends up."),
            next_topic = "TALK_ANCILLA_DOCTOR_AID_DONE",
            when = predicates.has_inventory("speaker", "RobofacCoin", 8),
            actions = { actions.handler("dlg_a_dda_8948663cd33d"), "give_all_aid" },
        },
        {
            text = ccb.content.text("I should be fine."),
            next_topic = "TALK_ANCILLA_DOCTOR",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BIONICS",
    line = {
        when = predicates.handler("dlg_p_dda_70bb50a96013"),
        yes = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_ancilla_doctor_u_learned_about_bionic_limbs" } }),
            yes = ccb.content.text("Sure, what can I do ya' for?"),
            no = ccb.content.text("&The Doc looks you over carefully.  \"Well, you still got all your fingers and toes, so I guess you're not here for the new prosthetics.  What can I do for you?\""),
        },
        no = ccb.content.text("Sure, what can I do ya' for?"),
    },
    replies = {
        {
            text = ccb.content.text("New prosthetics?  What do you mean?"),
            next_topic = "TALK_ANCILLA_DOCTOR_BIONICS_BIONIC_LIMB_INTRO",
            when = predicates.handler("dlg_p_dda_799f35256c4a"),
            actions = { actions.set_actor_value("speaker", "dialogue_ancilla_doctor_u_learned_about_bionic_limbs", "yes") },
        },
        {
            text = ccb.content.text("So about those cybernetic arms and legs… think you could replace one of my normal limbs with one?"),
            next_topic = "TALK_ANCILLA_DOCTOR_BIONICS_BIONIC_LIMB_PROPOSE_SWAP",
            when = predicates.handler("dlg_p_dda_a9060f5caa99"),
            actions = { actions.set_actor_value("speaker", "dialogue_ancilla_doctor_u_asked_about_swapping_limbs", "yes") },
        },
        {
            text = ccb.content.text("I was wondering if you could install a cybernetic limb…"),
            next_topic = "TALK_ANCILLA_DOCTOR_BIONICS_BIONIC_LIMB_REPLACEMENT_1",
            when = predicates.handler("dlg_p_dda_dbc8f5960e8c"),
        },
        {
            text = ccb.content.text("I was wondering if you could install a cybernetic implant…"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "currently_busy")), predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")) }),
            actions = { "bionic_install" },
        },
        {
            text = ccb.content.text("I was wondering if you could install a cybernetic implant in my friend here…"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_effect("interlocutor", "currently_busy")),
            actions = { "bionic_install_allies" },
        },
        {
            text = ccb.content.text("I need help removing an implant…"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "currently_busy")), predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")) }),
            actions = { "bionic_remove" },
        },
        {
            text = ccb.content.text("I need help removing an implant from one of my friends…"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_effect("interlocutor", "currently_busy")),
            actions = { "bionic_remove_allies" },
        },
        {
            text = ccb.content.text("I need my cybernetics repaired…"),
            next_topic = "TALK_ANCILLA_DOCTOR_BIONICS_REPAIR",
            when = predicates.negate(predicates.has_effect("interlocutor", "currently_busy")),
        },
        {
            text = ccb.content.text("Wow, you've got a proper setup here.  Impressive.  I'm not sure if it'll be compatible with my interface, but think you could help modify my bionic implants?"),
            next_topic = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_1",
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_ANCILLA_DOCTOR",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BIONICS_REPAIR",
    line = ccb.content.text("What do you need?  Repairing cybernetics isn't cheap, but I guess it's cheaper than replacing them.  Make sure you unload anything or remove any mods you want to keep.\"  The Doc then gently pats the automated surgical suite.  \"Doc Junior here will tear up anything you leave in during the repair."),
    replies = {
        {
            text = ccb.content.text("Can you repair damage to my bionic limbs?"),
            actions = { "repair_bionic_limbs" },
            when = predicates.any({ predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"), predicates.has_trait("speaker", "BIONIC_ARM_BASIC_BOTH"), predicates.has_trait("speaker", "BIONIC_LEG_BASIC_BOTH"), predicates.has_trait("speaker", "BIONIC_ARM_BASIC_LEFT"), predicates.has_trait("speaker", "BIONIC_ARM_BASIC_RIGHT"), predicates.has_trait("speaker", "BIONIC_LEG_BASIC_LEFT"), predicates.has_trait("speaker", "BIONIC_LEG_BASIC_RIGHT") }),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Actually, can you help me with something else?"),
            next_topic = "TALK_ANCILLA_DOCTOR_BIONICS",
        },
    },
}
