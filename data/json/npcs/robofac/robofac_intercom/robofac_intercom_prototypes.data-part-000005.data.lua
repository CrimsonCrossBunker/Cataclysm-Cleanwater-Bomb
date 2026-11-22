local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ARMOR_REQUEST",
    line = ccb.content.text("Understood.  The parts will finish fabrication in 24 hours, once you hand over the stipulated HGC.  Depending on our currently available selection, the price will range from 2 to 4 HGC for non-specialty equipment."),
    replies = {
        {
            text = ccb.content.text("[3 HGC] I'd like to request a replacement Modular Defense System."),
            next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_STARTED",
            when = predicates.has_inventory("speaker", "RobofacCoin", 3),
            actions = { actions.handler("dlg_a_dda_f989a6e61ab9"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_armor_type", "robofac_armor_pieces_rig"), actions.handler("dlg_a_dda_1f0e3eeb9ce5") },
        },
        {
            text = ccb.content.text("[2 HGC] I'd like to request a set of prototype armor."),
            next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_STARTED",
            when = predicates.has_inventory("speaker", "RobofacCoin", 2),
            actions = { actions.handler("dlg_a_dda_d95d58a657a5"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_armor_type", "robofac_armor_pieces_basic"), actions.handler("dlg_a_dda_1f0e3eeb9ce5") },
        },
        {
            text = ccb.content.text("[4 HGC] I'd like to request a set of turnout armor."),
            next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_STARTED",
            when = predicates.has_inventory("speaker", "RobofacCoin", 4),
            actions = { actions.handler("dlg_a_dda_4a00e32b9c37"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_armor_type", "robofac_armor_pieces_nomex"), actions.handler("dlg_a_dda_1f0e3eeb9ce5") },
        },
        {
            text = ccb.content.text("[4 HGC] I'd like to request a set of ballistic armor."),
            next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_STARTED",
            when = predicates.has_inventory("speaker", "RobofacCoin", 4),
            actions = { actions.handler("dlg_a_dda_4a00e32b9c37"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_armor_type", "robofac_armor_pieces_kevlar"), actions.handler("dlg_a_dda_1f0e3eeb9ce5") },
        },
        {
            text = ccb.content.text("[4 HGC] I'd like to request a set of kinetic armor."),
            next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_STARTED",
            when = predicates.has_inventory("speaker", "RobofacCoin", 4),
            actions = { actions.handler("dlg_a_dda_4a00e32b9c37"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_armor_type", "robofac_armor_pieces_rubber"), actions.handler("dlg_a_dda_1f0e3eeb9ce5") },
        },
        {
            text = ccb.content.text("[12 HGC] I'd like to request a set of soldier armor."),
            next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_STARTED",
            when = predicates.handler("dlg_p_dda_e6b3652800e3"),
            actions = { actions.handler("dlg_a_dda_b6b8885af26b"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_armor_type", "robofac_armor_pieces_military"), actions.handler("dlg_a_dda_1f0e3eeb9ce5") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_REPAIR",
    line = {
        when = predicates.handler("dlg_p_dda_07ee052fc1bb"),
        yes = ccb.content.text("The repairs and tuneup are complete.  Should be good as new or better."),
        no = ccb.content.text("Work is still ongoing.  These things can take time."),
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_07ee052fc1bb"),
            actions = { actions.handler("dlg_a_dda_4ad38383ecfb"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_current_project"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing"), actions.clear_actor_value("speaker", "timer_hub_rnd_u_waiting_on_hub") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PHASE_REPAIR",
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_dda_7c999ab7cbdb"),
            yes = ccb.content.text("Certainly; for a fee of ten coins, repairs and adjustments could be completed in two weeks.  We'll also pull suit metrics and haptic data to better understand the situation on the ground.  I'd ask you to make sure everything has been removed from the suit before giving it to us."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "global", key = "hub01_phase_suit_reverse_engineered" } }),
                yes = ccb.content.text("Certainly; for a fee of ten coins, repairs and adjustments could be completed in two weeks.  We'll also pull suit metrics and haptic data to better understand the situation on the ground.  I'd ask you to make sure everything has been removed from the suit before giving it to us."),
                no = ccb.content.text("&The camera starts scanning the armor, after a moment the intercom cracks back to life.  \"This technology is currently not within our database, we can probably repair it but we'll need to reverse-engineer it first.  We estimate the repairs to take around a month and a half, and they'll have an increased fee of 12 coins.  Please make sure everything has been removed from the suit before giving it to us.\""),
            },
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("[10 HGC] Alright."),
            next_topic = "TALK_ROBOFAC_INTERCOM_REPAIR_STARTED_SHORT",
            when = predicates.handler("dlg_p_dda_3b1a765dcf23"),
            actions = { actions.handler("dlg_a_dda_a46ac05ebff8"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_29d31aae2139"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_current_project", "phase_immersion_suit") },
        },
        {
            text = ccb.content.text("[12 HGC] Fine."),
            next_topic = "TALK_ROBOFAC_INTERCOM_REPAIR_STARTED_LONG",
            when = predicates.handler("dlg_p_dda_40cd2f4cf3d5"),
            actions = { actions.handler("dlg_a_dda_ac6ebea88ba9"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_9539ce7778ec"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_current_project", "phase_immersion_suit") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RM13_REPAIR",
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_dda_f22e5ca0a36c"),
            yes = ccb.content.text("Yes, that is within our capabilities.  For ten coins, repairs and adjustments can be completed in two weeks.  Also, please remove the battery.  We will recharge it.  Please note that if you have made any modifications to the armor, it will be reverted to factory standard as part of the repairs."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "global", key = "hub01_rm13_reverse_engineered" } }),
                yes = ccb.content.text("Yes, that is within our capabilities.  For ten coins, repairs and adjustments can be completed in two weeks.  Also, please remove the battery.  We will recharge it.  Please note that if you have made any modifications to the armor, it will be reverted to factory standard as part of the repairs."),
                no = ccb.content.text("&The camera starts scanning the armor, after a moment the intercom cracks back to life.  \"This technology is currently not within our database, we can probably repair it but we'll need to reverse-engineer it first.  We estimate the repairs to take around a month and a half, and they'll have an increased fee of 12 coins.  Please remove the battery from the suit before passing it to us - and we'll need the battery for testing.\""),
            },
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("[10 HGC] Alright."),
            next_topic = "TALK_ROBOFAC_INTERCOM_REPAIR_STARTED_SHORT",
            when = predicates.handler("dlg_p_dda_6e3e9a555c13"),
            actions = { actions.handler("dlg_a_dda_c9937f9c6197"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_29d31aae2139"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_current_project", "rm13_armor") },
        },
        {
            text = ccb.content.text("[12 HGC] Fine."),
            next_topic = "TALK_ROBOFAC_INTERCOM_REPAIR_STARTED_LONG",
            when = predicates.handler("dlg_p_dda_727ceaec8cd8"),
            actions = { actions.handler("dlg_a_dda_7b1d398e0165"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_9539ce7778ec"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_current_project", "rm13_armor") },
        },
        {
            text = ccb.content.text("I'll make sure I take the battery out and have it ready, then return."),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
            when = predicates.negate(predicates.has_inventory("speaker", "rm13_battery", 1)),
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_EXOSKELETON_REPAIR",
    line = {
        choices = {
            {
            when = predicates.handler("dlg_p_dda_d68c81abc701"),
            yes = ccb.content.text("Certainly, it'll cost you 10 coins and should be ready in two weeks.  Remember to take off any attachments and batteries before turning it in."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "global", key = "hub01_combat_exoskeleton_reverse_engineered" } }),
                yes = ccb.content.text("Certainly, it'll cost you 10 coins and should be ready in two weeks.  Remember to take off any attachments and batteries before turning it in."),
                no = ccb.content.text("One moment,\" the respondent audibly leaves for a moment and after a short period the intercom cracks with life.  \"We have never attempted repairs on a military exoskeleton, we will have to reverse-engineer it first, expect this to take around a month and a half, it will also cost you 12 coins.  Please make sure to take off any attachments and batteries before turning it in."),
            },
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("[10 HGC] Alright."),
            next_topic = "TALK_ROBOFAC_INTERCOM_REPAIR_STARTED_SHORT",
            when = predicates.handler("dlg_p_dda_c8e4d322606c"),
            actions = { actions.handler("dlg_a_dda_f5261b4bc601"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_current_project", "combat_exoskeleton_light_salvaged") },
        },
        {
            text = ccb.content.text("[12 HGC] Fine."),
            next_topic = "TALK_ROBOFAC_INTERCOM_REPAIR_STARTED_LONG",
            when = predicates.handler("dlg_p_dda_6cb731e3bdd9"),
            actions = { actions.handler("dlg_a_dda_78fa94826a02"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_current_project", "combat_exoskeleton_light_salvaged") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_REPAIR",
    line = ccb.content.text("Yes, that is within our capabilities.  For ten coins, repairs and adjustments can be completed by tomorrow.  Please note that if you have made any modifications to the armor, it will be reverted to factory standard as part of the repairs."),
    replies = {
        {
            text = ccb.content.text("[10 HGC] Alright."),
            next_topic = "TALK_ROBOFAC_INTERCOM_REPAIR_STARTED_SHORT",
            when = predicates.has_inventory("speaker", "RobofacCoin", 10),
            actions = { actions.handler("dlg_a_dda_b9f5c369fc72"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_29d31aae2139"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_current_project", "resonance_suit") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}
