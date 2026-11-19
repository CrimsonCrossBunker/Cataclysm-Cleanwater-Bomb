local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FOREMAN_reward",
    line = ccb.content.text("You've done a lot for the ranch, by generally helping the community with both wellness and trade.  As the project lead, I want to make sure these efforts don't go unnoticed."),
    replies = {
        {
            text = ccb.content.text("You mean setting up the doctor's office?"),
            next_topic = "TALK_RANCH_FOREMAN_Doctor_done",
            when = predicates.any_equal({ "no", { scope = "speaker", key = "mission_flag_Doctor_rewarded" } }),
        },
        {
            text = ccb.content.text("Is this about bootstrapping the trade relating to the bar?"),
            next_topic = "TALK_RANCH_FOREMAN_Bartender_done",
            when = predicates.any_equal({ "no", { scope = "speaker", key = "mission_flag_Bartender_rewarded" } }),
        },
        {
            text = ccb.content.text("Understood.  Back to business."),
            next_topic = "TALK_RANCH_FOREMAN",
        },
    },
}
