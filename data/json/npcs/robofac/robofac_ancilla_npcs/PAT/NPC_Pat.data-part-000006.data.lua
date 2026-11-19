local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_1_MVAS_HVAH",
    line = ccb.content.text("Great.  This should be easy.  Come back tomorrow, and I'll have somethin' for ya'."),
    replies = { { text = ccb.content.text("Sure, see you tomorrow."), next_topic = "TALK_DONE" } },
}
