local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "ancilla_doctor",
    unique_name = ccb.content.text("Doc.  Stevens"),
    gender = "male",
    class = "NC_ANCILLA_DOCTOR",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_ANCILLA_DOCTOR",
    faction = "no_faction",
}

ccb.content.define_npc_class {
    id = "NC_ANCILLA_DOCTOR",
    name = ccb.content.text("Ancilla Doctor"),
    job_description = ccb.content.text("I try to keep this gang in one piece.  It's a full time job."),
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    intelligence = { rng = { 3, 5 } },
    worn = "NC_ANCILLA_DOCTOR_worn",
    carry = "NC_ANCILLA_BARKEEP_carry",
    weapon = "NC_ANCILLA_BARKEEP_wield",
    shop_groups = {
        { id = "NC_ANCILLA_DOCTOR_stock", rigid = true },
        {
            id = "NC_ANCILLA_DOCTOR_bionics",
            rigid = true,
            strict = true,
            condition_handler = "ancilla_bionics_unlocked",
        },
        {
            id = "NC_ANCILLA_DOCTOR_bionics_LENS",
            rigid = true,
            strict = true,
            condition_handler = "ancilla_bionics_lenses_unlocked",
        },
    },
    price_rules = {
        { group = "NC_ANCILLA_DOCTOR_stock", premium = 2.0 },
        { group = "NC_ANCILLA_DOCTOR_EXPENSIVE_ITEMS", premium = 6.0 },
        { item = "RobofacCoin", price = 5000, fixed_adjustment = 0 },
    },
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "firstaid", bonus = 7 },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR",
    line = {
        when = predicates.handler("dlg_p_dda_2e6ab3005522"),
        yes = ccb.content.text("Oh, what can I do for you today?"),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_ancilla_doctor_first_meet" } }),
            yes = {
                choices = {
                    ccb.content.text("Try not to touch anything.  Keeping this place clean is a full time job."),
                    ccb.content.gendered_line("I'm free at the moment if you need something.", { "interlocutor" }),
                    ccb.content.text("Did you know you can lose a medical license over tax fraud?  Couldn't be me."),
                    ccb.content.text("You try to use the autodoc alone and I'll let it carve you up.  I'm not kidding."),
                },
            },
            no = ccb.content.text("Clinic is open, yes.  If you need medical assistance, I'm your man."),
        },
    },
    on_enter = {
        { once = "ancilla_doctor_meet", actions = { actions.set_actor_value("speaker", "dialogue_ancilla_doctor_first_meet", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("I'm <u_name>.  I was told to see you about field-testing the new cybernetics."),
            next_topic = "TALK_ANCILLA_DOCTOR_INSTALL_INTERFACE_REWARD_A",
            when = predicates.handler("dlg_p_dda_017a226b8b3c"),
        },
        {
            text = ccb.content.text("I'm <u_name>.  I was told to see you about replacing my CBM interface with the updated Hub 01 interface."),
            next_topic = "TALK_ANCILLA_DOCTOR_INSTALL_INTERFACE_REWARD_B",
            when = predicates.handler("dlg_p_dda_71404101a080"),
        },
        {
            text = ccb.content.text("What services do you offer?"),
            next_topic = "TALK_ANCILLA_DOCTOR_SERVICES",
        },
        {
            text = ccb.content.text("Could you help me with some bionics?"),
            next_topic = "TALK_ANCILLA_DOCTOR_BIONICS",
            when = predicates.any({ predicates.has_trait("speaker", "Hub01_CBM_Interface"), predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC") }),
        },
        {
            text = ccb.content.text("So… believe it or not, I've swapped my bionic interfaces.  Let's say I wanted you to swap them again, in favor of a new Hub 01 interface.  What's that gonna cost me?"),
            next_topic = "TALK_ANCILLA_DOCTOR_SWAP_INTERFACE_AGAIN",
            when = predicates.all({ predicates.has_trait("speaker", "CBM_Interface_brain_lesion"), predicates.has_trait("speaker", "CBM_Interface"), predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")) }),
        },
        {
            text = ccb.content.text("I HAVE A MINOR BRAIN LESION AND NO CBM INTERFACE, WHICH SHOULDN'T BE POSSIBLE!  [IF YOU SEE THIS OPTION IN A NORMAL GAME PLEASE FILE A BUG REPORT]"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.has_trait("speaker", "CBM_Interface_brain_lesion"), predicates.negate(predicates.has_trait("speaker", "CBM_Interface")), predicates.negate(predicates.has_trait("speaker", "Hub01_CBM_Interface")) }),
        },
        {
            text = ccb.content.text("I could use your medical assistance."),
            next_topic = "TALK_ANCILLA_DOCTOR_AID",
        },
        {
            text = ccb.content.text("I need to trade some medical supplies."),
            next_topic = "TALK_ANCILLA_DOCTOR",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Is there anything I can help you with?"),
            next_topic = "TALK_ANCILLA_DOCTOR_WORK",
        },
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_SERVICES",
    line = {
        when = predicates.has_trait("speaker", "Hub01_CBM_Interface"),
        yes = ccb.content.text("Primarily I run the new Hub 01 automated medical suite.  DON'T touch the machine.  You might lose a finger.  Or worse.  In any case, I can offer medical services in exchange for HGC, and can trade you medical supplies.  As you know, I'm also the field coordinator for the Cybernetic Enhancements Program.  Cool, huh?  Anyway, since you already have an interface, I can install, remove, and repair cybernetics.  The Hub has promised to sometimes provide supplies, so keep an eye on my stock."),
        no = ccb.content.text("Primarily I run the new Hub 01 automated medical suite.  DON'T touch the machine.  You might lose a finger.  Or worse.  In any case, I can offer medical services in exchange for HGC, and can trade you medical supplies.  We are also accepting applications for the cutting-edge Hub 01 Cybernetic Enhancements Program, if you're interested."),
    },
    replies = {
        {
            text = ccb.content.text("<fcl_doctor_new_interface>"),
            false_text = ccb.content.text("What?!  Seriously?  Cybernetics?  Tell me more!"),
            text_when = predicates.handler("dlg_p_dda_d292f701cba7"),
            next_topic = "TALK_ANCILLA_DOCTOR_CYBERNETICS_INFO",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "Hub01_CBM_Interface")), predicates.negate(predicates.has_trait("speaker", "CBM_Interface_brain_lesion")), predicates.negate(predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC")) }),
        },
        {
            text = ccb.content.text("Actually, I'm <u_name>.  I was told to see you about field-testing the new cybernetics."),
            next_topic = "TALK_ANCILLA_DOCTOR_INSTALL_INTERFACE_REWARD_A",
            when = predicates.handler("dlg_p_dda_73e629c1159d"),
        },
        {
            text = ccb.content.text("Actually, I'm <u_name>.  I was told to see you about replacing my CBM interface with the updated Hub 01 interface."),
            next_topic = "TALK_ANCILLA_DOCTOR_INSTALL_INTERFACE_REWARD_B",
            when = predicates.handler("dlg_p_dda_cf7380580dbd"),
        },
        {
            text = ccb.content.text("Okay, thanks."),
            next_topic = "TALK_ANCILLA_DOCTOR",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_CYBERNETICS_INFO",
    line = ccb.content.text("&The Doc cracks a wry grin.  \"Yup, believe it or not, motherfucker, we can soup you up with some metal and plastic and turn you into a Terminator.  Well, theoretically.  Need the implants, which we're short on.  In any case, Hub 01 graciously provides us all the tech and some supplies.  So, for a DISCOUNTED fee of 20 HGCs, I can install a bionic interface in your brain - totally safe, mind you - and fit you with a power supply, a battery compartment to keep it charged, and an integrated two-way radio.  Crazy shit, huh?\""),
    replies = {
        {
            text = ccb.content.text("Actually, I'm <u_name>.  I was told to see you about field-testing the new cybernetics."),
            next_topic = "TALK_ANCILLA_DOCTOR_INSTALL_INTERFACE_REWARD_A",
            when = predicates.handler("dlg_p_dda_ddc54381dd18"),
        },
        {
            text = ccb.content.text("Actually, I'm <u_name>.  I was told to see you about replacing my CBM interface with the updated Hub 01 interface."),
            next_topic = "TALK_ANCILLA_DOCTOR_INSTALL_INTERFACE_REWARD_B",
            when = predicates.handler("dlg_p_dda_15f8651f5dcf"),
        },
        {
            text = ccb.content.text("[20 HGC - Install Hub 01 CBM interface]  Twenty HGC to turn me into a cyborg?  Let's do it."),
            next_topic = "TALK_ANCILLA_DOCTOR_INSTALLED_HUB01_INTERFACE",
            when = predicates.all({ predicates.has_inventory("speaker", "RobofacCoin", 20), predicates.negate(predicates.has_flag("speaker", "NO_CBM_INSTALLATION")) }),
            actions = { actions.handler("dlg_a_dda_41fa82e14390"), actions.add_effect("speaker", "narcosis", { turns = 7200 }), actions.add_effect("speaker", "sleep", { turns = 7200 }), actions.handler("dlg_a_dda_24c42f18ee3c"), actions.replace_mutation("speaker", "Hub01_CBM_Interface"), actions.handler("dlg_a_dda_5e6f32226d3b") },
        },
        {
            text = ccb.content.text("Maybe later.  Let's talk about something else."),
            next_topic = "TALK_ANCILLA_DOCTOR",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_INSTALL_INTERFACE_REWARD_A",
    line = ccb.content.text("Right, they told me about you.  I guess we owe a lot of this to your efforts, yeah?  So, we can soup you up with some metal and plastic and turn you into a Terminator.  Well, theoretically.  Need the implants, which we're short on.  In any case, Hub 01 graciously provides us all the tech and some supplies.  For you?  No charge.  I can install a bionic interface in your brain - totally safe, mind you - and fit you with a power supply, a battery compartment, and an integrated commlink.  Crazy shit, huh?\""),
    replies = {
        {
            text = ccb.content.text("[Install Hub 01 CBM interface]  Turn me into a cyborg?  For free?  Let's do it."),
            next_topic = "TALK_ANCILLA_DOCTOR_INSTALLED_HUB01_INTERFACE",
            actions = { actions.handler("dlg_a_dda_41fa82e14390"), actions.add_effect("speaker", "narcosis", { turns = 7200 }), actions.add_effect("speaker", "sleep", { turns = 7200 }), actions.handler("dlg_a_dda_24c42f18ee3c"), actions.replace_mutation("speaker", "Hub01_CBM_Interface"), actions.handler("dlg_a_dda_98f3b3c746be") },
        },
        {
            text = ccb.content.text("Maybe later.  Let's talk about something else."),
            next_topic = "TALK_ANCILLA_DOCTOR",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_INSTALL_INTERFACE_REWARD_B",
    line = ccb.content.text("Right, they told me about you.  I guess you know the drill and how these things work.  I'll use the machine to take out that hostile Exodii tech, install the upgraded Hub 01 unit, and top you up with some extra power, a battery compartment, and a commlink, if you don't have those already.  The new interface is backwards compatible with the Exodii bionics, so no worries there.  I've been given 10 HGC to pay YOU for the Exodii interface scrap.  Remember, the Hub keeping your old interface is a condition for the surgery, and that old thing would've given you cancer, anyway.  So, good riddance, yeah?  You ready?\""),
    replies = {
        {
            text = ccb.content.text("[Exchange your current CBM interface for the Hub 01 CBM interface and 10 HGC]  Let's do it."),
            next_topic = "TALK_ANCILLA_DOCTOR_INSTALLED_HUB01_INTERFACE",
            actions = { actions.handler("dlg_a_dda_e0dc47445c10"), actions.add_effect("speaker", "narcosis", { turns = 7200 }), actions.add_effect("speaker", "sleep", { turns = 7200 }), actions.handler("dlg_a_dda_23c9930d5b44"), actions.replace_mutation("speaker", "Hub01_CBM_Interface"), actions.replace_mutation("speaker", "CBM_Interface_brain_lesion"), actions.handler("dlg_a_dda_ae248b091eef") },
        },
        {
            text = ccb.content.text("Maybe later.  Let's talk about something else."),
            next_topic = "TALK_ANCILLA_DOCTOR",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_INSTALLED_HUB01_INTERFACE",
    line = {
        when = predicates.handler("dlg_p_dda_6293b1c7fa21"),
        yes = ccb.content.text("&The Doc lays you down on the bed and tells you not to move - you're all too familiar with this process, having done it with the Exodii already.  You close your eyes and relax.  In an instant you wake up, now resting in a silent room.\n\nYou reach behind your ear and feel a bandage - underneath is a small metal port, and your fingers can make out several bumps that feel like USB connections.  The doctor sees you and grins.\n\n\"Ah, great, you're up.  All done.  Quite the cyborg already, weren't we?  No worries.  Doc Stevens Junior over here got that old, obsolete tech out without a problem.  The new stuff is ready to go, with the fresh upgrades to boot.  If we get any new implants from the Hub, you'll be free to come by and buy them.  Otherwise, happy to install any you can scavenge from those killer robots.  Just make sure they're packaged and sterile.\""),
        no = ccb.content.text("&The Doc lays you down on the bed and tells you not to move.  The last thing you see is the robotic arm of the device slowly descend toward your neck.  A syringe full of some liquid is then plunged into your skin, and you wake up, resting in a silent room.\n\nYou reach behind your ear and feel a bandage - underneath is a small metal port, and your fingers can make out several bumps that feel like USB connections.  The doctor sees you and grins.\n\n\"Ah, great, you're up.  All done.  If we get any new implants from the Hub, you'll be free to come by and buy them.  Otherwise, happy to install any you can scavenge from those killer robots.  Just make sure they're packaged and sterile.\""),
    },
    replies = {
        {
            text = ccb.content.text("Feels about the same.  Thanks, Doc."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_6293b1c7fa21"),
        },
        {
            text = ccb.content.text("I'm a cyborg now?  Doesn't feel too much different.  Guess I should go experiment with whatever the hell you did to me.  Thanks, I guess."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_6291656cdf4e"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_SWAP_INTERFACE_AGAIN",
    line = ccb.content.text("…you what?  Seriously?  I mean, yeah, I can do it again.  But look, I'll give it to you straight:  your brain isn't gonna be the same after.  I'm not even sure you'll live.  I'll tell you what… I'll discount it to 10 HGCs, but I get to keep your shit if you die.  Deal?"),
    replies = {
        {
            text = ccb.content.text("[10 HGC - swap CBM interfaces - MAJOR RISK OF BRAIN DAMAGE]  It's worth the risk.  Swap them!"),
            next_topic = "TALK_ANCILLA_DOCTOR_SWAPPED_INTERFACE_AGAIN",
            when = predicates.has_inventory("speaker", "RobofacCoin", 10),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 7200 }), actions.add_effect("speaker", "sleep", { turns = 7200 }), actions.handler("dlg_a_dda_bc4b9c66e736"), actions.replace_mutation("speaker", "Hub01_CBM_Interface"), actions.replace_mutation("speaker", "CBM_Interface_brain_lesion_2"), actions.handler("dlg_a_dda_41d893b6e4fb") },
        },
        {
            text = ccb.content.text("Maybe later.  Let's talk about something else."),
            next_topic = "TALK_ANCILLA_DOCTOR",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_SWAPPED_INTERFACE_AGAIN",
    line = ccb.content.text("&Everything after that moment is a blur in your memory.  You wake up.  For a moment, you're back in your bed.  Was the cataclysm all a dream?  Then you look around, and see Doc Stevens.  You come to your senses."),
    replies = {
        {
            text = ccb.content.text("Well, I feel pretty much the same.  Seems like there weren't any complications!"),
            next_topic = "TALK_ANCILLA_DOCTOR_SWAPPED_INTERFACE_AGAIN_2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_SWAPPED_INTERFACE_AGAIN_2",
    line = ccb.content.text("&Doc Stevens stares at you confusedly.  Then he squints at you.  Then he just shrugs his shoulders.  \"Yeah, what you said… same for me.  I think.\"  Then the doctor's eyes go wide and he raises his eyebrows.  He takes a sharp breath.  Then he turns and walks away."),
    replies = { { text = ccb.content.text("…What?"), next_topic = "TALK_DONE" } },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BIONICS_DONE",
    line = {
        choices = {
            ccb.content.text("Now some protocol tests for brain damage.  Please stare at the light over there…"),
            ccb.content.text("It might take some days for your nervous system to adapt.  Come back if you experience any concerning symptoms like…"),
            ccb.content.text("I suggest you take it easy for a few days now."),
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_AID_DONE",
    line = {
        choices = {
            ccb.content.text("Take it easy now, or come back soon.  All the same to me."),
            ccb.content.gendered_line("Now try not to do whatever you did again.  No, don't tell me more.", { "speaker" }),
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_WORK",
    line = ccb.content.text("It takes resources to keep this show running: disinfectant, antibiotics, anesthetics, so on.  I'll give you a great price if you bring any of those."),
    replies = { { text = ccb.content.text("I'll keep that in mind."), next_topic = "TALK_ANCILLA_DOCTOR" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BIONICS_BIONIC_LIMB_INTRO",
    line = ccb.content.text("That's right.\"  The doctor pulls out a vacuum-sealed package containing what is clearly a high-tech prosthetic arm, not too unlike those you saw before the Cataclysm.\n\n\"That annoying prick across the street has made some progress on those killer robots, I guess, and we figured out a way to improve standard prosthetics.  Missing limbs seems to be increasingly common.  Anyway, it's not superhuman stuff like some of these bionics, but it'll function like a normal limb, as long as you can keep it powered.  The benefit over the old-school stuff is the power, and that you control them with your neurobionic interface, and thus your brain, yeah?  So you may not be stronger or faster, but hey, at least your muscles won't get tired as easy.  Because you don't have'em!  Hah!"),
    replies = {
        {
            text = ccb.content.text("I'll keep that in mind in case I lose a limb.  See you around."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Actually… could you just cut off one of my limbs and install one of those instead?"),
            next_topic = "TALK_ANCILLA_DOCTOR_BIONICS_BIONIC_LIMB_PROPOSE_SWAP",
            actions = {
                actions.set_actor_value("speaker", "dialogue_ancilla_doctor_u_asked_about_swapping_limbs", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BIONICS_BIONIC_LIMB_PROPOSE_SWAP",
    line = ccb.content.text("&The Doc stares at you confusedly.  \"Give me a second.\"\n\nThe Doc pulls out a two-way radio and steps out of the room and down the hall.  They're gone for several minutes before they return, setting the radio down on the table.\n\n\"Well, I talked to the bosses, and yup, we're a go.  In fact, I've been authorized to give you a discount.  You'll be the first of the new Cybernetic Limb Enhancement Program, yeah?"),
    replies = {
        {
            text = ccb.content.text("Alright, let's talk about limb replacement."),
            next_topic = "TALK_ANCILLA_DOCTOR_BIONICS_BIONIC_LIMB_REPLACEMENT_1",
        },
        {
            text = ccb.content.text("I'll keep that in mind.  See you around."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BIONICS_BIONIC_LIMB_REPLACEMENT_1",
    line = ccb.content.text("Let's get you checked out.  Climb up onto the automated surgical suite here, yeah?"),
    replies = {
        {
            text = ccb.content.text("[Climb onto the bed by the surgical robot]"),
            next_topic = "TALK_ANCILLA_DOCTOR_BIONICS_BIONIC_LIMB_REPLACEMENT_2",
        },
        { text = ccb.content.text("Actually, maybe another time."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BIONICS_BIONIC_LIMB_REPLACEMENT_2",
    line = ccb.content.text("&The Doc spends a long moment clacking away on the keyboard, until the machine beeps several times.  \"Yup, all looks good.  Healthy as a horse.  Well, good enough for the machine, at least.  Maybe too healthy, seeing as you still have all your limbs, but that's none of my business.\n\n\"So you're sure about this?  What can I do ya' for?  Not sure yet if you have any cybernetics installed that won't swap over, but if you do, I'll remove them first.\n\n\"Oh, and the important parts.  Firstly, it'll take 6 hours, and I don't have the spare supplies to keep you hydrated, so come fed and healthy.  Second, it's 20 HGC per limb - a nice discounted price.  Third, you'll need to come back here if you damage them - trust me, you don't want to go fucking with the electronics yourself.  Let the robot do it.  Got all that?\""),
    replies = {
        {
            text = ccb.content.text("[20 HGC] Give me a right bionic arm."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "BIONIC_ARM_BASIC_RIGHT")), predicates.negate(predicates.has_trait("speaker", "BIONIC_ARM_BASIC_BOTH")), predicates.negate(predicates.has_trait("speaker", "BIONIC_ARM_BASIC_LEFT")), predicates.has_inventory("speaker", "RobofacCoin", 20) }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 21600 }), actions.add_effect("speaker", "sleep", { turns = 21600 }), actions.handler("dlg_a_dda_3b0f6c80d508"), actions.replace_mutation("speaker", "BIONIC_ARM_BASIC_RIGHT"), actions.handler("dlg_a_dda_8db1b51edca3") },
        },
        {
            text = ccb.content.text("[20 HGC] Give me a left bionic arm."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "BIONIC_ARM_BASIC_LEFT")), predicates.negate(predicates.has_trait("speaker", "BIONIC_ARM_BASIC_BOTH")), predicates.negate(predicates.has_trait("speaker", "BIONIC_ARM_BASIC_RIGHT")), predicates.has_inventory("speaker", "RobofacCoin", 20) }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 21600 }), actions.add_effect("speaker", "sleep", { turns = 21600 }), actions.handler("dlg_a_dda_3b0f6c80d508"), actions.replace_mutation("speaker", "BIONIC_ARM_BASIC_LEFT"), actions.handler("dlg_a_dda_8db1b51edca3") },
        },
        {
            text = ccb.content.text("[20 HGC] I've already got one bionic arm.  Install the other."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.any({ predicates.has_trait("speaker", "BIONIC_ARM_BASIC_LEFT"), predicates.has_trait("speaker", "BIONIC_ARM_BASIC_RIGHT") }), predicates.negate(predicates.has_trait("speaker", "BIONIC_ARM_BASIC_BOTH")), predicates.has_inventory("speaker", "RobofacCoin", 20) }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 21600 }), actions.add_effect("speaker", "sleep", { turns = 21600 }), actions.handler("dlg_a_dda_5eb7d97f57e0"), actions.replace_mutation("speaker", "BIONIC_ARM_BASIC_BOTH"), actions.handler("dlg_a_dda_8db1b51edca3") },
        },
        {
            text = ccb.content.text("[20 HGC] Give me a right bionic leg."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "BIONIC_LEG_BASIC_RIGHT")), predicates.negate(predicates.has_trait("speaker", "BIONIC_LEG_BASIC_BOTH")), predicates.negate(predicates.has_trait("speaker", "BIONIC_LEG_BASIC_LEFT")), predicates.has_inventory("speaker", "RobofacCoin", 20) }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 21600 }), actions.add_effect("speaker", "sleep", { turns = 21600 }), actions.handler("dlg_a_dda_abe9cab787b0"), actions.replace_mutation("speaker", "BIONIC_LEG_BASIC_RIGHT"), actions.handler("dlg_a_dda_8db1b51edca3") },
        },
        {
            text = ccb.content.text("[20 HGC] Give me a left bionic leg."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.has_trait("speaker", "BIONIC_LEG_BASIC_LEFT")), predicates.negate(predicates.has_trait("speaker", "BIONIC_LEG_BASIC_BOTH")), predicates.negate(predicates.has_trait("speaker", "BIONIC_LEG_BASIC_RIGHT")), predicates.has_inventory("speaker", "RobofacCoin", 20) }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 21600 }), actions.add_effect("speaker", "sleep", { turns = 21600 }), actions.handler("dlg_a_dda_abe9cab787b0"), actions.replace_mutation("speaker", "BIONIC_LEG_BASIC_LEFT"), actions.handler("dlg_a_dda_8db1b51edca3") },
        },
        {
            text = ccb.content.text("[20 HGC] I've already got one bionic leg.  Install the other."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.any({ predicates.has_trait("speaker", "BIONIC_LEG_BASIC_LEFT"), predicates.has_trait("speaker", "BIONIC_LEG_BASIC_RIGHT") }), predicates.negate(predicates.has_trait("speaker", "BIONIC_LEG_BASIC_BOTH")), predicates.has_inventory("speaker", "RobofacCoin", 20) }),
            actions = { actions.add_effect("speaker", "narcosis", { turns = 21600 }), actions.add_effect("speaker", "sleep", { turns = 21600 }), actions.handler("dlg_a_dda_27cd72b84fb0"), actions.replace_mutation("speaker", "BIONIC_LEG_BASIC_BOTH"), actions.handler("dlg_a_dda_8db1b51edca3") },
        },
        {
            text = ccb.content.text("Actually, maybe another time."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_1",
    line = ccb.content.text("You're fuckin' right it's a proper setup, but damn, I could say the same about you!  Look at ya'!\"  The Doc walks over to the spider-like surgical robot, and pats the soft, cushioned examination table.  He wipes his brow with his sleeve and gulps.  \"Right.  Hop up here, and let's plug into your interface there, and see what we're working with.  I suspect we'll have to swap it out.\"  The Doc then starts to unclasp a set of wrist and ankle ties attached to the exam table.\n\n\"Hope this is alright.  We'll tie down your limbs.  Never worked on… well… someone like you, before.  Guess I haven't worked on that many people in any case.  No worries.  I can do it.  Just don't want you, uh, bugging out and hurting yourself, got it?"),
    replies = {
        {
            text = ccb.content.text("[Hop up on the exam table] No problem."),
            next_topic = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_2",
        },
        { text = ccb.content.text("Actually… maybe some other time."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_2",
    line = ccb.content.text("&You lay down on the exam table and lean back.  The spider-like surgical robot that, at first, appeared familiar to you, now feels alien, jerking in its movement, greedily grasping at your ports, plates, and wires.  You hear a bone saw start to loudly whirr, as the Doc goes through various tests.\n\n<color_light_red>You have a bad feeling about this.</color>"),
    replies = {
        {
            text = ccb.content.text("<color_red>[Against your better judgment, let Doc Stevens restrain you on the the Hub 01 automated surgical suite]</color>"),
            next_topic = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_3",
        },
        {
            text = ccb.content.text("[Hop off the exam table] Actually… maybe some other time.  I have some things to do."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_3",
    line = ccb.content.text("&Doc Stevens ties down your limbs, and gives you a firm nod.  Then he wipes his brow, again.  And then again with the other sleeve.  The bone saw quickens until it is spinning with a deafening sound.  Its biting teeth cut the air with a harsh whistle.  \"Hoowee, it's hot today.  Alright, give me just a second to boot up the twilight juice, yeah?  Stay still!\".\n\n<color_red>You have a VERY bad feeling about this.</color>"),
    replies = {
        {
            text = ccb.content.text("<color_red>[Against your better judgment, give Doc Stevens permission to put you to sleep, here, strapped down beneath a spinning bone saw]</color>"),
            next_topic = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_4",
            actions = { actions.handler("dlg_a_dda_e77729ae12dd") },
        },
        {
            text = ccb.content.text("Actually, hold on, Doc.  Can you take these things off me?  I'm not ready."),
            next_topic = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_GOOD_CALL",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_4",
    line = ccb.content.text("&It all goes black."),
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "a_turncoat_to_the_end", { permanent = true }), "u_die" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_DOCTOR_BOTCHED_EXODII_SURGERY_GOOD_CALL",
    line = ccb.content.text("Doc Stevens hesitate for an uncomfortable moment.  The saw slows down.  Then he nods and unclasps you.  You are free to go."),
    replies = {
        {
            text = ccb.content.text("Thanks, Doc.  See you some other time."),
            next_topic = "TALK_DONE",
        },
    },
}
