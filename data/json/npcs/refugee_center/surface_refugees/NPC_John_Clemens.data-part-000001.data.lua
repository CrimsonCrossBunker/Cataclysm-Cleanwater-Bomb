local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_John_1a",
    line = ccb.content.gendered_line("*tips his cowboy hat and sets his feet far apart as he faces you.  \"Howdy, pardner.\"", { "speaker" }),
    replies = {
        { text = ccb.content.text("Hi, John.  Got a minute?"), next_topic = "TALK_REFUGEE_John_2" },
        { text = ccb.content.text("Hi John.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_John_1_firstmeet",
    line = ccb.content.text("Nice to meet you too.  I reckon' you got some questions 'bout this place."),
    replies = {
        { text = ccb.content.text("Yeah, I sure do."), next_topic = "TALK_REFUGEE_John_2" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_John_2",
    line = ccb.content.text("What can I do ya for?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_John_Background",
    line = ccb.content.text("My story?  Just a wanderin' cowhand, eatin' dust on the trail.  I settled here for a spell after I came upon some hard times."),
    replies = {
        {
            text = ccb.content.text("You… you do know what's going on here, right?  With the evacuation and stuff?"),
            next_topic = "TALK_REFUGEE_John_Background_cataclysm",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_John_Background_cataclysm",
    line = ccb.content.text("Course I do, I ain't an idjit.  It's all the folks here c'n talk about."),
    replies = {
        {
            text = ccb.content.text("So what, uh, what happened to you?"),
            next_topic = "TALK_REFUGEE_John_Background_cataclysm2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_John_Background_cataclysm2",
    line = ccb.content.text("*looks at you like you're in need of special help.  \"Just what I said.  I'm settled down here for a spell, then goin' back on the road with my sixgun.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
