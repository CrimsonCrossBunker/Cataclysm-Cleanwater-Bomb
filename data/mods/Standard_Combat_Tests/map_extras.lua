local ccb = require("ccb")
local content = ccb.content

-- Native map-extra definitions
do
local definition = content.MapExtra {
    id = "mx_sct_day1",
    name = ccb.content.text("Standard early game combat test area"),
    description = ccb.content.text("There are some improvised weapons nearby."),
    generator_method = "update_mapgen",
    generator_id = "mx_sct_day1",
    z_levels = { 0, 0 },
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_sct_mid",
    name = ccb.content.text("Standard midgame combat test area"),
    description = ccb.content.text("There are some scavenged weapons nearby."),
    generator_method = "update_mapgen",
    generator_id = "mx_sct_mid",
    z_levels = { 0, 0 },
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_sct_late",
    name = ccb.content.text("Standard lategame combat test area"),
    description = ccb.content.text("There are some survivor weapons nearby."),
    generator_method = "update_mapgen",
    generator_id = "mx_sct_late",
    z_levels = { 0, 0 },
}
content.add(definition)
end
