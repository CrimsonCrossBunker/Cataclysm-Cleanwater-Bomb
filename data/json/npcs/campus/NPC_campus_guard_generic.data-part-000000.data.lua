local ccb = require("ccb")

-- A generic guard for the campus faction.
ccb.content.define_npc {
    id = "great_library_guard",
    suffix = ccb.content.text("Guard"),
    class = "NC_CAMPUS_GUARD",
    attitude = 0,
    mission = "NULL",
    chat = "TALK_CAMP_GUARD",
    faction = "the_great_library",
}
