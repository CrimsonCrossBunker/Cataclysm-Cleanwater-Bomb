local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Appears in the refugee center as a bulk trader.  Promotes production of nonperishable food.
ccb.content.define_npc {
    id = "evac_broker",
    suffix = ccb.content.text("Broker"),
    class = "NC_TEAMSTER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_FREE_MERCHANT_STOCKS",
    faction = "free_merchants",
    missions_offered = "MISSION_BROKER_1",
}

-- table of contents - these options will appear in the listed dialogue topics
ccb.content.define_dialogue_topic {
    id = {
        "TALK_FREE_MERCHANT_STOCKS", "TALK_FREE_MERCHANT_STOCKS_NEW", "TALK_FREE_MERCHANT_STOCKS_ALL",
        "TALK_FREE_MERCHANT_STOCKS_BACKGROUND", "TALK_FREE_MERCHANT_STOCKS_FMCN",
        "TALK_FREE_MERCHANT_STOCKS_REFUGEES", "TALK_FREE_MERCHANT_STOCKS_BEGGARS",
        "TALK_FREE_MERCHANT_STOCKS_SEALED1", "TALK_FREE_MERCHANT_STOCKS_SEALED2",
        "TALK_FREE_MERCHANT_STOCKS_RANCH", "TALK_FREE_MERCHANT_STOCKS_Boris_Mission_1",
    },
    replies = {
        {
            text = ccb.content.text("I'm here to deliver some food supplies."),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_DELIVER",
        },
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you offer any help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_Boris_Mission_1",
        },
        {
            text = ccb.content.text("Are you able to buy some canning supplies?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_JARS",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_FMBroker_Mission1" } }),
        },
        {
            text = ccb.content.text("I was told you had work for me?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_FMShopkeep_Mission5" } }),
        },
        { text = ccb.content.text("Who are you?"), next_topic = "TALK_FREE_MERCHANT_STOCKS_NEW" },
        {
            text = ccb.content.text("What's the deal with this written-on paper money you guys use?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_FMCN",
        },
        {
            text = ccb.content.text("The refugees stuck up here seem a bit disgruntled."),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_REFUGEES",
        },
        {
            text = ccb.content.text("Do you know about those beggars in the lobby?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_BEGGARS",
        },
        {
            text = ccb.content.text("What's the deal with the closed-off areas of the building?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_SEALED1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_FMShopkeep_Mission1" } })),
        },
        {
            text = ccb.content.text("What are you going to do with that back bay area now that I've cleaned it out for you?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_SEALED2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_FMShopkeep_Mission1" } }),
        },
        {
            text = ccb.content.text("Tell me more about that ranch of yours."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_flag_tacoma_started" } }),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_RANCH",
        },
        { text = ccb.content.text("What were you saying before that?"), next_topic = "TALK_NONE" },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic { id = "TALK_FREE_MERCHANT_STOCKS", line = ccb.content.text("What can I help you with?") }

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_DELIVER",
    line = ccb.content.text("Excellent.  What've you brought us?"),
    repeat_replies = {
        {
            items = {
                "jerky", "meat_smoked", "fish_smoked", "dry_meat", "dry_veggy", "dry_fruit",
                "cooking_oil", "cornmeal", "flour", "fruit_wine", "beer", "sugar", "salt", "vinegar",
            },
            reply = { text = ccb.content.text("Delivering <topic_item>."), next_topic = "TALK_DELIVER_ASK" },
        },
    },
    replies = {
        {
            text = ccb.content.text("That's all for now.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("That's all for now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_JARS",
    line = ccb.content.text("Yes, I can buy 500 mL or 3 L glass jars at the moment."),
    repeat_replies = {
        {
            items = { "jar_glass_sealed", "jar_3l_glass_sealed" },
            reply = { text = ccb.content.text("Delivering <topic_item>."), next_topic = "TALK_DELIVER_ASK" },
        },
    },
    replies = {
        {
            text = ccb.content.text("That's all for now.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("That's all for now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_NEW",
    line = ccb.content.gendered_line("I oversee the food stocks for the center.  There was significant looting during the panic when we first arrived so most of our food was carried away.  I manage what we have left and do everything I can to increase our supplies.  We've got a few growing sources of fresh meats and vegetables, so I prioritize non-perishable food, such as cornmeal, jerky, and fruit wine.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Why cornmeal, jerky, and fruit wine?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_WHY",
        },
        {
            text = ccb.content.text("Okay, but I meant \"who are you\", like, \"what's your story?\""),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_BACKGROUND",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_WHY",
    line = ccb.content.text("All three are easy to locally produce in significant quantities and are non-perishable.  We have a local farmer or two and a few hunter types that have been making attempts to provide us with the nutritious supplies.  We do always need more suppliers though.  This stuff is rather cheap in bulk, so I can pay a premium for any you have on you.  Canned food and other edibles are handled by the merchant in the front in trade."),
    replies = {
        {
            text = ccb.content.text("Are you looking to buy anything else?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_ALL",
        },
        {
            text = ccb.content.text("Very well… let's talk about something else."),
            next_topic = "TALK_FREE_MERCHANT_STOCKS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_BACKGROUND",
    line = ccb.content.text("I'm sorry, but I'm not here to make friends, I've got a job to do."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_ALL",
    line = ccb.content.text("I'm actually accepting a number of different foodstuffs: beer, sugar, flour, smoked meat, smoked fish, dried fruit and vegetables, cooking oil, preservatives like salt and vinegar; and as mentioned before, jerky, cornmeal, and fruit wine."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_FMCN",
    line = ccb.content.text("We call them \"Free Merchant Certified Notes\".  We started signing money almost as soon as we got here as a way of showing it represented actual goods and services we had to trade.  Within a few days we'd organized the system, and now it's been evolving into a form of cash.  Internally they're traded for labor and services in exchange for food rations and other trade goods, but we've been using them with suppliers we regularly trade with as well, those that have faith in us."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_REFUGEES",
    line = ccb.content.text("Yeah, it's a tough situation.  When we started out here nobody was really in charge, and we let more in than we really had capacity to feed and support.  When the dust settled and we'd established a little order, there were still all these people upstairs waiting for a place to live, and no space.  We've set up a little space for them, but it's not ideal."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_BEGGARS",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_beggars_recruited" } }),
        yes = ccb.content.text("I do.  I don't know what you did to convince them to move out, but our supply chain and I both thank you.  I hope it wasn't too unseemly."),
        no = ccb.content.text("Even once we got things sorted out, there weren't enough beds for everyone, and definitely not enough supplies.  These are harsh times.  We're doing what we can for those folks… at least they've got shelter."),
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_SEALED1",
    line = ccb.content.gendered_line("Well, there's the downstairs section, we can't fit more people down there so it's out of bounds.  Then there's the second bay that we were using as a staging area at first.  Things went… wrong.  I hear the shopkeeper is offering a reward to clear it out, if you're feeling suicidal.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What went wrong with your staging area?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS_SEALED1wrong",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_SEALED1wrong",
    line = ccb.content.text("We didn't have great organization when we first arrived.  A few of the earliest arrivals set up a triage and sorting system, with the sick and infirm getting set aside to wait.  It's cruel, but we could see there was only space for so many, and we didn't know what was causing people to turn into zombies at the time, so we were trying to quarantine out infection.  A couple folks died in there, and it escalated.  One of the first people here, Jacob, had taken charge of the whole thing.  When the triage area had to be evacuated he stayed behind to make sure everyone who could get out got out.  It was a hell of a loss."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_conversation_told_about_FM_evacuation", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Thanks, can I ask you something else?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_SEALED2",
    line = ccb.content.text("Thank you for that.  We don't have any immediate plans for the area.  Once it's cleaned up I suppose we'll let the people living up here decide what to do with it."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_RANCH",
    line = ccb.content.gendered_line("I'm so glad we've got that up and running.  One of the people evacuated here had a connection to a functioning ranch, and we got him and a crew out there as quickly as we were able.  We're hoping they'll be able to supply us in enough foodstuffs to make this place self-sufficient and even to trade with other communities as they arise.", { "interlocutor" }),
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_Boris_Mission_1",
    line = ccb.content.text("You'd be better off asking the shopkeeper up front, I'm the quartermaster."),
}

ccb.content.define_mission {
    id = "MISSION_BROKER_1",
    name = ccb.content.text("In a Pickle Pt. 2"),
    description = ccb.content.text("Deliver 50 large three-liter jars in exchange for <reward_count:FMCNote> certified notes."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 20000,
    item = "jar_3l_glass_sealed",
    item_count = 50,
    finish = {
        handler = "mark_mission_flag_FMBroker_Mission1",
        item_rewards = { { item = "FMCNote", count = 25 } },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I do have some work for you."),
        offer = ccb.content.text("You heard right.  When you brought in those canning jars, it got us thinking about expanding our food storage from dehydrated to include cans.  We could use some larger jars though for big stock items.  Can you bring me 50 large three liter jars?  I'll pay you a Certified Note per two."),
        accepted = ccb.content.text("Thank you.  Once we get a cottage industry set up with some of our inhabitants, I'll be able to start buying these from you and other scavengers in smaller lots.  This should be enough to test out our equipment."),
        rejected = ccb.content.text("Oh well.  I'll see if I can find another supplier, thanks."),
        advice = ccb.content.text("Grocery stores, house kitchens, there's plenty of places to look."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Wow, that's a lot more jars than it sounded on paper.  Thanks.  Here's your payment."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I wonder where all the jars went…"),
    },
}
