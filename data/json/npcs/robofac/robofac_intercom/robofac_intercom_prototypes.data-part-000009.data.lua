local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_1",
    line = ccb.content.text("Interesting.  If you could provide us the item, we could direct research on it for a standard work week for a fee of two HGC; after that, we will let you know if any progress has been made and return the item as-is.  Please remove any batteries or other attachments before providing it."),
    replies = {
        {
            text = ccb.content.text("[2 HGC, s02a cleansuit] See you in five days."),
            next_topic = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_1_STARTED",
            when = predicates.all({ predicates.has_inventory("speaker", "RobofacCoin", 2), predicates.has_inventory("speaker", "xedra_artifact_cleansuit", 1) }),
            actions = { actions.handler("dlg_a_dda_fde17be1a40f"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_1f0e3eeb9ce5"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_current_project", "resonance_suit_pt_1") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_1_COMPLETE",
    line = {
        when = predicates.handler("dlg_p_dda_479e16cc31b2"),
        yes = ccb.content.text("We've made some notable progress.  The electronics seem to protect from extradimensional phenomena - specifically, from the accumulation of what we refer to as extradimensional resonance, which comes from contact with extradimensional materials.  The protection is modest, and the power drain substantial, but it is sufficient for moving limited hazardous materials about.  We believe we can integrate it into our standard environment suit, but the prototype will be more cumbersome, have no storage, and will be more rigid, thus losing the ability to unzip and wear about the waist, which we hear our contractors tend to enjoy on hot days.  Further, the electronics are sensitive, and only we will be able to repair them.  But I suppose that's the price one pays for extradimensional protections.  Let us know if you are interested in testing out such a prototype."),
        no = ccb.content.text("Work is still ongoing.  These things can take time."),
    },
    replies = {
        {
            text = ccb.content.text("Interesting."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_479e16cc31b2"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_current_project"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing"), actions.clear_actor_value("speaker", "timer_hub_rnd_u_waiting_on_hub"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_completed_resonance_suit_pt_1", "yes"), actions.handler("dlg_a_dda_9cd1e2a69204") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_2",
    line = ccb.content.text("Very well; we will need one coin for materials costs, the S02a cleansuit, and our standard issue environment suit.  I encourage you to remove everything from the pockets and battery compartment before handing them over for processing.  We'll need one day for construction and one day to verify efficacy."),
    replies = {
        {
            text = ccb.content.text("[1 HGC, cleansuit, environment suit] I'll see you in two days."),
            next_topic = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_2_STARTED",
            when = predicates.all({ predicates.has_inventory("speaker", "RobofacCoin", 1), predicates.has_inventory("speaker", "xedra_artifact_cleansuit", 1), predicates.has_inventory("speaker", "robofac_enviro_suit", 1) }),
            actions = { actions.handler("dlg_a_dda_270a3b7a0f3e"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_1f0e3eeb9ce5"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_current_project", "resonance_suit_pt_2") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_2_COMPLETE",
    line = {
        when = predicates.handler("dlg_p_dda_6e573fdc7475"),
        yes = ccb.content.text("The prototype hazardous materials suit is complete.  Thank you as always for your contributions to our research and technology."),
        no = ccb.content.text("Work is still ongoing.  These things can take time."),
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_6e573fdc7475"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_current_project"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing"), actions.clear_actor_value("speaker", "timer_hub_rnd_u_waiting_on_hub"), actions.handler("dlg_a_dda_d28f3867bd3a") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}
