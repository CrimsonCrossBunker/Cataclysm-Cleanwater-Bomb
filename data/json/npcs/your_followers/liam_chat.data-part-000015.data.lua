local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_exodii",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }),
        yes = ccb.content.text("We've been there, remember?  It's got those cyborg guys, the cockney ones."),
        no = ccb.content.text("Far-fetched and awesome!  Let's go see.  Maybe it's an abandoned theme park or something."),
    },
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_artisans",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_isolated_road_artisans" } }),
        yes = {
            joined = {
                ccb.content.text("We've been there, remember"),
                {
                    when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_isolated_road_cody" } }),
                    yes = ccb.content.text("?  Cody, the blacksmith, she's the food lady"),
                    no = ccb.content.text("?  I'm guessing the blacksmith we didn't talk to is the one who would have fed us"),
                },
                {
                    when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_isolated_road_jay" } }),
                    yes = ccb.content.text(", and Jay is the one with the weird bullet bank."),
                    no = ccb.content.text(", and the other guy there must be the one with the bullet bank."),
                },
            },
        },
        no = ccb.content.text("I'm open to anything if it means getting fed.  Ugh, unless it's unidentified meat.  I guess we have to be more careful of strangers than we used to.  Still, let's find out."),
    },
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
