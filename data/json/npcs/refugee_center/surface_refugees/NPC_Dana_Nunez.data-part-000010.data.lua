local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_DANA_Sourdough3",
    line = ccb.content.text("*takes the jar from you eagerly, studying it with care.  \"He's been through a lot, hasn't he.  Poor guy.  Aw man.\"  She turns back to you, beaming.  \"Oh, you will not regret this.  He may not look like much, but he's got it where it counts, kid.  It's gonna take me a few days to revive him after being abandoned so long, but he'll be operational soon and then you can come back for some real bread.\"  She frowns.  \"I don't really have much to give you in return, but I'll cut you a deal on bread if that helps.\""),
    on_enter = {
        { actions = { actions.transfer_items("landough_calrisean"), actions.finish_mission("MISSION_REFUGEE_Dana_Sourdough", { success = true }) } },
    },
    replies = {
        {
            text = ccb.content.text("I'll hold you to that."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'm just glad to help."),
            next_topic = "TALK_DONE",
        },
    },
}
