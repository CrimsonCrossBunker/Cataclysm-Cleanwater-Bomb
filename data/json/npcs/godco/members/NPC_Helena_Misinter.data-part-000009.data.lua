local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Accept_Contact_FreeMerch",
    line = ccb.content.text("Yes, you seem like a good fit for the job.  I'll pay you a small sum for getting some information about them."),
    replies = {
        {
            text = ccb.content.text("Alright, I'll go and see what's up."),
            next_topic = "TALK_DONE",
            actions = { actions.offer_mission("MISSION_GODCO_HELENA_VISIT_MERCHANTS") },
        },
        {
            text = ccb.content.text("Let's change the subject."),
            next_topic = "TALK_GODCO_Helena_2",
        },
        {
            text = ccb.content.text("Good luck with that."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Tell_FreeMerch",
    line = ccb.content.text("Really?  I'd pay a small sum for information about them."),
    replies = {
        {
            text = ccb.content.text("Well, they're…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_1af3223913ba") },
        },
    },
}
