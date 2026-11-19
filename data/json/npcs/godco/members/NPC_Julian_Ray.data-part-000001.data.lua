local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_2",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }),
        yes = {
            choices = {
                ccb.content.text("If you have complaints, please don't tell anyone."),
                ccb.content.text("You're still staying here, joinee?"),
                ccb.content.text("Need anything, joinee?"),
            },
        },
        no = { choices = { ccb.content.text("Need anything?"), ccb.content.text("Go on…") } },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
