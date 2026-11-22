local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GREAT_LIBRARY_LIBRARIAN_Talk", "TALK_GREAT_LIBRARY_LIBRARIAN_AboutGreeting_End", "TALK_GREAT_LIBRARY_LIBRARIAN_WhosInCharge" },
    line = {
        choices = {
            ccb.content.text("Of course, how can I help?"),
            ccb.content.text("I would be happy to assist."),
            ccb.content.text("Of course, please ask."),
            ccb.content.text("What questions do you have?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("You can't lend out books?  What kind of library is that?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutGreeting",
            when = predicates.has_effect("speaker", "u_Elvira_onetime_greeting"),
            actions = { actions.remove_effects("speaker", { "u_Elvira_onetime_greeting" }) },
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Plans",
        },
        {
            text = ccb.content.text("You want even more books?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_MoreBooks",
        },
        {
            text = ccb.content.text("Who's in charge here?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_WhosInCharge",
        },
        {
            text = ccb.content.text("Is there any way I can join your group?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_AskJoin",
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutMe",
        },
        {
            text = ccb.content.text("Have you heard anything about the rest of the world?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_OutsideWorld",
        },
        {
            text = ccb.content.text("Let me see what you have."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_DoneTrading",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
