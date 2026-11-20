local ccb = require("ccb")

ccb.content.define_map_extra_collection {
    id = "road",
    copy_from = "road",
    add_extras = {
        { extra = "mx_golden_monolith", weight = 15 },
        { extra = "mx_XE_XEDRA_mutagen_transport", weight = 3 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest",
    copy_from = "forest",
    add_extras = {
        { extra = "mx_goblin_fruits", weight = 25 },
        { extra = "mx_ozma_statue", weight = 5 },
        { extra = "mx_ring_of_mushrooms", weight = 15 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_thick",
    copy_from = "forest_thick",
    add_extras = {
        { extra = "mx_goblin_fruits", weight = 30 },
        { extra = "mx_ozma_statue", weight = 5 },
        { extra = "mx_ring_of_mushrooms", weight = 20 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_water",
    copy_from = "forest_water",
    add_extras = { { extra = "mx_goblin_fruits", weight = 15 } },
}

ccb.content.define_map_extra_collection {
    id = "field",
    copy_from = "field",
    add_extras = {
        { extra = "mx_deathworm_track", weight = 1 },
        { extra = "mx_sevenoclock_track", weight = 1 },
        { extra = "mx_dreamwound_shadow", weight = 5 },
        { extra = "mx_trees_map_salamander", weight = 75 },
        { extra = "mx_trees_map_sylph", weight = 75 },
        { extra = "mx_trees_map_ierde", weight = 75 },
        { extra = "mx_homelesscamp_homullus", weight = 75 },
        { extra = "mx_forest_pond_avore", weight = 75 },
        { extra = "mx_forest_pond_salamander_avore", weight = 75 },
        { extra = "mx_pond_forest_undine", weight = 75 },
        { extra = "mx_pond_forest_undine_ierde", weight = 75 },
        { extra = "mx_ring_of_mushrooms", weight = 30 },
        { extra = "mx_ozma_statue", weight = 5 },
        { extra = "mx_goblin_fruits", weight = 15 },
    },
}

ccb.content.define_map_extra_collection {
    id = "agricultural",
    copy_from = "agricultural",
    add_extras = {
        { extra = "mx_goblin_fruits", weight = 15 },
        { extra = "mx_ring_of_mushrooms", weight = 10 },
    },
}
