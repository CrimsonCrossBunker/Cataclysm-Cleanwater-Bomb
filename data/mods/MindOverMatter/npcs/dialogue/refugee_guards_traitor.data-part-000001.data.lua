local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD3_danger_sense" },
    line = ccb.content.text("&You open up your senses and the hair on the back of your neck immediately stands up.  Something could go very wrong for you at any moment."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EVAC_GUARD3" } },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD3_sense_hostility" },
    line = ccb.content.text("&You barely open up your senses before you're met with an overpowering sense of menace.  <npc_name> isn't planning to kill you at this exact second but that could change at any moment."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EVAC_GUARD3" } },
}
