local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_directions_isherwood",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_an_isherwood" } }),
        yes = ccb.content.text("It's just that Isherwood farm, yeah?"),
        no = ccb.content.text("More recon is good for me.  Go locked and loaded, yeah?"),
    },
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_directions_exodii",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }),
        yes = ccb.content.text("You've been there, remember?  It's got those fahkin' robots!"),
        no = ccb.content.text("I say this a lot, but go strapped, yeah?  Don't like the sound of that."),
    },
    replies = { { text = ccb.content.text("Thanks a lot."), next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_directions_artisans",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_isolated_road_artisans" } }),
        yes = ccb.content.text("You've been there, remember?  Cody n' Jay."),
        no = ccb.content.text("Could always use more bullets.  If it's like anywhere else, I bet they got work.  Make sure ya' check in if they do."),
    },
    replies = {
        {
            text = ccb.content.text("Right.  Thanks a lot."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}
