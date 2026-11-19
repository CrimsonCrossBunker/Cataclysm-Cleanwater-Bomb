local ccb = require("ccb")

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
