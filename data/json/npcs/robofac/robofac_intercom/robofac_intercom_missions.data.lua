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

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_NRE_RECORDER_REPLACEMENT_Microphone",
    line = ccb.content.text("The microphone is a static version of the same device used in the recorder, mounted on a tripod.  The glass ampoule is larger, but should look roughly the same in design.  They may be somewhat scarce given the current state of the world, but I would advise you to look inside of research labs.  Subway lines may be a good place to start."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_NRE_RECORDER_REPLACEMENT_Complete",
    line = ccb.content.text("&You fold up the microphone's legs, stuff it awkwardly into the tray, and slide it shut.  A few moments later, it slides open again, revealing a replacement NRE recorder.\n\n\"Try not to lose this one.\""),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_CONTRACTS_NoneAvailable",
    line = ccb.content.text("Give me a moment to look at your file… here we are.  Valid assignments are turning up empty at the moment.  I'm afraid we have no open contracts for you."),
    replies = { { text = ccb.content.text("Understood."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}

-- This mission is assigned and completed using conditions in dialogue with the intercom. As such, we don't have any goal, which would make it auto-complete under certain circumstances.
-- All dialogue for most of the intercom's missions is handled through talk_topics; we don't use these strings for those such missions
ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_1",
    name = ccb.content.text("Return Field Data"),
    goal = "MGOAL_NULL",
    description = ccb.content.text("Investigate a nearby field and return with Dr. Prado and the robot prototype she was testing.  Failing that, retrieve the I/O recorder stored within the robot.  If the robot remains operational, avoid direct confrontation and use EMP grenades to disable it."),
    difficulty = 5,
    value = 0,
    start = {
        target = { terrain = "field", reveal_radius = 2, random = true, search_range = 10 },
        map_updates = {
            {
                layout = {
                    rows = {
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "          M             ",
                        "            b b         ",
                        "         b b b@bb       ",
                        "             b b        ",
                        "                        ",
                        "                        ",
                    },
                    flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
                    field_glyphs = { b = { id = "fd_blood", intensity = { 1, 2 } } },
                    item_groups = { ["@"] = { group = "NC_ROBOFAC_SCIENTIST_worn", chance = 100 } },
                    item_spawns = { ["@"] = { { id = "corpse_generic_female" } } },
                    monster_glyphs = { M = { id = "mon_robofac_prototype" } },
                    terrain = { ["@"] = "t_grass", b = "t_dirt", M = "t_dirt" },
                },
            },
        },
    },
    finish = { handler = "advance_hub01_completed_missions_by_1" },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_1_OFFER",
    line = ccb.content.text("One of our scientists recently left the building to perform a field test of a prototype robot, but failed to return.  We have not been able to contact them.  Your job would be to investigate the testing site, and return with her and the prototype.  Failing that, return with the data recorder that was attached to our prototype."),
    replies = {
        {
            text = ccb.content.text("That seems trivial.  Is there a catch?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_ADVICE",
        },
        { text = ccb.content.text("Not interested."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_1_ADVICE",
    line = ccb.content.text("There is.  If the robot is operational, it's very likely to be hostile and extremely dangerous.  I don't recommend fighting it directly.  Dr. Prado left the building with a handful of EMP grenades.  If you can locate those grenades, use them to disable the prototype instead."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  Where is the test site?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_ACCEPTED",
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_1") },
        },
        {
            text = ccb.content.text("Extremely dangerous?  What kind of danger should I expect?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_ADVICE_2",
        },
        {
            text = ccb.content.text("I'll pass on getting killed today, thanks."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_1_ADVICE_2",
    line = ccb.content.text("It's built with experimental combat programming and some heavy-duty armor.  Despite the armor, it's pretty nimble, so unless you've got a vehicle don't expect to outrun it.  We decided to hold off on adding long-range weapons until we finished the initial field testing, so if you can keep your distance, you should be safe."),
    replies = {
        {
            text = ccb.content.text("I can handle it.  Where is the test site?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_ACCEPTED",
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_1") },
        },
        { text = ccb.content.text("I think I'll pass."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_1_ACCEPTED",
    line = ccb.content.text("Very close by.\"  The voice lists off some relative coordinates.  \"Good luck."),
    replies = { { text = ccb.content.text("I'll be back soon."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_1_INQUIRE",
    line = ccb.content.text("You're back.  Do you have anything to report?"),
    replies = {
        {
            text = ccb.content.text("Your scientist was dead, but I disabled the prototype.  Is this what you were looking for?  [Hand over the prototype I/O recorder.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_COMPLETE",
            when = predicates.has_item("speaker", "robofac_test_data"),
            actions = { actions.handler("dlg_a_dda_a757f4a3a655") },
        },
        {
            text = ccb.content.text("Not yet.  I'll get back to it."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_1_COMPLETE", "MISSION_ROBOFAC_INTERCOM_1_COMPLETE_2" },
    line = ccb.content.text("&The intercom is silent for a few seconds while the tray slides back in.  \"Yes it is.  It's unfortunate that only the data was salvageable, but you have our thanks for returning it nonetheless.\""),
    replies = {
        {
            text = ccb.content.text("Alright, I've done my part.  What now?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_COMPLETE_3",
        },
        {
            text = ccb.content.text("Is \"unfortunate\" how you usually describe someone being eviscerated by a robot?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_COMPLETE_2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_1_COMPLETE_2",
    line = ccb.content.text("Dr. Prado knew the risks, and she chose to follow through with the test anyway.  Her death is cause for sadness, and it will affect us, but you didn't even know her.  At least now, something of her work will remain."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_1_COMPLETE_3",
    line = ccb.content.text("&The voice hesitates.  \"About that.  Give me a moment.\"  After a pause, you hear muffled back-and-forth conversation.  You can't make out what's being said, but you can make out at least two other distinct voices."),
    replies = { { text = ccb.content.text("[Wait.]"), next_topic = "TALK_ROBOFAC_INTERCOM_1_JOBS" } },
}

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_2",
    name = ccb.content.text("Return to sender"),
    description = ccb.content.text("Find the corpse of a Hub 01's AI researcher and retrieve the hard case they brought with them during the evacuation."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    start = {
        target = { terrain = "road_ew", match = "EXACT", reveal_radius = 2, random = true, search_range = 80 },
        map_updates = {
            { layout = { nested = { { x = 0, y = 0, id = "robofac_mi2_convoy_ambush_chunk" } } } },
        },
        handler = "mark_global_portal_storms_u_heard_of_portal_storms",
    },
    finish = {
        map_updates = {
            {
                terrain = "robofachq_surface_entrance",
                layout = { nested = { { x = 6, y = 7, id = "robofac_hq_surface_merc_1" } } },
            },
        },
        item_rewards = { { item = "RobofacCoin", count = 4 } },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_2",
            "advance_hub01_completed_missions_by_1",
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_dialogue_topic {
    id = {
        "MISSION_ROBOFAC_INTERCOM_2_OFFER", "MISSION_ROBOFAC_INTERCOM_2_ADVICE_Convoy",
        "MISSION_ROBOFAC_INTERCOM_2_ADVICE_DARPA",
    },
    line = ccb.content.text("When the portal storms started, the government issued an evacuation order for critical personnel and sent convoys to retrieve them, with our head of AI research among the recalled.  We recently discovered that he died when the convoy transferring him was ambushed in the initial chaos, but his corpse and belongings might remain intact enough to benefit from his research.\"\n\n\"We want you to travel to the convoy and locate the body, if possible.  His evacuation protocol included retrieving and storing as much of the data from his facility as possible, to be stored in a code-locked hard case.  If this hard case is present, retrieve it, and bring it back here.\"\n\n\"We offer the standard hazard pay of 4 HGC for this contract."),
    replies = {
        {
            text = ccb.content.text("I'll take it.  Where's the convoy?"),
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_2") },
            next_topic = "MISSION_ROBOFAC_INTERCOM_2_ACCEPTED",
        },
        {
            text = ccb.content.text("What should I expect to go up against?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_2_ADVICE_Convoy",
        },
        {
            text = ccb.content.text("Who was this person, and what do they look like?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_2_ADVICE_DARPA",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_2_ADVICE_Convoy",
    line = ccb.content.text("The convoy was composed of vehicles and personnel from the US Army, and it was heavily armed.  Our surveillance of the area has shown that the majority of the slain military personnel have revived, including one wearing a light combat exoskeleton.  Resistance will be heavy, but if possible, you may be able to locate and retrieve the hard case, then exfiltrate without direct combat as long as you can outpace the undead there.  Otherwise, bring a rifle and plenty of ammo."),
}

-- This is a lie.  The researcher was XEDRA; DARPA is just the organization being used as a front.
ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_2_ADVICE_DARPA",
    line = ccb.content.text("Officially speaking, they were a senior DARPA researcher.  Their corpse should stick out; it's likely the only one not wearing camouflage.  That's all you need to know."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_2_ACCEPTED",
    line = ccb.content.text("It was ambushed on the road.\"  The intercom recites a series of coordinates.  \"Report back with the hard case.  If the researcher brought it with him, it will be intact; have no doubt about that."),
}

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_2_COMPLETE", "MISSION_ROBOFAC_INTERCOM_2_COMPLETE_Hardcase" },
    line = ccb.content.text("&The intercom's tray slides shut.\n\n\"This is the case; thank you.  Transferring the stipulated amount now.\"  The tray slides back open with your payment.  \"As an additional form of payment, you have been given clearance to receive a map of the area around this site, to assist in your work.  The standing price is 1 HGC; please inform us if you'd like to follow up on that offer going forward.\""),
    replies = {
        {
            text = ccb.content.text("[PER 8] The original markings on that case had been scratched out.  Who did it really belong to?"),
            when = predicates.minimum_attribute("speaker", "perception", 8),
            next_topic = "MISSION_ROBOFAC_INTERCOM_2_COMPLETE_Hardcase",
        },
        {
            text = ccb.content.text("I'm interested in that map."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_LOCAL_MAP",
        },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_2_COMPLETE_Hardcase",
    line = ccb.content.text("&The intercom is silent."),
}

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_3",
    name = ccb.content.text("Light retrieval"),
    description = ccb.content.text("Reach the collapsed tower basement, and search the ruins for a photonic circuitry template.  The intercom warned you about heavy enemy presence, and of the existence of a hazardous environment.  They aren't sure if the safety gear they gave you is enough."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    start = {
        target = {
            terrain = "office_tower_collapse_b_a0",
            special = "office_tower_collapsed",
            reveal_radius = 1,
            random = true,
            search_range = 180,
            z = -1,
        },
        map_updates = { { layout = { nested = { { x = 10, y = 22, id = "robofac_mi3_photonics_chunk" } } } } },
    },
    finish = {
        item_rewards = { { item = "RobofacCoin", count = 8 } },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_3",
            "advance_hub01_completed_missions_by_1",
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_dialogue_topic {
    id = {
        "MISSION_ROBOFAC_INTERCOM_3_OFFER", "MISSION_ROBOFAC_INTERCOM_3_OFFER_AnythingElse",
        "MISSION_ROBOFAC_INTERCOM_3_OFFER_Hesitating", "MISSION_ROBOFAC_INTERCOM_3_ADVICE_Location",
    },
    line = ccb.content.text("Our facility once sourced advanced photonic circuitry from a nearby robotics manufacturer.  Their building suffered major damage during the portal storms, and collapsed almost entirely.  However, preliminary scouting reveals that the basement prototyping lab likely remains intact.\"\n\n\"We ask you to investigate the ruins, and if possible, retrieve a template for the fabrication of said photonic circuitry.\"\n\n\"Completion of this contract awards 8 HGC, the standard heightened-hazard rate.  We are also willing to provide you with a set of protective gear at a considerable discount upon acceptance of the contract."),
    replies = {
        {
            text = ccb.content.text("Let's do this, then.  Transfer the location."),
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_3") },
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_ACCEPTED",
        },
        {
            text = ccb.content.text("Where is this manufacturer?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_Location",
        },
        {
            text = ccb.content.text("You mention hazard pay.  What dangers are there?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}

-- Restore previous dialogue if we ever get multi-story rappelling. If so, make sure to leave at least one elevator as the teleporting elevator trap
ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_Location",
    line = ccb.content.text("I don't believe I'm cleared to-\"  You hear brief chatter.  \"Apologies; I was mistaken.  The manufacturer was, technically speaking, kept secret from the public.  As a result, it operated using an office tower as a front, and was located underground.  An elevator in the back of the building led to the basement, but it was likely destroyed in the damage and the shaft may well be inaccessible - as a result, you will need to find a way down yourself.  There is a maintenance staircase in the compound, which may provide a means of entry should you be able to find an access card on the premises."),
}

ccb.content.define_dialogue_topic {
    id = {
        "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS", "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS_Toxins",
        "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS_Heat",
    },
    line = ccb.content.text("About that.\"  You hear papers shuffling.  \"Our drones are unable to approach the structure too closely, as a large amount of interference prevents surveillance, but long-distance measurements reveal a high concentration of toxic compounds in the air, as well as densely-clustered heat signatures.  We expect a high concentration of undead, and other dangers are likely."),
    replies = {
        {
            text = ccb.content.text("Toxic compounds?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS_Toxins",
        },
        {
            text = ccb.content.text("Tell me about these heat signatures."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS_Heat",
        },
        {
            text = ccb.content.text("\"Other dangers\" is a little vague.  Do you have anything more substantial?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS_Other",
        },
        {
            text = ccb.content.text("Back to the contract itself…"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_OFFER_AnythingElse",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS_Toxins",
    line = ccb.content.text("Correct.  The source of the chemicals is unknown, as is the exact composition; only trace amounts are present in the air itself.  We can, however, extrapolate that something within the ruins is creating highly poisonous emissions.  We do not know how strong these emissions will become, or what form they will take."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS_Heat",
    line = ccb.content.text("At the moment, their origin is unclear.  The temperature profile of the building is highly unusual, despite the damage, and is much denser than wandering hordes observed through remote scouting.  A large amount of heat consistent with an extremely high density of organisms appears to be emanating from the basement itself.  We are, unfortunately, in the dark about the cause of this density.  We would advise you remain observant and note down any abnormalities."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_ADVICE_DANGERS_Other",
    line = ccb.content.text("To be specific, there have been anomalous readings that we are unable to explain.  Seismic disturbances have been recorded emanating from the ruins, with a magnitude ranging from two to four, and periodic vocalizations have been documented to exceed 150 decibels.  We are uncertain why or how these phenomena are created."),
    replies = {
        {
            text = ccb.content.text("The more I hear about this, the worse it sounds."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_OFFER_Hesitating",
        },
        {
            text = ccb.content.text("Understood."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_OFFER_AnythingElse",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_OFFER_AnythingElse",
    line = ccb.content.text("Did you have any other concerns?"),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_OFFER_Hesitating",
    line = ccb.content.text("Your hesitation is understandable.  Unfortunately, we have already taken all possible measures to obtain data and information remotely, but we are unable to develop our understanding further without a physical presence."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_ACCEPTED",
    line = ccb.content.text("Excellent.  Thank you very much.\"  The intercom recites a series of coordinates.  \"Exercise a great deal of caution.  We do not know what the conditions on the ground are like.  Use your best judgment.  As before, we are willing to offer you better protective gear, if you would like it, we can't know if this mask will be enough without direct field tests."),
    replies = {
        {
            text = ccb.content.text("I would like that gear, yes.  Tell me about it."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_PROTECTIVE_GEAR",
        },
        { text = ccb.content.text("Understood."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE",
    line = ccb.content.text("Fantastic.\"  The intercom's tray slides shut, and then opens shortly afterwards with your payment.  \"You have our thanks and our payment."),
    replies = {
        {
            text = ccb.content.text("Do you have any idea what I just went through?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_1",
        },
        {
            text = ccb.content.text("You certainly gave me a run for my money, I'll say that much."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_1",
        },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_1",
    line = ccb.content.text("As we discussed during acceptance of the contract, we were aware of hazardous ground conditions, but we were unable to deduce further information other than what was available through long-range sensing.  If you would like to provide a description of the hazards present, we are willing to document them."),
    replies = {
        {
            text = ccb.content.text("[Detail the conditions at the collapsed tower and its basement.  This will advance time by ten minutes.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_Explainer",
            actions = { actions.handler("dlg_a_dda_d05d0c5b676b") },
        },
        {
            text = ccb.content.text("[Let them know how bad that mission REALLY was.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut",
        },
        {
            text = ccb.content.text("…Just forget it.  Let's never speak of this again."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_Explainer",
    line = ccb.content.text("&Over the course of several minutes, you explain what happened at the ruins: the zombie presence and gigantic tendrils on the surface, and the biological infestation completely taking over the basement, as well as the hostile threats encountered therein.  The voice periodically interjects with questions or statements; the whole time, you hear the sounds of typing on a keyboard.\n\n\"We would like to extend our thanks for your detailed report.  It is clear to us that the threat level present at the manufacturer was far higher than we had originally anticipated, and your performance in the situation was exemplary.  Should you desire further contract work, we will bear these facts in mind, and ensure that the threat prognoses of your future assignments are adequately assessed.\""),
    replies = {
        {
            text = ccb.content.text("It's fine.  At least now we know for the future."),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("Yeah, yeah.  You're welcome."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Let's never do that again."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut",
    line = ccb.content.text("&The intercom waits patiently."),
    replies = {
        {
            text = ccb.content.text("Description, huh?  Where to begin?  Let's start with the giant mob of zombies that was infesting the building.  Oh, and there were also horrors full of toxic gas that exploded when I got near them or killed one, so I was constantly choking on fumes the whole time."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_1",
    line = ccb.content.text("That makes-"),
    replies = {
        {
            text = ccb.content.text("Oh, but that's not all!  They were coming from a pair of giant fucking tentacles coming out of the ground like a monster movie that were constantly roaring and shaking the whole building, and toxic exploding spiders kept crawling off and shooting poison darts at me until I got away or stopped the tentacles themselves, which wasn't easy because the entire building had come down around them."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_2",
        },
        {
            text = ccb.content.text("[Stop talking.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_5",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_2",
    line = ccb.content.text("What do you mean by-"),
    replies = {
        {
            text = ccb.content.text("Then it took me half an hour to find the way down, because there were holes in the floor everywhere, and when I finally did, I was in the insides of a goddamn flesh pit with flooding up to my ankles, and to complement the innards hanging from the ceiling that I couldn't see through the gas that would throw me ten feet and make me start drowning, there were dozens of people fused together in lumps everywhere, and did I mention the poison gas?  Because they were full of it too, and so everything reeked and it felt like being in a giant fucking intestine full of people."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_3",
        },
        {
            text = ccb.content.text("[Stop talking.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_3",
    line = ccb.content.text("Please slow down-"),
    replies = {
        {
            text = ccb.content.text("And after ALL THAT, I find your manufacturing lab on the other end of this thing straight out of a fever dream nightmare, and after ALL THAT, I find your photonics, and then I have to get ALL THE WAY out of the ENTIRE ZOMBIE-INFESTED TOWN so I could bring you your stupid fucking template.  Are you happy now?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_4",
        },
        {
            text = ccb.content.text("[Stop talking.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_4",
    line = ccb.content.text("&The voice on the other side of the intercom is silent with disbelief."),
    replies = {
        {
            text = ccb.content.text("[Wait.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_5",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_5",
    line = ccb.content.text("…Uh.  We are- thank you for finding the photonics.  We will, ah, make sure that the threat conditions of your future contracts are adequately assessed.  Um.  Thank you."),
    replies = { { text = ccb.content.text("Good."), next_topic = "TALK_DONE" } },
}

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1",
    name = ccb.content.text("Iron Safari"),
    description = ccb.content.text("Disable and retrieve the unusual robot by <color_yellow>successfully stunning it with the prototype rifle provided,</color> then <color_yellow>quickly running up and deactivating the robot before it recovers from the stun</color>.  You can keep shooting it while it's stunned to prolong the time until it is active again.  You can intercept the robot indicated by Hub 01, or find an inactive robot somewhere else.  <color_yellow>You'll need to read the 'trifacet handling procedures' manual before trying to deactivate it</color>."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    start = {
        target = { terrain = "forest", reveal_radius = 2, random = true, search_range = 70 },
        map_updates = {
            {
                layout = {
                    rows = {
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "              M         ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                        "                        ",
                    },
                    monster_glyphs = { M = { id = "mon_yrax_trifacet" } },
                    terrain = { M = "t_dirt" },
                },
            },
        },
    },
    finish = {
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_robot_sm_1",
            "advance_hub01_completed_missions_by_1",
        },
    },
    failure = { handler = "set_dialogue_intercom_completed_robofac_intercom_robot_sm_1_to_no" },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_OFFER", "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_OFFER_ADVICE_Gun", "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_OFFER_ADVICE_Trifacet" },
    line = ccb.content.text("One of our scout drones spotted a partially-malfunctioning robot of unconventional make while tracking an anomalous radiation spike close by.  We project that much knowledge could be gained from a close examination of this subject, and you would be tasked to retrieve it for us intact.  We will equip you with a prototype rifle and instructions on how to use it and deactivate the robot, if you accept.\"\n\n\"The success of this contract requires that the subject be brought back in an inactive state, and *not* destroyed.  A ruined robot is of no scientific value.  We emphasize that you use the prototype to complete this task; an EMP blast would likely destroy the subject outright.\"\n\n\"Completion of this contract awards 2 HGC, and you will be able to keep the prototype and the equipment used to operate it."),
    replies = {
        {
            text = ccb.content.text("You've got a deal.  I'll track down your robot."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_ACCEPTED",
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1"), actions.handler("dlg_a_dda_ea2ba23445ef") },
        },
        {
            text = ccb.content.text("Tell me about this prototype."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_OFFER_ADVICE_Gun",
        },
        {
            text = ccb.content.text("What is this robot, and what does it look like?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_OFFER_ADVICE_Trifacet",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_OFFER_ADVICE_Gun",
    line = ccb.content.text("If you'll give me a moment…\"  You hear the sounds of typing.  \"Its working name is the hm12.  It functions similarly to a laser, but is specifically designed to incapacitate robots without harming their internals.  Once a subject is stunned, it can be manually deactivated.\"\n\n\"A shot will only stun the robot if you manage to hit its main sensory array, which will rely on your aim.  After a stunning shot, you might proceed to the deactivation attempts by examining the robot from up close."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_OFFER_ADVICE_Trifacet",
    line = ccb.content.text("We are as of yet uncertain of its origin and purpose.  Its body most closely resembles a pyramid on what we believe are three sets of legs for mobility.  It is lightly armed, and has attacked our cam-spy drones using high-voltage electric discharge.  We theorize that this is most likely for deterrence, and not to cause direct harm.  Nonetheless, we need to emphasize that its full capabilities are unknown, and we do not know how it will react when confronted with a living threat."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_ACCEPTED",
    line = ccb.content.text("Lovely.  Just a moment; we will transfer the prototype and handling procedures, which includes information of its last recorded location.\"\n\nThe intercom tray thumps several times as objects are placed into it.  After about a minute, it slides open, revealing a slender weapon that looks a bit like a radar gun, a tool battery, a sheaf of papers in a binder, and a UPS.  \"The hm12 draws power from a connected UPS.  Please remember to bring the specimen back *intact* - battered salvage is of no use to us.  To safely perform the task of deactivation, <color_yellow>please review the provided documentation</color>, and pay special attention to the procedures detailed in subsections IV and VII."),
}

ccb.content.define_dialogue_topic {
    id = {
        "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_COMPLETE",
        "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_COMPLETE_Prototype",
        "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_COMPLETE_Binder",
    },
    line = ccb.content.text("&The intercom tray quickly slides shut.\n\n\"We expected nothing less.  We hope you found the prototype's performance to be satisfactory.\""),
    replies = {
        {
            text = ccb.content.text("Will this weapon work on other robots, as well?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_COMPLETE_Prototype",
        },
        {
            text = ccb.content.text("The handling procedures you gave me seemed to predate the Cataclysm.  How long had that robot been here?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_COMPLETE_Binder",
            actions = {
                actions.set_actor_value("speaker", "global_portal_storms_u_heard_of_portal_storms", "yes"),
            },
        },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_COMPLETE_Prototype",
    line = ccb.content.text("We believe so; it underwent intensive internal tests on existing and theoretical models before giving it to you.  UGVs, autonomous CROWS units, manhacks, and other robots should all be possible to neutralize by using the weapon, although we advise great caution; the weapon is short-ranged, and was not designed to target distant enemies."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_COMPLETE_Binder",
    line = ccb.content.text("Pardon me.\"  The voice briefly turns away from the microphone and asks something.  \"Very well.  I am cleared to tell you that it appeared near the beginning of the portal storms, and during this time, it was logged and documented.  No attempt was ever made to retrieve it before the government collapsed.  That is all I am able to share with you at this time."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_FAILED",
    line = ccb.content.text("&The intercom tray quickly slides shut.  After a pause, the voice on the other end sighs.\n\n\"…we requested that the subject remain intact.  This outcome is… unfortunate.  We will process the specimen, but it is unlikely that it will yield usable information as to its purpose.\"\n\n\"You may keep the prototype.  You are dismissed.\""),
    replies = {
        { text = ccb.content.text("I'm sorry."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Alright, alright."), next_topic = "TALK_DONE" },
    },
}

-- This mission is completed when you first sell any piece of portal storm data.
ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1",
    name = ccb.content.text("Hazard Meteorology"),
    goal = "MGOAL_NULL",
    description = ccb.content.text("Use the NRE recorder to collect information during a portal storm event.  You'll need to <color_yellow>stay outside and carry the recorder for around 6 minutes until you hear a sharp beep</color> to collect sufficient data.  Generate a printout by activating the NRE recorder and offer it to Hub 01 to finish the mission."),
    difficulty = 5,
    value = 0,
    finish = {
        map_updates = {
            {
                terrain = "robofachq_surface_entrance",
                layout = { nested = { { x = 1, y = 9, id = "robofac_hq_surface_merc_2" } } },
            },
        },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_portal_sm_1",
            "advance_hub01_completed_missions_by_1",
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER", "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER_ADVICE_Recorder", "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER_ADVICE_Outside", "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER_ADVICE_Hold", "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER_ADVICE_Replacement" },
    line = ccb.content.text("As we mentioned before, our research into the portal storm phenomena requires that we obtain additional data to verify our own local measurements.  Recording this data will require you to carry a scientific instrument called an NRE recorder on your person while outside in the storm for around six minutes.  The recording instrument will be provided at no cost if you choose to accept.\"\n\n\"We are willing to offer 1 HGC for each standard-length recording.  Higher-quality data may be obtained by collecting more data before printing a report, and as a result, we are willing to provide higher pay for better recordings."),
    replies = {
        {
            text = ccb.content.text("Sure, why not?  Let's do some science."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_ACCEPTED",
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1"), actions.handler("dlg_a_dda_bfa0da4ca246") },
        },
        {
            text = ccb.content.text("How does the recorder work?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER_ADVICE_Recorder",
        },
        {
            text = ccb.content.text("How will I know when I've been outside long enough?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER_ADVICE_Outside",
        },
        {
            text = ccb.content.text("Do I need to physically hold the recorder in my hand?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER_ADVICE_Hold",
        },
        {
            text = ccb.content.text("If I lose the recorder or break it, what should I do?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER_ADVICE_Replacement",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER_ADVICE_Recorder",
    line = ccb.content.text("Once the storm starts, it should be enough to walk outside while carrying the NRE, as the recording requires no particular actions on your part.  Research insist on the fact that you must personally carry the NRE on your person to take accurate measurements, so leaving it outside while you take shelter won't work.  I'd explain the synchronistic relations that demand this, but I didn't really understand that part myself… oh, and you might want to obtain a high-caliber firearm before attempting to take the measurements.  Just in case things start leaking into uhm… prime."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER_ADVICE_Outside",
    line = ccb.content.text("The recorder will beep once it has recorded enough data for a report.  The longer you stay outside, however, the higher the quality and quantity of the data will be.  While you are only expected to obtain the minimum viable report that the NRE can produce, we are willing to offer increased pay for higher-quality recordings."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER_ADVICE_Hold",
    line = ccb.content.text("You do not.  All that is required is that you have it somewhere on your person; it will function equally well inside of a bag as it would in your own hands.  Your preferred method of carrying the instrument will be enough to collect data as long as it is directly carried on your person."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_OFFER_ADVICE_Replacement",
    line = ccb.content.text("The recorder is not irreplaceable, but it is constructed using delicate components that are now in short supply.  In the event that the device is rendered nonfunctional, we are willing to provide a replacement at an equivalent cost.  Specifically, if you can locate an NRE microphone, which can be located in certain laboratories, then we are willing to provide a replacement recorder in exchange for it."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1_ACCEPTED",
    line = ccb.content.text("Transferring the recorder now.\"  The intercom tray slides open, revealing a hefty, barebones device and a light battery to accompany it.  \"Please remember to exercise caution; the effects of portal storms on human physiology are poorly understood."),
}

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER", "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_MWS", "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Reality_Bubble", "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Recording_Length", "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Replacement" },
    line = ccb.content.text("Your field NRE recordings are of continued interest of us.  Since you have proved yourself capable, we would like to expand your assignment.  We are willing to provide you with a mobile weather station.  We'd like you to set it up and deploy it near a portal storm.  A standard recording takes 1 hour.  We realize the anomalies may not last that long, so as long as the portal storm passes near the unit while recording, we can make use of the data.  As payment we will let you keep the weather system and pay you our standard subcontracting rate."),
    replies = {
        {
            text = ccb.content.text("More science?  I'm in."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_1_ACCEPTED",
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_MWS_1"), actions.handler("dlg_a_dda_7f37f3e7ae70") },
        },
        {
            text = ccb.content.text("How does the weather station work?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_MWS",
        },
        {
            text = ccb.content.text("Do I need to stay near the station while it records?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Reality_Bubble",
        },
        {
            text = ccb.content.text("How close do I need to get and do I need to record for the full hour?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Recording_Length",
        },
        {
            text = ccb.content.text("If I lose the station or break it, what should I do?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Replacement",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_MWS",
    line = ccb.content.text("The station is a self-contained meteorology unit.  You will have to haul it to the location and construct it, but it's rather simple.  The assembly process takes the average person about twenty minutes.  After that, start the recording subroutine using the onboard computer.  After recording, remove the printed datasheet.  Again, simply set it up and start recording while a portal storm is around, and we'll be able to make use of the data."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Reality_Bubble",
    line = ccb.content.text("You do not.  This is expensive technology in short supply, so you may wish to defend it from anomalous interference.  But the device can hypothetically be left and collected later."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Recording_Length",
    line = ccb.content.text("You do need to have the storm, in some capacity, be active near the unit while it is recording.  But, we do not expect you to record from the eye of the storm, nor does the storm need to be active for the full hour.  As long as you capture some data it will suffice.  We caution you not to shut off the device early - allow it to finish the 1 hour recording subroutine so that it prints useable data."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_1_OFFER_ADVICE_Replacement",
    line = ccb.content.text("While these are infinitely easier to construct than your NRE recorder, the components are still in short supply.  We will be able to issue replacements through our normal surplus trade, so you may have to wait for some time.  Be careful with it."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_1_ACCEPTED",
    line = ccb.content.text("Transferring the weather station now.\"  The intercom tray slides open and thunks, revealing a yellow, hard-plastic case with a sturdy handle.  \"As in your previous assignment, please remember to exercise caution during these storms, especially with the delicate equipment."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_1_COMPLETE",
    line = ccb.content.text("Fantastic.  Just a moment.\"  The intercom's tray slides shut.  There is a very long silence, and then it opens again, this time with your payment.  \"You have our thanks and your payment.  Unfortunately, this equipment seems to have malfunctioned in the storm.  We will need more sensitive equipment to proceed.  If you'd like another contract, we're prepared to make an offer."),
    replies = { { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}

ccb.content.define_dialogue_topic {
    id = {
        "MISSION_ROBOFAC_INTERCOM_MWS_2_OFFER", "MISSION_ROBOFAC_INTERCOM_MWS_2_OFFER_ADVICE_MWS",
        "MISSION_ROBOFAC_INTERCOM_MWS_2_OFFER_ADVICE_Dangers",
    },
    line = ccb.content.text("Unsurprisingly, the consumer-grade weather station malfunctioned during the storm recording.  Nevertheless, you've proved yourself a capable contractor.  Therefore, we'd like you to retrieve more advanced recording equipment.  Some time ago we lost contact with a DARPA-affiliated limnological test station, and we have reason to believe they kept sensitive recording equipment on hand.  We'd like you to retrieve it - for your standard contracting fee, of course."),
    replies = {
        {
            text = ccb.content.text("Alright, I'll find the advanced weather recording equipment."),
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_MWS_2") },
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_2_ACCEPTED",
        },
        {
            text = ccb.content.text("What does the equipment look like?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_2_OFFER_ADVICE_MWS",
        },
        {
            text = ccb.content.text("Based on our previous work together, I'm guessing there may be some resistance?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_2_OFFER_ADVICE_Dangers",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_2_OFFER_ADVICE_MWS",
    line = ccb.content.text("The station is a self-contained meteorology unit like the one you've previously used.  The case is black, and will be marked as a \"Hazardous Environment\" unit.  It will have been kept behind a locked door, but this is likely non-functional without power.  The station is situated in a lake and was actively researching the effects of… weather… on the sediment, so there may be other access points."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_2_OFFER_ADVICE_Dangers",
    line = ccb.content.text("The station is inactive and drone footage suggests it has been barricaded.  We do not know what or who is inside."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_2_ACCEPTED",
    line = ccb.content.text("Excellent.  Transferring the coordinates now."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_2_COMPLETE",
    line = ccb.content.text("Fantastic.  Please hand over the unit.\"  The intercom's tray slides open, you deposit the device, and it quickly closes.  There is a brief silence, and then it opens again, this time with your payment.  \"You have our thanks and your payment, once again.  Please let us know if you are interested in additional field work."),
    replies = { { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_MWS_3_OFFER", "MISSION_ROBOFAC_INTERCOM_MWS_3_OFFER_ADVICE_HEW" },
    line = ccb.content.text("We've confirmed that the Hazardous Environment unit that you've recovered is in working condition.  We are willing to pay you a standard contracting fee to repeat your previous storm recordings."),
    replies = {
        {
            text = ccb.content.text("Alright, let's get a real recording this time."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_3_ACCEPTED",
            actions = { actions.handler("dlg_a_dda_55aec7df7093"), actions.assign_mission("MISSION_ROBOFAC_INTERCOM_MWS_3") },
        },
        {
            text = ccb.content.text("Anything different from last time?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_3_OFFER_ADVICE_HEW",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_3_OFFER_ADVICE_HEW",
    line = ccb.content.text("The station is a self-contained meteorology unit like the one you've previously used.  The case is black, and will be marked as a \"Hazardous Environment\" unit.  It will have been kept behind a locked door, but this is likely non-functional without power.  The station is situated in a lake and was actively researching the effects of… weather… on the sediment, so there may be other access points."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_3_ACCEPTED",
    line = ccb.content.text("Excellent.  See you soon."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_3_COMPLETE",
    line = ccb.content.text("Fantastic.\"  The intercom's tray slides open, you deposit the datasheet, and it quickly closes.  There is a brief silence, and then it opens again, this time with your payment.  \"You have our thanks and your payment, once again.  If you are interested in an open-ended contract as a research, we are prepared to offer you one."),
    replies = {
        {
            text = ccb.content.text("Thank you.  I'll consider it."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER", "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE", "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE_FRAME", "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE_NRE" },
    line = ccb.content.text("We believe your HEW unit can produce scientifically useful recordings near many types of of anomalous, extra-dimensional activity - not just portal storms.  In fact, we now know that it is equipped with a small, and relatively simple DARPA AI program trained on extensive data collected before… recent events.  It is capable of producing reports for anomalies and relating them to previously studied laboratory phenomena - anomalies it can assign unique codes to, which we can then interpret using our supercomputers.  If you can bring us these reports, we will pay you for them.  We will also pay for more portal storm recordings.  To facilitate your work, we can offer you two things.  First, we are prepared to give you a custom-printed pack frame, which will allow you to carry your HEW station and some essential supplies.  Secondly, if you are willing to pay, we would be willing to put R&D time into integrating your NRE recorder with your HEW unit."),
    replies = {
        {
            text = ccb.content.text("Well, I guess you can call me the weatherperson.  I'm in."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_4_ACCEPTED",
            actions = { actions.handler("dlg_a_dda_e0b22c7c9d72"), actions.assign_mission("MISSION_ROBOFAC_INTERCOM_MWS_4") },
        },
        {
            text = ccb.content.text("What sorts of places should I be looking for?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE",
        },
        {
            text = ccb.content.text("Tell me more about this custom frame."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE_FRAME",
        },
        {
            text = ccb.content.text("Tell me more about the HEW-NRE unit."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE_NRE",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE",
    line = ccb.content.text("Anywhere there is portal activity, or where you think portal activity occurred in the recent past.  If you happen to find yourself transported to… exotic places… that would also be a good time to make recordings."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE_FRAME",
    line = ccb.content.text("It is a 3D-printed pack frame, much like those used to move equipment for more… traditional field work.  We've designed an ergonomic frame to accommodate your HEW unit, a small tent, a rollmat, as well as waterproof compartments for essential electronics: one UPS, one folding solar panel, and one standard laptop.  It is cumbersome, and you won't be able to store anything in it other than the specific equipment, but it is lightweight and efficient.  We will provide only frame and some solar panels for field charging your HEW unit."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_4_OFFER_ADVICE_NRE",
    line = ccb.content.text("We believe we can integrate the units, which may make it easier for you to make complex recordings on the move."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_4_ACCEPTED",
    line = ccb.content.text("Excellent.  We look forward to your progress."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_intercom_u_hub_prototypes", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_4_COMPLETE",
    line = ccb.content.text("The intercom's tray slides open and you deposit the report.  There is a brief silence, and then it opens with your payment."),
    replies = { { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}

ccb.content.define_dialogue_topic {
    id = {
        "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER",
        "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_DANGERS",
        "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_FIELD_TEAM",
        "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_SCAN_LOCATION",
    },
    line = ccb.content.text("The recording you brought us suggests that there is some underground source of alien organic volatiles.  We've cross-referenced with our existing geographic data, and we think we've identified several underground structures that may match the signatures you've brought us.  We'd like you and a field team to go to one of these and measure underground atmospheric conditions - with your HEW station, of course."),
    replies = {
        {
            text = ccb.content.text("Alright, so go underground to specific coordinates, set up the HEW station, and make a recording.  I'm in."),
            actions = {
                actions.assign_mission("MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_FIELD_TEAM"),
                actions.assign_mission("MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE"),
            },
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_ACCEPTED",
        },
        {
            text = ccb.content.text("Any idea what I can expect?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_DANGERS",
        },
        {
            text = ccb.content.text("Field team?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_FIELD_TEAM",
        },
        {
            text = ccb.content.text("Do I need to scan at these EXACT coordinates?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_SCAN_LOCATION",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_DANGERS",
    line = ccb.content.text("There appear to be lifeforms, alien and otherwise.  We don't know anything about them."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_FIELD_TEAM",
    line = ccb.content.text("Yes, we've already contracted several others to perform surface reconnaissance.  It may be worth speaking with them to share information."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_OFFER_ADVICE_SCAN_LOCATION",
    line = ccb.content.text("Yes, absolutely.  We think recordings from these exact coordinates will give us the most useful data on these volatile organics.  However, like other recordings, you don't need to be present for the full hour the recording runs - you can set up the station, leave, and come back later for the report."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_ACCEPTED",
    line = ccb.content.text("Excellent.  You'll meet the advanced team on the surface near your coordinates."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_COMPLETE",
    line = ccb.content.text("The intercom's tray slides open and you deposit the report.  There is a brief silence, and then it opens with your payment.  \"You have our thanks and your payment.  It will take us some time for Research to digest this and the other field data, but perhaps we will have more related contracts for you later."),
    replies = { { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_IVAS_OFFER", "MISSION_ROBOFAC_INTERCOM_IVAS_ADVICE_ANDURIL" },
    line = ccb.content.text("It has become clear that you and other agents required improved equipment for data collection and reconnaissance.  One of our surveillance teams has identified an Anduril Industries testing facility that we believe houses, or at least, housed, a prototype Military Visual Augmentation System.  It will resemble a consumer virtual reality headset, but has valuable hardware and software that we can use to develop useful tech for you and other mercenaries.  We want you to retrieve it and return it to us.\"\n\n\"We offer the standard hazard pay of 4 HGC for this contract, and we will grant you the honor of prototyping the first device, after we have studied it."),
    replies = {
        {
            text = ccb.content.text("I'll find it.  Where's this building?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_IVAS_ACCEPTED",
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_IVAS"), actions.handler("dlg_a_dda_32fed1313479") },
        },
        {
            text = ccb.content.text("What is Anduril Industries?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_IVAS_ADVICE_ANDURIL",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_IVAS_ADVICE_ANDURIL",
    line = ccb.content.text("They are, or were, a defense contractor.  They are headquartered elsewhere, but maintained software engineering offices here, and we believe this one was testing the MVAS system."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_IVAS_ACCEPTED",
    line = ccb.content.text("Use this ID card to access the facility.\"  The slot opens, revealing a small ID badge.  \"Report back with the system.  Naturally, you may keep anything else you find."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_IVAS_COMPLETE",
    line = ccb.content.text("The intercom's tray slides open and you deposit the headset.  There is a brief silence, and then it opens with your payment.  \"You have our thanks and your payment.  Return in approximately five days and R&D may have a prototype visual augmentation system ready for testing."),
    replies = { { text = ccb.content.text("Thank you."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}

ccb.content.define_dialogue_topic {
    id = {
        "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_OFFER",
        "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ADVICE_Resistance",
        "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ADVICE_Experiments",
    },
    line = ccb.content.text("When the portal storms started, alien structures started to appear all over the surrounding area.  We sent a field team to recover and study them, and we have been in constant contact since.  However, we have since learned that the project lead, Dr. Michael Harlow, has been performing unethical human experimentation at his field site, without approval from our Institutional Review Board.  While we would usually take the IRB report to the authorities, there are no more authorities.  The IRB has unanimously determined that these experiments must be put to an end.  However, Dr. Harlow has indicated that the experiments will not stop, so they must be stopped by force.\"\n\n\"We want you to travel to the field site, execute Dr. Harlow, and free any living prisoners he may still have.  If Dr. Harlow's mercenaries resist, you are authorized to respond with deadly force.  Given the severity of Dr. Harlow's ethics violations, this is the most utilitarian outcome.\"\n\n\"We offer the standard hazard pay of 4 HGC for this contract, and you may keep anything valuable you find at the site."),
    replies = {
        {
            text = ccb.content.text("I'll do it.  I'll kill the scientist."),
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_CHOP_SHOP") },
            next_topic = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ACCEPTED",
        },
        {
            text = ccb.content.text("What sort of resistance might there be?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ADVICE_Resistance",
        },
        {
            text = ccb.content.text("What sort of experiments is Dr. Harlow doing?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ADVICE_Experiments",
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ADVICE_Resistance",
    line = ccb.content.text("The doctor has hired a mercenary team well known to us, all of which are former law enforcement.  Proceed with caution."),
}

-- The Hub in fact sactioned these experiments, but Melchior has determined that the experiments are endangering the Hub, and must be stopped.  The real justification is that they no longer expect the research to produce practical results, yet Dr. Harlow has refused to bend the knee and stop.
ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ADVICE_Experiments",
    line = ccb.content.text("Dr. Harlow discovered some sort of alien robotics, and has been performing unsanctioned medical procedures in an attempt to implant them in living humans.  The experiments are unethical and a failure to boot, and thus must be stopped."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_ACCEPTED",
    line = ccb.content.text("A makeshift laboratory and medical facility has been set up in a nearby dentist's office, where the alien structure was found.  We will transfer the coordinates.  We suggest you don't speak with Dr. Harlow, or anyone else.  Just execute your orders as quickly as possible."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP_COMPLETE",
    line = ccb.content.text("The intercom's tray slides open, filled with your payment.  \"The IRB thanks you for your service to ethics, and has asked us to remind you that the details of this assignment are to remain classified."),
    replies = { { text = ccb.content.text("Right."), next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES" } },
}

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_OFFER", "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_What", "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_How", "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_Which", "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_Prototype" },
    line = {
        when = predicates.handler("dlg_p_dda_ac36be63f1e3"),
        yes = ccb.content.text("As you are aware, we have recovered advanced equipment from the Exodii warehouse.  Analysis indicates it may constitute an automated surgical suite; however, additional hardware is required to fully assemble and activate the system.  Given your successful retrieval of the Trifacet, we are offering you the contract as a priority.  Research is in need of an Exodii \"worker\".\"\n\n\"The Exodii have demonstrated extreme hazard potential.  Accordingly, should you accept this contract, a prototype HOUND unit will be assigned to you to assist in your operation.\"\n\n\"This contract includes the standard hazard pay of 4 HGC and an indefinite license to use the HOUND unit.  Additionally, we anticipate that your involvement will facilitate critical technical developments, which may become available to you in due course."),
        no = ccb.content.text("Our robotics research division has requested new robot specimens.  Given your successful retrieval of the Trifacet, we are offering you the contract as a priority.  Research is in need of an Exodii \"worker\".\"\n\n\"The Exodii have demonstrated extreme hazard potential.  Accordingly, should you accept this contract, a prototype HOUND unit will be assigned to you to assist in your operation.\"\n\n\"This contract includes the standard hazard pay of 4 HGC and an indefinite license to use the HOUND unit.  Additionally, we anticipate that your involvement will facilitate critical technical developments, which may become available to you in due course."),
    },
    replies = {
        {
            text = ccb.content.text("So take down an Exodii worker and bring it to you?  I'm in."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ACCEPTED",
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "hub01_explained_exodii" } }) }),
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI"), actions.handler("dlg_a_dda_f6e107a6ca8f") },
        },
        {
            text = ccb.content.text("What's an Exodii?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_What",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } })),
            actions = { actions.set_actor_value("speaker", "hub01_explained_exodii", "yes") },
        },
        {
            text = ccb.content.text("How am I supposed to take down an Exodii worker?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_How",
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "hub01_explained_exodii" } }) }),
        },
        {
            text = ccb.content.text("What exactly am I looking for?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_Which",
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "hub01_explained_exodii" } }) }),
        },
        {
            text = ccb.content.text("Tell me more about this prototype HOUND."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_Prototype",
            when = predicates.any({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "hub01_explained_exodii" } }) }),
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_What",
    line = ccb.content.text("Killer robots that invaded earth during the portal storm.  They have a large fortress somewhere - some sort of metal castle - and thus show signs of dangerous intelligence.  We do not fully understand their directives or functions, and thus need a salvaged robot to deconstruct and reverse engineer."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_How",
    line = ccb.content.text("We understand these Exodii can be quite dangerous, hence why we are assigning you a HOUND unit.  You can disable the robot by any violent means you deem necessary, as long as it does not seriously damage its frame."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_Which",
    line = ccb.content.text("Yes, a good question.  Our recon teams have identified several units that appear to be mindless \"worker\" drones.  These worker units can be found at some of their field sites, which may look like large shipping containers, metal boxes, or strange barns.  We also know that there are infected robots roaming near some of their facilities, which we have taken to calling \"zomborgs\".  But, we have other contractors working with these zomborgs, and these efforts have not yet yielded results, so please do not bring us any of those."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ADVICE_Prototype",
    line = ccb.content.text("We refer to it as the Hostile Overstimulation and Unmanned Neutralization Drone, or HOUND.  It is a custom-build robot that will engage hostiles with a noisemaker and taser unit.  It should keep hostile Exodii, and other threats, distracted so that you can engage them safely.  We strongly suggest you bring hearing protection."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_ACCEPTED",
    line = ccb.content.text("&The intercom's tray slides open, revealing an inactive robot and a pair of earplugs.  \"Happy hunting.\""),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_COMPLETE",
    line = {
        when = predicates.handler("dlg_p_dda_ac36be63f1e3"),
        yes = ccb.content.text("&The intercom's tray slides open, filled with your payment.  \"Excellent.  In addition to your contracting fee you may keep the HOUND.  We would appreciate periodic reports on its field performance.\"\n\nYou hear a THUNK as something covers the microphone, and through scratches and muffled words, you heard \"Permission--tell-----okay.\"\n\nYou then hear the intercom click off, there is a moment of silence, and it clicks on again.  \"Ahem, so, as discussed earlier, we think this unit will lead to some important developments that will need field testing.  If things go as planned we will happily offer you a place in our field testing program.  Please occasionally check with us about project status.\""),
        no = ccb.content.text("&The intercom's tray slides open, filled with your payment.  \"Excellent.  In addition to your contracting fee you may keep the HOUND.  We would appreciate periodic reports on its field performance.\""),
    },
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI_COMPLETE_ALT",
    line = {
        when = predicates.handler("dlg_p_dda_ac36be63f1e3"),
        yes = ccb.content.text("&The intercom is silent a long moment, and then you hear a keyboard clacking and the tray slides open, filled with your payment.  \"Yes, this will do.  In addition to your contracting fee you may of course keep the HOUND.  We would appreciate periodic reports on its field performance.\"\n\nYou hear a THUNK as something covers the microphone, and through scratches and muffled words, you heard \"Permission--tell-----okay.\"\n\nYou then hear the intercom click off, there is a moment of silence, and it clicks on again.  \"Ahem, so, as discussed earlier, we think this unit will lead to some important developments that will need field testing.  If things go as planned we will happily offer you a place in our field testing program.  Please occasionally check with us about project status.\""),
        no = ccb.content.text("&The intercom is silent a long moment, and then you hear a keyboard clacking and the tray slides open, filled with your payment.  \"Yes, this will do.  In addition to your contracting fee you may of course keep the HOUND.  We would appreciate periodic reports on its field performance.\""),
    },
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1",
    name = ccb.content.text("Data Retrieval"),
    description = ccb.content.text("Reach the LIXA facility, and search the area for anything of interest.  The intercom warned you about a number of undead aboveground, and the high probability of more underground."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    start = {
        target = { terrain = "LIXA_road_guard", special = "physics_lab_LIXA", reveal_radius = 1, z = 0 },
    },
    finish = {
        item_rewards = { { item = "RobofacCoin", count = 5 } },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_lixa_sm_1",
            "advance_hub01_completed_missions_by_1",
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_dialogue_topic {
    id = { "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_OFFER", "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_WHAT_ELSE", "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_OFFER_ADVICE", "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_LIXA_ACRONYM", "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_OFFER_ADVICE_Replacement", "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_OFFER_ADVICE_HEW" },
    line = ccb.content.text("During the Cataclysm, we lost contact with one of our sister sites, LIXA.  Aerial surveillance indicates that the facility's inhabitants are deceased, and beyond the now-zombified security detail, the site should be sparsely populated.  We want you to enter the facility and make a copy of what they were researching on the provided thumb drive.  Additionally, we will be providing you with a keycard that should at the very least get you in the front door.\"\n\n\"We're offering a standard 5 HGC for successful retrieval of the data.  If that isn't enough of an incentive, we do have a manifest from before we lost contact with the facility showing a handful of specialized powered suits in inventory.  You are free to take any that are left."),
    replies = {
        {
            text = ccb.content.text("Alright, I'll see if I can't get that data for you."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_ACCEPTED",
            actions = { actions.assign_mission("MISSION_ROBOFAC_INTERCOM_LIXA_SM_1"), actions.handler("dlg_a_dda_2f5e615d151c") },
        },
        {
            text = ccb.content.text("What can you tell me about what they were doing there?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_WHAT_ELSE",
        },
        {
            text = ccb.content.text("What does LIXA even mean?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_LIXA_ACRONYM",
        },
        {
            text = ccb.content.text("If I lose the ID card or the memory stick, what should I do?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_OFFER_ADVICE_Replacement",
        },
        {
            text = ccb.content.text("You told me that the HEW system picked up \"spacetime anomalies\".  What does that mean?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_OFFER_ADVICE_HEW",
            when = predicates.handler("dlg_p_dda_361ee57aaaf3"),
        },
        {
            text = ccb.content.text("What else do you have available?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_CONTRACTS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_WHAT_ELSE",
    line = ccb.content.text("All I can tell you is that they were conducting cutting-edge research related to-\" The intercom abruptly cuts off for several seconds before coming back on, the voice sounding apologetic, \"Sorry, but as it turns out I'm not at liberty to divulge that information.  What I can do however is recommend you bring an NRE recorder with you if you still have one."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_LIXA_ACRONYM",
    line = ccb.content.text("It's an acronym that stands for Laser Interferometer eXodimensional resonance Array."),
}

-- I feel like this could be phrased better.
ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_OFFER_ADVICE_Replacement",
    line = ccb.content.text("Well, the ID card wouldn't strictly speaking be necessary if you were to find some way of breaching the facility's security doors.\" The voice pauses for a moment, \"But that said we only have the one ID card, so unless you're confident you can get in without it, please don't lose it.  As for the memory stick I would highly recommend you not lose that as portable drives with the required hardware security modules to interface with secure terminals are in short supply these days.  However there may very well be some on-site for you to scavenge if you're lucky."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_OFFER_ADVICE_HEW",
    line = ccb.content.text("&You hear a click as the microphone shuts off.  After several seconds it clicks back on, someone taps the microphone twice to test it - thud thud - and then speaks: \"All I can tell you is that you may encounter extradimensional anomalies, but we cannot be certain which.  I strongly recommend you take an NRE recorder.\""),
}

-- Is it a semi-colon or colon that goes here? Man, idk.
ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_ACCEPTED",
    line = ccb.content.text("Transferring the items now.\"  The intercom tray slides open, revealing an ID card for the facility and what looks like a USB thumb drive.  \"Again: please take care not to lose either of these since we can't exactly make more of them."),
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE",
    line = ccb.content.text("As we discussed during acceptance of the contract, we were aware of hazardous ground conditions, but we were unable to deduce further information other than what was available through long-range sensing.  If you would like to provide a description of the hazards present, we are willing to document them."),
    replies = {
        {
            text = ccb.content.text("[Detail the conditions at the research facility.  This will advance time by ten minutes.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_Explainer",
            actions = { actions.handler("dlg_a_dda_d05d0c5b676b") },
        },
        {
            text = ccb.content.text("[Let them know how much of a trainwreck THIS one was.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut",
        },
        {
            text = ccb.content.text("…Just forget it.  Let's never speak of this again."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_Explainer",
    line = ccb.content.text("&Over the course of several minutes, you calmly detail the events at the facility: the unexpected zombie presence underground, the anomalous nature of the experiment floor, and the encounter with the warped and hostile research staff trapped in the corridor.  Throughout, the voice interjects with questions, the sounds of typing filling the pauses.\n\n\"We appreciate your thorough report,\" the voice finally responds.  \"Your handling of the circumstances was commendable considering the anomalous and unpredictable nature of the facility.  If you seek further contract work, rest assured, we'll take into account the potential for anomalous circumstances in future assignments and relay them accordingly.\""),
    replies = {
        {
            text = ccb.content.text("It's fine.  At least now we know for the future."),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("Yeah, yeah.  You're welcome."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Let's never do that again."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut",
    line = ccb.content.text("&The intercom waits patiently."),
    replies = {
        {
            text = ccb.content.text("Hoo boy, where do I even begin with this one?  Let's start with the fact that your intel was about as useful as a screen door on a submarine!  \"Sparsely-populated,\" my ass!  How did you lot miss the goddamn zombie mosh pit down the open elevator shaft!?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_1",
    line = ccb.content.text("We're sorry but-"),
    replies = {
        {
            text = ccb.content.text("Oh, ho ho ho ho ho no friend you do not get to talk right now.  When I FINALLY got down to the experiment floor, you know what I found?  The entire corridor was turned into a two-dimensional image!  What were they even DOING that turned an entire section of the building INTO A HAUNTED VIDEO GAME PORTAL PAINTING!?"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_2",
        },
        {
            text = ccb.content.text("[Stop talking.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_5",
        },
    },
}

-- I realize I'm assuming the player has encountered congealed light by accidentally breaking open the terrain features, but eh.
ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_2",
    line = ccb.content.text("What do you mean by-"),
    replies = {
        {
            text = ccb.content.text("I SAID SHUT UP!  It teleported me to an infinitely looping corridor!  INFINITELY!  LOOPING!  CORRIDOR!  I mean, fuck, you ever see one of those Escher paintings?  It's like that, only you don't just see the surface of what you're looking at, you see EV-ER-Y-THING, and friend let me tell you getting a first-hand look at the inside of my digestive system was *not* pretty.  Oh, and did I mention the light?  Yeah, when some of the laser tubes got broken, they spat out light THAT HURT!  A LOT!"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_3",
        },
        {
            text = ccb.content.text("[Stop talking.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_3",
    line = ccb.content.text("Please slow down-"),
    replies = {
        {
            text = ccb.content.text("You know why they got broken?  I was fighting the insane remnants of the research staff!  They were climbing the walls, spitting light!  And then there was the corridor itself somehow!  I fought the goddamn building!  I've had nightmares that made more sense than fighting that thing!"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_4",
        },
        {
            text = ccb.content.text("[Stop talking.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_4",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_4",
    line = ccb.content.text("&The voice on the other side of the intercom is silent with disbelief."),
    replies = {
        {
            text = ccb.content.text("[Wait.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut_5",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_LIXA_SM_1_COMPLETE_ChewingOut_5",
    line = ccb.content.text("Uh… Yeah, sorry.  I'll, um… I'll make a note to try and see if we can't get any better information for your future contracts."),
    replies = { { text = ccb.content.text("Good."), next_topic = "TALK_DONE" } },
}

-- Dialogue for this mission is handled externally.
ccb.content.define_mission {
    id = "MISSION_HUB01_PAY_BACK_RIOT_GEAR",
    name = ccb.content.text("Pay Back The Riot Gear to Hub 01"),
    goal = "MGOAL_NULL",
    difficulty = 1,
    value = 0,
    failure = { handler = "lose_robofac_trust_for_riot_gear" },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    deadline = { "20 days", "20 days" },
    dialogue = {
        describe = ccb.content.text("."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("."),
        inquire = ccb.content.text("."),
        success = ccb.content.text("."),
        success_lie = ccb.content.text("."),
        failure = ccb.content.text("."),
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PAY_BACK_RIOT_GEAR",
    line = ccb.content.gendered_line("Good thing you came back with the money.  Your mission work out?", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("I appreciate the credit.  I've got your payment now."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            actions = { actions.handler("dlg_a_dda_8948663cd33d"), actions.finish_mission("MISSION_HUB01_PAY_BACK_RIOT_GEAR", { success = true }) },
        },
        {
            text = ccb.content.text("I'll have to give it some thought."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PAY_BACK_RIOT_GEAR_SPECIMENS",
    line = ccb.content.text("[thanks bro this will be very interesting where's the tower?]"),
    replies = {
        {
            text = ccb.content.text("[tell them where scout tower is]"),
            actions = { actions.finish_mission("MISSION_HUB01_PAY_BACK_RIOT_GEAR", { success = true }) },
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
        {
            text = ccb.content.text("I'll have to give it some thought."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_1",
    name = ccb.content.text("Weather Permitting"),
    description = ccb.content.text("Assemble and <color_yellow>activate the 1-hour recording subroutine</color> on a <color_yellow>mobile weather station</color> during an <color_yellow>early</color>, <color_yellow>distant</color>, or <color_yellow>close portal storm</color>.  After 1 hour the station will print some sort of <color_yellow>strange weather datasheet</color> to return to Hub 01."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    finish = {
        item_rewards = { { item = "RobofacCoin", count = 4 } },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_mws_1",
            "advance_hub01_completed_missions_by_1",
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_2",
    name = ccb.content.text("System Retrieval"),
    description = ccb.content.text("Travel to the DARPA research station and find the <color_yellow>mobile hazardous environment weather station</color>.  Should I bring a swimsuit?"),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    start = {
        target = {
            terrain = "dls_small_surface",
            special = "limnological_station",
            reveal_radius = 2,
            random = true,
            search_range = 2000,
        },
    },
    finish = {
        item_rewards = { { item = "RobofacCoin", count = 8 } },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_mws_2",
            "advance_hub01_completed_missions_by_1",
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_3",
    name = ccb.content.text("Storm Chaser"),
    description = ccb.content.text("Take the <color_yellow>mobile hazardous environment weather station</color> into an <color_yellow>early</color>, <color_yellow>distant</color>, or <color_yellow>close portal storm</color>, assemble it, and start a recording.  Return the resulting <color_yellow>HEW anomalous weather printout</color> to Hub 01."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    finish = {
        item_rewards = { { item = "RobofacCoin", count = 8 } },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_mws_3",
            "advance_hub01_completed_missions_by_1",
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_4",
    name = ccb.content.text("True Weatherperson"),
    description = ccb.content.text("Record \"atmospheric\" data return a HEW datasheet to Hub 01.  They recommend scanning with the HEW system anywhere there is, or was, portal activity."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    start = { handler = "mark_dialogue_intercom_accepted_robofac_intercom_mws_4" },
    finish = {
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_mws_4",
            "advance_hub01_completed_missions_by_1",
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE",
    name = ccb.content.text("Invasive \"Meteorology\""),
    description = ccb.content.text("Go to the <color_yellow>exact underground coordinates</color>, set up a HEW station, and make a recording.  Return the <color_yellow>alien \"atmospheric\" datasheet</color> to Hub 01.  You may wish to rendezvous with the advanced field team, if you can find them."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    start = {
        target = {
            terrain = "corpse_bowels_mid",
            special = "nether_monster_corpse",
            reveal_radius = 1,
            random = false,
        },
    },
    finish = {
        item_rewards = { { item = "RobofacCoin", count = 8 } },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_mws_monster_corpse",
            "advance_hub01_completed_missions_by_1",
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}

-- Place the field team here instead of at the entrance, just incase the rare Yrax spawns.  It'd be odd for them to be in the same place.
ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_MWS_MONSTER_CORPSE_FIELD_TEAM",
    name = ccb.content.text("Invasive \"Meteorology:\" contact the field team"),
    description = ccb.content.text("A team of Hub 01 contractors is at work near the organic mass.  I can check in with them if I want to, but it isn't essential to my mission."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "corpse_surface",
    difficulty = 5,
    value = 0,
    start = {
        target = {
            terrain = "corpse_surface",
            special = "nether_monster_corpse",
            reveal_radius = 2,
            random = false,
        },
        map_updates = {
            { layout = { nested = { { x = 0, y = 0, id = "robofac_monster_corpse_field_team" } } } },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_IVAS",
    name = ccb.content.text("Augmented Reality"),
    description = ccb.content.text("The intercom has asked me to retrieve something called a <color_yellow>Military Visual Augmentation System</color>, which looks like a VR headset.  They're sending me to an in-town office to fetch it.  Use the <color_yellow>ID card</color> to gain access."),
    goal = "MGOAL_NULL",
    destination = "office_warehouse_anduril",
    difficulty = 5,
    value = 0,
    start = {
        target = {
            terrain = "office_warehouse_anduril",
            special = "office_warehouse_anduril",
            reveal_radius = 2,
            random = false,
        },
    },
    finish = {
        item_rewards = { { item = "RobofacCoin", count = 4 } },
        handler = {
            "mark_dialogue_intercom_completed_robofac_intercom_ivas",
            "advance_hub01_completed_missions_by_1",
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_CHOP_SHOP",
    name = ccb.content.text("Post-Apocalyptic IRB"),
    description = ccb.content.text("The intercom has asked me to <color_yellow>kill a rogue scientist named Dr. Harlow</color>, who they say is performing unethical experiments on live humans.  I am also authorized to use lethal force against anyone who resists, and to pillage the site."),
    goal = "MGOAL_NULL",
    destination = "robofac_strip_mall_x1y0",
    difficulty = 5,
    value = 0,
    start = {
        target = {
            terrain = "robofac_strip_mall_x1y0",
            special = "robofac_strip_mall",
            reveal_radius = 4,
            random = false,
        },
        handler = "set_world_robofac_chop_shop_scientist_1_kill_orders_to_1",
    },
    finish = {
        actions = {
            { item = "RobofacCoin", count = 4 },
            { handler = "mark_dialogue_intercom_completed_robofac_intercom_chop_shop" },
            { handler = "advance_hub01_completed_missions_by_1" },
            ccb.content.dialogue_actions.update_map("remove_robofac_mercs", "robofac_strip_mall_x0y0"),
            ccb.content.dialogue_actions.update_map("remove_robofac_mercs", "robofac_strip_mall_x1y0"),
            ccb.content.dialogue_actions.update_map("remove_robofac_mercs", "robofac_strip_mall_x2y0"),
            ccb.content.dialogue_actions.update_map("remove_robofac_mercs", "robofac_strip_mall_x3y0"),
            ccb.content.dialogue_actions.update_map("remove_robofac_mercs", "robofac_strip_mall_x4y0"),
            ccb.content.dialogue_actions.update_map("remove_robofac_mercs", "robofac_strip_mall_x0y1"),
            ccb.content.dialogue_actions.update_map("remove_robofac_mercs", "robofac_strip_mall_x1y1"),
            ccb.content.dialogue_actions.update_map("remove_robofac_mercs", "robofac_strip_mall_x2y1"),
            ccb.content.dialogue_actions.update_map("remove_robofac_mercs", "robofac_strip_mall_x3y1"),
            ccb.content.dialogue_actions.update_map("remove_robofac_mercs", "robofac_strip_mall_x4y1"),
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_ROBOFAC_INTERCOM_CIRCUIT_SAFARI",
    name = ccb.content.text("Circuit Safari"),
    description = ccb.content.text("The intercom has asked me to bring them the remains of an <color_yellow>Exodii worker</color>.  They said I can use any violent means necessary to take it down."),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 0,
    finish = {
        actions = {
            { item = "RobofacCoin", count = 4 },
            { handler = "mark_dialogue_intercom_completed_robofac_intercom_circuit_safari" },
            { handler = "advance_hub01_completed_missions_by_1" },
            { handler = "set_world_hub01_has_cbm_interface_tech_to_1" },
            { handler = "schedule_robofac_hq_ancilla_autodoc" },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}
