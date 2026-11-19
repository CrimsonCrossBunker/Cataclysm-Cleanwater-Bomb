local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_PERFORM_CURE",
    line = {
        choices = {
            ccb.content.text("\"And done\" Phyliss says.  \"You're now free from vampirism for the time being.  Take some time to recover, and ask Blaine if you ever want to buy a less painful cure from him.\""),
        },
    },
    replies = { { text = ccb.content.text("thanks.  <end_talking_bye>"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_INTRO",
    line = {
        choices = {
            ccb.content.text("I can use my heartvines to cure people from vampirism.  I let the heartvines enter their veins where the curse will be destroyed by the heartvines and their intense desire to kill all vampires.  It's painful for them, but it's better than staying a vampire."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What's a heartvine?"),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_INNER_PLANT",
        },
        { text = ccb.content.text("Cool.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

-- Maybe she'll offer the player to become a Bloodthorne druid someday, but not for now.
ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_INNER_PLANT",
    line = {
        choices = {
            ccb.content.text("That's how Bloodthorne druids call the plant inside them.  It empowers us through the essence of nature spirits so we may kill the blood-drinkers.  Before you ask, I can't help you become one.  I wasn't taught how to do this before I lost contact with other Bloodthorne druids."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What do you mean by \"essence\"?"),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_NEED_SAMPLES",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
