local content = require("ccb").content

content.add(content.OvermapLocation {
    id = "generic_loot_locations",
    flags = { "GENERIC_LOOT" },
})

content.add(content.OvermapLocation {
    id = "railroad",
    terrains = { "railroad" },
})

content.add(content.OvermapLocation {
    id = "railroad_level_crossing_allowed",
    terrains = { "road" },
})
