local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_SACRIFICE" },
    line = ccb.content.text("To become a true vampire, you must kill someone that cherishes you with your own hands.  It might be hard to bear at first, but with time you'll see how much it was worth it."),
    replies = {
        {
            text = ccb.content.text("That's all?"),
            actions = { actions.assign_mission("KILL_YOUR_BEST_FRIEND") },
            next_topic = "TALK_VAMPIRE_MENTOR_SACRIFICE_1",
        },
        {
            text = ccb.content.text("I'll do it, if it what it takes."),
            actions = { actions.assign_mission("KILL_YOUR_BEST_FRIEND") },
            next_topic = "TALK_VAMPIRE_MENTOR_SACRIFICE_2",
        },
        {
            text = ccb.content.text("[Uncaring] Make someone love me and then kill them in return for immortality and power?  What's the downside?"),
            next_topic = "TALK_VAMPIRE_MENTOR_SACRIFICE_1",
            when = predicates.has_trait("speaker", "PSYCHOPATH"),
            actions = { actions.assign_mission("KILL_YOUR_BEST_FRIEND") },
        },
        {
            text = ccb.content.text("[Pacifist] That's monstrous, of course I won't do that!"),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("speaker", "PACIFIST"),
        },
        { text = ccb.content.text("I'm not doing that.  Bye."), next_topic = "TALK_DONE" },
    },
}
