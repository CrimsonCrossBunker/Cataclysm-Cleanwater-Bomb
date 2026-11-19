local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_mine_amigara_finale_central_1",
    line = ccb.content.text("Sounded like someone--omething, chattin' on -- frequency.  It's gone-\"… the signal becomes dead static."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
