local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_DoneTrading",
    line = {
        choices = {
            ccb.content.text("Hope it helps."),
            ccb.content.text("Give me second to write that down… okay, done."),
            ccb.content.text("You know where to find me."),
        },
    },
    on_enter = {
        { actions = { "distribute_food_auto" } },
    },
    replies = {
        {
            text = ccb.content.text("About other things…"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("Let's trade."),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_5376c19ccc7f") },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_DoneTrading", actions = { "start_trade" } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_CANNIBAL_GTFO" },
        },
        {
            text = ccb.content.text("When will you have new stuff in stock?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AskedRestock",
        },
        {
            text = ccb.content.text("That's all for now.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AskedRestock",
    line = {
        choices = {
            ccb.content.text("Next shipment should arrive in around <restock_time_point>."),
            ccb.content.text("Stick around 'til <restock_time_point>, there will surely be something you'd like."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("Thanks, I will make sure to check back.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Intro",
    line = {
        joined = {
            ccb.content.text("Before you ask, we're full.  You're right about the refugee part, but we're way over capacity right now.  We don't have the food or space to take on anyone else.\"  He softens a little.  \"As for me, I do a lot of things here, but mostly I keep tabs on our supplies.  You can call me Smokes, or Gavin; whichever you prefer.  I also trade with people from outside, like you.  If you're in the market for hardware, we're selling, and if you have food, we are very much buying.  Anyways, uh, what can I do for you"),
            {
            when = predicates.handler("dlg_p_dda_e9d71f52da0b"),
            yes = ccb.content.text("?\"\n\nLiam looks around at the crowded room, speaking in a soft voice for just your ears.  \"Can't honestly believe people are trying to crowd in here.  They're all so scared, this is a death trap."),
            no = ccb.content.text("?"),
        },
        },
    },
    on_enter = {
        { when = predicates.negate(predicates.has_effect("speaker", "u_Gavin_onetime_greeting")), once = "has_onetime_greeting_effect", actions = { actions.add_effect("speaker", "u_Gavin_onetime_greeting", { turns = 43200 }) } },
    },
    replies = {
        {
            text = ccb.content.text("Got some time to talk?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("Let's trade."),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_5376c19ccc7f") },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_DoneTrading", actions = { "start_trade" } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_CANNIBAL_GTFO" },
        },
        {
            text = ccb.content.text("I just wanted to look around.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FREE_MERCHANTS_MERCHANT_Talk", "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_End", "TALK_FREE_MERCHANTS_MERCHANT_AboutMerch", "TALK_FREE_MERCHANTS_MERCHANT_WhosInCharge" },
    line = {
        choices = {
            ccb.content.text("What's on your mind?"),
            ccb.content.text("Lay it on me."),
            ccb.content.text("Alright, shoot."),
            ccb.content.text("Something on your mind?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm here on behalf of a group called the Exodii.  They're interested in establishing trade."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants",
            when = predicates.handler("dlg_p_dda_a42ad18468ec"),
        },
        {
            text = ccb.content.text("I'm here on behalf of a group called the Exodii.  They're interested in establishing trade.  Except I seem to have forgotten the radio I was supposed to bring.  I'll come back later."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_9e0a72bc07b7"),
        },
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you offer any help?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_BorisCleanup",
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
        },
        {
            text = ccb.content.text("Can I talk to you about that fellow over there in the dinosaur suit?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_DavePermission",
            when = predicates.has_mission("MISSION_BEGGAR_2_PERMISSION"),
        },
        {
            text = ccb.content.text("'Sorry, we're full'?  Do you greet everyone like that?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting",
            when = predicates.has_effect("speaker", "u_Gavin_onetime_greeting"),
            actions = { actions.remove_effects("speaker", { "u_Gavin_onetime_greeting" }) },
        },
        {
            text = ccb.content.text("What are you doing out here?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Plans",
        },
        {
            text = ccb.content.text("You're having trouble with food?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_TroubleWithFood",
        },
        {
            text = ccb.content.text("You mentioned you were selling hardware?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_SellingHardware",
        },
        {
            text = ccb.content.text("What's with these people in the lobby?  Are they with you?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Beggars",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_beggars_recruited" } })),
        },
        {
            text = ccb.content.text("I took care of your beggar problem."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_BeggarsRecruited",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_beggars_recruited" } }), predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_recruit_beggars_reward_agreed" } }) }),
            actions = { actions.clear_actor_value("interlocutor", "general_recruit_beggars_reward_agreed") },
        },
        {
            text = ccb.content.text("Who's in charge here?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_WhosInCharge",
        },
        {
            text = ccb.content.text("Is there any way I can join your group?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AskJoin",
        },
        {
            text = ccb.content.text("What's with these 'Free Merchant certified notes'?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutMerch",
            when = predicates.has_item("speaker", "FMCNote"),
            actions = { actions.set_actor_value("speaker", "general_free_merchants_u_knows_about_merch", "yes") },
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutMe",
        },
        {
            text = ccb.content.text("Have you heard anything about the rest of the world?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_OutsideWorld",
        },
        {
            text = ccb.content.text("I'm looking for work.  Can I do anything for the center?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Let's trade."),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_5376c19ccc7f") },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_DoneTrading", actions = { "start_trade" } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_CANNIBAL_GTFO" },
        },
        {
            text = ccb.content.text("Are you interested in buying any processed lumber?"),
            next_topic = "TALK_EVAC_MERCHANT_DEAL_NEGOTIATE",
            when = predicates.has_mission("MISSION_LUMBERMILL_SET_TRADE_ROUTE"),
        },
        {
            text = ccb.content.text("Does this center need any metal?"),
            next_topic = "TALK_EVAC_MERCHANT_DEAL_NEGOTIATE",
            when = predicates.has_mission("MISSION_SCRAPPER_SET_TRADE_ROUTE"),
        },
        {
            text = ccb.content.text("Are you interested in any chemical supplies?"),
            next_topic = "TALK_EVAC_MERCHANT_DEAL_NEGOTIATE_CHEM",
            when = predicates.has_mission("MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE"),
        },
        {
            text = ccb.content.text("That's all for now.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FREE_MERCHANTS_MERCHANT_Beggars", "TALK_FREE_MERCHANTS_MERCHANT_Beggars2", "TALK_FREE_MERCHANTS_MERCHANT_Beggars3" },
    line = ccb.content.text("No, unfortunately.  They're folks that wanted to join us, but we're too full and we don't have enough to share.  Most people leave and look for their own place when we turn them down, but these ones… didn't.  We've been trying to find them a safe place, but there's a shortage of those these days, for reasons I'm sure you can guess.  Until then, we're letting them crash here as long as they don't mess the place up."),
    replies = {
        {
            text = ccb.content.text("[Social 1] If I could look into clearing them out of here, would you be able to pay me back?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Beggars_Reward",
            when = predicates.handler("dlg_p_dda_e5d79fed3b60"),
            actions = { actions.set_actor_value("interlocutor", "general_recruit_beggars_reward_agreed", "yes") },
        },
        {
            text = ccb.content.text("Why haven't they gone anywhere else?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Beggars2",
        },
        {
            text = ccb.content.text("Couldn't you get them out?  Your guards are well-armed."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Beggars3",
        },
        {
            text = ccb.content.text("Best of luck."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Beggars2",
    line = {
        joined = {
            ccb.content.text("I don't know, why don't you ask them?  I haven't pried, but where else do they have to go?  You've seen how bad it is out there.  We don't have the space for them, but it won't kill us to give them some shelter as long as they aren't too much of a drain on resources"),
            {
            when = predicates.handler("dlg_p_dda_e9d71f52da0b"),
            yes = ccb.content.text(".\"\n\n\"Don't you guys have, like, scavengers and things?\"  Liam sounds like he's trying not to get irritated with Smokes.  \"Can't these guys help out in some way in exchange for food?  It seems insane to just keep them sitting in your entry way.\"\n\nSmokes gives him a long-suffering look.  \"Like I said, ask them.  We can't take them in, though.  It's not just them.  We've had to turn away dozens of people, if we started making exceptions we'd be dead meat.  These guys are just the ones who didn't try their luck out there, they've got their reasons I guess.  I don't like this any more than you do."),
            no = ccb.content.text("."),
        },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Beggars3",
    line = ccb.content.text("Jesus, man, we aren't monsters.  I'm sure we could get them out if we really needed to, yeah, but why would we do that?  We need to be stringent with who we take on, that's true, but forcing out people in need isn't a great way to convince anyone that we're reliable allies.  The world doesn't run on good faith, but it's damn well nicer to live in because of it."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Beggars_Reward",
    line = ccb.content.text("We don't have a lot to share, but… well, I guess it's not safe for them.  At best, it's a health hazard waiting to happen.  We could pay you in merch if you can clear them out without anyone getting hurt, yeah."),
    replies = {
        {
            text = ccb.content.text("I'll see what I can do.  What's merch?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutMerch",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_merchants_u_knows_about_merch" } })),
        },
        {
            text = ccb.content.text("No guarantees, but I'll see what I can do."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_BeggarsRecruited",
    line = ccb.content.text("I appreciate it a lot, getting them somewhere safe.  I hope that's what you did, anyway.  In any case, having the lobby clear is a big help.  Even with the uh, cardboard guy still around, he's a lot easier to handle alone."),
    on_enter = {
        { actions = { actions.update_map("shopkeep_lobby_cleanup1", "evac_center_13"), actions.update_map("shopkeep_lobby_cleanup2", "evac_center_18") } },
    },
    replies = {
        {
            text = ccb.content.text("I do believe we discussed a reward?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_BeggarsRecruited_Reward",
        },
        {
            text = ccb.content.text("Just glad to help."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_BeggarsRecruited_Reward",
    line = {
        joined = {
            ccb.content.text("And so we did.\"  Smokes reaches under their table, counts out some money, and slides it through a slot in the glass.  \"Here's five merch a head for the folks you found a new home for.  We won't forget it"),
            {
            when = predicates.handler("dlg_p_dda_1580c9fd076b"),
            yes = ccb.content.text(".\"\n\nLuo puts her hands on her hips.  \"You're getting *paid* for… ah, fuck it.  I should be pissed, but honestly I'm so glad to be out of this place, I can't even be mad.  That's really saying something, coming from me."),
            no = ccb.content.text("."),
        },
        },
    },
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_9d4a5a864597") } },
    },
    replies = {
        {
            text = ccb.content.text("Thank you!"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = {
        "TALK_FREE_MERCHANTS_MERCHANT_OutsideWorld", "TALK_FREE_MERCHANTS_MERCHANT_OutsideWorld1",
        "TALK_FREE_MERCHANTS_MERCHANT_OutsideWorld2",
    },
    line = ccb.content.text("Not as much as I'd like, I'm afraid.  Most of these shelters seemed to have been designed to make people *feel* safer, not to actually keep them safe.  Our radio equipment is terrible… I don't think it was even meant to be used seriously.  I've heard some talk of hordes."),
    replies = {
        {
            text = ccb.content.text("Hordes?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_OutsideWorld1",
        },
        {
            text = ccb.content.text("Are there any other settlements around?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Robofac",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_merchants_u_hub01_breadcrumb_accepted" } })),
        },
        {
            text = ccb.content.text("Are there any other settlements around?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_OutsideWorld2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_merchants_u_hub01_breadcrumb_accepted" } }),
        },
        {
            text = ccb.content.text("That's fine for now."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FREE_MERCHANTS_MERCHANT_SellingHardware", "TALK_FREE_MERCHANTS_MERCHANT_SellingHardware1" },
    line = ccb.content.text("Tools, to be precise.  The basement and the storage rooms had way more than we need, and a lot of people brought their own when they were evacuating.  There's more than we could ever use, so we'll be happy to sell them at a very fair price.  Nothing in the way of radios, so you'll have to look somewhere else for that."),
    replies = {
        {
            text = ccb.content.text("Wait, basement?  I didn't know this place had a basement."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Basement",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_merchants_u_knows_about_basement" } })),
            actions = { actions.set_actor_value("speaker", "general_free_merchants_u_knows_about_basement", "yes") },
        },
        {
            text = ccb.content.text("Mind if I take a look at your stock?"),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_5376c19ccc7f") },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_DoneTrading", actions = { "start_trade" } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_CANNIBAL_GTFO" },
        },
        {
            text = ccb.content.text("Radios?  That seems awfully specific."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_SellingHardware1",
        },
        {
            text = ccb.content.text("Good to know."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_SellingHardware1",
    line = ccb.content.text("We've had some issues with scavengers.  Apparently a big part of the marketing for these shelters was high-end radio equipment that they could use to keep in touch with each other, and a lot of the people we've traded with have asked about it.  Not that we don't have any radios, mind you, but they're all absolutely awful.  Even if we *could* spare any, they'd be useless to anyone that actually needed it - not much point in lugging around a ham radio that can't pick up anything more than a mile away."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_TroubleWithFood",
    line = ccb.content.text("Yes we are.  The center had a good stock of those awful soy bars, but between all of us, it went fast.  We're making do with what we can skim off the edge of towns, but mostly we rely on trade from people like you.  Speaking of, we'll pay top dollar for anything preserved - canned, salted, dried, whatever.  Just talk to the broker in the back."),
    replies = {
        {
            text = ccb.content.text("I don't see that many of you around."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Basement",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_merchants_u_knows_about_basement" } })),
            actions = {
                actions.set_actor_value("speaker", "general_free_merchants_u_knows_about_basement", "yes"),
            },
        },
        {
            text = ccb.content.text("I'll keep that in mind."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_MERCHANT_DEAL_NEGOTIATE",
    line = ccb.content.text("Sure, we could use some around here for repairs and whatnot.  What are the terms?"),
    replies = {
        {
            text = ccb.content.text("Well, how about 250 merch for 100 pounds of…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_01edabb98966") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_MERCHANT_DEAL_NEGOTIATE_CHEM",
    line = ccb.content.text("Chemicals?  I'm sure we could find some use for them, and we are in need of medical supplies.  What's the offer?"),
    replies = {
        {
            text = ccb.content.text("Well, how about 300 merch for 10 liters of…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_01edabb98966") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_CANNIBAL_GTFO",
    line = ccb.content.text("Listen, buddy.  We were putting away some of the last food you gave us and noticed it was… off.  Okay I'll cut the shit- It was people.  I don't know how you got it, or what you did, but we aren't taking any chances.  You are not welcome here anymore.  <color_red>I'll give you one minute</color> to fuck off and never come back."),
    on_enter = {
        { actions = { "end_conversation", actions.handler("w16b_a_dda_4548838cb2cf") } },
    },
    replies = {
        {
            text = ccb.content.text("But I-"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants",
    line = {
        when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
        yes = ccb.content.text("Well, from taking a look at you, I can only guess what these Exodii are all about.  But trade's trade, so tell me more."),
        no = ccb.content.text("Exodii?  Tell me more."),
    },
    replies = {
        {
            text = ccb.content.text("[Boot up the Exodii TV-radio] Maybe it's best if their representative does the talking.  We'll call them on this screen.  They sort of speak English, and I can try and translate back and forth."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations",
        },
        {
            text = ccb.content.text("I mean, just look at me!  They're cyborgs from another dimension.  They turn humans and maybe other beings into cyborgs, and jump from here to there, dodging cataclysms like ours.  And they're very interested in trade."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_2",
            when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
            actions = { actions.adjust_faction_trust(1) },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_2",
            actions = { actions.adjust_faction_trust(2) },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings that use a mix of futuristic and ancient technology, the latter being mostly due to their last landing place being an ancient battlefield of some sort.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  While their choice for personal defense was more along the lines of ancient gear like spears and swords.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_2",
            actions = { actions.adjust_faction_trust(3) },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings.  These guys are more metal than man in my opinion - they use automated machinery to do their fighting and heavy lifting.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic.  They are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_2",
            actions = { actions.adjust_faction_trust(4) },
        },
        {
            text = ccb.content.text("They are a race of inter-dimensional beings that use a mix of futuristic and ancient technology, the latter being mostly due to their last landing place being an ancient battlefield of some sort.  These guys are more metal than man in my opinion and use automated machinery to do their fighting and heavy lifting.  However their choice for personal defense was more along the lines of ancient gear like spears and swords.  They do understand English to a certain extent and when talking they use a strange dialect they like to call Anglic.  They are here to mine this place of any useful metal, gather any tech they deem worth saving and maybe even grab a couple of survivors to join their ranks before they move out."),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_know_exodii_purpose2" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "u_talk_exodii_about_medieval_stock" } }) }),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_2",
            actions = { actions.adjust_faction_trust(5) },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_2",
    line = ccb.content.text("Well, that's a lot to take in.  What do they want?"),
    replies = {
        {
            text = ccb.content.text("[Boot up the Exodii TV-radio] Maybe it's best if their representative does the talking.  We'll call them on this screen.  They sort of speak English, and I can try and translate back and forth."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Exodii_mission_meet_free_merchants_negotiations",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_MERCHANT_EXODII_MISSION_WAREHOUSE",
    line = {
        joined = {
            ccb.content.text("&You describe the warehouse to the best of your ability.  Smokes listens"),
            {
            when = predicates.any_equal({ "no", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            yes = ccb.content.text(", then shakes his head.  \"Not ringing a bell, I think I'd remember if I'd heard about something like that.\""),
            no = ccb.content.text(", then nods slowly.  \"This sounds a bit familiar, I remember a scavenger coming through a while ago with a weird story about a place like that.  Might be nothing though.\""),
        },
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "asked_about_exodii_warehouse_mission", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Oh well.  Thanks anyway.  I'll go ask around."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "no", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            actions = { actions.handler("dlg_a_dda_399f0cdb5f50") },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "shopkeep_lobby_cleanup1",
    layout = {
        tile_edits = {
            {
                shape = "rectangle",
                operation = "remove_items",
                x = 5,
                y = 22,
                end_x = 18,
                end_y = 23,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "shopkeep_lobby_cleanup2",
    layout = {
        tile_edits = { { shape = "rectangle", operation = "remove_items", x = 5, y = 0, end_x = 18, end_y = 2 } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }),
        yes = {
            choices = {
                ccb.content.text("Welcome back."),
                ccb.content.text("Hello again.  What do you need?"),
                ccb.content.text("*looks up.  \"Hey.\""),
            },
        },
        no = ccb.content.text("*waves you over.  \"I haven't seen you before.  Welcome to our little homely house.\""),
    },
    replies = {
        {
            text = ccb.content.text("Who are you?  This is a refugee center, right?"),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Intro",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } })),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_Gavin", "yes") },
        },
        {
            text = ccb.content.text("I'm looking for a specific, strange building.  I wonder if you've heard anything about it, maybe from some of the traders coming through?"),
            next_topic = "TALK_EVAC_MERCHANT_EXODII_MISSION_WAREHOUSE",
            when = predicates.all({ predicates.has_mission("EXODII_MISSION_WAREHOUSE"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "asked_about_exodii_warehouse_mission" } })) }),
            actions = { actions.handler("w16b_a_dda_9812bef589e2") },
        },
        {
            text = ccb.content.text("Just passing through, don't mind me."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } })),
        },
        {
            text = ccb.content.text("I wanted to talk."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_Talk",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }),
        },
        {
            text = ccb.content.text("Let's trade."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }),
            trial = { kind = "condition", when = predicates.handler("w16b_p_dda_8b2c9e90f0af") },
            success = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_DoneTrading", actions = { "start_trade" } },
            failure = { next_topic = "TALK_FREE_MERCHANTS_MERCHANT_CANNIBAL_GTFO" },
        },
        {
            text = ccb.content.text("Just saying hello.  Keep safe."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }),
        },
    },
}
