local ccb = require("ccb")

-- Nested damage which has been extracted from standard_domestic_palette because it wasn't playing nicely with nests
ccb.content.define_mapgen_palette {
    id = "no_hope_damage_palette",
    layout = {
        nested_glyphs = {
            o = {
                choices = { { id = "destroyed_furniture", weight = 80 }, { id = "null", weight = 20 } },
            },
            [":"] = {
                choices = { { id = "destroyed_glass_door_wall", weight = 80 }, { id = "null", weight = 20 } },
            },
            [" "] = {
                choices = {
                    { id = "bile_field", weight = 5 },
                    { id = "trash", weight = 5 },
                    { id = "null", weight = 90 },
                },
            },
        },
    },
}
