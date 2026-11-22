local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_ARMOR_POSITIVE",
    line = ccb.content.text("We've solved that issue with our more recent prototypes.\"  There is a brief pause.  \"You seem like a good candidate.  We will transfer over the additional pieces to complete that prototype set, with the goal of collecting additional field data.  The core armor platform is solid, and we have been iterating on supplementary pieces we would be willing to trade to you.  Any feedback on their performance would be appreciated."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_ae90e528a11f") } },
    },
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            actions = { actions.handler("dlg_a_dda_b452b1ce4f53") },
        },
        {
            text = ccb.content.text("Hopefully it serves me better than the good doctor."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            actions = { actions.handler("dlg_a_dda_b452b1ce4f53") },
        },
        {
            text = ccb.content.text("We'll see what happens."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            actions = { actions.handler("dlg_a_dda_b452b1ce4f53") },
        },
    },
}
