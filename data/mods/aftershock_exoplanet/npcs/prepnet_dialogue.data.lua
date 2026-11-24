local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_PrepNet_gardener_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_prepnet_gardener" } }),
        yes = {
            choices = {
                ccb.content.text("Hey there."),
                ccb.content.text("Hello."),
                ccb.content.text("How are you?"),
                ccb.content.text("Welcome!"),
                ccb.content.text("How's the weather?"),
            },
        },
        no = ccb.content.text("Howdy!  You seem new, what brings you here?"),
    },
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_prepnet_gardener", "yes") },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_prepnet_gardener" } })),
            next_topic = "TALK_PrepNet_gardener_firstmeet",
        },
        {
            text = ccb.content.text("What is this place?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_prepnet_gardener" } }),
            next_topic = "TALK_PrepNet_gardener_place",
        },
        {
            text = ccb.content.text("What's your story?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_prepnet_gardener" } }),
            next_topic = "TALK_PrepNet_gardener_ask_past",
        },
        {
            text = ccb.content.text("How are things here?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_prepnet_gardener" } }),
            next_topic = "TALK_PrepNet_gardener_ask_mood",
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_prepnet_gardener" } }),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("How do I join the phyle?"),
            next_topic = "TALK_PrepNet_gardener_ask_membership",
        },
        { text = ccb.content.text("I'm going on my way now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PrepNet_gardener_firstmeet",
    line = ccb.content.text("I'm a gardener for PrepNet Phyle.  Who are you?"),
    replies = {
        {
            text = ccb.content.text("I am a beggar who really needs something to eat."),
            next_topic = "TALK_PrepNet_gardener_food",
        },
        {
            text = ccb.content.text("I am just a fellow survivor."),
            next_topic = "TALK_PrepNet_gardener_1",
        },
        {
            text = ccb.content.text("I'm bringing order back to the land."),
            next_topic = "TALK_PrepNet_gardener_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PrepNet_gardener_place",
    line = ccb.content.text("This is a PrepNet Phyle orchard.  We were a community of survivalists gathering resources to prepare for climate change, but it left us better prepared for what actually happened than most."),
    replies = {
        {
            text = ccb.content.text("Can you give me something to eat then?"),
            next_topic = "TALK_PrepNet_gardener_food",
        },
        {
            text = ccb.content.text("What can I buy here?"),
            next_topic = "TALK_PrepNet_gardener_ask_goods",
        },
        { text = ccb.content.text("Oh, okay."), next_topic = "TALK_PrepNet_gardener_1" },
        {
            text = ccb.content.text("Only the insane will prosper, I guess."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PrepNet_gardener_food",
    line = ccb.content.text("This food has to go back to our core communities.  But maybe we can trade some food for services."),
    replies = {
        {
            text = ccb.content.text("I can pay."),
            next_topic = "TALK_PrepNet_gardener_ask_food_bribe",
        },
        { text = ccb.content.text("What do you need done?"), next_topic = "TALK_MISSION_LIST" },
        { text = ccb.content.text("Well I'm heading out then."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PrepNet_gardener_ask_food_bribe",
    line = ccb.content.text("You have to earn the right to trade with us.  Plus we created our own currency before the Cataclysm."),
    replies = {
        { text = ccb.content.text("It was worth a try."), next_topic = "TALK_PrepNet_gardener_1" },
        {
            text = ccb.content.text("What kind of currency?"),
            next_topic = "TALK_PrepNet_gardener_currency",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PrepNet_gardener_ask_membership",
    line = ccb.content.text("This is just an outpost, you'd have to find our main camp and currently we don't want you to."),
    replies = {
        {
            text = ccb.content.text("I didn't want to join your club anyway."),
            next_topic = "TALK_PrepNet_gardener_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PrepNet_gardener_ask_goods",
    line = ccb.content.text("Here?  Fruits and berries.  Maybe the occasional piece of farm equipment, but you'll need crypto coins."),
    replies = {
        { text = ccb.content.text("Ok."), next_topic = "TALK_PrepNet_gardener_1" },
        {
            text = ccb.content.text("Crypto coins?  Are you insane, there isn't any global internet now."),
            next_topic = "TALK_PrepNet_gardener_currency",
        },
        {
            text = ccb.content.text("What can I buy here?"),
            native_actions = { "start_trade" },
            next_topic = "TALK_PrepNet_gardener_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PrepNet_gardener_ask_past",
    line = ccb.content.text("I got introduced to the movement through Mutual Aid Society.  From there it became an all consuming part of my life to prepare for a post consumption world.  It seems to have worked better for us than for many others."),
    replies = {
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_PrepNet_gardener_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PrepNet_gardener_ask_mood",
    line = ccb.content.text("It can get lonely out here between caravans.  But there's plenty of work and my Cyber Mastiffs.  If a horde comes through we hunker down in a nearby shelter if it's too large for us."),
    replies = {
        {
            text = ccb.content.text("I'm glad you stay busy."),
            next_topic = "TALK_PrepNet_gardener_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_PrepNet_gardener_currency",
    line = ccb.content.text("We use so-called crypto coins for money here.  They were a pre-Cataclysm attempt to abstract money even further and create electronic cash.  Now it's a joke because we use physical coins.  Barter only gets you so far.  And one day we'll have the Net back up."),
    replies = {
        { text = ccb.content.text("Oh, okay."), next_topic = "TALK_PrepNet_gardener_1" },
        {
            text = ccb.content.text("What can I buy here?"),
            native_actions = { "start_trade" },
            next_topic = "TALK_PrepNet_gardener_1",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_PrepNet_gardener_FUR_1",
    name = ccb.content.text("Big Game Hunting"),
    description = ccb.content.text("Find 50 fur pelts."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "fur",
    item_count = 50,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_PrepNet_gardener_FOOD_2",
    dialogue = {
        describe = ccb.content.text("I need 50 fur pelts."),
        offer = ccb.content.text("I've got to maintain the orchard but at nights I work on prepping winter clothes.  Could you find about… 50 fur pelts for me?"),
        accepted = ccb.content.text("Don't forget to tell me when you have them."),
        rejected = ccb.content.text("It's okay, I can do without them.  Just let me know if you reconsider."),
        advice = ccb.content.text("There's a lot of places to look.  The entire outdoors is full of wild animals."),
        inquire = ccb.content.text("How is the search going?  Have you found 'em?"),
        success = ccb.content.text("I really appreciate your help.  Don't worry, you won't leave empty-handed."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("Don't worry about it, it's not that important."),
    },
    finish = { item_rewards = { { item = "crypto_coin", count = 6 } } },
}

ccb.content.define_mission {
    id = "MISSION_PrepNet_gardener_FOOD_2",
    name = ccb.content.text("Bread"),
    description = ccb.content.text("Find 50 flour."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 0,
    item = "flour",
    item_count = 50,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_PrepNet_gardener_FOOD_3",
    dialogue = {
        describe = ccb.content.text("I need 50 flour."),
        offer = ccb.content.text("Flour would let me break the monotony of fruit and meats."),
        accepted = ccb.content.text("Thanks for accepting this task.  Otherwise I might kill a stranger for a sandwich.  Just kidding."),
        rejected = ccb.content.text("Just let me know if you change your mind."),
        advice = ccb.content.text("Flour is not that hard to find.  I'd look for them in residential areas and professional kitchens or bakeries."),
        inquire = ccb.content.text("Have you found the flour?"),
        success = ccb.content.text("Thank you for your help.  Here's your reward."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("It's not a big deal, it isn't that urgent."),
    },
    finish = { item_rewards = { { item = "crypto_coin", count = 5 } } },
}

ccb.content.define_mission {
    id = "MISSION_PrepNet_gardener_FOOD_3",
    name = ccb.content.text("Gallon Jugs"),
    description = ccb.content.text("Find 5 gallon jugs."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 1,
    value = 0,
    item = "jug_plastic",
    item_count = 5,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_PrepNet_gardener_QUEST_4",
    dialogue = {
        describe = ccb.content.text("I need storage for various liquid products when the fruits come in."),
        offer = ccb.content.text("Every season we produce so much fruit.  Some of it will be turned into juice and some into alcohol.  I need easy containers to load it on the caravan."),
        accepted = ccb.content.text("Thank you for accepting.  I'm almost out after the last caravan."),
        rejected = ccb.content.text("I guess I'll have to make stomach waterskins."),
        advice = ccb.content.text("Gallon jugs are not that rare to find.  They are commonly found in kitchens."),
        inquire = ccb.content.text("Do you have those jugs now?"),
        success = ccb.content.text("I am grateful for the help you've done.  I have one more task to do."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("Don't worry about it, it's not that important."),
    },
    finish = { item_rewards = { { item = "crypto_coin", count = 3 } } },
}

ccb.content.define_mission {
    id = "MISSION_PrepNet_gardener_QUEST_4",
    name = ccb.content.text("Burnt Out CBMs"),
    description = ccb.content.text("Find 5 burnt out CBMs."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 0,
    item = "burnt_out_bionic",
    item_count = 5,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("We have the ability to manufacture CBMs but lack resources."),
        offer = ccb.content.text("If you can bring me burnt out CBMs we can recycle them into new ones."),
        accepted = ccb.content.text("Thank you for accepting.  You're really making yourself useful to the phyle."),
        rejected = ccb.content.text("These materials are often in dangerous areas.  I understand your decision."),
        advice = ccb.content.text("Zombie scientists, technicians, shocker zombies.  These are not undertaken lightly."),
        inquire = ccb.content.text("Do you have those CBMs now?"),
        success = ccb.content.text("I am grateful for the help you've done.  I think we might be able to introduce you to others soon."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("Don't worry about it, it's not that important."),
    },
    finish = { item_rewards = { { item = "crypto_coin", count = 12 } } },
}
