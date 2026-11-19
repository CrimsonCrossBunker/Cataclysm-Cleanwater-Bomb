local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD1_danger_sense" },
    line = ccb.content.text("&You open your senses, alert for danger, but don't sense anything.  <npc_name> bears you no ill will at all."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_EVAC_GUARD1" } },
}
