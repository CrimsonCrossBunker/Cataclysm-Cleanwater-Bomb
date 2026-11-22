local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_DINODAVE_Gift_Given",
    line = ccb.content.text("Indeed, my knight.  I was hesitant to grant you this power, but you have proven your worth and fealty many times over.  Make sure it does not fall into the wrong hands.  May it help you on your journey."),
    replies = {
        {
            text = ccb.content.text("[Take the gift.]"),
            next_topic = "TALK_DINODAVE_Gift_Bye",
            actions = { actions.handler("dlg_a_dda_4db2f5d30388") },
        },
    },
}
