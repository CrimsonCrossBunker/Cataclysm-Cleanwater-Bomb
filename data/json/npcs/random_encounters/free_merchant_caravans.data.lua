local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Random NPC, non persistent, can direct you to the free merchants and sell you things.
ccb.content.define_npc {
    id = "FM_caravan_merchant_random",
    suffix = ccb.content.text("Caravan Merchant"),
    class = "NC_CARAVAN_MERCHANT",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_CARAVAN_MERCHANT_1",
    faction = "free_merchants",
}

-- Random NPC, non persistent, tells you about being a guard and directs you to free merchants.
ccb.content.define_npc {
    id = "FM_caravan_guard_A",
    suffix = ccb.content.text("Caravan Guard"),
    class = "NC_CARAVAN_GUARD",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_CARAVAN_GUARD_A1",
    faction = "free_merchants",
}

-- Random NPC, non persistent, doesn't have much to say.
ccb.content.define_npc {
    id = "FM_caravan_guard_B",
    suffix = ccb.content.text("Caravan Guard"),
    class = "NC_CARAVAN_GUARD",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_CARAVAN_GUARD_B",
    faction = "free_merchants",
}

ccb.content.define_npc_class {
    id = "NC_CARAVAN_MERCHANT",
    name = ccb.content.text("Trader"),
    job_description = ccb.content.text("I'm collecting gear and selling it."),
    common = false,
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
}

