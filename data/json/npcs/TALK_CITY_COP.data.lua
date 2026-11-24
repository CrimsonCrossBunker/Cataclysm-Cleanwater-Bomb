local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CITY_COP",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_survivor_cop_talked_to_survivor_cop" } }),
        yes = ccb.content.text("Hi there, <name_g>."),
        no = ccb.content.gendered_line("STOP, Put your hands in the air!  Ha, startled you didn't I… there is no law anymore…", { "interlocutor" }),
    },
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_CITY_COP_INTRO",
            actions = {
                actions.set_actor_value("speaker", "dialogue_survivor_cop_talked_to_survivor_cop", "yes"),
            },
        },
        { text = ccb.content.text("Wanna get outta here?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_CITY_COP",
            actions = { "start_trade" },
        },
        { text = ccb.content.text("Can I do anything for you?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CITY_COP_INTRO",
    line = ccb.content.gendered_line("I was watching the station when things went sideways.  None of the other officers returned from the last call, well not as humans anyway…", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_CITY_COP_LEAVE",
        },
        {
            text = ccb.content.text("Let's trade then."),
            native_actions = { "start_trade" },
            next_topic = "TALK_CITY_COP",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CITY_COP_LEAVE",
    line = ccb.content.gendered_line("This is a nice, secure building.  I'd be a fool to leave.  Been living off the vending machines, but I found the code for the evidence lockup so I've been doing some trading with other survivors.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What kind of stuff was in the evidence lockup?"),
            next_topic = "TALK_CITY_COP_EVIDENCE",
        },
        {
            text = ccb.content.text("You've seen other survivors?"),
            next_topic = "TALK_CITY_COP_NEWS",
        },
        { text = ccb.content.text("Wanna get outta here?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text("What can you sell me?"),
            next_topic = "TALK_CITY_COP",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CITY_COP_EVIDENCE",
    line = ccb.content.text("Knives… drugs… um… drugs and shiny things.  Thieves steal all sorts of stuff."),
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_CITY_COP_LEAVE",
        },
        {
            text = ccb.content.text("You've seen other survivors?"),
            next_topic = "TALK_CITY_COP_NEWS",
        },
        { text = ccb.content.text("Wanna get outta here?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text("Well, let me check out some of that stuff."),
            next_topic = "TALK_CITY_COP",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CITY_COP_NEWS",
    line = ccb.content.text("Yeah, there are some like me that have holed up around town.  We do some trading… and then sometimes a stranger wanders through thinking they'll find something better here than they left behind."),
    replies = {
        {
            text = ccb.content.text("Why don't you go somewhere else?"),
            next_topic = "TALK_CITY_COP_LEAVE",
        },
        { text = ccb.content.text("Wanna get outta here?"), next_topic = "TALK_SUGGEST_FOLLOW" },
        {
            text = ccb.content.text("Well, let me check out some of that stuff."),
            next_topic = "TALK_CITY_COP",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
