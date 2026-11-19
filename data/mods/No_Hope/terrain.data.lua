local ccb = require("ccb")

ccb.content.define_terrain {
    abstract = "t_abstract_wall_wood",
    copy_from = "t_abstract_wall_wood",
    delete = { flags = { "FLAMMABLE" } },
    extend = { flags = { "FLAMMABLE_HARD" } },
}

ccb.content.define_terrain {
    id = "t_carpet_red",
    copy_from = "t_carpet_red",
    extend = { connect_groups = { "RAIL" }, connects_to = { "RAIL" } },
}

ccb.content.define_terrain {
    id = "t_red_carpet_olight",
    name = ccb.content.text("red carpet, overhead light"),
    description = ccb.content.text("A soft red carpet with a still-functioning light attached to the ceiling above."),
    looks_like = "t_carpet_red",
    symbol = ".",
    color = "red",
    move_cost = 2,
    light_emitted = 120,
    roof = "t_flat_roof",
    connect_groups = { "RAIL", "INDOORFLOOR" },
    connects_to = "RAIL",
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "RUG" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 12,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        failure_volume = 10,
        terrain = "t_carpet_red",
        drops = { { item = "glass_shard", count = { 0, 2 } } },
    },
    shoot = {
        chance_to_hit = 0,
        reduce_damage = { 0, 0 },
        reduce_damage_laser = { 0, 0 },
        destroy_damage = { 2, 8 },
    },
}

ccb.content.define_terrain {
    id = "t_rock_floor",
    copy_from = "t_rock_floor",
    extend = { connect_groups = { "RAIL" }, connects_to = { "RAIL" } },
}

ccb.content.define_terrain {
    id = "t_rock_floor_olight",
    name = ccb.content.text("rock floor, overhead light"),
    description = ccb.content.text("A relatively flat area of rock and stone with a still-functioning light attached to the ceiling above."),
    symbol = ".",
    color = "light_gray",
    looks_like = "t_rock_floor",
    move_cost = 2,
    light_emitted = 120,
    connect_groups = { "RAIL", "INDOORFLOOR" },
    connects_to = "RAIL",
    roof = "t_flat_roof",
    flags = { "TRANSPARENT", "INDOORS", "COLLAPSES", "SUPPORTS_ROOF", "FLAT", "ROAD" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 12,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        failure_volume = 10,
        terrain = "t_rock_floor",
        drops = { { item = "glass_shard", count = { 0, 2 } } },
    },
    shoot = {
        chance_to_hit = 0,
        reduce_damage = { 0, 0 },
        reduce_damage_laser = { 0, 0 },
        destroy_damage = { 2, 8 },
    },
}
