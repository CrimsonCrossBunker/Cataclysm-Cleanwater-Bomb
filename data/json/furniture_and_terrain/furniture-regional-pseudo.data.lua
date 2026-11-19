local ccb = require("ccb")

ccb.content.define_furniture {
    abstract = "f_region_pseudo",
    name = ccb.content.text("pseudo furniture"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional furniture."),
    symbol = " ",
    color = "black",
    move_cost_mod = 0,
    required_strength = 0,
    flags = { "TRANSPARENT", "REGION_PSEUDO" },
}

ccb.content.define_furniture {
    id = "f_region_flower",
    copy_from = "f_region_pseudo",
    name = ccb.content.text("pseudo furniture"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional furniture."),
    move_cost_mod = 0,
}

ccb.content.define_furniture {
    id = "f_region_weed",
    copy_from = "f_region_pseudo",
    name = ccb.content.text("pseudo furniture"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional furniture."),
    move_cost_mod = 0,
}

ccb.content.define_furniture {
    id = "f_region_water_plant",
    copy_from = "f_region_pseudo",
    name = ccb.content.text("pseudo furniture"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional furniture."),
    move_cost_mod = 0,
}

ccb.content.define_furniture {
    id = "f_region_plain",
    copy_from = "f_region_pseudo",
    name = ccb.content.text("pseudo furniture"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional furniture."),
    move_cost_mod = 0,
}

ccb.content.define_furniture {
    id = "f_region_forest",
    copy_from = "f_region_pseudo",
    name = ccb.content.text("pseudo furniture"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional furniture."),
    move_cost_mod = 0,
}

ccb.content.define_furniture {
    id = "f_region_forest_dense",
    copy_from = "f_region_pseudo",
    name = ccb.content.text("pseudo furniture"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional furniture."),
    move_cost_mod = 0,
}

ccb.content.define_furniture {
    id = "f_region_forest_water",
    copy_from = "f_region_pseudo",
    name = ccb.content.text("pseudo furniture"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional furniture."),
    move_cost_mod = 0,
}

ccb.content.define_furniture {
    id = "f_region_flower_decorative",
    copy_from = "f_region_pseudo",
    name = ccb.content.text("pseudo furniture"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional furniture."),
    move_cost_mod = 0,
}

ccb.content.define_furniture {
    id = "f_region_lake_bed",
    copy_from = "f_region_pseudo",
    name = ccb.content.text("pseudo furniture"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional furniture."),
    move_cost_mod = 0,
}

ccb.content.define_furniture {
    id = "f_region_ocean_bed",
    copy_from = "f_region_pseudo",
    name = ccb.content.text("pseudo furniture"),
    description = ccb.content.text("This should never actually show up, it should have been replaced with regional furniture."),
    move_cost_mod = 0,
}
