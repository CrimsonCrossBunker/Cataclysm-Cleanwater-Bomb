local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = {
        "TALK_GREAT_LIBRARY_LIBRARIAN_AskJoin", "TALK_GREAT_LIBRARY_LIBRARIAN_AskJoin1",
        "TALK_GREAT_LIBRARY_LIBRARIAN_AskJoin2",
    },
    line = ccb.content.text("Oh.  Um.  I don't.  I don't think that makes sense right now.  I have enough help here, and we.  Maybe when things are more settled but not now.  But you might ask others if they need help."),
    replies = {
        {
            text = ccb.content.text("Another time, then."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Talk",
        },
        {
            text = ccb.content.text("I'm useful!  I have skills!"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_AskJoin1",
        },
        {
            text = ccb.content.text("Maybe I could change your mind…?~"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_AskJoin2",
            when = predicates.has_item("speaker", "condom"),
        },
    },
}
