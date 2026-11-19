local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "open_cryo_pod2",
    layout = {
        size = { width = 1, height = 1 },
        monster_group_placements = {
            {
                group = "GROUP_CRYO_LAB",
                x = { 0 },
                y = { 0 },
                density = 0.01,
                repetitions = { 1, 3 },
            },
        },
    },
}
