local ccb = require("ccb")

-- These terrains are for generating a bullet trailer.  While they can be remixed in some ways, in general they will only fit with each other and will only produce a trailer in an east-west orientation with a south-facing door.  Furniture has to be made non-blocking and placed in the central path to work correctly.
ccb.content.define_terrain {
    id = "t_bullettrailer_brownfloor",
    name = ccb.content.text("brown laminate floor"),
    roof = "t_metal_flat_roof",
    description = ccb.content.text("A section of flooring made out of a tough, smooth material, colored in an atrocious mottled brown."),
    symbol = ".",
    color = "brown",
    copy_from = "t_linoleum_gray",
}

ccb.content.define_terrain {
    id = "t_bullettrailer_roof",
    name = ccb.content.text("bullet trailer roof"),
    description = ccb.content.text("A smooth roof of gleaming chrome, slightly dusty from the road."),
    copy_from = "t_metal_flat_roof",
}

ccb.content.define_terrain {
    id = "t_bullettrailer_nwall_westcorner",
    name = ccb.content.text("bullet trailer exterior wall"),
    copy_from = "t_scrap_wall",
    description = ccb.content.text("A smooth wall of gleaming chrome, slightly dusty from the road."),
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "SUPPORTS_ROOF", "WALL", "REDUCE_SCENT", "AUTO_WALL_SYMBOL", "MINEABLE", "BLOCK_WIND" },
    symbol = "#",
    color = "light_gray",
}

ccb.content.define_terrain {
    id = "t_bullettrailer_nwall",
    symbol = "#",
    color = "light_gray",
    copy_from = "t_bullettrailer_nwall_westcorner",
}

ccb.content.define_terrain {
    id = "t_bullettrailer_nwall_window",
    symbol = "#",
    color = "light_gray",
    looks_like = "t_window",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = {
        "SUPPORTS_ROOF",
        "WALL",
        "REDUCE_SCENT",
        "AUTO_WALL_SYMBOL",
        "MINEABLE",
        "BLOCK_WIND",
        "TRANSPARENT",
    },
    copy_from = "t_bullettrailer_nwall_westcorner",
}

ccb.content.define_terrain {
    id = "t_bullettrailer_nwall_eastcorner",
    symbol = "#",
    color = "light_gray",
    copy_from = "t_bullettrailer_nwall_westcorner",
}

ccb.content.define_terrain {
    id = "t_bullettrailer_wwall",
    symbol = "#",
    color = "light_gray",
    copy_from = "t_bullettrailer_nwall_westcorner",
}

ccb.content.define_terrain {
    id = "t_bullettrailer_ewall",
    symbol = "#",
    color = "light_gray",
    copy_from = "t_bullettrailer_nwall_westcorner",
}

ccb.content.define_terrain {
    id = "t_bullettrailer_inner_westcorner",
    symbol = "#",
    color = "light_gray",
    copy_from = "t_bullettrailer_nwall_westcorner",
}

ccb.content.define_terrain {
    id = "t_bullettrailer_inner_T",
    copy_from = "t_bullettrailer_nwall_westcorner",
    symbol = "#",
    color = "light_gray",
    name = ccb.content.text("bullet trailer interior wall"),
    description = ccb.content.text("A simple wall paneled in a coarsely textured gray laminate of some sort."),
}

ccb.content.define_terrain {
    id = "t_bullettrailer_inner_eastcorner",
    copy_from = "t_bullettrailer_inner_T",
    symbol = "#",
    color = "light_gray",
}

ccb.content.define_terrain {
    id = "t_bullettrailer_swall_westcorner",
    name = ccb.content.text("bullet trailer exterior wall"),
    description = ccb.content.text("A smooth wall of gleaming chrome, slightly dusty from the road."),
    symbol = "#",
    color = "light_gray",
    copy_from = "t_bullettrailer_nwall_westcorner",
}

ccb.content.define_terrain {
    id = "t_bullettrailer_swall_windows",
    symbol = "+",
    color = "light_blue",
    copy_from = "t_bullettrailer_nwall_window",
}

ccb.content.define_terrain {
    id = "t_bullettrailer_swall_door",
    symbol = "-",
    color = "light_gray",
    looks_like = "t_door_metal_c",
    connect_groups = "WALL",
    connects_to = "WALL",
    rotates_to = "INDOORFLOOR",
    flags = { "TRANSPARENT", "DOOR", "NOITEM", "MINEABLE", "BLOCK_WIND", "SUPPORTS_ROOF" },
    open = "t_bullettrailer_swall_door_o",
    copy_from = "t_bullettrailer_swall_westcorner",
}

ccb.content.define_terrain {
    id = "t_bullettrailer_swall_door_o",
    symbol = "/",
    color = "dark_gray",
    move_cost = 2,
    looks_like = "t_door_metal_o",
    connect_groups = "WALL",
    connects_to = "WALL",
    rotates_to = "INDOORFLOOR",
    flags = { "TRANSPARENT", "DOOR", "NOITEM", "MINEABLE", "BLOCK_WIND", "SUPPORTS_ROOF" },
    copy_from = "t_bullettrailer_swall_westcorner",
    close = "t_bullettrailer_swall_door",
}

ccb.content.define_terrain {
    id = "t_bullettrailer_swall_wheels",
    symbol = "o",
    color = "light_gray",
    copy_from = "t_bullettrailer_nwall_window",
}

ccb.content.define_terrain {
    id = "t_bullettrailer_swall",
    symbol = "#",
    color = "light_gray",
    copy_from = "t_bullettrailer_swall_westcorner",
}

