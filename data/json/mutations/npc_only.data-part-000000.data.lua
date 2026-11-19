local ccb = require("ccb")

ccb.content.define_mutation {
    id = "NPC_STARTING_NPC",
    name = ccb.content.text_without_extraction("Starting NPC"),
    description = ccb.content.text_without_extraction("Marker for starting NPCs"),
    points = 0,
    player_display = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "NPC_STATIC_NPC",
    name = ccb.content.text_without_extraction("Static NPC"),
    description = ccb.content.text_without_extraction("Marker for static NPCs"),
    points = 0,
    player_display = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "HALLUCINATION",
    name = ccb.content.text_without_extraction("Hallucination"),
    description = ccb.content.text_without_extraction("NPC trait that makes them be hallucination.  It is a bug if you have it."),
    threshold = true,
    points = 0,
    player_display = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "IGNORE_SOUND",
    name = ccb.content.text_without_extraction("Ignores Sounds"),
    description = ccb.content.text_without_extraction("NPC ignores sounds and does not investigate them.  If you see this, it's is a bug."),
    points = 99,
    player_display = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "NO_BASH",
    name = ccb.content.text_without_extraction("Will Not Bash"),
    description = ccb.content.text_without_extraction("NPC will not bash to reach things.  If you see this, it's a bug."),
    points = 99,
    player_display = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "RETURN_TO_START_POS",
    name = ccb.content.text_without_extraction("Returns to Start POS"),
    description = ccb.content.text_without_extraction("NPC will return to its spawn position on idle."),
    points = 99,
    player_display = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "NPC_STASIS",
    name = ccb.content.text_without_extraction("In Stasis"),
    description = ccb.content.text_without_extraction("This NPC is in stasis and will not act, move, or accumulate needs until activated."),
    points = 0,
    player_display = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "INTERCOM_OPERATOR",
    name = ccb.content.text_without_extraction("Intercom Operator"),
    description = ccb.content.text_without_extraction("This NPC operates an intercom system."),
    points = 0,
    player_display = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "TRADE_BACKEND",
    name = ccb.content.text_without_extraction("Trade Backend"),
    description = ccb.content.text_without_extraction("This NPC serves as a backend trade actor for delegated shopkeeping."),
    points = 0,
    player_display = false,
    purifiable = false,
    valid = false,
}
