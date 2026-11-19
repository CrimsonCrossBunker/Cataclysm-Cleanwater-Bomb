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
