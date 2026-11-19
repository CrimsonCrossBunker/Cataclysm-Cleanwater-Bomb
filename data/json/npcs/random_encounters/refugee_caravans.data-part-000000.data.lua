local ccb = require("ccb")

-- Random NPC, can direct you to the free merchants and nearest FEMA camp.
ccb.content.define_npc {
    id = "NC_caravan_refugee_A",
    suffix = ccb.content.text("refugee"),
    class = "NC_SCAVENGER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_CARAVAN_REFUGEE_A1",
    faction = "wasteland_scavengers",
}

-- Random NPC, can be recruited away.
ccb.content.define_npc {
    id = "NC_caravan_refugee_B",
    suffix = ccb.content.text("refugee"),
    class = "NC_SCAVENGER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_CARAVAN_REFUGEE_B1",
    faction = "wasteland_scavengers",
}

-- Random NPC, demands heroin and can accept.
ccb.content.define_npc {
    id = "NC_caravan_refugee_C",
    suffix = ccb.content.text("refugee"),
    class = "NC_SCAVENGER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_CARAVAN_REFUGEE_C1",
    faction = "wasteland_scavengers",
}
