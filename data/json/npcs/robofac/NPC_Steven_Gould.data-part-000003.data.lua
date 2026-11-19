local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_1_EQUIPMENT_ACCEPTED",
    line = ccb.content.text("You didn't get that from me, yeah?"),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_DONE" } },
}
