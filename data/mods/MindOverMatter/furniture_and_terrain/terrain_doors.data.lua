local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_secretdoor_strconcrete_c",
    name = ccb.content.text("reinforced concrete wall"),
    description = ccb.content.text("An extremely resilient wall, filled with concrete and rebar.  Best suited for supporting multi-level buildings, only serious explosives and high-speed impacts would be capable of damaging this wall."),
    symbol = "#",
    looks_like = "t_strconc_wall",
    color = "light_gray",
    move_cost = 0,
    roof = "t_concrete_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "DOOR", "CONNECT_WITH_WALL", "AUTO_WALL_SYMBOL", "SUPPORTS_ROOF" },
    open = "t_secretdoor_strconcrete_o",
    bash = {
        minimum_strength = 120,
        maximum_strength = 460,
        sound = ccb.content.text("scrrrash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_reb_cage",
        drops = { { item = "rock", count = { 10, 22 } } },
    },
}

ccb.content.define_terrain {
    id = "t_secretdoor_strconcrete_o",
    name = ccb.content.text("open secret door"),
    looks_like = "t_thconc_floor",
    description = ccb.content.text("This apparently normal segment of reinforced concrete wall has opened to reveal a secret passage."),
    symbol = "'",
    color = "light_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "CONNECT_WITH_WALL", "ROAD", "SUPPORTS_ROOF" },
    close = "t_secretdoor_strconcrete_c",
    bash = {
        minimum_strength = 120,
        maximum_strength = 460,
        sound = ccb.content.text("scrrrash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_reb_cage",
        drops = { { item = "rock", count = { 10, 22 } } },
    },
}
