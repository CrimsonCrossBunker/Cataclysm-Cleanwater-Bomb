local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_4",
    line = {
        joined = {
            ccb.content.text("&He grins.  \"I'm gonna level with you, this sounds incredibly *cool*.\"  He laughs at his own joke.  \"Seriously though, it's probably going to be a really tricky one"),
            {
                when = predicates.has_trait("speaker", "CBM_Interface"),
                yes = ccb.content.text(".  It'd be good to maybe try cybernetics to help us with the cold, they won't be as bulky and confining to fight in as winter gear.\""),
                no = ccb.content.text(".  We'll need to bundle up extra toasty, that'll make fighting tough.\""),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Good thoughts.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
