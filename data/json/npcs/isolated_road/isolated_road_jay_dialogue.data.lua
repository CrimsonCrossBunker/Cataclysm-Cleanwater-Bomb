local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_SERVICES",
    line = ccb.content.text("Welcome to the first American bank of munitions.  We convert your goods and services to the new gold standard."),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "u_met_isolated_road_artisans", "yes"), actions.set_actor_value("speaker", "u_met_isolated_road_jay", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("About that contract…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("What's your deal?"),
            next_topic = "TALK_GUNSMITH_ABOUT",
        },
        {
            text = ccb.content.text("Munitions?"),
            next_topic = "TALK_GUNSMITH_SHOP_ABOUT",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_knows_about_conversion" } })),
        },
        {
            text = ccb.content.text("Hey.  Cody wanted to say that she's sorry.  She thought that you would want to see this."),
            next_topic = "TALK_GUNSMITH_KORD",
            when = predicates.all({ predicates.has_inventory("speaker", "broken_kord", 1), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_mentioned_quest" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_completed_quest" } }) }),
            actions = { actions.transfer_items("broken_kord") },
        },
        {
            text = ccb.content.text("I'm interested in helping with that thing for Cody."),
            next_topic = "TALK_GUNSMITH_Q1_DETAILS",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_mentioned_quest" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_accepted_quest" } })) }),
            actions = { actions.offer_mission("MISSION_GUNSMITH_1"), actions.set_actor_value("speaker", "dialogue_artisans_gunsmith_accepted_quest", "yes") },
        },
        {
            text = ccb.content.text("I'd like to exchange some rounds."),
            next_topic = "TALK_GUNSMITH_CONVERT_FROM_TYPE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_knows_about_conversion" } }),
        },
        {
            text = ccb.content.text("How are my rounds coming?"),
            next_topic = "TALK_GUNSMITH_BULLET_PICKUP",
            when = predicates.handler("dlg_p_dda_df5563c8a03b"),
        },
        {
            text = ccb.content.text("I'd like to convert some rounds."),
            next_topic = "TALK_GUNSMITH_CONVERT_TO_TYPE",
            when = predicates.handler("dlg_p_dda_09d75b71ed57"),
        },
        {
            text = ccb.content.text("Are you and Cody close?"),
            next_topic = "TALK_GUNSMITH_CODY",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_mentioned_cody" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_gunsmith_accepted_quest" } })) }),
        },
        {
            text = ccb.content.text("What is this place?"),
            next_topic = "TALK_GUNSMITH_LOCATION_ABOUT",
        },
        {
            text = ccb.content.text("About those contracts…"),
            next_topic = "TALK_MISSION_LIST_ASSIGNED",
            when = predicates.assigned_missions(2),
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_artisans_made_up" } }), predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }) }),
        },
        {
            text = ccb.content.text("Let's trade."),
            next_topic = "TALK_GUNSMITH_SERVICES",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("How's the 'printing' thing going?"),
            next_topic = "TALK_GUNSMITH_RESTOCK",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_RESTOCK",
    line = ccb.content.text("Next series of currency gotta be ready around <restock_time_point>, fresh off the print!"),
    replies = {
        {
            text = ccb.content.text("I'll make sure to take a look.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_SHOP_ABOUT",
    line = ccb.content.text("Fuck yeah.  New currency is death and I'm dealing it."),
    replies = {
        {
            text = ccb.content.text("I understand, but how does this work exactly?"),
            next_topic = "TALK_GUNSMITH_SHOP_ABOUT_MORE",
        },
        { text = ccb.content.text("…"), next_topic = "TALK_GUNSMITH_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_SHOP_ABOUT_MORE",
    line = ccb.content.text("Pretty simple stuff, bud.  I barter in pre-shitshow ammo, and to stimulate the growing economy, I print and issue more.  I take your goods - Cody would call it labor - and exchange it for the new universal currency.  If you want to convert currency I'm happy to facilitate, but it'll take a few days and there is a service charge."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_artisans_gunsmith_knows_about_conversion", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("So you're really going all in on this bank thing?"),
            next_topic = "TALK_GUNSMITH_SERVICES",
        },
        {
            text = ccb.content.text("So you'll exchange bullets for other bullets directly?"),
            next_topic = "TALK_BULLET_EXCHANGE_INFO",
        },
        { text = ccb.content.text("…"), next_topic = "TALK_GUNSMITH_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_ABOUT",
    line = ccb.content.text("I did a boring IT job and prepped for this shit.  Look at me now."),
    replies = {
        { text = ccb.content.text("Look at you now."), next_topic = "TALK_GUNSMITH_SERVICES" },
        { text = ccb.content.text("…"), next_topic = "TALK_GUNSMITH_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_LOCATION_ABOUT",
    line = ccb.content.text("It's my house.  Cody's in the other building, if you've met her.  We dug a trench and set up some milspec turrets.  I programmed them, Cody armored them.  Now we're just trying to get by.  This ain't the wizard of Oz, you can look behind the curtain over there."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_artisans_gunsmith_mentioned_cody", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Where'd you get half a dozen milspec turrets?"),
            next_topic = "TALK_GUNSMITH_TURRETS",
        },
        { text = ccb.content.text("…"), next_topic = "TALK_GUNSMITH_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_TURRETS",
    line = ccb.content.text("*stares off into the distance.  \"The owners didn't need them anymore.  Not anymore…\""),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_GUNSMITH_SERVICES" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_CODY",
    line = ccb.content.text("Stuff is fucked all over, bud.  How about we stick to talking business?"),
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_GUNSMITH_SERVICES" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_KORD",
    line = ccb.content.text("Where did you… I- I don't know what to say.\"  Jay takes the rifle reverently.  \"What did they do to this thing?  The receiver's all chopped up!\"  He turns it over so carefully that you could mistake him for holding a child instead of a gun.  \"This thing was beautiful.  Modern rails, ergonomic furniture, recoil balancing system… At least it's all still here.  I know Cody thinks that she did something wrong, but all I remember is being so angry… just blindingly furious.  Then I was running.  When I woke up, everything was fine.\"\n\n\"Thank you for letting me see this, and for getting Cody and I talking.  If you could help me out with something for Cody, I'll make this rifle right, and hook you up with a casket mag and a box of the good ammo for it.  Stuff from my reserves."),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "dialogue_artisans_gunsmith_mentioned_quest", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("I'm listening."),
            next_topic = "TALK_GUNSMITH_Q1_DETAILS",
            actions = { actions.offer_mission("MISSION_GUNSMITH_1"), actions.set_actor_value("speaker", "dialogue_artisans_gunsmith_accepted_quest", "yes") },
        },
        {
            text = ccb.content.text("Not really interested."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'll think about it."),
            next_topic = "TALK_GUNSMITH_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GUNSMITH_Q1_DETAILS",
    line = ccb.content.text("Alright, so Cody has talked about some cutting-edge tech she's seen displayed.  This thing is called a nano-fabricator.  It's like a complicated, robotic 3D printer.  Cody used to run with some hackers that steal IP, schematics, that sort of thing.  I guess a problem they were running into was the newest tech stuff is all encrypted as templates for these printers.  Well, I know of a colleague who went home with debug software for the system.  You get that for her, and we're in business."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_artisans_gunsmith_mentioned_quest", "yes"),
            },
        },
    },
    replies = {
        { text = ccb.content.text("I'll see if I can find it."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Alright."), next_topic = "TALK_GUNSMITH_SERVICES" },
    },
}
