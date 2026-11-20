local ccb = require("ccb")
local content = ccb.content

-- Native overmap connections
do
local definition = content.OvermapConnection {
    id = "local_railroad",
}
definition:subtype("railroad", 1, { "railroad" }, false, false)
definition:subtype("railroad", 2, { "generic_loot_locations" }, false, false)
definition:subtype("railroad", 2, { "wilderness" }, false, false)
definition:subtype("railroad", 2, { "swamp" }, false, false)
definition:subtype("railroad_level_crossing", 2, { "railroad_level_crossing_allowed" }, true, false)
definition:subtype("railroad_bridge", 2, { "water" }, true, false)
content.add(definition)
end
