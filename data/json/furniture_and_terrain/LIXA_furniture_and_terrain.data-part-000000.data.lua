local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_carpet_concrete_green_olight",
    name = ccb.content.text("industrial green carpet"),
    description = ccb.content.text("Firm, low-pile, high-durability carpet in a green color, for laying down on bare concrete, with a still-functioning light attached to the ceiling above."),
    symbol = ".",
    color = "green",
    move_cost = 2,
    light_emitted = 120,
    looks_like = "t_carpet_green",
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "RUG" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 12,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        failure_volume = 10,
        terrain = "t_carpet_concrete_green",
        drops = { { item = "glass_shard", count = { 8, 16 } } },
    },
    shoot = {
        chance_to_hit = 50,
        reduce_damage = { 0, 0 },
        reduce_damage_laser = { 0, 0 },
        destroy_damage = { 2, 8 },
    },
}

ccb.content.define_terrain {
    id = "t_lixa_wall",
    name = ccb.content.text("reinforced concrete wall"),
    looks_like = "t_concrete_wall",
    description = ccb.content.text("An extremely resilient wall, filled with concrete and rebar.  Best suited for supporting multi-level buildings, only serious explosives and high-speed impacts would be capable of damaging this wall."),
    symbol = "#",
    color = "light_gray",
    move_cost = 0,
    coverage = 100,
    roof = "t_concrete_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 120,
        maximum_strength = 460,
        sound = ccb.content.text("scrrrash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_folded_wall",
    },
}

ccb.content.define_terrain {
    id = "t_folded_wall",
    name = ccb.content.text("folded wall"),
    description = ccb.content.text("When looked at out of the side of the eye, this wall seems to bend and curve in on itself and when looked at head on it seems to be a repeating pattern of solid concrete hexagons."),
    symbol = "#",
    color = "yellow_cyan",
    move_cost = 0,
    coverage = 100,
    roof = "t_concrete_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 120,
        maximum_strength = 460,
        sound = ccb.content.text("scrrrash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_unfolded_wall",
    },
}

ccb.content.define_terrain {
    id = "t_unfolded_wall",
    name = ccb.content.text("unfolded wall"),
    description = ccb.content.text("This wall tessellates as you view it."),
    symbol = "#",
    color = "cyan_red",
    move_cost = 0,
    coverage = 100,
    roof = "t_concrete_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 120,
        maximum_strength = 460,
        sound = ccb.content.text("scrrrash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_lixa_wall",
    },
}
