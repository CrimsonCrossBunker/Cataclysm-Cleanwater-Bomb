local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_EVAC_GUARD2_danger_sense" },
    line = ccb.content.text("&You open your senses, alert for danger, but don't sense anything.  <npc_name> is sincere in their friendliness, or least isn't hiding a dagger behind their back."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_GUARD" } },
}
