local ccb = require("ccb")
local content = ccb.content

-- Native map-extra definitions
do
local definition = content.MapExtra {
    id = "mx_teleporter_node",
    name = ccb.content.text("Red room"),
    description = ccb.content.text("There's a red room here."),
    generator_method = "update_mapgen",
    generator_id = "mx_teleporter_node",
    symbol = "X",
    color = "red",
    autonote_visibility = "same_tile",
}
definition:flag("BACKROOMS")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_autodoc_room",
    name = ccb.content.text("Autodoc room"),
    description = ccb.content.text("There's an autodoc here."),
    generator_method = "update_mapgen",
    generator_id = "mx_autodoc_room",
    symbol = "A",
    color = "pink",
    autonote_visibility = "same_tile",
}
definition:flag("BACKROOMS")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_wasp_backrooms",
    name = ccb.content.text("Wasp Nest"),
    description = ccb.content.text("A wasp nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_wasp_backrooms",
    z_levels = { -3, 3 },
    symbol = "W",
    color = "yellow",
    autonote_visibility = "same_tile",
}
definition:flag("WASP")
definition:flag("BACKROOMS")
content.add(definition)
end
do
local definition = content.MapExtra {
    id = "mx_nest_dermatik_backrooms",
    name = ccb.content.text("Dermatik Nest"),
    description = ccb.content.text("A dermatik nest."),
    generator_method = "update_mapgen",
    generator_id = "mx_nest_dermatik_backrooms",
    z_levels = { -3, 3 },
    symbol = "D",
    color = "brown",
    autonote_visibility = "same_tile",
}
definition:flag("WASP")
definition:flag("BACKROOMS")
content.add(definition)
end
