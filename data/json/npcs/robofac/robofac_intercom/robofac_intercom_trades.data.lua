local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_BUY_PROTECTIVE_GEAR", "TALK_ROBOFAC_INTERCOM_BUY_PROTECTIVE_GEAR_INFO" },
    line = ccb.content.text("Given the context of your assignment, we are willing to sell you a set of our protective gear - a gas mask and an environmental suit - at a considerable discount.  We will part with it for two exchange coins.\"  The intercom waits expectantly.  \"Actually, hold on, we might not have one in your size…"),
    replies = {
        {
            text = ccb.content.text("[2 HGC] Deal!"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.has_inventory("speaker", "RobofacCoin", 2),
            actions = { actions.handler("dlg_a_dda_079275754668"), actions.set_actor_value("interlocutor", "dialogue_intercom_npc_bought_protective_gear", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_bought_protective_gear" }, { "yes" }) },
        },
        {
            text = ccb.content.text("What will it do for me?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_PROTECTIVE_GEAR_INFO",
        },
        {
            text = ccb.content.text("I have to give it a thought."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_PROTECTIVE_GEAR_INFO",
    line = ccb.content.text("What the gas mask does should be obvious; we'll provide you with a cartridge, of course.  The environment suit is full-body, and protects you from water, harmful radiation, and environmental hazards.  It's also rated to protect from electric shocks of up to twelve thousand volts.\"\n\n\"Bear in mind that the suit isn't armor.  It will keep you safe from the environment, but it's just Nomex and it won't protect you from anything stronger than a punch.  The modular defense system is designed to fit over it, so I'd urge you to bring them both if fighting is unavoidable."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_LOCAL_MAP",
    line = ccb.content.text("To assist your operations, we are willing to sell you a map of the local area, as surveyed by our cam-spy drones.  Its standing price is 1 HGC."),
    replies = {
        {
            text = ccb.content.text("[1 HGC] Deal!"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.has_inventory("speaker", "RobofacCoin", 1),
            actions = { actions.handler("dlg_a_dda_77e2cf4040b1"), actions.set_actor_value("interlocutor", "dialogue_intercom_sold_local_map", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_sold_local_map" }, { "yes" }) },
        },
        {
            text = ccb.content.text("I'll have to give it some thought."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA", "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Small", "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Medium", "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Large" },
    line = ccb.content.text("Excellent; please deposit the printouts in the intercom's tray.  We'll issue a reward based on the quality of your recordings."),
    replies = {
        {
            text = ccb.content.text("[Deposit a NRE anomaly printout.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Large",
            when = predicates.has_inventory("speaker", "nre_anomaly_printout_data", 1),
            actions = { actions.handler("dlg_a_dda_0b73973a513f") },
        },
        {
            text = ccb.content.text("[Deposit a long NRE printout.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Large",
            when = predicates.has_inventory("speaker", "large_printout_portal_storm_data", 1),
            actions = { actions.handler("dlg_a_dda_c424948a0318") },
        },
        {
            text = ccb.content.text("[Deposit an NRE printout.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Medium",
            when = predicates.handler("dlg_p_dda_516caf4fa5ec"),
            actions = { actions.handler("dlg_a_dda_6c27eeafdb86") },
        },
        {
            text = ccb.content.text("[Deposit a short NRE printout.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Small",
            when = predicates.handler("dlg_p_dda_2ac1991513ff"),
            actions = { actions.handler("dlg_a_dda_9ce16051e93c") },
        },
        {
            text = ccb.content.text("That would be all."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Small",
    line = {
        when = predicates.handler("dlg_p_dda_9ce50d3ad911"),
        yes = ccb.content.text("Extrapolating trends from these recordings has become difficult.  Research has requested we only accept higher quality data from now on."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_accepted_nre_recording" } }),
            yes = ccb.content.text("&\"Thank you.\"  The recording changes hands."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_intercom_accepted_nre_recording" } }),
                yes = ccb.content.text("&\"Thank you.\"  The recording changes hands."),
                no = ccb.content.text("Excellent; this should be enough to work with.  Here's your agreed-upon reward.\"  The tray slides shut, and quickly reopens with your payment.  \"Given your performance and our constant need for new data, you are free to keep the recorder for further use.  We are willing to pay for any future data that you're able to record."),
            },
        },
    },
    on_enter = {
        { once = "nre_trade", actions = { actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_nre_recording", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_accepted_nre_recording" }, { "yes" }), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1", { success = true }) } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Medium",
    line = {
        when = predicates.handler("dlg_p_dda_1bc8ba6fed47"),
        yes = ccb.content.text("Extrapolating trends from these recordings has become difficult.  Research has requested we only accept higher quality data from now on."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_accepted_nre_recording" } }),
            yes = ccb.content.text("&\"Excellent.\"  The recording changes hands."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_intercom_accepted_nre_recording" } }),
                yes = ccb.content.text("&\"Excellent.\"  The recording changes hands."),
                no = ccb.content.text("Great!  This looks like a very high-quality recording.  Because this data is much better, we are willing to pay five times what we paid for the base data collected.\"  The tray slides shut, and quickly reopens with your payment.  \"Given your performance and our constant need for new data, you are free to keep the recorder for further use.  We are willing to pay for any future data that you're able to record."),
            },
        },
    },
    on_enter = {
        { once = "nre_trade", actions = { actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_nre_recording", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_accepted_nre_recording" }, { "yes" }), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1", { success = true }) } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_PORTAL_STORM_DATA_Large",
    line = {
        when = predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_accepted_nre_recording" } }),
        yes = ccb.content.text("Fantastic.\"  The recording changes hands.  \"At this rate, we'll have some real results soon."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_intercom_accepted_nre_recording" } }),
            yes = ccb.content.text("Fantastic.\"  The recording changes hands.  \"At this rate, we'll have some real results soon."),
            no = ccb.content.text("Uh… please allow me a second to check this in.\"  The tray slides shut, and the intercom turns off.  Roughly a minute later, it turns back on.  \"Well, it looks like this is a real treasure trove of information.  In fact, you've made quite an impression on R&D, and probably just saved us a few weeks of research at the least.  They demanded you be given a pretty significant accomplishment bonus, so… well, there you go.\"  The tray slides open, revealing an impressive pile of coins.\n\n\"Given your performance and our constant need for new data, you are free to keep the recorder for further use.  We are willing to pay for any future data that you're able to record."),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_nre_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_nre_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1", { success = true }),
            },
            once = "nre_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_RIOT_GEAR",
    line = ccb.content.text("There is an infinite supply of the stuff but I guess from us you can get it clean and undamaged.  That'll be $400."),
    replies = {
        {
            text = ccb.content.text("[8 HGC] Deal!"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.has_inventory("speaker", "RobofacCoin", 8),
            actions = { actions.handler("dlg_a_dda_1a1507c0fc87"), actions.set_actor_value("interlocutor", "npc_dialogue_exodii_npc_bought_riot_gear", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_bought_riot_gear" }, { "yes" }) },
        },
        {
            text = ccb.content.text("I'm a little tight on funds right now.  Can we work out a buy now pay later deal?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_RIOT_GEAR_NEGOTIATE",
            when = predicates.negate(predicates.has_inventory("speaker", "RobofacCoin", 8)),
        },
        {
            text = ccb.content.text("I'll have to give it some thought."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_RIOT_GEAR_NEGOTIATE",
    line = ccb.content.text("So we'd need a sweeter deal than just the money if we did this."),
    replies = {
        {
            text = ccb.content.text("I can pay you what I owe in cash and looted gear."),
            actions = {
                actions.set_actor_value("interlocutor", "npc_dialogue_intercom_u_pay_back_on_cash", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_pay_back_on_cash" }, { "yes" }),
            },
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_RIOT_GEAR_ON_CREDIT_ACCEPT",
        },
        {
            text = ccb.content.text("If you give me this deal you can have all the alien corpses, their stuff and their tower"),
            actions = {
                actions.set_actor_value("interlocutor", "npc_dialogue_intercom_u_pay_back_on_specimens", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_pay_back_on_specimens" }, { "yes" }),
            },
            next_topic = "TALK_ROBOFAC_INTERCOM_BUY_RIOT_GEAR_ON_CREDIT_ACCEPT",
        },
        {
            text = ccb.content.text("I'll have to give it some thought."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_BUY_RIOT_GEAR_ON_CREDIT_ACCEPT",
    line = {
        when = predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_pay_back_on_specimens" } }),
        yes = ccb.content.text("Well it might be more interesting than straight gear.  Tell us when it's available for inspection.  We expect you back in 20 days or less."),
        no = ccb.content.text("20 days then for payment."),
    },
    replies = {
        {
            text = ccb.content.text("Much obliged."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            actions = { actions.handler("dlg_a_dda_93f3ca32d409"), actions.assign_mission("MISSION_HUB01_PAY_BACK_RIOT_GEAR"), actions.set_actor_value("interlocutor", "npc_dialogue_exodii_npc_bought_riot_gear", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_bought_riot_gear" }, { "yes" }) },
        },
        {
            text = ccb.content.text("I'll have to give it some thought."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_SELL_YRAX_TOYS", "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_TRIFACET", "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_TRIAKIS", "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_GOLDEN_MONOLITH", "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_DELTA", "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_QUADRAPHRACT_LEG", "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_QUADRAPHRACT", "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_TRIFACET", "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_TRIAKIS", "TALK_ROBOFAC_INTERCOM_SELL_BOT_GOLDEN_MONOLITH", "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_DELTA" },
    line = ccb.content.text("Beautiful; please put them into loading area.  We'll issue a reward depending on what you managed to scavenge."),
    replies = {
        {
            text = ccb.content.text("[Deliver a broken trifacet.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_TRIFACET",
            when = predicates.has_inventory("speaker", "broken_yrax_trifacet", 1),
            actions = { actions.handler("dlg_a_dda_d134bbc1a0ec") },
        },
        {
            text = ccb.content.text("[Deliver a broken triakis drone.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_TRIAKIS",
            when = predicates.all({ predicates.has_inventory("speaker", "broken_yrax_triakis", 1) }),
            actions = { actions.handler("dlg_a_dda_7de768356dce") },
        },
        {
            text = ccb.content.text("[Deliver a broken monolith.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_GOLDEN_MONOLITH",
            when = predicates.all({ predicates.has_inventory("speaker", "broken_golden_monolith", 1) }),
            actions = { actions.handler("dlg_a_dda_482889d0a465") },
        },
        {
            text = ccb.content.text("[Deliver a broken delta drone.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_BROKEN_YRAX_DELTA",
            when = predicates.all({ predicates.has_inventory("speaker", "broken_yrax_delta", 1) }),
            actions = { actions.handler("dlg_a_dda_d81f3b78e058") },
        },
        {
            text = ccb.content.text("[Drag in broken quadraphract leg.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_QUADRAPHRACT_LEG",
            when = predicates.has_inventory("speaker", "broken_yrax_quadraphract_leg", 1),
            actions = { actions.handler("dlg_a_dda_5188f4918353") },
        },
        {
            text = ccb.content.text("[Drag in broken quadraphract.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_QUADRAPHRACT",
            when = predicates.has_inventory("speaker", "broken_yrax_quadraphract", 1),
            actions = { actions.handler("dlg_a_dda_1107ada30080") },
        },
        {
            text = ccb.content.text("[Deliver a deactivated trifacet.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_TRIFACET",
            when = predicates.has_inventory("speaker", "bot_yrax_trifacet", 1),
            actions = { actions.handler("dlg_a_dda_9ba1a784cc90") },
        },
        {
            text = ccb.content.text("[Deliver a deactivated triakis.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_TRIAKIS",
            when = predicates.has_inventory("speaker", "bot_yrax_triakis", 1),
            actions = { actions.handler("dlg_a_dda_6326394a9290") },
        },
        {
            text = ccb.content.text("[Deliver a deactivated monolith.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BOT_GOLDEN_MONOLITH",
            when = predicates.has_inventory("speaker", "bot_golden_monolith", 1),
            actions = { actions.handler("dlg_a_dda_f1359c393a58") },
        },
        {
            text = ccb.content.text("[Deliver a deactivated delta.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_DELTA",
            when = predicates.has_inventory("speaker", "bot_yrax_delta", 1),
            actions = { actions.handler("dlg_a_dda_91d78fc5eb37") },
        },
        {
            text = ccb.content.text("That would be all."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_TRIFACET",
    line = ccb.content.text("We already have a similar model in better condition but this one is useful as a reference."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_TRIAKIS",
    line = ccb.content.text("We can probably gain some insight from studying this unit, but it appears seriously damaged."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_GOLDEN_MONOLITH",
    line = ccb.content.text("That is quite a lot of broken metal, let's hope R&D can at least salvage some materials."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_DELTA",
    line = ccb.content.text("We don't need all of your glossy scrap."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_QUADRAPHRACT_LEG",
    line = ccb.content.text("We witnessed it as a part of larger construct."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BROKEN_YRAX_QUADRAPHRACT",
    line = ccb.content.text("I'm impressed you managed to drag it inside.  We gonna need to fix the lift after this one."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_TRIFACET",
    line = ccb.content.text("I believe we already have similar model already but is nice to have more, it will allow us be more active in our research."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_TRIAKIS",
    line = ccb.content.text("Oh what an interesting piece.  R&D will have a field day with it."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BOT_GOLDEN_MONOLITH",
    line = ccb.content.text("I assume you were trying to figure out limits of the hm12.  I guess they are right here."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_BOT_YRAX_DELTA",
    line = ccb.content.text("I doubt we can get a lot of information from this drone but thanks."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_yrax_robot", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_yrax_robot" }, { "yes" }),
            },
            once = "yrax_trade",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PORTAL", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STORM", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_VITRIFIED", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_EXODII", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STRANGE_TEMPLE", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_LIXA", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_HIGHLANDS", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_LABYRINTH", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PHYSICS_LAB", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_AMIGARA", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_RADIOSPHERE", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_MONSTER_CORPSE", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_CABIN_REVERB", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_CABIN_REVERB_DIMENSION", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_BARRICADED_CHURCH", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_MORGANTOWN", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STRING_DIMENSION", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_SPIRAL_MINE", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_VOID_SPIDER_LAIR", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_INNER_CABINS", "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PORTAL_STORM_DUNGEON" },
    line = ccb.content.text("Excellent; please deposit the printouts in the intercom's tray."),
    replies = {
        {
            text = ccb.content.text("[Deposit a \"stable portal\" datasheet.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PORTAL",
            when = predicates.handler("dlg_p_dda_aac75cf8768a"),
            actions = { actions.handler("dlg_a_dda_754d7f875bd1") },
        },
        {
            text = ccb.content.text("[Deposit a \"unstable portal\" datasheet.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STORM",
            when = predicates.handler("dlg_p_dda_c2a99b57a75a"),
            actions = { actions.handler("dlg_a_dda_af49f71339ee") },
        },
        {
            text = ccb.content.text("[Deposit datasheet CC1044.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_VITRIFIED",
            when = predicates.handler("dlg_p_dda_d2f986e3ea6d"),
            actions = { actions.handler("dlg_a_dda_4751aabc51ba") },
        },
        {
            text = ccb.content.text("[Deposit datasheet IAE20.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_EXODII",
            when = predicates.handler("dlg_p_dda_fa1a5afc547e"),
            actions = { actions.handler("dlg_a_dda_c9cda4679366") },
        },
        {
            text = ccb.content.text("[Deposit datasheet WKG1.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STRANGE_TEMPLE",
            when = predicates.handler("dlg_p_dda_f1dd7b15c41d"),
            actions = { actions.handler("dlg_a_dda_2e9eea0a3fa5") },
        },
        {
            text = ccb.content.text("[Deposit datasheet DP72063.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_LIXA",
            when = predicates.handler("dlg_p_dda_a157c71e578f"),
            actions = { actions.handler("dlg_a_dda_7febbe92e1db") },
        },
        {
            text = ccb.content.text("[Deposit datasheet TCOB1.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_HIGHLANDS",
            when = predicates.handler("dlg_p_dda_c17431e270ac"),
            actions = { actions.handler("dlg_a_dda_c2f7a8139984") },
        },
        {
            text = ccb.content.text("[Deposit datasheet DB86.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_LABYRINTH",
            when = predicates.handler("dlg_p_dda_b47377db4daf"),
            actions = { actions.handler("dlg_a_dda_78bc9cadb9aa") },
        },
        {
            text = ccb.content.text("[Deposit datasheet 22BMBS.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PHYSICS_LAB",
            when = predicates.handler("dlg_p_dda_0e0ef696abb0"),
            actions = { actions.handler("dlg_a_dda_780722f802a0") },
        },
        {
            text = ccb.content.text("[Deposit datasheet 01ITO.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_AMIGARA",
            when = predicates.handler("dlg_p_dda_25dafcc3ab88"),
            actions = { actions.handler("dlg_a_dda_7517b5e57697") },
        },
        {
            text = ccb.content.text("[Deposit datasheet VKTRS.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_RADIOSPHERE",
            when = predicates.handler("dlg_p_dda_c93719a0ba1a"),
            actions = { actions.handler("dlg_a_dda_5d72456d1ad5") },
        },
        {
            text = ccb.content.text("[Deposit datasheet LKG1.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_MONSTER_CORPSE",
            when = predicates.handler("dlg_p_dda_911ebc8a27b4"),
            actions = { actions.handler("dlg_a_dda_60f9f01fb672") },
        },
        {
            text = ccb.content.text("[Deposit datasheet CITW01.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_CABIN_REVERB",
            when = predicates.handler("dlg_p_dda_3cfc230a3afb"),
            actions = { actions.handler("dlg_a_dda_c796f2e12fa3") },
        },
        {
            text = ccb.content.text("[Deposit datasheet CITW02.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_CABIN_REVERB_DIMENSION",
            when = predicates.handler("dlg_p_dda_f15dff4d4a58"),
            actions = { actions.handler("dlg_a_dda_7b88d52e4d58") },
        },
        {
            text = ccb.content.text("[Deposit datasheet ESFX.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_BARRICADED_CHURCH",
            when = predicates.handler("dlg_p_dda_d7ee61bf7e06"),
            actions = { actions.handler("dlg_a_dda_efab7034dde2") },
        },
        {
            text = ccb.content.text("[Deposit datasheet 01Z90.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_MORGANTOWN",
            when = predicates.handler("dlg_p_dda_6b0652c15d96"),
            actions = { actions.handler("dlg_a_dda_fb214d511ce0") },
        },
        {
            text = ccb.content.text("[Deposit datasheet IHS.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STRING_DIMENSION",
            when = predicates.handler("dlg_p_dda_c3dc3402ba5e"),
            actions = { actions.handler("dlg_a_dda_49a658f92ec7") },
        },
        {
            text = ccb.content.text("[Deposit datasheet UJI98.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_SPIRAL_MINE",
            when = predicates.handler("dlg_p_dda_a3d245331fd2"),
            actions = { actions.handler("dlg_a_dda_5c2cdab017b9") },
        },
        {
            text = ccb.content.text("[Deposit datasheet NLL8.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_VOID_SPIDER_LAIR",
            when = predicates.handler("dlg_p_dda_ba009730232b"),
            actions = { actions.handler("dlg_a_dda_e9b68481bb9b") },
        },
        {
            text = ccb.content.text("[Deposit datasheet MROTS-S.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PORTAL_STORM_DUNGEON",
            when = predicates.handler("dlg_p_dda_a417252a70db"),
            actions = { actions.handler("dlg_a_dda_8b17fea9c83e") },
        },
        {
            text = ccb.content.text("[Deposit datasheet CITW-BFα and give a verbal report.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_INNER_CABINS",
            when = predicates.handler("dlg_p_dda_fd7aecf5a7d0"),
            actions = { actions.handler("dlg_a_dda_f89b78acaa19") },
        },
        {
            text = ccb.content.text("[Deposit datasheet CITW-BFβ and give a verbal report.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_INNER_CABINS",
            when = predicates.handler("dlg_p_dda_c4801519cf29"),
            actions = { actions.handler("dlg_a_dda_e0b08fee1722") },
        },
        {
            text = ccb.content.text("[Deposit datasheet CITW-BFγ and give a verbal report.]"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_INNER_CABINS",
            when = predicates.handler("dlg_p_dda_7cf23cfab2c6"),
            actions = { actions.handler("dlg_a_dda_7236e065e066") },
        },
        {
            text = ccb.content.text("That would be all."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PORTAL",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"We have forwarded the recording to Research and thank you for your continued cooperation.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STORM",
    line = {
        when = predicates.handler("dlg_p_dda_f5179cb22d81"),
        yes = ccb.content.text("Research has requested we no longer pay for portal storm recordings.  You have done enough."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "global", key = "hub01_intercom_accepted_HEW_recording" } }),
            yes = ccb.content.text("&\"Thank you.\"  The recording changes hands."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_intercom_accepted_HEW_recording" } }),
                yes = ccb.content.text("&\"Thank you.\"  The recording changes hands."),
                no = ccb.content.text("Excellent.  Here's your agreed-upon reward.\"  The tray slides shut, and quickly reopens with your payment."),
            },
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }) } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_VITRIFIED",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"This is a very curious recording.  The unit detected an active 'tear' in spacetime.  More importantly, there is something like an event horizon surrounding the source of the resonance recordings - that is to say that if you were to enter, you may never be able to leave.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_EXODII",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"This report contains what we can only call… human-like radio and other signals.  We've recorded similar transmissions recently and independently.  We suggest you do not engage with these creatures, should you find the source of the information.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STRANGE_TEMPLE",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"This is a very curious recording.  For the most part it's normal.  However, the instruments detected a point where anomalous converge - whatever this structure is, it houses something of extra-dimensional origins.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_LIXA",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"You've located a severe spacetime disturbance.  Notably, several of the recordings performed unexpected loops in their subroutines.  In fact, these anomalies seem to be centered around a facility we are familiar with, and where we have recently performed extensive aerial surveillance.  If you are interested, we are willing to offer you a contract to retrieve something from this location.  Let us know if you are interested.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_HIGHLANDS",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"Astounding!  Incredible!  You've clearly recorded these in a non-Earth environment.  While the atmosphere is similar to ours, the humidity is substantially higher, and the pressure makes it more prone to violent storms.  The report also identified several concentrated anomalies, indicating there are extra-dimensional objects located in the area you scanned.  Interestingly, there are no signs of artificial communication such as radio waves.  This place is clearly not housing any advanced intelligent life.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_LABYRINTH",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"Unbelievable!  You've clearly recorded these in a non-Earth environment.  The atmosphere has several foreign materials, but does not appear toxic.  Most interestingly, there are substantial signs of life in the electromagnetic spectrum.  We'll speak with Research, as they may be interested in acquiring a specimen.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PHYSICS_LAB",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"The recording you have brought us contains classified information.  The likelihood of death if you enter the source of this recording is extremely high.  Please accept payment and disregard any knowledge you have of this place.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_AMIGARA",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"We have detected an extremely large source of extra-dimensional energy - energy we have not seen since the initial cataclysm.  We have also detected extreme geological anomalies.  We believe this underground location is unstable, perhaps due to an active tear in spacetime.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_RADIOSPHERE",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"Incredible - these are clearly non-Earth conditions!  What is strange is that there are a substantial number of man-made radio waves, but they all appear to be the same very high frequency radio waveform.  We will study these further.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_MONSTER_CORPSE",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"Curiously, this report indicates that there are alien volatile organic compounds in the area you recorded in, and hints that they have an underground origin.  We may be interested in contracting you for further investigation.  Ask of you are interested.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_CABIN_REVERB",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"The recordings performed unexpected loops in its subroutines, resulting in a multitude of errors, but the report otherwise seems normal.  We note that these loops only occur when scanning the roof of a structure in the scan-zone.  In any case, we will forward this to Research, but perhaps you should investigate that roofs.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_CABIN_REVERB_DIMENSION",
    line = {
        when = predicates.handler("dlg_p_dda_2facb0b881bc"),
        yes = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"Ah, interesting.  So this is where you entered this other place?  This decreases the chances that what you experienced was a hallucination.  These conditions are clearly Earth-like, but the recordings performed unexpected loops in its subroutines.  The topographical scan shows what appear to be deliberate patterns in the placement of whatever structures you may have encountered.  We suspect that this may be a location where spacetime is slipping in various directions.  We will forward this to Research.\""),
        no = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"Astounding!  These conditions are clearly Earth-like, but the recordings performed unexpected loops in its subroutines.  The topographical scan shows what appear to be deliberate patterns in the placement of whatever structures you may have encountered.  We suspect that this may be a location where spacetime is slipping in various directions.  We will forward this to Research and alert you if we need more scans.\""),
    },
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }) } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_MORGANTOWN",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"This report shows signs of what we might call 'portal storm scarring.'  Preliminarily we expect this may be a site of significant activity during the initial portal storms, but we have forwarded it to Research for further study.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_BARRICADED_CHURCH",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"This report shows signs of what we might call 'portal storm scarring.'  We also noted some other features suggesting extradimensional materials may have been, or are, present.  Preliminarily we suspect this may be a site of significant activity during the initial portal storms.  We have forwarded it to Research for further study.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_STRING_DIMENSION",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"Your story would be unbelievable if it weren't for these recordings.  Even the mundane aspects, like the temperature and humidity, are astounding.  We have forwarded this report to Research for further study.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_SPIRAL_MINE",
    line = ccb.content.text("You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"The graph you perhaps saw on the report is an anomalous ground radar recoding.  The instruments in the HEW system are not very advanced, but they've clearly picked up someone with intelligent design.  We've forwarded it to Research for further study.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_VOID_SPIDER_LAIR",
    line = ccb.content.text("&You deposit the sheet in the tray.  The person behind the microphone starts mumbling, as if speaking to someone off mic:  \"New HEW…  yeah…  atmospheric readings are normal…  subterranean…  several returned null, look.  Should be noisy…  yeah…  no, can't read the GC-MS until we plug it in…  right…  could be the instrument, but we've seen recordings like this before.\"\n\nThe intercom clicks twice, off then on, then the tray slides open, this time with a pile of coins.  \"This is an odd one.  We've turned it over to Research, but you might expect a relevant contract to be added to your list in the future.  Keep an eye out.  Thank you for your contributions to science, as always.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_PORTAL_STORM_DUNGEON",
    line = ccb.content.text("&You deposit the sheet in the tray.  After a long silence, the tray opens again, this time with a pile of coins.  \"We imagine what you experienced was harrowing, but we think this may be a localized effect of the portal storm, rather than a new world.  It's difficult to tell from the recordings.  But they are nevertheless valuable, and we have turned them over to Research for further investigation.  Thank you for your contributions to science, as always.  If you return, please note any, let us say, passageways, that you may see, which could, well, lead to other places.  Yes?  Clear?  Thank you.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"),
                actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }),
                actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_SELL_HEW_DATA_INNER_CABINS",
    line = {
        when = predicates.handler("dlg_p_dda_2facb0b881bc"),
        yes = ccb.content.text("&You deposit the sheet in the tray and collect your payment.  \"Well, another report from that \"place\".  It's different, and we have growing confidence it is real, however distant.  Let us know if you have any other reports.\""),
        no = {
            when = predicates.handler("dlg_p_dda_bff2be0ec026"),
            yes = ccb.content.text("&You deposit the sheet in the tray and tell them all about that far-away world.  \"…  Well, that's certainly a report.  This is consistent with your previous reports, but the recording is suspiciously normal in many respects.  Perhaps a hallucination induced by interdimensional travel?  Perhaps everything you saw was here, in New England?  Not that we doubt your mental faculties, of course.  Anyway…  we look forward to future reports.\""),
            no = ccb.content.text("&You deposit the sheet in the tray and tell them all about that far-away world.  \"…  Well, that's certainly a report.  Based on these readings, I can tell you the place was certainly real, but it's not so different from here.  Perhaps a hallucination induced by the portal storms?  Perhaps everything you saw was here, in New England?  Not that we doubt your mental faculties, of course.  Anyway…  we look forward to future reports.\""),
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "dialogue_intercom_accepted_HEW_recording", "yes"), actions.set_string({ scope = "global", key = "hub01_intercom_accepted_HEW_recording" }, { "yes" }), actions.finish_mission("MISSION_ROBOFAC_INTERCOM_MWS_4", { success = true }) } },
    },
}
