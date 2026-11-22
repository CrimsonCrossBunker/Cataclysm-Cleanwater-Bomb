local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_DEFENSE_MODE_WIN",
    line = ccb.content.text("&Through all your struggles, you have won the day against the unknown.  Do you wish to struggle more, or rest in your triumph."),
    replies = {
        {
            text = ccb.content.text("I wish to rest in my triumph, and let the struggle end."),
            next_topic = "TALK_DONE",
            actions = { "u_die" },
        },
        {
            text = ccb.content.text("I will continue on and face oblivion, even if it costs me my life and limb."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_defense_mode_cab489514716") },
        },
    },
}
