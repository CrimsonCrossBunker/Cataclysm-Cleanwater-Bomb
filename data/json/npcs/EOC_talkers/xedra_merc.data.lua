local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_XEDRA_MERC_HAUNTING",
    line = ccb.content.text("With a terrible shriek the mercenary falls off the spike and begins to move.  It stares right at you before vanishing.  In the distance you can hear a radio squelch:\n\"Target acquired.  Falling back, regroup and prepare to attack the intruder.\""),
    replies = {
        {
            text = ccb.content.text("You can hear the rushing of boots all around you, and the chattering of radios.  It must still be close and you are their target."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_5d4a44ef57cd") },
        },
    },
}
