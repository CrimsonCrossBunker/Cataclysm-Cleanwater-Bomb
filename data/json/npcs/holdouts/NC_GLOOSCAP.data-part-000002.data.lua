local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_WHERE",
    line = ccb.content.gendered_line("I'm used to it.  No, Glooscap has been a name here for a very long time.  Is your name foreign?", { "interlocutor" }),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_glooscap", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("No, my name has been a name here for a very long time too."),
            next_topic = "TALK_GLOOSCAP",
        },
        { text = ccb.content.text("No, I just made it up."), next_topic = "TALK_GLOOSCAP" },
        {
            text = ccb.content.text("Yes, I just got here.  What's happening?"),
            next_topic = "TALK_GLOOSCAP_HAPPENING",
        },
        {
            text = ccb.content.text("I don't know about names, let's talk about something more interesting."),
            next_topic = "TALK_GLOOSCAP",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_MYTH",
    line = ccb.content.text("You know the real people's stories?  Yes, a lot like that."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_glooscap", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Cool, cool.  So you like myths and stuff?"),
            next_topic = "TALK_GLOOSCAP_MYTH_FAIL",
        },
        {
            text = ccb.content.text("[INT 14] Do you have a twin named Malsumis?"),
            next_topic = "TALK_GLOOSCAP_MYTH_SUCCESS",
            when = predicates.minimum_attribute("speaker", "intelligence", 14),
        },
        {
            text = ccb.content.text("Yes, I'm a very smart survivor of the apocalypse.  <end_talking_leave>  Later Glooscap."),
            next_topic = "TALK_DONE",
        },
    },
}
