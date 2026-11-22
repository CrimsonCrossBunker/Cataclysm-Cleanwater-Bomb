local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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
