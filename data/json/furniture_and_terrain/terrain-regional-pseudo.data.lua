local ccb = require("ccb")

ccb.content.define_terrain {
    abstract = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    symbol = " ",
    color = "black",
    move_cost = 1,
    flags = { "TRANSPARENT", "REGION_PSEUDO" },
}

ccb.content.define_terrain {
    abstract = "t_region_pseudo_noitem",
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
    extend = { flags = { "NOITEM" } },
}

ccb.content.define_terrain {
    id = "t_region_groundcover",
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_groundcover_urban",
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_groundcover_forest",
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_groundcover_swamp",
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_groundcover_barren",
    description = ccb.content.text("This should never actually show up, it's a pseudo terrain.  For use where people have trampled away grass, or otherwise cleared plant life."),
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_grass",
    description = ccb.content.text("This should never actually show up, it's a pseudo terrain.  For use where clean, curated grass is the only expected terrain - modified by whatever the biome equivalent is."),
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_soil",
    description = ccb.content.text("This should never actually show up, it's a pseudo terrain.  For use where plants have been planted and grass/groundcover kept clear."),
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_tree",
    copy_from = "t_region_pseudo_noitem",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_tree_forest_dense",
    copy_from = "t_region_pseudo_noitem",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_tree_forest",
    copy_from = "t_region_pseudo_noitem",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_tree_forest_other",
    copy_from = "t_region_pseudo_noitem",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_tree_evergreen",
    copy_from = "t_region_pseudo_noitem",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_tree_fruit",
    copy_from = "t_region_pseudo_noitem",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_tree_fruit_wild",
    copy_from = "t_region_pseudo_noitem",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_tree_nut",
    copy_from = "t_region_pseudo_noitem",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_tree_shade",
    copy_from = "t_region_pseudo_noitem",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_tree_dead",
    copy_from = "t_region_pseudo_noitem",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_shrub",
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_shrub_fruit",
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_shrub_plains",
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_shrub_swamp",
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_shrub_forest_dense",
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_shrub_forest",
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_region_shrub_decorative",
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_highland_groundcover",
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_string_dimension_groundcover",
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_netherum_labyrinth_groundcover",
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}

ccb.content.define_terrain {
    id = "t_portal_storm_dungeon_groundcover",
    copy_from = "t_region_pseudo",
    name = ccb.content.text("pseudo terrain"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional terrain."),
    move_cost = 1,
}
