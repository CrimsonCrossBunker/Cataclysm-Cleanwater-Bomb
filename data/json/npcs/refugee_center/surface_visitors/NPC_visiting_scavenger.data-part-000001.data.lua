local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RC_SURVIVOR_1",
    line = ccb.content.text("Hey there.  Do you work here, or what?"),
    on_enter = {
        { actions = { actions.set_first_topic("TALK_RC_SURVIVOR_2"), actions.handler("dlg_a_dda_c231e68b393b") } },
    },
    replies = {
        {
            text = ccb.content.text("Me?  No, I'm just passing through, how about you?"),
            next_topic = "TALK_RC_SURVIVOR_Story",
        },
        {
            text = ccb.content.text("Work here?  No, of course not.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_SURVIVOR_2",
    line = ccb.content.text("What's up?"),
    replies = {
        { text = ccb.content.text("What's your story?"), next_topic = "TALK_RC_SURVIVOR_Story" },
        {
            text = ccb.content.text("You seen anything interesting out there?"),
            next_topic = "TALK_RC_SURVIVOR_Tips",
        },
        {
            text = ccb.content.text("Not much, just passing through.  Have a good day."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RC_SURVIVOR_Story",
    line = ccb.content.gendered_line("I found a map to this place in an evac center and thought I'd see if it was just full of <zombies> or if there was something up.  Didn't expect to find so many survivors still alive though.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("You looking for a traveling companion?  I could use someone to watch my back."),
            next_topic = "TALK_RC_SURVIVOR_Join",
        },
        {
            text = ccb.content.text("You seen anything interesting out there?"),
            next_topic = "TALK_RC_SURVIVOR_Tips",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
