local ccb = require("ccb")
local content = ccb.content

content.add(content.TerrainTransform { id = "iso_open_bossfight" }
    :terrain {
        inputs = { "t_iso_bossfight_door" },
        results = { "t_metal_floor" },
    })
