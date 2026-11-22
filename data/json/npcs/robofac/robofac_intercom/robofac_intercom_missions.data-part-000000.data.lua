local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_CONTRACTS", "MISSION_ROBOFAC_INTERCOM_2_ACCEPTED", "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_ACCEPTED", "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_ACCEPTED", "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_ACCEPTED", "MISSION_ROBOFAC_INTERCOM_NRE_RECORDER_REPLACEMENT_Complete", "MISSION_ROBOFAC_INTERCOM_MWS_1_ACCEPTED", "MISSION_ROBOFAC_INTERCOM_MWS_2_ACCEPTED", "MISSION_ROBOFAC_INTERCOM_MWS_3_ACCEPTED", "MISSION_ROBOFAC_INTERCOM_MWS_4_ACCEPTED", "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_ACCEPTED", "MISSION_ROBOFAC_INTERCOM_IVAS_ACCEPTED", "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ACCEPTED", "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ACCEPTED" },
    line = ccb.content.text("What would you like to discuss?"),
    replies = {
        {
            text = ccb.content.text("I'm back from the convoy.  [Hand over the hard case.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_2_COMPLETE",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_INTERCOM_2"), predicates.has_item("speaker", "robofac_hardcase") }),
            actions = { actions.handler("dlg_a_dda_97a98b37e4a2"), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_2", { success = true }) },
        },
        {
            text = ccb.content.text("I'm back from LIXA.  [Hand over the data.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_INTERCOM_LIXA_SM_1"), predicates.has_item("speaker", "lixa_data") }),
            actions = { actions.handler("dlg_a_dda_e60854e28f18"), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_LIXA_SM_1", { success = true }) },
        },
        {
            text = ccb.content.text("I found it.  I found your template.  [Hand over the silicon photonics template.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_INTERCOM_3"), predicates.has_item("speaker", "template_photonics") }),
            actions = { actions.handler("dlg_a_dda_1d69328e3153"), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_3", { success = true }) },
        },
        {
            text = ccb.content.text("The weapon worked!  [Hand over the inactive trifacet.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_COMPLETE",
            when = predicates.handler("dlg_p_dda_ca5cbcdbc6ec"),
            actions = { actions.handler("dlg_a_dda_57fc2fc62bb9"), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1", { success = true }) },
        },
        {
            text = ccb.content.text("I found the robot, but…  [Hand over the trifacet remains.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_FAILED",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1"), predicates.has_item("speaker", "broken_yrax_trifacet") }),
            actions = { actions.handler("dlg_a_dda_a773511d99e2"), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1", { success = false }) },
        },
        {
            text = ccb.content.text("I have that portal storm recording for you.  [Hand over the datasheet.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_1_COMPLETE",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_INTERCOM_MWS_1"), predicates.has_item("speaker", "mws_portal_storm_weather_data") }),
            actions = { actions.handler("dlg_a_dda_47c31d449f38"), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_1", { success = true }) },
        },
        {
            text = ccb.content.text("I've returned with the mobile weather station.  [Hand over the HEW unit.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_2_COMPLETE",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_INTERCOM_MWS_2"), predicates.has_item("speaker", "xedra_mobile_weather_station") }),
            actions = { actions.handler("dlg_a_dda_fcd2e40a4a2f"), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_2", { success = true }) },
        },
        {
            text = ccb.content.text("I've returned with a recording from the HEW station.  [Hand over the HEW datasheet.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_3_COMPLETE",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_INTERCOM_MWS_3"), predicates.has_item("speaker", "HEW_printout_data_portal_storm") }),
            actions = { actions.handler("dlg_a_dda_fddffa8eba7a"), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_3", { success = true }) },
        },
        {
            text = ccb.content.text("I'm back.  I don't know what the hell that thing was, but it wasn't a cave.  [Hand over the alien \"atmospheric data.\"]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_COMPLETE",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE"), predicates.has_item("speaker", "mws_monster_corpse_weather_data") }),
            actions = { actions.handler("dlg_a_dda_b197d5c1b644"), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE", { success = true }) },
        },
        {
            text = ccb.content.text("I've returned with the military headset.  [Hand over the MVAS headset.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_IVAS_COMPLETE",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_INTERCOM_IVAS"), predicates.has_item("speaker", "military_vis_aug_system") }),
            actions = { actions.handler("dlg_a_dda_a331a1f04941"), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_IVAS", { success = true }), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_1f0e3eeb9ce5"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_current_project", "ivas") },
        },
        {
            text = ccb.content.text("Dr. Harlow is dead."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_COMPLETE",
            when = predicates.handler("dlg_p_dda_be7465adaf56"),
            actions = { actions.finish_mission("MISSION_ROBOFAC_INTERCOM_CHOP_SHOP", { success = true }) },
        },
        {
            text = ccb.content.text("I've returned with a disabled Exodii worker.  [Hand over the broken Exodii worker]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_COMPLETE",
            when = predicates.handler("dlg_p_dda_f050b705a514"),
            actions = { actions.handler("dlg_a_dda_03dcd9c43e61"), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI", { success = true }), actions.handler("dlg_a_dda_9b39ae23c06a"), actions.set_actor_value("speaker", "dialogue_hub_u_waiting_on_autodoc", "yes") },
        },
        {
            text = ccb.content.text("About that Exodii worker you wanted.  Will this work instead?  [Hand over the broken robot head]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_COMPLETE_ALT",
            when = predicates.all({ predicates.has_mission("MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI"), predicates.has_item("speaker", "exodii_chop_shop_head") }),
            actions = { actions.handler("dlg_a_dda_d1be8bff804a"), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI", { success = true }), actions.handler("dlg_a_dda_9b39ae23c06a"), actions.set_actor_value("speaker", "dialogue_hub_u_waiting_on_autodoc", "yes") },
        },
        {
            text = ccb.content.text("[Contract: Return to sender]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_2_OFFER",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_ROBOFAC_INTERCOM_2")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_2" } })) }),
            actions = { actions.set_actor_value("speaker", "global_portal_storms_u_heard_of_portal_storms", "yes") },
        },
        {
            text = ccb.content.text("[Contract: Light retrieval]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_OFFER",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_ROBOFAC_INTERCOM_3")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_3" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_2" } }) }),
        },
        {
            text = ccb.content.text("[Contract: Iron Safari]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_OFFER",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_robot_sm_1" } })), predicates.negate(predicates.any_equal({ "no", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_robot_sm_1" } })) }),
        },
        {
            text = ccb.content.text("[Contract: Hazard Meteorology]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_portal_sm_1" } })), predicates.any({ predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_told_portal_storms" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_intercom_told_about_portal_storms" } }) }) }),
        },
        {
            text = ccb.content.text("[Contract: Weather Permitting]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER",
            when = predicates.handler("dlg_p_dda_37b4cd82ab6b"),
        },
        {
            text = ccb.content.text("[Contract: System Retrieval]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_2_OFFER",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_ROBOFAC_INTERCOM_MWS_2")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_mws_2" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_mws_1" } }) }),
        },
        {
            text = ccb.content.text("[Contract: Storm Chaser]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_3_OFFER",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_ROBOFAC_INTERCOM_MWS_3")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_mws_3" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_mws_2" } }) }),
        },
        {
            text = ccb.content.text("[Contract: True Weatherperson]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_ROBOFAC_INTERCOM_MWS_4")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_mws_4" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_mws_3" } }) }),
        },
        {
            text = ccb.content.text("[Contract: Invasive \"Meteorology\"]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER",
            when = predicates.handler("dlg_p_dda_0a6e3394d56b"),
        },
        {
            text = ccb.content.text("[Contract: Augmented Reality]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_IVAS_OFFER",
            when = predicates.handler("dlg_p_dda_2cf035a086a1"),
        },
        {
            text = ccb.content.text("[Contract: Data Retrieval]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_OFFER",
            when = predicates.handler("dlg_p_dda_4e2c00e5869b"),
        },
        {
            text = ccb.content.text("[Contract: Post-Apocalyptic IRB]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_OFFER",
            when = predicates.handler("dlg_p_dda_de25ca4967a5"),
        },
        {
            text = ccb.content.text("[Contract: Circuit Safari]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_OFFER",
            when = predicates.handler("dlg_p_dda_b6e5b246be96"),
        },
        {
            text = ccb.content.text("I need a new NRE recorder."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_NRE_RECORDER_REPLACEMENT",
            when = predicates.all({ predicates.negate(predicates.has_item("speaker", "nre_recorder")), predicates.any({ predicates.has_mission("MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1"), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_portal_sm_1" } }) }) }),
        },
        {
            text = ccb.content.text("Do you have any more work for me right now?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS_NoneAvailable",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_2" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_2" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_3" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_portal_sm_1" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_lixa_sm_1" } }), predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_robot_sm_1" } }), predicates.any_equal({ "no", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_robot_sm_1" } }) }) }),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_NRE_RECORDER_REPLACEMENT", "MISSION_ROBOFAC_INTERCOM_NRE_RECORDER_REPLACEMENT_Microphone" },
    line = ccb.content.text("Unfortunate, but not unfixable.  As before, we are willing to provide a replacement in exchange for an NRE microphone."),
    replies = {
        {
            text = ccb.content.text("Hook me up.  [Hand over the NRE microphone.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_NRE_RECORDER_REPLACEMENT_Complete",
            when = predicates.has_item("speaker", "xedra_microphone"),
            actions = { actions.handler("dlg_a_dda_55e0caefb02f") },
        },
        {
            text = ccb.content.text("What is an NRE microphone, and where can I find it?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_NRE_RECORDER_REPLACEMENT_Microphone",
        },
        {
            text = ccb.content.text("On second thought, I'll get back to you on that."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}
