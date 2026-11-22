local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_1",
    line = ccb.content.text("Interesting.  If you could provide us the item, we could direct research on it for a standard work week for a fee of two HGC; after that, we will let you know if any progress has been made and return the item as-is.  Please remove any batteries or other attachments before providing it."),
    replies = {
        {
            text = ccb.content.text("[2 HGC, anchor] See you in five days."),
            next_topic = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_1_STARTED",
            when = predicates.all({ predicates.has_inventory("speaker", "RobofacCoin", 2), predicates.has_inventory("speaker", "dimensional_anchor", 1) }),
            actions = { actions.handler("dlg_a_dda_7b93e757fb8e"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_1f0e3eeb9ce5"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_current_project", "anchor_pt_1") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_1_COMPLETE",
    line = {
        when = predicates.handler("dlg_p_dda_479e16cc31b2"),
        yes = ccb.content.text("We've made some notable progress.  The anchor itself appears to provide some degree of protection from extradimensional phenomena, and we believe that we can integrate it into our current modular armor system.  This will, however, make it heavier and less portable.  The armor will remain wearable outside of metal armor, although it will be a more snug fit than the anchor alone would have been.\"\n\n\"We are returning the anchor now."),
        no = ccb.content.text("Work is still ongoing.  These things can take time."),
    },
    replies = {
        {
            text = ccb.content.text("Interesting."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_479e16cc31b2"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_current_project"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing"), actions.clear_actor_value("speaker", "timer_hub_rnd_u_waiting_on_hub"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_completed_anchor_pt_1", "yes"), actions.handler("dlg_a_dda_03ba7e1acdef") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_2",
    line = ccb.content.text("Very well; we will need one coin for materials costs, as well as the anchor itself and the modular defense system you wish to combine it with.  As usual, I encourage you to remove everything from the pockets before handing them over for processing.  We'll need one day for construction and one day to verify efficacy."),
    replies = {
        {
            text = ccb.content.text("[1 HGC, anchor, MDS] I'll see you in two days."),
            next_topic = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_2_STARTED",
            when = predicates.all({ predicates.has_inventory("speaker", "RobofacCoin", 1), predicates.has_inventory("speaker", "dimensional_anchor", 1), predicates.has_inventory("speaker", "robofac_armor_rig", 1) }),
            actions = { actions.handler("dlg_a_dda_a6f3892b29aa"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_1f0e3eeb9ce5"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_current_project", "anchor_pt_2") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_2_COMPLETE",
    line = {
        when = predicates.handler("dlg_p_dda_6e573fdc7475"),
        yes = ccb.content.text("The anchor has been integrated into the harness.  Thank you as always for your contributions to our research and technology."),
        no = ccb.content.text("Work is still ongoing.  These things can take time."),
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_6e573fdc7475"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_current_project"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing"), actions.clear_actor_value("speaker", "timer_hub_rnd_u_waiting_on_hub"), actions.handler("dlg_a_dda_b6aa2a600d2f") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}
