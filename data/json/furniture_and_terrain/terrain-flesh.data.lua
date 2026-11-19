local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_thconc_floor_flesh",
    name = ccb.content.text("overgrown floor"),
    description = ccb.content.text("A bare concrete floor, almost completely covered by twitching filaments of gray flesh."),
    symbol = ".",
    color = "red_yellow",
    move_cost = 5,
    roof = "t_concrete_roof",
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT" },
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_concrete",
        minimum_strength = 10,
        maximum_strength = 20,
        minimum_strength_supported = 10,
        drops = { { item = "meat_tainted", count = { 5, 10 } } },
    },
}

ccb.content.define_terrain {
    id = "t_concrete_wall_flesh",
    name = ccb.content.text("overgrown wall"),
    description = ccb.content.text("A concrete wall overgrown by a grotesque grid of veins and knotted flesh."),
    symbol = "#",
    color = "magenta_yellow",
    move_cost = 0,
    coverage = 100,
    roof = "t_concrete_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 10,
        maximum_strength = 20,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_strconc_wall",
        drops = { { item = "meat_tainted", count = { 5, 10 } } },
    },
}

ccb.content.define_terrain {
    id = "t_pit_corpsed_flesh",
    looks_like = "t_pit_corpsed",
    name = ccb.content.text("corpse filled pit"),
    description = ccb.content.text("A giant trench full of corpses, maybe even a mass graveyard.  The bodies seem to be fused together in some grotesque fashion."),
    symbol = "#",
    color = "green",
    move_cost = 5,
    flags = { "TRANSPARENT", "DIGGABLE", "PIT_FILLABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}
