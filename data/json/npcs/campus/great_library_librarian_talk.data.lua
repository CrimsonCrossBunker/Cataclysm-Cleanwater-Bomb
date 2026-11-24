local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Elvira" } }),
        yes = {
            choices = {
                ccb.content.text("*whispering.  \"Welcome back to the Library.\""),
                ccb.content.text("*whispering.  \"Hello again.  Can I help you find something?\""),
                ccb.content.text("*whispering.  \"Hello.\""),
            },
        },
        no = ccb.content.text("*waves and smiles.  \"Welcome fellow reader.\""),
    },
    replies = {
        {
            text = ccb.content.text("Hello, who are you?  This is a library, is it?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Intro",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Elvira" } })),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_Elvira", "yes") },
        },
        {
            text = ccb.content.text("Oh sorry, I'm not interested right now."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Elvira" } })),
        },
        {
            text = ccb.content.text("I wanted to talk."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Talk",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Elvira" } }),
        },
        {
            text = ccb.content.text("Let me see what you have."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_DoneTrading",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Elvira" } }),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Just saying hello."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Elvira" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_DoneTrading",
    line = {
        choices = {
            ccb.content.text("Always glad to help another reader."),
            ccb.content.text("Never stop learning."),
            ccb.content.text("I just love books."),
        },
    },
    replies = {
        {
            text = ccb.content.text("About other things…"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Talk",
        },
        {
            text = ccb.content.text("Let me see what you have."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_DoneTrading",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("When will you have new material?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_AskedRestock",
        },
        {
            text = ccb.content.text("That's all for now.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_AskedRestock",
    line = {
        choices = {
            ccb.content.text("It can be hard to predict the way things are now, but I am expecting new materials around <restock_time_point>."),
            ccb.content.text("I am expecting some new materials around <restock_time_point>, hopefully some good escapism."),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Talk",
        },
        {
            text = ccb.content.text("Thanks, I will make sure to check back."),
            next_topic = "TALK_DONE",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = {
        "TALK_GREAT_LIBRARY_LIBRARIAN_OutsideWorld", "TALK_GREAT_LIBRARY_LIBRARIAN_OutsideWorld1",
        "TALK_GREAT_LIBRARY_LIBRARIAN_OutsideWorld2",
    },
    line = ccb.content.text("Some, here and there.  My responsibilities keep me here but I have spoken with traveling merchants.  They thought we wanted guns and were confused that we wished to trade books for books.  I must assume that most of the other survivors are more violent and less scholarly."),
    replies = {
        {
            text = ccb.content.text("Are there any other settlements around?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Robofac",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_merchants_u_hub01_breadcrumb_accepted" } })),
        },
        {
            text = ccb.content.text("Are there any other settlements around?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_OutsideWorld2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_free_merchants_u_hub01_breadcrumb_accepted" } }),
        },
        {
            text = ccb.content.text("That's fine for now."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_MoreBooks",
    line = ccb.content.text("Yes we are.  We still have some of our original collection, but far too much of it was stolen or destroyed, and of course it was far from complete even before.  Some of us go out to try and rebuild the collection from towns nearby, but mostly we rely on people passing through like you.  We especially want anything rare and hard to find."),
    replies = {
        {
            text = ccb.content.text("I'll keep that in mind."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Talk",
        },
    },
}
