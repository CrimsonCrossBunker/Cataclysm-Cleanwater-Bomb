local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FINISH_ROBOFAC_EXODII_DISCUSSION",
    line = ccb.content.text("Thank you for bringing this information to us…"),
    replies = {
        {
            text = ccb.content.text("Let's talk reward."),
            next_topic = "TALK_ROBOFAC_EXODII_INFO_REWARD",
        },
        {
            text = ccb.content.text("No problem, if you ask me to choose between us and cyborg tyrants, you best believe I ain't betraying my race.  It's unnatural you know?  Please let me know if there is anything else I can do for you guys."),
            next_topic = "TALK_ROBOFAC_INTERCOM_INTRO_4",
            actions = { actions.adjust_faction_trust(2) },
        },
    },
}
