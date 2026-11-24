local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_WHATELY_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_whately" } }),
        yes = {
            choices = {
                ccb.content.text("Outsider."),
                ccb.content.text("Hello."),
                ccb.content.text("Hospitality rites are civilization."),
                ccb.content.text("Guest."),
                ccb.content.text("How's the madness outside?"),
            },
        },
        no = ccb.content.text("We don't get outsiders around here all that much."),
    },
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_whately", "yes") },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_whately" } })),
            next_topic = "TALK_WHATELY_firstmeet",
        },
        {
            text = ccb.content.text("What is this place?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_whately" } }),
            next_topic = "TALK_WHATELY_place",
        },
        {
            text = ccb.content.text("What's your story?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_whately" } }),
            next_topic = "TALK_WHATELY_ask_past",
        },
        {
            text = ccb.content.text("How are things here?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_whately" } }),
            next_topic = "TALK_WHATELY_ask_mood",
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_whately" } }),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("How do I join the family?"),
            next_topic = "TALK_WHATELY_ask_membership",
        },
        { text = ccb.content.text("I'm going on my way now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WHATELY_firstmeet",
    line = ccb.content.text("I'm a member of the Whately Family.  Who are you?"),
    replies = {
        {
            text = ccb.content.text("I am lost and really need something to eat."),
            next_topic = "TALK_WHATELY_food",
        },
        { text = ccb.content.text("I am just a fellow survivor."), next_topic = "TALK_WHATELY_1" },
        {
            text = ccb.content.text("I've done some tasks for your relatives."),
            next_topic = "TALK_WHATELY_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WHATELY_place",
    line = ccb.content.text("Welcome to Whately lands.  Behave yourself or we'll harvest you for parts."),
    replies = {
        {
            text = ccb.content.text("Can you give me something to eat then?"),
            next_topic = "TALK_WHATELY_food",
        },
        { text = ccb.content.text("What can I buy here?"), next_topic = "TALK_WHATELY_ask_goods" },
        { text = ccb.content.text("Oh, okay."), next_topic = "TALK_WHATELY_1" },
        { text = ccb.content.text("Family bonds above all, huh?"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WHATELY_food",
    line = ccb.content.text("We aren't in the habit of breaking bread with outsiders."),
    replies = {
        { text = ccb.content.text("I can pay."), next_topic = "TALK_WHATELY_ask_goods" },
        {
            text = ccb.content.text("How do I join your family?"),
            next_topic = "TALK_WHATELY_ask_membership",
        },
        { text = ccb.content.text("Well I'm heading out then."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WHATELY_ask_goods",
    line = ccb.content.text("Then let's see what you've got to trade."),
    replies = {
        { text = ccb.content.text("It was worth a try."), next_topic = "TALK_WHATELY_1" },
        {
            text = ccb.content.text("What can I buy here?"),
            native_actions = { "start_trade" },
            next_topic = "TALK_WHATELY_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WHATELY_ask_membership",
    line = ccb.content.text("Only blood allowed, and the family Elders can make you of the blood."),
    replies = { { text = ccb.content.text("Well that sounds creepy."), next_topic = "TALK_WHATELY_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WHATELY_ask_past",
    line = ccb.content.text("I was born part of the family.  We've never been accepted here but our wealth and talents have kept us alive through the centuries."),
    replies = {
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_WHATELY_1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_WHATELY_ask_mood",
    line = ccb.content.text("Family keeps me busy and our experiments and projects take up the rest of my time."),
    replies = { { text = ccb.content.text("I'm glad you stay busy."), next_topic = "TALK_WHATELY_1" } },
}
