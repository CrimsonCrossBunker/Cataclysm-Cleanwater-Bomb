local ccb = require("ccb")

ccb.content.define_map_extra_collection {
    id = "forest_water",
    copy_from = "forest_water",
    add_extras = { { extra = "mx_pond_swamp", weight = 240 }, { extra = "mx_pond_swamp_2", weight = 240 } },
}

ccb.content.define_map_extra_collection {
    id = "ravine_bottom",
    chance = 30,
    extras = {
        { extra = "mx_grove_ravine", weight = 200 },
        { extra = "mx_pond_ravine", weight = 150 },
        { extra = "mx_pond_forest_ravine", weight = 100 },
        { extra = "mx_pond_forest_2_ravine", weight = 50 },
        { extra = "mx_shrubbery_ravine", weight = 100 },
        { extra = "mx_blackberry_patch", weight = 25 },
        { extra = "mx_strawberry_patch", weight = 25 },
        { extra = "mx_blueberry_patch", weight = 25 },
        { extra = "mx_raspberry_patch", weight = 25 },
        { extra = "mx_huckleberry_patch", weight = 25 },
        { extra = "mx_hobblebush_patch", weight = 25 },
        { extra = "mx_autumn_olive_patch", weight = 25 },
        { extra = "mx_spider", weight = 25 },
    },
}
