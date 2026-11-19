local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_LULIYA_ENGLISH",
    line = ccb.content.text("&A long pause, then she shakes her head  \"Inigilizinya yelemi.  No.\""),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_language_u_not_english_luliya", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("All right then.  You seem to understand what I mean.  And the word no."),
            next_topic = "TALK_LULIYA",
        },
        { text = ccb.content.text("Fine.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LULIYA_NAME",
    line = ccb.content.text("&A long pause.  You can't see her eyes but it seems like she is studying your face.  \"Sime Luliya ibalalehu.\"  She points to her own chest.  \"Luliya.\"  She points to your chest.  \"<u_name>.  Siletewawekini desi bilonyali, <u_name>.\"  She strums a pleasant melody on her krar."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "general_name_u_luliya_name", "yes") } } },
    replies = {
        {
            text = ccb.content.text("We're getting somewhere.  Pleased to meet you Luliya."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LULIYA_ARABIC",
    line = ccb.content.text("&A long pause, then she shakes her head.  \"Ayi arebinya alinagerimi.\""),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_language_u_not_arabic_luliya", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("All right then.  It seems like you do kind of understand it though."),
            next_topic = "TALK_LULIYA",
        },
        { text = ccb.content.text("Fine.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}
