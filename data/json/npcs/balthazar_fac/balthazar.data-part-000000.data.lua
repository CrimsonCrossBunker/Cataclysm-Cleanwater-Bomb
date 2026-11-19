local ccb = require("ccb")

ccb.content.define_npc {
    id = "balthazar_intercom",
    unique_name = ccb.content.text("balthazar"),
    class = "NC_BALTHAZAR_INTERCOM",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_BALTHAZAR_INTERCOM",
    faction = "balthazar_fac",
    missions_offered = "MISSION_GET_SOLAR_PANELS_BALTHAZAR",
}

-- trading will be implemented later
ccb.content.define_npc_class {
    id = "NC_BALTHAZAR_INTERCOM",
    name = ccb.content.text("bunker voice"),
    job_description = ccb.content.text("Locked in a bunker."),
    common = false,
    carry = "EMPTY_GROUP",
    worn = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    sells_belongings = false,
}
