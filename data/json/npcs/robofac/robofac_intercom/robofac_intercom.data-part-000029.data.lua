local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_INTRODUCE_EXODII_VIA_WAREHOUSE",
    line = ccb.content.text("What kind of exotic tech?  I'll need more information than that to even consider payment."),
    replies = {
        {
            text = ccb.content.text("It's a warehouse owned by a race of inter-dimensional beings who call themselves the Exodii.  They're… robots?  Cyborgs?  More metal than man in my opinion.  They use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent, but when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE",
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_687c0fab6ae8") },
        },
        {
            text = ccb.content.text("It's a warehouse owned by a race of inter-dimensional beings who call themselves the Exodii.  They're… robots?  Cyborgs?  More metal than man in my opinion.  They use automated machinery to do their fighting and heavy lifting, and they seem to have a preference for large firearms, swords, and spears.  They do understand English to a certain extent, but when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }),
            actions = { actions.adjust_faction_trust(2), actions.handler("dlg_a_dda_687c0fab6ae8") },
        },
        {
            text = ccb.content.text("It's a warehouse owned by a race of inter-dimensional beings who call themselves the Exodii.  They're… robots?  Cyborgs?  More metal than man in my opinion.  They use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent, but when talking they use a strange dialect they like to call Anglic.  From what I understand, they are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }),
            actions = { actions.adjust_faction_trust(2), actions.handler("dlg_a_dda_687c0fab6ae8") },
        },
        {
            text = ccb.content.text("It's a warehouse owned by a race of inter-dimensional beings who call themselves the Exodii.  They're… robots?  Cyborgs?  More metal than man in my opinion.  They use automated machinery to do their fighting and heavy lifting, and they seem to have a preference for large firearms, swords, and spears.  They do understand English to a certain extent, but when talking they use a strange dialect they like to call Anglic.  From what I understand, they are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }) }),
            actions = { actions.adjust_faction_trust(3), actions.handler("dlg_a_dda_687c0fab6ae8") },
        },
        {
            text = ccb.content.text("Actually, nevermind."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE",
    line = ccb.content.text("&The intercom is silent for a long moment, before a different voice replies:  \"If this warehouse is indeed full of inter-dimensional cyborg technology, we would be willing to pay generously for its location.\""),
    replies = {
        {
            text = ccb.content.text("I can give you the coordinates, for a price."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_2a",
            when = predicates.handler("dlg_p_dda_88b494c31259"),
        },
        {
            text = ccb.content.text("I'll give you the coordinates free of charge - consider it part of our ongoing professional relationship."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3",
            when = predicates.handler("dlg_p_dda_88b494c31259"),
            actions = { actions.adjust_faction_trust(3), actions.handler("dlg_a_dda_17ca1cc4d07b") },
        },
        {
            text = ccb.content.text("Actually, nevermind.  I don't know where it is."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_2a",
    line = ccb.content.text("Very well.  We are prepared to offer 5 HGCs, which is generous, given that this is a considerable risk."),
    replies = {
        {
            text = ccb.content.text("Deal!  5 HGCs in exchange for the coordinates."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3",
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_3c564ddaa56c") },
        },
        {
            text = ccb.content.text("I don't need any coins, but I'd like you to tell me about the tech you find inside."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3",
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_729e39bdeb38") },
        },
        {
            text = ccb.content.text("I want 10 HGCs."),
            trial = { kind = "persuade", difficulty = 20 },
            success = { next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3", actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_7ece42511df9") } },
            failure = { next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_2b" },
        },
        {
            text = ccb.content.text("I want 5 HGCs and information on the tech you find."),
            trial = { kind = "persuade", difficulty = 20 },
            success = { next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3", actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_383f4e5a2e01") } },
            failure = { next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_2b" },
        },
        {
            text = ccb.content.text("I want 10 HGCs and information on the tech you find."),
            trial = { kind = "persuade", difficulty = 10 },
            success = { next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3", actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_1de9d516ef01") } },
            failure = { next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_2b" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_2b",
    line = ccb.content.text("We can only offer you 5 HGCs.  Alternatively, we could give you information on the tech once it's recovered, if that is more interesting to you."),
    replies = {
        {
            text = ccb.content.text("Deal!  5 HGCs in exchange for the coordinates."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3",
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_3c564ddaa56c") },
        },
        {
            text = ccb.content.text("Deal!  Information on the tech in exchange for the coordinates."),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3",
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_729e39bdeb38") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_3",
    line = ccb.content.text("Excellent.  We will scout the area and send a team to recover the materials.  We will dispatch the team immediately, but it will take a full day until we have any more information.  We thank you for your contributions to the future of humanity."),
    replies = {
        {
            text = ccb.content.text("Nice doing business with you."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_656434aaa958"),
            actions = { actions.adjust_faction_trust(-3), actions.handler("dlg_a_dda_bb58c961d492"), actions.set_actor_value("speaker", "dialogue_hub_u_waiting_on_warehouse", "yes") },
        },
        {
            text = ccb.content.text("Nice doing business with you."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_6b2a493d9e87"),
            actions = { actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_4b808a776918"), actions.set_actor_value("speaker", "dialogue_hub_u_waiting_on_warehouse", "yes"), actions.update_map("exo_warehouse_1_robofac_looted", "exo_warehouse_1") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_4a",
    line = {
        when = predicates.handler("dlg_p_dda_a73b7872f690"),
        yes = ccb.content.text("Indeed, we have found the warehouse, and as you promised, it is full of exotic technology.  Your services are appreciated."),
        no = ccb.content.text("The recovery process is still ongoing."),
    },
    replies = {
        {
            text = ccb.content.text("Glad to hear it."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_a73b7872f690"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_u_waiting_on_warehouse"), actions.clear_actor_value("speaker", "timer_hub_waiting_on_warehouse"), actions.handler("dlg_a_dda_2675ed36767c") },
        },
        {
            text = ccb.content.text("I'll check in later."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_4b",
    line = {
        when = predicates.handler("dlg_p_dda_a73b7872f690"),
        yes = ccb.content.text("Indeed, we have found the warehouse, and as you promised, it is full of exotic technology.  As promised, we have additional details on the contents.  We have discovered components for what appears to be some sort of surgical robot.  We are currently reverse engineering it in an attempt to understand it better.  If we have needs of your services in these efforts - and we very well may - we'll be sure to let you know."),
        no = ccb.content.text("The recovery process is still ongoing."),
    },
    replies = {
        {
            text = ccb.content.text("Great.  I'll check in later about helping out, if I can."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_a73b7872f690"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_u_waiting_on_warehouse"), actions.clear_actor_value("speaker", "timer_hub_waiting_on_warehouse"), actions.handler("dlg_a_dda_74f94310dceb") },
        },
        {
            text = ccb.content.text("I'll check in later."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_EXODII_WAREHOUSE_4c",
    line = {
        when = predicates.handler("dlg_p_dda_a73b7872f690"),
        yes = ccb.content.text("Indeed, but curiously, these \"Exodii\" beat us there.  We were not able to recover the contents of the warehouse.  We hope your future intel will be more complete."),
        no = ccb.content.text("The recovery process is still ongoing."),
    },
    replies = {
        {
            text = ccb.content.text("Right."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_a73b7872f690"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_u_waiting_on_warehouse"), actions.clear_actor_value("speaker", "timer_hub_waiting_on_warehouse") },
        },
        {
            text = ccb.content.text("I'll check in later."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODI_INTERCOM_AUTODOC_A",
    line = {
        when = predicates.handler("dlg_p_dda_b7d7d0397e2b"),
        yes = ccb.content.text("&The intercom clicks off and there is a long moment of silence, before it clicks back on again with a new person on the other end.  \"Yes, hello.  Right.  Yes.  Indeed, the technology we recovered was instrumental in developing new medical technology we are making available for our contractors, like yourself.  You can find a new, public medical suite across the street, in the old basement of the weather station - you should be able to find the stairs just inside the entrance.  Please feel free to make use of its services.\""),
        no = {
            when = predicates.handler("dlg_p_dda_a8aa712606ab"),
            yes = ccb.content.text("Our newest project will be ready for field testing within the week.  We suggest checking back regularly."),
            no = {
                when = predicates.handler("dlg_p_dda_4c0d289091f3"),
                yes = ccb.content.text("This project is ongoing, but is advancing quickly.  We expect research to be done in a matter of weeks."),
                no = ccb.content.text("The project is ongoing, and we expect it will take weeks or months until it is ready for testing.  We suggest you check back in next week."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("A new medical facility across the street, in the basement?  I guess I can go check it out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_b7d7d0397e2b"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_u_waiting_on_autodoc"), actions.clear_actor_value("speaker", "timer_hub_waiting_on_autodoc") },
        },
        {
            text = ccb.content.text("I'll check in later."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_98d2c880556a"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODI_INTERCOM_AUTODOC_B",
    line = {
        when = predicates.handler("dlg_p_dda_b7d7d0397e2b"),
        yes = ccb.content.text("&The intercom clicks off and there is a long moment of silence, before it clicks back on again with a new person on the other end.  \"Yes, hello.  Right.  Yes.  Indeed, we have been able to reconstruct the automatic medical device, and due to your efforts, and the efforts of other contractors and Hub scientists, we were able to reverse engineer the cybernetic implants the Exodii make use of.  You can find a new, public medical suite across the street, in the old basement of the weather station - you should be able to find the stairs just inside the entrance.  Please feel free to make use of its services.  As previously discussed, we would like to invite you to join our new program, where select mercenaries will be allowed to field test new cybernetic enhancements.  Doctor Stevens at the facility will give you more information.  In fact, as a reward for your service, we are prepared to install some very useful cybernetic enhancements that we developed as a part of these efforts.\""),
        no = {
            when = predicates.handler("dlg_p_dda_a8aa712606ab"),
            yes = ccb.content.text("Our newest project will be ready for field testing within days.  We suggest checking back regularly."),
            no = {
                when = predicates.handler("dlg_p_dda_4c0d289091f3"),
                yes = ccb.content.text("We expect the surgical suite to be ready in approximately one week."),
                no = ccb.content.text("The project is ongoing, and we expect it will take weeks or months until it is ready for testing.  We suggest you check back in next week."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("<fcl_hub_has_interface>"),
            false_text = ccb.content.text("Actually, I'm familiar with these cybernetics.  I already have one."),
            text_when = predicates.handler("dlg_p_dda_d292f701cba7"),
            next_topic = "TALK_EXODI_INTERCOM_AUTODOC_B_EXODII_INTERFACE",
            when = predicates.handler("dlg_p_dda_bb45537eefe5"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_u_waiting_on_autodoc"), actions.clear_actor_value("speaker", "timer_hub_waiting_on_autodoc"), actions.handler("dlg_a_dda_aaefecbdde37") },
        },
        {
            text = ccb.content.text("Ah, well, I guess this could be useful for me, being a cyborg myself.  I'll go check it out."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_604824d886c4"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_u_waiting_on_autodoc"), actions.clear_actor_value("speaker", "timer_hub_waiting_on_autodoc"), actions.handler("dlg_a_dda_aaefecbdde37") },
        },
        {
            text = ccb.content.text("<fcl_hub_new_cybernetics>"),
            false_text = ccb.content.text("Cybernetics?  What do you mean by that?"),
            text_when = predicates.handler("dlg_p_dda_d292f701cba7"),
            next_topic = "TALK_EXODI_INTERCOM_AUTODOC_B_CYBERNETICS_INFO",
            when = predicates.handler("dlg_p_dda_d98308d74f14"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_u_waiting_on_autodoc"), actions.clear_actor_value("speaker", "timer_hub_waiting_on_autodoc"), actions.handler("dlg_a_dda_aaefecbdde37") },
        },
        {
            text = ccb.content.text("I guess I can go check the new medical facility out.  Across the street in the basement, right?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_b7d7d0397e2b"),
            actions = { actions.clear_actor_value("speaker", "dialogue_hub_u_waiting_on_autodoc"), actions.clear_actor_value("speaker", "timer_hub_waiting_on_autodoc"), actions.handler("dlg_a_dda_aaefecbdde37") },
        },
        {
            text = ccb.content.text("I'll check in later."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("dlg_p_dda_98d2c880556a"),
        },
    },
}
