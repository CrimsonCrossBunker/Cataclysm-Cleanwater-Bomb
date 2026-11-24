local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_1_STARTED", "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_2_STARTED", "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_1_STARTED", "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_2_STARTED", "TALK_ROBOFAC_INTERCOM_HEW_UPGRADE_STARTED", "TALK_ROBOFAC_INTERCOM_ARMOR_STARTED", "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU", "TALK_ROBOFAC_INTERCOM_REPAIR_STARTED_LONG", "TALK_ROBOFAC_INTERCOM_REPAIR_STARTED_SHORT", "TALK_ROBOFAC_INTERCOM_RIFLE_STARTED" },
    line = ccb.content.text("What project would you like to know about?"),
    replies = {
        {
            text = ccb.content.text("Have you decoded the disk?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_BREAKTHROUGH",
            when = predicates.handler("w16b_p_dda_b48c54e1e2a9"),
        },
        {
            text = ccb.content.text("[6 HGC] I'd like to buy the rest of the armor set now."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("w16b_p_dda_51aa2fb965a7"),
            actions = { actions.handler("w16b_a_dda_64a68bf9b5df"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_can_buy_armor") },
        },
        {
            text = ccb.content.text("I'd like to request a Hybrid Weapons Platform."),
            next_topic = "TALK_ROBOFAC_INTERCOM_RIFLE_REQUEST",
            when = predicates.handler("w16b_p_dda_f21d2511f384"),
        },
        {
            text = ccb.content.text("How goes work on the HWP?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RIFLE_BREAKTHROUGH",
            when = predicates.handler("w16b_p_dda_24d90ed9d882"),
        },
        {
            text = ccb.content.text("I'd like to request a set of armor."),
            next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_REQUEST",
            when = predicates.handler("w16b_p_dda_f21d2511f384"),
        },
        {
            text = ccb.content.text("How is my ordered armor going?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_FINISHED",
            when = predicates.handler("w16b_p_dda_690ac67f75b5"),
        },
        {
            text = ccb.content.text("I would like you to upgrade my modular defense system."),
            next_topic = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_2",
            when = predicates.handler("w16b_p_dda_bfd9d51e57e1"),
        },
        {
            text = ccb.content.text("I would like you to make the hazardous materials prototype."),
            next_topic = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_2",
            when = predicates.handler("w16b_p_dda_3c717f06f9ce"),
        },
        {
            text = ccb.content.text("My phase immersion suit has taken a serious beating.  Could someone repair it for me?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PHASE_REPAIR",
            when = predicates.handler("w16b_p_dda_a6e0a06374ab"),
        },
        {
            text = ccb.content.text("My RM13 combat armor has taken some damage.  Could someone repair it for me?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RM13_REPAIR",
            when = predicates.handler("w16b_p_dda_be11e37ce5f8"),
        },
        {
            text = ccb.content.text("I salvaged this combat exoskeleton.  Do you think you could repair it?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_EXOSKELETON_REPAIR",
            when = predicates.handler("w16b_p_dda_2db687ba25ae"),
        },
        {
            text = ccb.content.text("My hazardous materials suit has taken a damage.  Could someone repair it for me?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_REPAIR",
            when = predicates.handler("w16b_p_dda_8434301dc662"),
        },
        {
            text = ccb.content.text("How are my armor repairs coming?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_REPAIR",
            when = predicates.any({ predicates.any_equal({ "combat_exoskeleton_light_salvaged", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }), predicates.any_equal({ "phase_immersion_suit", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }), predicates.any_equal({ "rm13_armor", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }), predicates.any_equal({ "resonance_suit", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }) }),
        },
        {
            text = ccb.content.text("I've found this piece of XEDRA tech; it seems to offer some kind of protection.  I'm curious what you all can make of it."),
            next_topic = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_1",
            when = predicates.handler("w16b_p_dda_4c3b44384355"),
        },
        {
            text = ccb.content.text("Any progress on the anchor?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_1_COMPLETE",
            when = predicates.any_equal({ "anchor_pt_1", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }),
        },
        {
            text = ccb.content.text("Any progress on the Hub anchor?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_2_COMPLETE",
            when = predicates.any_equal({ "anchor_pt_2", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }),
        },
        {
            text = ccb.content.text("I've found this odd XEDRA cleansuit.  I'm curious what you all can make of it."),
            next_topic = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_1",
            when = predicates.handler("w16b_p_dda_11f1425194b0"),
        },
        {
            text = ccb.content.text("Any progress on the cleansuit?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_1_COMPLETE",
            when = predicates.any_equal({ "resonance_suit_pt_1", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }),
        },
        {
            text = ccb.content.text("Any progress on the new prototype environment suit?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_2_COMPLETE",
            when = predicates.any_equal({ "resonance_suit_pt_2", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }),
        },
        {
            text = ccb.content.text("You mentioned you could improve my HEW system.  Can you tell me more?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_HEW_UPGRADE",
            when = predicates.handler("w16b_p_dda_c54cbad21301"),
        },
        {
            text = ccb.content.text("Any progress on the HEW-NRE system?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_HEW_UPGRADE_COMPLETE",
            when = predicates.any_equal({ "hew_upgrade", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }),
        },
        {
            text = ccb.content.text("Any progress on that AR headset?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_IVAS_COMPLETE",
            when = predicates.any_equal({ "ivas", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }),
        },
        {
            text = ccb.content.text("I've found a rifle chambered for a caliber I don't recognize.  Do you think you could make an HWP adapter for it?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_HWP_EXODII",
            when = predicates.handler("w16b_p_dda_bb9ae721a5aa"),
        },
        {
            text = ccb.content.text("Have you finished work on that exotic conversion kit?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_COMPLETE",
            when = predicates.any_equal({ "hwp_exodii", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_NO",
    line = ccb.content.text("At the moment, no.  While you are no doubt proficient, distribution of prototype equipment is so far restricted to trusted field agents.  Were someone else from the organization to vouch for your competency, we may consider extending access."),
}

-- quick access to prototype menu through the merc vouching
ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_GUN_YES",
    line = ccb.content.text("Yes, Foster gave you quite a recommendation.  Very well - I will authorize you access to our prototype fabrication services for agents in the field.  This includes the Hybrid Weapons Platform, alongside the ability to order spare or replacement parts for your field gear."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_intercom_u_hub_prototypes", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Great.  What exactly is this 'Hybrid Weapons Platform', anyway?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RIFLE_REQUEST",
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RIFLE_BREAKTHROUGH",
    line = {
        when = predicates.handler("dlg_p_dda_b386bedc4d2b"),
        yes = ccb.content.text("The Platform is complete.  As a reminder, the HWP will not function as a weapon without a conversion kit installed.  Transferring the requested items now.\"\n\nThe tray shakes as several heavy objects are dropped into it, and it slides open.  Inside: the Hybrid Weapons Platform.  On its own, it doesn't look like much; it resembles the body of a service rifle without a stock or barrel, colored in sleek black with blue highlights around the magazine well.  Small yellow arrows and inscriptions are present at certain points, highlighting the fasteners used to assemble the thing in earnest.  Accompanying the Platform itself is a series of four bundles of parts for it, each held together using velcro strips and tagged by caliber.  A drawstring nylon bag, embroidered with the Hub's logo and filled with proprietary tools, completes the whole package.\n\nAll in all, not a bad deal.\n\n\"Should you require magazines of any given caliber, we are willing to provide them through standard requisitions.  We hope you find its performance to be satisfactory."),
        no = ccb.content.text("Work is still ongoing.  These things can take time."),
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_b386bedc4d2b"),
            actions = { actions.set_actor_value("speaker", "dialogue_hub_rnd_u_has_researched_gun", "yes"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing"), actions.clear_actor_value("speaker", "timer_hub_rnd_u_waiting_on_gun"), actions.handler("dlg_a_dda_390efe4feee0") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_RIFLE_REQUEST", "TALK_ROBOFAC_INTERCOM_RIFLE_ADAPTERS", "TALK_ROBOFAC_INTERCOM_RIFLE_TIMEGATE", "TALK_ROBOFAC_INTERCOM_RIFLE_BENEFITS" },
    line = ccb.content.text("I'll spare you the marketing pitch.  The Hybrid Weapons Platform - or more commonly the HWP - is a weapons platform capable of supporting multiple calibers via the use of quick-release adapters.  On its own, the platform does nothing; each adapter, however, allows it to chamber and fire a different type of round.\"\n\n\"Each new HWP is printed to order.  Materials will require eight HGC up front, and fabrication will take seven days."),
    replies = {
        {
            text = ccb.content.text("[8 HGC] A week is fine."),
            next_topic = "TALK_ROBOFAC_INTERCOM_RIFLE_STARTED",
            when = predicates.has_inventory("speaker", "RobofacCoin", 8),
            actions = { actions.handler("dlg_a_dda_8948663cd33d"), actions.adjust_faction_trust(2), actions.handler("dlg_a_dda_3b89db9308f4"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes") },
        },
        {
            text = ccb.content.text("Tell me about the adapters.  Does it come with any?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RIFLE_ADAPTERS",
        },
        {
            text = ccb.content.text("A week feels like an eternity these days.  Why the wait?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RIFLE_TIMEGATE",
        },
        {
            text = ccb.content.text("Why should I use this over something like a rifle that doesn't need proprietary parts?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RIFLE_BENEFITS",
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RIFLE_ADAPTERS",
    line = ccb.content.text("Adapters are standalone conversion kits, and can be swapped in the field without any tools, though it will take a minute or so.  The factory standard includes adapters for the following calibers… 5.56 NATO, 7.62 NATO, 9mm Parabellum, and 12-gauge shotshell.  Two loaded magazines are also provided for each of these calibers, and additional empty magazines can be purchased through trade.  A maintenance kit with the necessary tools to service the Platform is also provided."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RIFLE_TIMEGATE",
    line = ccb.content.text("As before, each Platform is made to order.  This is a slow process for several reasons.  First, the parts must be printed to spec; this takes a great degree of precision, and so the process is lengthy.  The remainder of the week is spent running reliability tests as each conversion kit finishes production.  I understand that it isn't an ideal option, but I believe the quality of the product is worth that investment."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RIFLE_BENEFITS",
    line = ccb.content.text("I believe the answer to that question to be twofold.  First, a maintenance kit is included with each new Platform that includes the tools required to service it, including a diagram of the weapon's construction.  Second, even if you would prefer to use the weapon only for a specific purpose, we are able to manufacture and provide high-capacity drum magazines far exceeding the capacity of widely-available analogues.  We expect this to be a significant boon to your ability to use the Platform in a variety of environments and situations, as high-capacity magazines can be difficult or dangerous to find in the new world."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RIFLE_STARTED",
    line = ccb.content.text("Excellent.  Report back in seven days' time, and your Platform will be ready."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ARMOR_STARTED",
    line = ccb.content.text("Excellent.  We will begin work shortly.  Report back in 24 hours for pickup."),
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ARMOR_BREAKTHROUGH",
    line = {
        when = predicates.handler("w16b_p_dda_1a48db796a76"),
        yes = ccb.content.text("Yes we have!  The disk contained the configuration necessary to print our armors with a much more resilient composite than was previously available to us, without sacrificing any maneuverability.  As a form of payment, we are willing to provide you with the first functional models of the armor at a good price - six HGC.  While that may seem steep, the materials used are very high-end, and six coins just barely covers the production cost alone.  If you are unwilling or incapable of filling that price now, the offer will remain available indefinitely - just let us know when you'd like it.\"\n\n\"Should you find anything else of interest in the world, please bring it to us.  We would be happy to collaborate like this again in the future."),
        no = ccb.content.text("Not yet.  The contents are very strongly encrypted, so simply pulling the data is impossible.  Work is underway to deduce the correct access key, but even with our facilities, it will take some time."),
    },
    on_enter = {
        { when = predicates.handler("w16b_p_dda_1a48db796a76"), actions = { actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_can_buy_armor", "yes"), actions.handler("w16b_a_dda_b5a2696d95dd") } },
    },
    replies = {
        {
            text = ccb.content.text("[6 HGC] Let's see what this armor is capable of."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("w16b_p_dda_7ece59ddc907"),
            actions = { actions.handler("w16b_a_dda_64a68bf9b5df") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ARMOR_FINISHED",
    line = {
        when = predicates.handler("w16b_p_dda_55a9c64ca06c"),
        yes = ccb.content.text("Yes, we've finished printing the requested armor pieces.  Transferring to you now."),
        no = ccb.content.text("The parts are still being printed.  Please be patient."),
    },
    replies = {
        {
            text = ccb.content.text("Sweet, thanks."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("w16b_p_dda_55a9c64ca06c"),
            actions = { actions.handler("w16b_a_dda_b6833dfd9ade"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_armor_type"), actions.clear_actor_value("speaker", "timer_hub_rnd_u_waiting_on_hub") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_REPAIR_STARTED_SHORT",
    line = ccb.content.text("We will begin work shortly.  Report back in two weeks for pickup."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_REPAIR_STARTED_LONG",
    line = ccb.content.text("We will begin work shortly.  Report back in around one and a half months for pickup."),
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_1_STARTED",
    line = ccb.content.text("Lovely.  Research will begin within the next few hours."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_2_STARTED",
    line = ccb.content.text("The combination should be a fairly simple matter.  Return in two days to pick up the finished product."),
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_1_STARTED",
    line = ccb.content.text("Research will begin within the next few hours."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_2_STARTED",
    line = ccb.content.text("Return in two days to pick up the finished product."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_HEW_UPGRADE",
    line = ccb.content.text("Yes.  For the cost of three HGC we can begin R&D to incorporate your NRE recorder.  You'll need to provide the HEW and your NRE recorder.  R&D will take one working week."),
    replies = {
        {
            text = ccb.content.text("[3 HGC, HEW, NRE] See you in five days."),
            next_topic = "TALK_ROBOFAC_INTERCOM_HEW_UPGRADE_STARTED",
            when = predicates.all({ predicates.has_inventory("speaker", "RobofacCoin", 3), predicates.has_inventory("speaker", "xedra_mobile_weather_station", 1), predicates.has_inventory("speaker", "nre_recorder", 1) }),
            actions = { actions.handler("dlg_a_dda_51de27d579cc"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_1f0e3eeb9ce5"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_current_project", "hew_upgrade") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_HEW_UPGRADE_STARTED",
    line = ccb.content.text("Lovely.  Research will begin within the next few hours."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_HEW_UPGRADE_COMPLETE",
    line = {
        when = predicates.handler("dlg_p_dda_479e16cc31b2"),
        yes = ccb.content.text("The NRE has been integrated into the HEW."),
        no = ccb.content.text("Work is still ongoing."),
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_479e16cc31b2"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_current_project"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing"), actions.clear_actor_value("speaker", "timer_hub_rnd_u_waiting_on_hub"), actions.handler("dlg_a_dda_26411ca6123b") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_IVAS_COMPLETE",
    line = {
        when = predicates.handler("dlg_p_dda_479e16cc31b2"),
        yes = ccb.content.text("We've reverse engineered the headset and were able to 'trim the fat,' so to speak, as a good deal of the internals were dedicated to GPS and other non-functional devices.  We've been able to produce a superior in-house version and have integrated it into our standard recon helmet.  We ask that you keep detailed notes on its function for us.  If you die, we will send a field team to retrieve it, so please don't damage it."),
        no = ccb.content.text("Work is still ongoing."),
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_479e16cc31b2"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_current_project"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing"), actions.clear_actor_value("speaker", "timer_hub_rnd_u_waiting_on_hub"), actions.handler("dlg_a_dda_3f4de49eb783") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_HWP_EXODII", "TALK_ROBOFAC_INTERCOM_HWP_EXODII_1", "TALK_ROBOFAC_INTERCOM_HWP_EXODII_2" },
    line = ccb.content.text("Excuse me for a moment.\"  The intercom turns off abruptly.  It comes back on after roughly a minute, and when it speaks again, another voice is on the other side, speaking carefully.\n\n\"Yes… the Exodii.  We have yet to make contact, but we are keenly interested in their capabilities and technology.  If you were to provide us with, say, five rounds, in addition to the rifle itself and a magazine suitable for it, we believe we would be able to replicate the parts.  We expect it to take three days of research.\"\n\n\"Please note that the requested materials will not be returned, as they are likely to be damaged during research."),
    replies = {
        {
            text = ccb.content.text("[5 12.3ln, PA md. 68 magazine, PA md. 68] Is this what you need?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_STARTED",
            when = predicates.all({ predicates.has_inventory("speaker", "pamd68", 1), predicates.has_inventory("speaker", "exodiiBRmag", 1), predicates.has_inventory("speaker", "123ln", 5) }),
            actions = { actions.handler("dlg_a_dda_851bba12780b") },
        },
        {
            text = ccb.content.text("[5 12.3ln, PS md. 71z magazine, PS md. 71z] Is this what you need?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_STARTED",
            when = predicates.all({ predicates.has_inventory("speaker", "pamd71z", 1), predicates.has_inventory("speaker", "exodiiminimag", 1), predicates.has_inventory("speaker", "123ln", 5) }),
            actions = { actions.handler("dlg_a_dda_4b2a0f82b77b") },
        },
        {
            text = ccb.content.text("Why not contact them directly?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_1",
            when = predicates.handler("dlg_p_dda_2271d9d05c70"),
        },
        {
            text = ccb.content.text("I've met them already.  They seem friendly; if you'd like to reach out to them yourself, I'm sure that they could help."),
            next_topic = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_2",
            when = predicates.handler("dlg_p_dda_87d61a034b3e"),
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_1",
    line = ccb.content.text("While the Exodii seem benign, our experience with extradimensional life thus far has been… unpleasant, shall we say, given the current state of the world.  We find it wise to approach with an abundance of caution.  We are incapable of knowing the true agenda and capabilities of this group, and we believe that understanding some degree of how they operate will allow us to make contact in a more educated way."),
}

-- this is a lie. if the hub has done any kind of surveillance at all, they'd know that the Exodii would consider melchior a heavy threat, and they are unwilling to approach until they're certain that they could effectively conceal its presence.
ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_2",
    line = ccb.content.text("Have you, now?  We are pleased to hear.  However, we still believe that approaching with an excess of wariness is a wise choice.  We feel that it would behoove us to understand more about this group before we approach directly, and so for the time being, understanding more about their general-use technology is our preferred course of action."),
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_HWP_EXODII_STARTED" },
    line = ccb.content.text("Brilliant!!  Just brilliant.  Thank you very much.  Please contact us again in three days.  Thank you!\"\n\nThe voice abruptly disconnects.  When the intercom comes back on, it's the original voice again.  \"Was there anything else?"),
    on_enter = {
        { once = "started_exodii_gun_research", actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_1f0e3eeb9ce5"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing", "yes"), actions.set_actor_value("speaker", "dialogue_hub_rnd_u_current_project", "hwp_exodii") } },
    },
    replies = {
        {
            text = ccb.content.text("You seem very… excited about this."),
            next_topic = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_STARTED_1",
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}

-- this is a half-truth. while the Hub does have an interest in understanding or reversing the Cataclysm, their primary intent here is specifically to understand the Exodii better.
ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_STARTED_1",
    line = ccb.content.text("The Cataclysm has illuminated hitherto unknown facts about our universe.  The opportunity to research - and perhaps understand - technology from not only another world, but another dimension entirely, is an exceptionally promising field of study.  Now more than ever is our continued delving into this field of study paramount; while our focus has shifted rather abruptly, we believe that if there is ever any chance of understanding or even reversing <the_cataclysm>, it would come from studies like this."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
        { text = ccb.content.text("I'll check in later."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_COMPLETE",
    line = {
        when = predicates.handler("dlg_p_dda_f6a45ea987e4"),
        yes = ccb.content.text("The project was a success!  The ammo is fairly rudimentary, but ultimately proved simple to manufacture, and has lent itself well to large magazines.  We will transfer a copy of the conversion kit in a moment; it is capable of accepting specialized magazines that we have just begun to produce ourselves.  Thank you for allowing us this opportunity."),
        no = ccb.content.text("Work is still ongoing.  These things can take time."),
    },
    on_enter = {
        { when = predicates.handler("dlg_p_dda_f6a45ea987e4"), actions = { actions.handler("dlg_a_dda_3e7802f824a8") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_f6a45ea987e4"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_current_project"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_project_ongoing"), actions.clear_actor_value("speaker", "timer_hub_rnd_u_waiting_on_hub"), actions.handler("dlg_a_dda_7bdb5baa184c") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU",
        },
    },
}
