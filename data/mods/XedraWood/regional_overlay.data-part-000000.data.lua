local ccb = require("ccb")

ccb.content.define_map_extra_collection {
    id = "forest_water",
    copy_from = "forest_water",
    add_extras = {
        { extra = "mx_giant_snake_nest", weight = 1 },
        { extra = "mx_nest_claw_hunter", weight = 1 },
        { extra = "mx_nest_claw_runner", weight = 4 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest",
    copy_from = "forest",
    add_extras = {
        { extra = "mx_warped_tree_grove", weight = 10 },
        { extra = "mx_campfire_remnants", weight = 5 },
        { extra = "mx_nest_claw_runner", weight = 2 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_thick",
    copy_from = "forest_thick",
    add_extras = {
        { extra = "mx_warped_tree_grove", weight = 10 },
        { extra = "mx_campfire_remnants", weight = 5 },
        { extra = "mx_tanglevine_patch", weight = 2 },
    },
}

ccb.content.define_map_extra_collection {
    id = "ravine_bottom",
    copy_from = "ravine_bottom",
    add_extras = {
        { extra = "mx_warped_tree_grove", weight = 10 },
        { extra = "mx_tanglevine_patch", weight = 4 },
    },
}
