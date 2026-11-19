local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_chocolate_sh",
    name = ccb.content.text("shallow chocolate"),
    description = ccb.content.text("The chocolate isn't too deep here.  With a watertight container, you could gather what looks to be pure melted cacao.  This will not be tasty."),
    symbol = "~",
    color = "light_blue",
    move_cost = 5,
    liquid_source = { item = "liquid_cacao", minimum_temperature = 4.4 },
    flags = { "TRANSPARENT", "LIQUID", "NO_SCENT", "SWIMMABLE", "FISHABLE", "SHALLOW_WATER" },
    connect_groups = "WATER",
    connects_to = "WATER",
    builtin_examine = "water_source",
}

ccb.content.define_terrain {
    id = "t_chocolate_dp",
    name = ccb.content.text("deep chocolate"),
    description = ccb.content.text("The chocolate here is deep enough to drown in.  With a watertight container, you could gather what looks to be pure melted cacao.  This will not be tasty."),
    symbol = "~",
    color = "light_blue",
    move_cost = 5,
    liquid_source = { item = "liquid_cacao", minimum_temperature = 4.4 },
    flags = { "TRANSPARENT", "LIQUID", "NO_SCENT", "SWIMMABLE", "FISHABLE" },
    connect_groups = "WATER",
    connects_to = "WATER",
    builtin_examine = "water_source",
}

ccb.content.define_terrain {
    id = "t_caramel",
    name = ccb.content.text("caramel"),
    description = ccb.content.text("An extremely hot, glowing liquid, composed of molten caramel.  In some places, caramel coated fruit is a delicacy."),
    symbol = "~",
    color = "red",
    move_cost = 4,
    light_emitted = 50,
    trap = "tr_lava",
    flags = { "TRANSPARENT", "LIQUID", "NO_SCENT", "DESTROY_ITEM", "USABLE_FIRE" },
}
