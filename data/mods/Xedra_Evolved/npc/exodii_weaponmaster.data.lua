local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_WEAPONMASTER_EXODII_DO_NOT_SPEAK_TO_FAIR_FOLK",
    line = ccb.content.text("&No matter what you do or say, the mechanical creature refuses to acknowledge you."),
    replies = { { text = ccb.content.text("Leaves."), next_topic = "TALK_DONE" } },
}
