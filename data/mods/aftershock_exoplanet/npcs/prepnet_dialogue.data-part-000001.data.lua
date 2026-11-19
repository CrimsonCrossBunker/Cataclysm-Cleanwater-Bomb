local ccb = require("ccb")

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
