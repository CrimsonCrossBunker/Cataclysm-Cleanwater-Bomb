local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_LOCATION_ABOUT",
    line = {
        choices = {
            ccb.content.text("I don't know if you've met Jay yet, but he and I split a garden out here.  We both work - well, worked - in technology, and we were convinced the world was ending so we both got property outside town.  We met when he moved in next door.  So this is our little homestead with a few upgrades.  We aren't really sweating property lines at this point."),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_mentioned_jay", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("What's with all the weapons and armor?"),
            next_topic = "TALK_BLACKSMITH_SHOP_ABOUT",
        },
        { text = ccb.content.text("Who are you?"), next_topic = "TALK_BLACKSMITH_ABOUT" },
        {
            text = ccb.content.text("Are you and Jay close?"),
            next_topic = "TALK_BLACKSMITH_JAY",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_accepted_quest" } })),
        },
        { text = ccb.content.text("Alright."), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_SHOP_ABOUT",
    line = {
        choices = {
            ccb.content.text("I make them myself!  I've always loved traditional armaments and am a proud member of the SCA!  Figured now that everything has gone to hell I can make it a full-time thing.  Lots of survivors in need of a big ol' hammer or some armored guards to keep the biters off."),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_heard_the_deal", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("It must take some serious equipment to make all this."),
            next_topic = "TALK_BLACKSMITH_SHOP_ABOUT_MORE",
        },
        {
            text = ccb.content.text("What is this place?"),
            next_topic = "TALK_BLACKSMITH_LOCATION_ABOUT",
        },
        { text = ccb.content.text("Alright."), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_SHOP_ABOUT_MORE",
    line = {
        choices = {
            ccb.content.text("Well, what can I say, I had lots of disposable income.  Kept me busy and all that.  So yeah, I've got a pretty impressive shop in the back."),
        },
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_heard_the_deal", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Still this is a lot of equipment.  Wouldn't it have been easier to buy this stuff from a manufacturer?"),
            next_topic = "TALK_BLACKSMITH_SHOP_ABOUT_STUPID_QUESTION",
        },
        {
            text = ccb.content.text("Can anyone use the workshop?"),
            next_topic = "TALK_BLACKSMITH_COOP_ABOUT",
        },
        { text = ccb.content.text("Alright."), next_topic = "TALK_BLACKSMITH_SERVICES" },
    },
}
