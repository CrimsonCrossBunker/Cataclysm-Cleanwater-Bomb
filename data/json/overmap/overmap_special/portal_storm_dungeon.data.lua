local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "portal_storm_dungeon_teleporter",
    tiles = { { point = { 0, 0, 0 }, terrain = "portal_storm_dungeon_teleporter" } },
    locations = { "portal_storm_dungeon" },
    occurrences = { 50, 75 },
    flags = { "PORTAL_STORM_DUNGEON", "EXTRADIMENSIONAL" },
}
