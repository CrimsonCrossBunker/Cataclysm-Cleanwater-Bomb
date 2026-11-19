local ccb = require("ccb")

ccb.content.define_npc {
    id = "thug",
    suffix = ccb.content.text("Thug"),
    class = "NC_THUG",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_DONE",
    faction = "hells_raiders",
}

ccb.content.define_npc {
    id = "bandit",
    suffix = ccb.content.text("Bandit"),
    class = "NC_SCAVENGER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_DONE",
    faction = "hells_raiders",
}

ccb.content.define_npc {
    id = "raider",
    suffix = ccb.content.text("Raider"),
    class = "NC_SOLDIER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_DONE",
    faction = "hells_raiders",
}

-- Mission set to null, so they walk around.
ccb.content.define_npc {
    id = "wandering_thug",
    suffix = ccb.content.text("Thug"),
    class = "NC_THUG",
    attitude = 0,
    mission = "NULL",
    chat = "TALK_DONE",
    faction = "hells_raiders",
}

ccb.content.define_npc {
    id = "wandering_bandit",
    suffix = ccb.content.text("Bandit"),
    class = "NC_SCAVENGER",
    attitude = 0,
    mission = "NULL",
    chat = "TALK_DONE",
    faction = "hells_raiders",
}

ccb.content.define_npc {
    id = "wandering_raider",
    suffix = ccb.content.text("Raider"),
    class = "NC_SOLDIER",
    attitude = 0,
    mission = "NULL",
    chat = "TALK_DONE",
    faction = "hells_raiders",
}
