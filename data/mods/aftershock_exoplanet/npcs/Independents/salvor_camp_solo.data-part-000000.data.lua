local ccb = require("ccb")

-- A generic mercenary for decorative purposes.
ccb.content.define_npc {
    id = "salvor_camp_solo",
    suffix = ccb.content.text("mercenary"),
    class = "NC_AFS_SOLO",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_SALVOR_CAMP_SOLO",
    faction = "independents",
}
