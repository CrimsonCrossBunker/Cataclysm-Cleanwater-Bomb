local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_BRING_BOANN_JABBERWOCK_HEART_ACCEPTED",
    line = ccb.content.text("I had no doubts in you."),
    replies = {
        { text = ccb.content.text("Can I see the other quests?"), next_topic = "TALK_QUEST_LIST" },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_BRING_BOANN_JABBERWOCK_HEART_ADVICE",
        },
        { text = ccb.content.text("I'm going to head on now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_BRING_BOANN_JABBERWOCK_HEART_COMPLETED" },
    line = ccb.content.text("I'm pleased to grant you a Melian mount of your own."),
    replies = {
        { text = ccb.content.text("Can I talk about something else?"), next_topic = "TALK_BOANN_1" },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" },
    },
}
