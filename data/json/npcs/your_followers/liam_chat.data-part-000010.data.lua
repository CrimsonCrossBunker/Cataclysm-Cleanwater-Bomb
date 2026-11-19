local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_5",
    line = ccb.content.text("Look, you're the one that agreed to this.  I don't know why you keep agreeing to this stuff.  Maybe we can check hardware stores?  Or just eat a lot of jarred food, and keep the empties?  A hundred jars.  That's a lot, my friend.\"  He shakes his head.  \"You don't have to agree to do *everything* people ask you to do, you know?"),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "u_liam_opinion_liam_MISSION_FREE_MERCHANTS_EVAC_5", "yes"),
            },
            once = "liam_opinion_liam_MISSION_FREE_MERCHANTS_EVAC_5",
        },
    },
    replies = {
        {
            text = ccb.content.text("Your objection is noted.  I'd like your opinion on something else, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
