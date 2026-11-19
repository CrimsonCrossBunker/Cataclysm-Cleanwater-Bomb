local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
    line = ccb.content.text("Interesting, interesting, interesting.  Hm.  I'll note that information.  Now, about that dangerous task."),
    replies = {
        {
            text = ccb.content.text("I'm listening."),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_OFFER",
        },
        {
            text = ccb.content.text("Risk my neck for the privilege of trading with you?  Maybe another time."),
            next_topic = "TALK_DONE",
            actions = { actions.add_effect("speaker", "robofac_surveillance", { turns = 7776000 }) },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_WHO_SENT_YOU",
    line = ccb.content.text("&\"We are listening…\"\n\nYou detect a slight elevation in their voice, with a start you realize they are nervous."),
    replies = {
        {
            text = ccb.content.text("Actually I was just joking.  Our meeting is indeed a fortunate accident but now that I have your attention would you be interested in trading in some goods?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO",
            trial = { kind = "lie", difficulty = 80 },
            failure = {
                actions = {
                    actions.adjust_faction_trust(-3),
                    actions.add_effect("speaker", "robofac_surveillance", { turns = 2592000 }),
                },
            },
        },
        {
            text = ccb.content.text("Some mercenaries I met mentioned this place, said it's a good place to find some work and possibly some valuable post-apocalyptic gear."),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO",
            trial = { kind = "lie", difficulty = 90 },
            failure = {
                actions = {
                    actions.adjust_faction_trust(-3),
                    actions.add_effect("speaker", "robofac_surveillance", { turns = 2592000 }),
                },
            },
        },
        {
            text = ccb.content.text("You guys aren't as slick as you think.  You think no one's gonna notice a pristine looking meteorological station in the middle of nowhere with not a potted plant out of place?"),
            next_topic = "TALK_ROBOFAC_EXODII_EXISTENCE",
        },
    },
}
