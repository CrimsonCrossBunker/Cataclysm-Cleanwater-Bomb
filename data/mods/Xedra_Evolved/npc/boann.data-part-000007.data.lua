local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_FIVE_MI_GO_GUARDS_ACCEPTED",
    line = ccb.content.text("I had no doubts in you."),
    replies = {
        { text = ccb.content.text("Can I see the other quests?"), next_topic = "TALK_QUEST_LIST" },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_FIVE_MI_GO_GUARDS_ADVICE",
        },
        { text = ccb.content.text("I'm going to head on now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_FIVE_MI_GO_GUARDS_COMPLETED" },
    line = ccb.content.text("Here is the object.  As promised, using it will recharge your mana."),
    replies = {
        { text = ccb.content.text("Can I talk about something else?"), next_topic = "TALK_BOANN_1" },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" },
    },
}
