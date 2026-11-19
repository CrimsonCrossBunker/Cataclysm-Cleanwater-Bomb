local ccb = require("ccb")

-- old magus in the wizard tower.
ccb.content.define_npc {
    id = "magus_old",
    suffix = ccb.content.text("magus"),
    class = "NC_OLD_MAGUS",
    attitude = 0,
    mission = "GUARD",
    missions_offered = "MISSION_GET_MAGIC_BOOK",
    chat = "TALK_OLD_MAGUS",
    faction = "wizards_ancient",
}

-- possibly crazy techno kid
ccb.content.define_npc {
    id = "techno_kid",
    suffix = ccb.content.text("technologist"),
    class = "NC_TECHNO_KID",
    attitude = 0,
    mission = "GUARD",
    missions_offered = "MISSION_GET_POWER_CBM",
    chat = "TALK_TECHNO_KID",
    faction = "no_faction",
}

-- a priest of the grey flame
ccb.content.define_npc {
    id = "healer_priest",
    suffix = ccb.content.text("healer"),
    class = "NC_BIO_PRIEST",
    attitude = 0,
    mission = "GUARD",
    missions_offered = "MISSION_PURGE_50_Z",
    chat = "TALK_HEALER_GREY",
    faction = "healers_grey",
}
