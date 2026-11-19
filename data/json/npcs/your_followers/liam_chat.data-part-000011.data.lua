local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BROKER_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_liam_opinion_liam_MISSION_FREE_MERCHANTS_EVAC_5" } }),
        yes = ccb.content.text("*shakes his head at you.  \"Look, you asked last time, and I told you you didn't have to keep taking jobs like this.  Now you're asking again?  *I dunno, stop offering to bring a billion jars to people if you don't know where to find them.*\"  He laughs.  \"I'm just messing with you.\"  His eyes narrow.  \"Or am I?\""),
        no = ccb.content.text("Look, you're the one that agreed to this.  I don't know why you keep agreeing to this stuff.  Maybe we can check hardware stores?  Or just eat a lot of jarred food, and keep the empties?  A hundred jars.  That's a lot, my friend.\"  He shakes his head.  \"You don't have to agree to do *everything* people ask you to do, you know?"),
    },
    replies = {
        {
            text = ccb.content.text("Your objection is noted.  I'd like your opinion on something else, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