ccb.content.define_terrain {
    id = "t_bullettrailer_swall_eastcorner",
    symbol = "#",
    color = "light_gray",
    copy_from = "t_bullettrailer_swall_westcorner",
}

ccb.content.define_furniture {
    id = "f_bullettrailer_table_top",
    move_cost_mod = -1,
    description = ccb.content.text("A small trailer table, designed to convert into a bed when not in use."),
    symbol = "T",
    color = "yellow",
    copy_from = "f_table",
}

ccb.content.define_furniture {
    id = "f_bullettrailer_table_middle",
    symbol = "T",
    color = "yellow",
    copy_from = "f_bullettrailer_table_top",
}

ccb.content.define_furniture {
    id = "f_bullettrailer_table_bottom",
    symbol = "T",
    color = "yellow",
    copy_from = "f_bullettrailer_table_top",
}

ccb.content.define_furniture {
    id = "f_bullettrailer_cabinet",
    copy_from = "f_cupboard",
    name = ccb.content.text("trailer cabinets"),
    symbol = "n",
    color = "yellow",
    description = ccb.content.text("Cramped trailer cabinets, with some inbuilt appliances taking up even more of the limited space."),
    move_cost_mod = 0,
}

ccb.content.define_furniture {
    id = "f_bullettrailer_sink",
    name = ccb.content.text("trailer sink"),
    move_cost_mod = 0,
    symbol = "u",
    color = "brown",
    description = ccb.content.text("A tiny metal sink and connected cabinet."),
    copy_from = "f_sink",
}

ccb.content.define_furniture {
    id = "f_bullettrailer_desk",
    name = ccb.content.text("mini desk"),
    move_cost_mod = 20,
    symbol = "t",
    color = "brown",
    description = ccb.content.text("A small wooden desk with a little attached bookshelf."),
    copy_from = "f_desk",
}

ccb.content.define_terrain {
    id = "t_bullettrailer_inner_door",
    name = ccb.content.text("trailer bathroom door"),
    description = ccb.content.text("A gray textured door, rimmed in chrome, like a very tacky version of a ship's hatch."),
    move_cost = -1,
    symbol = "|",
    color = "light_gray",
    coverage = 100,
    rotates_to = "INDOORFLOOR",
    flags = { "NOITEM", "FLAMMABLE_ASH", "BLOCK_WIND", "REDUCE_SCENT", "DOOR" },
    looks_like = "t_door_metal_c",
    open = "t_bullettrailer_inner_door_o",
    bash = {
        minimum_strength = 10,
        maximum_strength = 70,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = {
            { item = "2x4", count = { 0, 5 } },
            { item = "wood_panel", count = { 0, 1 } },
            { item = "nail", charges = { 0, 5 } },
            { item = "splinter", count = { 5, 10 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_bullettrailer_inner_door_o",
    name = ccb.content.text("trailer bathroom door"),
    move_cost = 0,
    symbol = "/",
    color = "light_gray",
    coverage = 30,
    looks_like = "t_door_metal_o",
    description = ccb.content.text("A gray textured door, rimmed in chrome, like a very tacky version of a ship's hatch."),
    rotates_to = "INDOORFLOOR",
    flags = { "NOITEM", "FLAMMABLE_ASH", "BLOCK_WIND", "DOOR", "MOUNTABLE", "TRANSPARENT" },
    close = "t_bullettrailer_inner_door",
    bash = {
        minimum_strength = 10,
        maximum_strength = 70,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = {
            { item = "2x4", count = { 0, 5 } },
            { item = "wood_panel", count = { 0, 1 } },
            { item = "nail", charges = { 0, 5 } },
            { item = "splinter", count = { 5, 10 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_bullettrailer_toilet",
    name = ccb.content.text("travel toilet"),
    description = ccb.content.text("A tiny plastic toilet for use in a travel trailer.  Unlike a normal toilet, it doesn't store water locally for you to siphon out."),
    symbol = "b",
    color = "white",
    move_cost_mod = 2,
    coverage = 15,
    required_strength = 6,
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "MOUNTABLE", "EASY_DECONSTRUCT" },
    base_item = "toilet_travel",
    bash = {
        minimum_strength = 6,
        maximum_strength = 15,
        sound = ccb.content.text("plastic cracking!"),
        failure_sound = ccb.content.text("whump!"),
    },
}

ccb.content.define_furniture {
    id = "f_bullettrailer_minisofa",
    name = ccb.content.text("trailer sofa"),
    symbol = "h",
    color = "red",
    description = ccb.content.text("A folding trailer sofa with a durable, somewhat comfortable weave of coarse red fabric."),
    copy_from = "f_sofa",
}

ccb.content.define_furniture {
    id = "f_bullettrailer_bed_foot",
    name = ccb.content.text("trailer bed"),
    symbol = "H",
    color = "green",
    description = ccb.content.text("A small but comfy-looking double bed."),
    copy_from = "f_bed",
}

ccb.content.define_furniture {
    id = "f_bullettrailer_bed_head",
    name = ccb.content.text("trailer bed"),
    symbol = "H",
    color = "green",
    description = ccb.content.text("A small but comfy-looking double bed."),
    copy_from = "f_bed",
}

ccb.content.define_furniture {
    id = "f_bullettrailer_sign_danabakery",
    name = ccb.content.text("plywood sign for 'Dana's Bakery'"),
    symbol = "#",
    color = "red",
    description = ccb.content.text("A spraypainted plywood sign reads 'Dana's Bakery' in red letters."),
    copy_from = "f_sign",
}