ccb.content.define_npc_class {
    id = "NC_CARAVAN_GUARD",
    name = ccb.content.text("Bounty Hunter"),
    job_description = ccb.content.text("I'm a killer for hire."),
    common = false,
    traits = {
        { group = "BG_survival_story_POLICE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 4 } } },
        { skill = "rifle", bonus = { rng = { 2, 4 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_1",
    line = ccb.content.gendered_line("Well well, another traveler.  Don't try anything, you're outnumbered here and we're well armed.", { "speaker" }),
    on_enter = { { actions = { actions.set_first_topic("TALK_CARAVAN_MERCHANT_2") } } },
    replies = {
        {
            text = ccb.content.text("Are you threatening me?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Threatening",
        },
        {
            text = ccb.content.text("What's your deal here?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Job",
        },
        {
            text = ccb.content.text("I won't try anything if you don't.  Just passing through."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_2",
    line = ccb.content.text("What can I do for you?"),
    replies = {
        {
            text = ccb.content.text("Do you have anything to trade?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Story",
        },
        {
            text = ccb.content.text("Nothing much.  Just passing through."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_Threatening",
    line = ccb.content.text("No, not at all.  Just being cautious.  You know how it gets out here.  We're not looking for trouble.  In fact, if you've got anything worthwhile, maybe we could do a little trading."),
    replies = {
        {
            text = ccb.content.text("Sure, let's trade."),
            next_topic = "TALK_CARAVAN_MERCHANT_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("What's your deal here?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Job",
        },
        {
            text = ccb.content.text("That suits me fine.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_Job",
    line = ccb.content.text("We're just travelers, making a pit stop.  Might be willing to trade a bit, if you've got anything to share.  We're not looking for trouble, there's plenty of that on the roads already."),
    replies = {
        {
            text = ccb.content.text("Sure, let's trade."),
            next_topic = "TALK_CARAVAN_MERCHANT_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("That's it?  What's your story?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Story",
        },
        {
            text = ccb.content.text("That suits me fine.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_Story",
    line = ccb.content.text("We're with a larger group of survivors, working out of one of the old FEMA bunkers.  Folks have taken to calling us Free Merchants, although that sounds kinda on the nose to me.  We know about a few survivor groups and we make regular trips around, sharing supplies back and forth and bringing them home.  We're on the way back now."),
    replies = {
        {
            text = ccb.content.text("That's interesting.  Well, let's trade."),
            next_topic = "TALK_CARAVAN_MERCHANT_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Can you give me directions to any of these other survivor groups?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Others",
        },
        {
            text = ccb.content.text("Where is 'home'?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Home",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("Thanks for chatting.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_Others",
    line = ccb.content.gendered_line("No offense, but my clients definitely would not like me giving strangers directions to their hideouts.  You'll have to find them on their own terms.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("I can understand that.  Well, let's trade."),
            next_topic = "TALK_CARAVAN_MERCHANT_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Where is 'home'?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Home",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("Thanks for chatting.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_Home",
    line = ccb.content.text("Here, I'll mark it on your map.  Feel free to come by and trade, or if you're the type, we might have use for your services as a merc."),
    on_enter = { { actions = { actions.assign_mission("MISSION_REACH_REFUGEE_CENTER") } } },
    replies = {
        {
            text = ccb.content.text("Hey, thanks.  Well, let's trade."),
            next_topic = "TALK_CARAVAN_MERCHANT_Trade",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Can you give me directions to any of these other survivor groups?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Others",
        },
        {
            text = ccb.content.text("Thanks for that.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_Trade",
    line = ccb.content.text("Always good to do a little trading."),
    replies = {
        {
            text = ccb.content.text("Actually, I had a little more to trade still."),
            next_topic = "TALK_CARAVAN_MERCHANT_Trade",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Thanks.  What were we talking about before?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Thanks for that.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_A1",
    line = ccb.content.text("Sup?  Nice to see a survivor.  If you're here for business, talk to the trader."),
    on_enter = { { actions = { actions.set_first_topic("TALK_CARAVAN_GUARD_A2") } } },
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_CARAVAN_GUARD_A_Job",
        },
        { text = ccb.content.text("Thanks for the tip."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_A2",
    line = ccb.content.text("Hi again.  You want something?"),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_CARAVAN_GUARD_A_Job",
        },
        {
            text = ccb.content.text("You looking for work?  I might be hiring."),
            next_topic = "TALK_CARAVAN_GUARD_A_Hire",
        },
        { text = ccb.content.text("Nope, just saying hi."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_A_Job",
    line = ccb.content.text("I'm a caravan guard, working for the Free Merchants.  I'm an independent contractor though.  Seems like a good way to get safety in numbers and try to find a safe place to settle down."),
    replies = {
        {
            text = ccb.content.text("So you're working for these guys, but aren't one of them?"),
            next_topic = "TALK_CARAVAN_GUARD_A_Merc",
        },
        {
            text = ccb.content.text("You looking for work?  I might be hiring."),
            next_topic = "TALK_CARAVAN_GUARD_A_Hire",
        },
        {
            text = ccb.content.text("The Free Merchants?  Do they have some kind of trade outpost or anything like that?"),
            next_topic = "TALK_CARAVAN_GUARD_A_Directions",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("It's a living, eh?  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_A_Merc",
    line = ccb.content.text("Yeah, these guys snagged some kind of FEMA evacuation bunker during the early part of <the_cataclysm> and hoard the space.  They don't let anyone else join, but they need supplies, so they send out traders, and those traders need protection, so they send out guys like me."),
    replies = {
        {
            text = ccb.content.text("You looking for work?  I might be hiring."),
            next_topic = "TALK_CARAVAN_GUARD_A_Hire",
        },
        {
            text = ccb.content.text("How do I get there?"),
            next_topic = "TALK_CARAVAN_GUARD_A_Directions",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("It's a living, eh?  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_A_Hire",
    line = ccb.content.text("I'm good for the moment, but you can usually find a merc or two waiting between jobs, back at the Free Merchant base."),
    replies = {
        {
            text = ccb.content.text("How do I get there?"),
            next_topic = "TALK_CARAVAN_GUARD_A_Directions",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_REFUGEE_CENTER")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_refugee_center" } })) }),
        },
        {
            text = ccb.content.text("Thanks for the tip!  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_A_Directions",
    line = ccb.content.text("Sure, I can mark it on your map if you like.  Here."),
    on_enter = { { actions = { actions.assign_mission("MISSION_REACH_REFUGEE_CENTER") } } },
    replies = {
        {
            text = ccb.content.text("Thanks for the tip!  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Thanks for the tip!  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_B",
    line = ccb.content.text("*tips their hat down from their eyes and looks at you blearily.  \"Huh?  Hey, I'm tryin'a sleep here.  I was on night watch.\""),
    replies = { { text = ccb.content.text("Oh, uh, sorry."), next_topic = "TALK_DONE" } },
}
