local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_LULIYA_MUSIC",
    line = ccb.content.text("&She nods enthusiastically and strums a few notes on her krar.  \"Awo muzika iwedalehu.\""),
    replies = {
        {
            text = ccb.content.text("[Use Guitar] I happen to have a nice guitar, want to play with me?"),
            next_topic = "TALK_LULIYA_MUSIC2",
            when = predicates.has_item("speaker", "acoustic_guitar"),
        },
        {
            text = ccb.content.text("[Use Trumpet] I happen to have a nice trumpet, want to play with me?"),
            next_topic = "TALK_LULIYA_MUSIC2",
            when = predicates.has_item("speaker", "trumpet"),
        },
        {
            text = ccb.content.text("[Use Saxophone] I happen to have a nice saxophone, want to play with me?"),
            next_topic = "TALK_LULIYA_MUSIC2",
            when = predicates.has_item("speaker", "saxophone"),
        },
        {
            text = ccb.content.text("[Use Violin] I happen to have a nice violin, want to play with me?"),
            next_topic = "TALK_LULIYA_MUSIC2",
            when = predicates.has_item("speaker", "violin"),
        },
        {
            text = ccb.content.text("[Use Harmonica] I happen to have a nice harmonica, want to play with me?"),
            next_topic = "TALK_LULIYA_MUSIC2",
            when = predicates.has_item("speaker", "harmonica_holder"),
        },
        {
            text = ccb.content.text("[Use Cowbell] I happen to have a nice cowbell, want to play with me?"),
            next_topic = "TALK_LULIYA_MUSIC2",
            when = predicates.has_item("speaker", "cow_bell"),
        },
        {
            text = ccb.content.text("Huh, you know music, good to know.  I'll try and find something to play and come back."),
            next_topic = "TALK_DONE",
        },
    },
}
