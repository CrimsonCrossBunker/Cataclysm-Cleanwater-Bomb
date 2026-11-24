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

ccb.content.define_mutation {
    id = "GETS_RANDOM_MISSION",
    name = ccb.content.text_without_extraction("Assign Random Mission"),
    description = ccb.content.text_without_extraction("This is an AI tag to give a static NPC a random mission.  If you see this, it's a bug."),
    points = 0,
    purifiable = false,
    valid = false,
    active = true,
    starts_active = true,
    on_process = "give_random_mission",
}

ccb.content.define_mutation {
    id = "GETS_RANDOM_MISSION_NOMOVE",
    name = ccb.content.text_without_extraction("Assign Random No-move Mission"),
    description = ccb.content.text_without_extraction("This is an AI tag to give a static NPC a random mission that doesn't involve them following you.  If you see this, it's a bug."),
    points = 0,
    purifiable = false,
    valid = false,
    active = true,
    starts_active = true,
    on_process = "give_random_mission",
}

ccb.content.define_mutation {
    id = "BEE",
    name = ccb.content.text_without_extraction("Bee"),
    description = ccb.content.text_without_extraction("NPC trait that makes monsters see it as a bee.  It is a bug (heh) if you have it."),
    threshold = true,
    points = 0,
    player_display = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "MYCUS_FRIEND",
    name = ccb.content.text_without_extraction("Mycus friend"),
    description = ccb.content.text_without_extraction("NPC trait that makes fungaloid monsters see this NPC as a friend."),
    points = 0,
    player_display = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "NPC_BRANDY",
    name = ccb.content.text_without_extraction("Carries Brandy"),
    description = ccb.content.text_without_extraction("This Bartender now carries brandy!"),
    points = 0,
    player_display = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "NPC_RUM",
    name = ccb.content.text_without_extraction("Carries Rum"),
    description = ccb.content.text_without_extraction("This Bartender now carries rum!"),
    points = 0,
    player_display = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "NPC_WHISKEY",
    name = ccb.content.text_without_extraction("Carries Whiskey"),
    description = ccb.content.text_without_extraction("This Bartender now carries whiskey!"),
    points = 0,
    player_display = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "NPC_MISSION_LEV_1",
    name = ccb.content.text_without_extraction("Has Level 1 Companion Missions"),
    description = ccb.content.text_without_extraction("New mission options have become available!"),
    points = 0,
    player_display = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "NPC_CONSTRUCTION_LEV_1",
    name = ccb.content.text_without_extraction("Has Level 1 Construction Built"),
    description = ccb.content.text_without_extraction("New options may have become available!"),
    points = 0,
    player_display = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "NPC_CONSTRUCTION_LEV_2",
    name = ccb.content.text_without_extraction("Has Level 2 Construction Built"),
    description = ccb.content.text_without_extraction("New options may have become available!"),
    points = 0,
    player_display = false,
    purifiable = false,
    valid = false,
}
