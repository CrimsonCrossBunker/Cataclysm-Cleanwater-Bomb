local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_KILL_STAR_CROWN_HOUND_ACCEPTED",
    line = ccb.content.text("I had no doubts in you."),
    replies = {
        { text = ccb.content.text("Can I see the other quests?"), next_topic = "TALK_QUEST_LIST" },
        {
            text = ccb.content.text("Do you have any advice?"),
            next_topic = "TALK_KILL_STAR_CROWN_HOUND_ADVICE",
        },
        { text = ccb.content.text("I'm going to head on now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_KILL_STAR_CROWN_HOUND_COMPLETED" },
    line = ccb.content.text("I give you this necklace as a gift for your services.  May it serve you well."),
    replies = {
        { text = ccb.content.text("Can I talk about something else?"), next_topic = "TALK_BOANN_1" },
        { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_JOIN_COURT_SUCCESS" },
    line = ccb.content.text("You are now officially a member of my court and can leave this place for the summer lands.  You will be assigned a territory to guard in my name in the Marches and troops to help you hold it.  But only when you leave here and there is no return from there to here so anyone you wish to take must come with you when you leave."),
    replies = {
        {
            text = ccb.content.text("Thank you my liege.  I will let you know when I am ready to make the journey."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I wish to leave now.  (This will end the game)"),
            next_topic = "TALK_OUTWORLD_CONFIRM",
        },
    },
}
