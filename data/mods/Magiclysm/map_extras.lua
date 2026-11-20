local ccb = require("ccb")
local content = ccb.content

-- Native map-extra definitions
do
local definition = content.MapExtra {
    id = "mx_catoblepas_lair",
    name = ccb.content.text("Catoblepas Lair"),
    description = ccb.content.text("There are catoblepases lairing here."),
    generator_method = "update_mapgen",
    generator_id = "mx_catoblepas_lair",
    z_levels = { 0, 0 },
    symbol = "C",
    color = "brown",
    autonote_visibility = "none",
}
content.add(definition)
end
