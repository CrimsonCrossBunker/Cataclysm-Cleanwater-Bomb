local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_isherwood",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_an_isherwood" } }),
        yes = ccb.content.text("Isn't he just directing us out to that Isherwood farm?"),
        no = ccb.content.text("Sounds good.  I'm a bit nervous about what we might find, though.  Who knows what the apocalypse would do to a bunch of gun-toting back country folks?  On the other hand, maybe they're sweet, salt-of-the-earth types.  Only one way to find out!"),
    },
    replies = {
        {
            text = ccb.content.text("Right.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
