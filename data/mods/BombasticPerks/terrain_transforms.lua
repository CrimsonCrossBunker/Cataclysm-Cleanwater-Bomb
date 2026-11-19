local ccb = require("ccb")
local content = ccb.content

content.add(content.TerrainTransform { id = "perk_closetland_regenerate_light_if_broken" }
    :terrain {
        inputs = { "t_closetland_floor" },
        results = { "t_closetland_floor_olight" },
    })
