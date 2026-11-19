local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_FirstmeetA",
    line = ccb.content.text("Well if that's the case, I don't suppose you could help out struggling survivors, do you?"),
    replies = { { text = ccb.content.text("Sorry, not interested."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_FirstmeetB",
    line = ccb.content.text("Hey, we're on the same boat, aren't we?"),
    replies = {
        {
            text = ccb.content.text("What needs to be done?"),
            next_topic = "TALK_GODCO_Corrie_Mission",
        },
        { text = ccb.content.text("Sorry, not interested."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_FirstmeetC",
    line = ccb.content.text("Just so you know, a lot of the folks here might not take to kindly to your appearance.  I'm cool with it, though."),
    replies = {
        {
            text = ccb.content.text("Why would that be?"),
            next_topic = "TALK_GODCO_Corrie_You_Mutant",
        },
        {
            text = ccb.content.text("Thank you for your politeness and generosity.  I'll be seeing you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_2",
    line = {
        choices = { ccb.content.text("Sure.  I can clear a few minutes of my oh-so hectic schedule.") },
    },
    replies = { { text = ccb.content.text("Sorry Corrie.  <end_talking_leave>"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Story",
    line = ccb.content.text("&Corrie blankly stares at the wall for a moment.  \"Me and my friends were in the cities when it hit, I was the only one to make it out.  Some gigantic horror… devoured… everything in its way.  There was a memorial service and all, organized by the church-goers.  By far the nicest thing they've done for me.\""),
    replies = {
        {
            text = ccb.content.text("Sorry for bringing it up.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Sorry for bringing it up.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Community",
    line = ccb.content.text("Like second-class citizens, that's how they treat us."),
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
