local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Greenwood_1", "TALK_GODCO_Greenwood_2", "TALK_GODCO_Greenwood_Firstmeet" },
    replies = {
        {
            text = ccb.content.text("I'm seeking forgiveness, Father.  I've made mistakes in my life that I can never take back."),
            actions = {
                "morale_chat_activity",
                actions.add_effect("speaker", "godco_confessed", { turns = 86400 }),
            },
            when = predicates.all({ predicates.negate(predicates.has_effect("speaker", "godco_confessed")), predicates.negate(predicates.has_flag("speaker", "PSYCHOPATH")) }),
            next_topic = "TALK_GODCO_Greenwood_Confessed",
        },
    },
}
