local ccb = require("ccb")

-- decorative flora for breather biome.
ccb.content.define_furniture {
    id = "f_crystalline_flower",
    name = ccb.content.text("crystalline flower"),
    description = ccb.content.text("A crystalline structure that resembles a plant."),
    symbol = "f",
    color = "light_green",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE" },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_absence",
    name = ccb.content.text("less than nothing"),
    description = ccb.content.text("There is nothing here.  Not even time or space."),
    symbol = "O",
    color = "black",
    move_cost_mod = -1,
    required_strength = -1,
    flags = { "TRANSPARENT", "FLOATS_IN_AIR" },
}
