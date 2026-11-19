local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_meteorologist_safe",
    line = ccb.content.gendered_line("I'm glad you still alive.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Me too."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_meteorologist_Background",
    line = ccb.content.gendered_line("I'm just a regular meteorologist.  In recent years I have worked at a weather station, monitored the weather, state of air, read and wrote reports, drew up schedules… in general, complete boredom.  In my free time I was studying electronics and radio engineering, making various devices, some for work, some just for fun.  When the first riots began, I gathered all my things that I managed to take with me and settled here.  Since then I've been sitting here, wasting my time doing all sorts of nonsense.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
    },
}
