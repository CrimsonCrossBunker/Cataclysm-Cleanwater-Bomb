local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_Intro",
    line = ccb.content.text("Before you ask, we can't lend out books anymore.  We've had too many stolen and destroyed.  If you want to read something, either do it here or I will need to sell it to you for something useful, like a book.  Oh, my name is Elvira Fish, I run Circulations here.  I hope you learn something."),
    on_enter = {
        {
            once = "has_onetime_greeting_effect",
            when = predicates.negate(predicates.has_effect("speaker", "u_Elvira_onetime_greeting")),
            actions = { actions.add_effect("speaker", "u_Elvira_onetime_greeting", { turns = 43200 }) },
        },
    },
    replies = {
        {
            text = ccb.content.text("Can you answer some questions for me?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Talk",
        },
        {
            text = ccb.content.text("Let me look at what you have."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_DoneTrading",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("I just want to browse.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
