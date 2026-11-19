local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_dormant",
    layout = {
        monster_group_glyphs = { [" "] = { group = "GROUP_VANILLA_DORMANT", chance = 10, density = 0.02 } },
    },
}
