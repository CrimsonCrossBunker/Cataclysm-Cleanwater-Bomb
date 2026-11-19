local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "MSU14_DOCS_FAILURE",
    line = ccb.content.text("&ERROR: Schematic access denied - too many requests.\nPlease contact the system administrator."),
    replies = { { text = ccb.content.text("Return."), next_topic = "MSU14_MAIN" } },
}
