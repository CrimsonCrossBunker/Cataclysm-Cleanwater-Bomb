local ccb = require("ccb")

-- Fire extinguisher that may or may not be empty
ccb.content.define_mapgen {
    kind = "nested",
    id = "fire_extinguisher",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "+",
        },
        item_spawns = { ["+"] = { id = "extinguisher", chance = 75 } },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}
