local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_DOCTOR_SHARE_LIFE_ELIXIR",
    line = {
        choices = {
            ccb.content.text("[Blaine copies the recipe on a paper sheet]  If it is true, the only ingredient I lack is elder ginseng.  Could you please bring me some?  This would be a favor I won't forget soon."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I'll find some."),
            next_topic = "TALK_HUNTER_DOCTOR_FIND_GINSENG_ACCEPT",
            actions = { actions.assign_mission("MISSION_VAMPIRE_HUNTER_DOCTOR_FIND_GINSENG") },
        },
        {
            text = ccb.content.text("I'm not interested in doing that."),
            next_topic = "TALK_HUNTER_DOCTOR_FIND_GINSENG_REFUSE",
        },
    },
}
