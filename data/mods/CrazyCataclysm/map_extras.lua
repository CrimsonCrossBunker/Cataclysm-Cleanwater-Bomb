local ccb = require("ccb")
local content = ccb.content

-- Native map-extra definitions
do
local definition = content.MapExtra {
    id = "mx_shia",
    name = ccb.content.text("Shia LaBeouf"),
    description = ccb.content.text("Cannibal is nearby."),
    generator_method = "update_mapgen",
    generator_id = "mx_shia",
    z_levels = { 0, 0 },
    symbol = "s",
    color = "red",
    autonote_visibility = "same_tile",
}
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_jackson",
    name = ccb.content.text("Jackson"),
    description = ccb.content.text("It's close to midnight, and something evil's lurking in the dark."),
    generator_method = "update_mapgen",
    generator_id = "mx_jackson",
    z_levels = { 0, 0 },
    symbol = "j",
    color = "red",
    autonote_visibility = "same_tile",
}
content.add(definition)
end
