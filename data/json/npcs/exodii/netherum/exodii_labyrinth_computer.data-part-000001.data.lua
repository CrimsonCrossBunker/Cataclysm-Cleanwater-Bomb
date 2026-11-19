local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Entrance_Controls2_no",
    line = ccb.content.text("& User not permitted."),
    replies = { { text = ccb.content.text("[Step away]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Entrance_Controls2_wait",
    line = ccb.content.text("& Cycle in effect.  Wait five days from last jump."),
    replies = { { text = ccb.content.text("[Step away]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Entrance_Controls2_no_access",
    line = ccb.content.text("& ERROR: Doing 'wobble()' terminated unwarly.  DIAGNOSTIC: Labyrinth coordinate update required."),
    replies = { { text = ccb.content.text("[Step away]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Entrance_Controls2_no_charges",
    line = ccb.content.text("& ERROR: Doing 'wobble()' terminated unwarly.  DIAGNOSTIC: No valid coordinates in attached device."),
    replies = { { text = ccb.content.text("[Step away]"), next_topic = "TALK_DONE" } },
}
