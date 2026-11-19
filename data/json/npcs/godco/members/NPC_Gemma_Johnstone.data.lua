local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Help",
    line = ccb.content.text("My flowers look a bit dehydrated, I'd appreciate it if you watered them for me.  These indoor plants are the most calming reminders of life before <the_cataclysm>."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I meant \"Are there any jobs you know of?\""),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("Sure.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_You_Mutant",
    line = ccb.content.text("You certainly have the marks of one.  I don't understand how you can go walking around looking like an abomination, cursed by God, and think everything's alright.  I'm not interested in learning, either, so be gone with you."),
    replies = { { text = ccb.content.text("Sure.  <end_talking_bye>"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Gemma_Angry",
    line = ccb.content.text("If you really want to know the truth, I;m quite upset with how you've been acting as of late, and I don't want to talk to you.  Now please, leave me be."),
    replies = { { text = ccb.content.text("Sure.  <end_talking_bye>"), next_topic = "TALK_DONE" } },
}
