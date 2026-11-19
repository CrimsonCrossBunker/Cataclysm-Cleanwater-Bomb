local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGRS_SCHIZO_1_STORY1",
    line = ccb.content.text("Monsters!  Monsters everywhere.  Everyone is suspect, how do I know you aren't a monster?"),
    replies = {
        { text = ccb.content.text("Are you ok?"), next_topic = "BGRS_SCHIZO_1_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGRS_SCHIZO_1_STORY2",
    line = ccb.content.text("You can't trust anyone these days.  Everyone is either a cannibal or a monster or a government spook."),
    replies = {
        {
            text = ccb.content.text("Why would you trust me then?"),
            next_topic = "BGRS_SCHIZO_1_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGRS_SCHIZO_1_STORY3",
    line = ccb.content.text("Because, what if I'm the monster?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
