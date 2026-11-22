local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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
