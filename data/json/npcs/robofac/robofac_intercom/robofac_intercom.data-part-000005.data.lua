local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_2",
    line = ccb.content.text("You hear a short, muffled conversation from the other end.  There's a brief pause.  \"English it is.  We believe we could gain some mutual benefit by talking and trading.  We would like to extend you trading access.  But we need something in return.  We would like to know more about your nature.  And we have a task.  It is dangerous, but from the look of you, you'll know exactly how to handle it.\""),
    replies = {
        {
            text = ccb.content.text("I'm listening."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_3",
            actions = {
                actions.add_effect("speaker", "robofac_surveillance", { turns = 7776000 }),
                actions.set_actor_value("speaker", "robofac_knows_about_u_cyberframe", "yes"),
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_3",
    line = ccb.content.text("&\"Did someone send you?  Are you… human?  Our scann- I mean, our camera feed suggests you are some sort of cybernetic being?\"\n\nYou detect a slight elevation in their voice, with a start you realize they are nervous."),
    replies = {
        {
            text = ccb.content.text("Yeah, I'm human.  I was turned into a cyborg by beings called Exodii."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_4",
        },
        {
            text = ccb.content.text("This was some kind of government experiment before everything happened.  I don't fully understand it myself."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
            trial = { kind = "lie", difficulty = 90 },
            failure = { actions = { actions.adjust_faction_trust(-3) } },
        },
        {
            text = ccb.content.text("Honestly, I have no idea how all of this happened."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
            trial = { kind = "lie", difficulty = 30 },
            failure = { actions = { actions.adjust_faction_trust(-3) } },
        },
        {
            text = ccb.content.text("I'm an alien robot!  But, I come in peace."),
            next_topic = "TALK_ROBOFAC_INTERCOM_CYBORG_INTRO_5",
            trial = { kind = "lie", difficulty = 15 },
            failure = { actions = { actions.adjust_faction_trust(-3) } },
        },
    },
}
