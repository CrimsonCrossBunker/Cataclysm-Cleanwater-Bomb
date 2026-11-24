local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_string_void",
    name = ccb.content.text("nothing"),
    description = ccb.content.text("There's an otherworldly nothing there - it somehow feels like a black wall at the front of your senses, yet you can also tell what lies beyond it."),
    symbol = " ",
    color = "black",
    flags = { "TRANSPARENT", "WALL" },
}

ccb.content.define_terrain {
    id = "t_nl_sd_2d_sky",
    name = ccb.content.text("flattened sky"),
    description = ccb.content.text("This is the sky, you think.  It is impossibly flattened into two dimensions."),
    symbol = " ",
    color = "black",
    flags = { "TRANSPARENT", "WALL" },
}

ccb.content.define_terrain {
    id = "t_nl_sd_2d_sky_walkable",
    name = ccb.content.text("flattened horizon"),
    description = ccb.content.text("You can stand here, upon the horizon.  It is impossibly flattened into two dimensions."),
    symbol = " ",
    color = "black",
    move_cost = 1,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
}

ccb.content.define_terrain {
    id = "t_nl_sd_2d_ground",
    looks_like = "t_wall_warped",
    name = ccb.content.text("flattened ground"),
    description = ccb.content.text("This is the ground, you think.  It is impossibly flattened into two dimensions, and the patterns upon it are constantly shifting, like an image passing through a veined rock, its insides twisting upon the two dimensional projection."),
    symbol = "#",
    color = "light_gray",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "BLOCK_WIND", "TRANSPARENT" },
}

ccb.content.define_terrain {
    id = "t_string_true_void",
    name = ccb.content.text("nothing"),
    description = ccb.content.text("There's an otherworldly nothing there - a black wall at the front of your senses."),
    symbol = " ",
    color = "black",
    flags = { "WALL" },
}

ccb.content.define_terrain {
    id = "t_string_point_small",
    name = ccb.content.text("nothing"),
    description = ccb.content.text("A speck in the darkness."),
    symbol = ".",
    light_emitted = 1,
    color = "white",
    flags = { "TRANSPARENT", "WALL" },
}

ccb.content.define_terrain {
    id = "t_string_point_big",
    name = ccb.content.text("nothing"),
    description = ccb.content.text("A speck in the darkness."),
    symbol = "*",
    light_emitted = 1,
    color = "white",
    flags = { "TRANSPARENT", "WALL" },
}

ccb.content.define_terrain {
    id = "t_string_point_small_gray",
    name = ccb.content.text("nothing"),
    description = ccb.content.text("A speck in the darkness."),
    symbol = ".",
    light_emitted = 1,
    color = "light_gray",
    flags = { "TRANSPARENT", "WALL" },
}

ccb.content.define_terrain {
    id = "t_string_point_big_gray",
    name = ccb.content.text("nothing"),
    description = ccb.content.text("A speck in the darkness."),
    symbol = "*",
    light_emitted = 1,
    color = "light_gray",
    flags = { "TRANSPARENT", "WALL" },
}

ccb.content.define_terrain {
    id = "t_string_x",
    name = ccb.content.text("impossibly thin magenta line"),
    description = ccb.content.text("You perceive a magenta line here.  It seems impossibly thin - you're not even sure it has width in any meaningful sense.  In your mind's eye the space around it shimmers, and you feel you could walk upon it."),
    symbol = "-",
    color = "magenta",
    light_emitted = 20,
    light_color = { 255, 0, 255 },
    move_cost = 1,
    connect_groups = "STRING",
    connects_to = "STRING",
    flags = { "TRANSPARENT", "FLAT", "ROAD", "ONE_DIMENSIONAL_X" },
}

ccb.content.define_terrain {
    id = "t_string_y",
    name = ccb.content.text("impossibly thin cyan line"),
    description = ccb.content.text("You perceive a cyan line here.  It seems impossibly thin - you're not even sure it has width in any meaningful sense.  In your mind's eye the space around it shimmers, and you feel you could walk upon it."),
    symbol = "|",
    color = "cyan",
    light_emitted = 20,
    light_color = { 0, 255, 255 },
    move_cost = 1,
    connect_groups = "STRING",
    connects_to = "STRING",
    flags = { "TRANSPARENT", "FLAT", "ROAD", "ONE_DIMENSIONAL_Y" },
}

ccb.content.define_terrain {
    id = "t_string_z",
    name = ccb.content.text("impossibly thin yellow line"),
    description = ccb.content.text("You perceive a yellow line here that extends up and down.  It seems impossibly thin - you're not even sure it has width in any meaningful sense.  In your mind's eye the space around it shimmers, and you feel you could walk upon it.  Or perhaps climb it?"),
    symbol = ".",
    color = "yellow",
    light_emitted = 20,
    light_color = { 255, 255, 0 },
    move_cost = 1,
    connect_groups = "STRING",
    connects_to = "STRING",
    flags = { "TRANSPARENT", "ONE_DIMENSIONAL_Z", "GOES_DOWN", "GOES_UP" },
}

ccb.content.define_terrain {
    id = "t_string_xy",
    name = ccb.content.text("impossibly flat blue square"),
    description = ccb.content.text("You perceive a square, here.  It seems impossibly flat - you're not even sure it has depth in any meaningful sense.  In your mind's eye the space around it shimmers, and you feel you could walk upon it."),
    symbol = "+",
    color = "blue",
    light_emitted = 20,
    connect_groups = "STRING",
    connects_to = "STRING",
    light_color = { 0, 0, 255 },
    move_cost = 1,
    flags = { "TRANSPARENT", "FLAT", "ROAD", "ONE_DIMENSIONAL_X", "ONE_DIMENSIONAL_Y" },
}

ccb.content.define_terrain {
    id = "t_string_xy_plane_1",
    name = ccb.content.text("impossibly flat blue square"),
    description = ccb.content.text("You perceive a square, here.  It seems impossibly flat - you're not even sure it has depth in any meaningful sense.  In your mind's eye the space around it shimmers, and you feel you could walk upon it."),
    symbol = ".",
    color = "blue",
    light_emitted = 20,
    light_color = { 0, 0, 255 },
    move_cost = 1,
    connect_groups = "STRING",
    connects_to = "STRING",
    flags = { "TRANSPARENT", "FLAT", "ROAD", "ONE_DIMENSIONAL_X", "ONE_DIMENSIONAL_Y" },
}

ccb.content.define_terrain {
    id = "t_string_xy_plane_2",
    name = ccb.content.text("shimmering blue square"),
    description = ccb.content.text("You perceive a square, here.  It is both shimmering and impossibly flat - you're not even sure it has depth in any meaningful sense.  In your mind's eye the space around it shimmers, and you feel you could walk upon it."),
    symbol = ",",
    color = "blue",
    light_emitted = 20,
    light_color = { 0, 0, 255 },
    move_cost = 1,
    connect_groups = "STRING",
    connects_to = "STRING",
    flags = { "TRANSPARENT", "FLAT", "ROAD", "ONE_DIMENSIONAL_X", "ONE_DIMENSIONAL_Y" },
}

ccb.content.define_terrain {
    id = "t_string_xy_plane_3",
    name = ccb.content.text("wavy square"),
    description = ccb.content.text("You perceive a square, here.  It is both waving and impossibly flat - you're not even sure it has depth in any meaningful sense.  In your mind's eye the space around it shimmers, and you feel you could walk upon it."),
    symbol = ",",
    color = "light_blue",
    light_emitted = 20,
    light_color = { 0, 0, 255 },
    move_cost = 1,
    connect_groups = "STRING",
    connects_to = "STRING",
    flags = { "TRANSPARENT", "FLAT", "ROAD", "ONE_DIMENSIONAL_X", "ONE_DIMENSIONAL_Y" },
}

ccb.content.define_terrain {
    id = "t_string_xyz",
    name = ccb.content.text("white cube"),
    description = ccb.content.text("A true cube of space where one could go left, right, up, down, backward, or forward - it somehow reminds you of home."),
    symbol = "#",
    color = "white",
    light_emitted = 20,
    move_cost = 1,
    connect_groups = "STRING",
    connects_to = "STRING",
    flags = { "TRANSPARENT", "FLAT", "GOES_UP", "GOES_DOWN" },
}

ccb.content.define_terrain {
    id = "t_string_gates_mech_control",
    name = ccb.content.text("rotary lever"),
    description = ccb.content.text("A heavy-duty metal lever with two settings, each marked by an alien symbol."),
    symbol = "6",
    color = "cyan_red",
    move_cost = 0,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "NOITEM", "INDOORS", "PERMEABLE", "THIN_OBSTACLE" },
    builtin_examine = "controls_gate",
    bash = {
        minimum_strength = 18,
        maximum_strength = 80,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_metal_floor",
        drops = { { item = "mc_steel_chunk", count = { 1, 4 } }, { item = "scrap", count = { 3, 6 } } },
    },
}

ccb.content.define_terrain {
    id = "t_string_gates_mech_control_inert",
    name = ccb.content.text("rotary lever"),
    description = ccb.content.text("A heavy-duty metal lever with two settings, each marked by an alien symbol.  Toggling it back and forth does nothing."),
    symbol = "6",
    color = "cyan_red",
    move_cost = 0,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "NOITEM", "INDOORS", "PERMEABLE", "THIN_OBSTACLE" },
    bash = {
        minimum_strength = 18,
        maximum_strength = 80,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_metal_floor",
        drops = { { item = "mc_steel_chunk", count = { 1, 4 } }, { item = "scrap", count = { 3, 6 } } },
    },
}

ccb.content.define_terrain {
    id = "t_string_grass_alien",
    name = ccb.content.text("alien grass"),
    description = ccb.content.text("An area of something that almost looks like grass, but a deep orange-red.  All the fern-like blades grow in one, uniform direction."),
    looks_like = "t_grass_alien",
    symbol = ".",
    color = "red",
    move_cost = 2,
    connect_groups = "STRING",
    connects_to = "STRING",
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "PLOWABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 40,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_string_distress_beacon",
    name = ccb.content.text("scrap metal thing"),
    looks_like = "t_scrap_wall",
    description = ccb.content.text("Part of a structure that almost looks like a small version of Earth's lunar lander.  It has exposed electronics and deployed stabilizers made of cobbled together scrap metal.  The ground at its feet appears to have been scorched long ago."),
    symbol = "-",
    color = "dark_gray",
    move_cost = 0,
    connect_groups = "STRING",
    connects_to = "STRING",
    coverage = 100,
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "REDUCE_SCENT", "AUTO_WALL_SYMBOL", "BLOCK_WIND" },
    bash = {
        minimum_strength = 80,
        maximum_strength = 200,
        sound = ccb.content.text("metal crying!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_rock_floor",
        drops = { { item = "steel_chunk", count = { 10, 22 } } },
    },
}

ccb.content.define_terrain {
    id = "t_string_dimension_strconc_red_light",
    name = ccb.content.text("strong concrete floor, red utility light"),
    description = ccb.content.text("An extremely resilient floor made from carefully placed rebar and poured concrete.  A still-functioning red utility light is attached to the ceiling above.  The metal and plastic cage around the bulb is frosted over and cracked."),
    symbol = ".",
    color = "red",
    move_cost = 2,
    light_emitted = 120,
    light_color = { 255, 0, 0 },
    looks_like = "t_thconc_floor_olight",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "INDOORS", "FLAT", "ROAD" },
    connect_groups = { "CONCRETE", "INDOORFLOOR" },
    connects_to = { "CONCRETE", "STRING" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 12,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        failure_volume = 10,
        terrain = "t_strconc_floor",
        drops = { { item = "glass_shard", count = { 8, 16 } } },
    },
    shoot = {
        chance_to_hit = 0,
        reduce_damage = { 0, 0 },
        reduce_damage_laser = { 0, 0 },
        destroy_damage = { 2, 8 },
    },
}

ccb.content.define_terrain {
    id = "t_string_dimension_meteoric_rock",
    copy_from = "t_rock",
    looks_like = "t_rock",
    name = ccb.content.text("pitted rock"),
    description = ccb.content.text("A wall of solid rock, deeply pitted and patterned with metallic shine."),
    color = "white",
    extend = { flags = { "NATURAL_UNDERGROUND" } },
    delete = { flags = { "AUTO_WALL_SYMBOL" } },
    roof = "t_rock_floor_no_roof",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        terrain_from_above = "t_rock_floor_no_roof",
        drops = { { group = "mining_rock", count = 1 } },
    },
}

ccb.content.define_terrain {
    id = "t_string_dimension_meteoric_rock_charred",
    copy_from = "t_rock",
    name = ccb.content.text("charred rock"),
    description = ccb.content.text("A wall of solid rock, deeply pitted, charred, and coated in a residue with an acrid smell"),
    color = "white",
    extend = { flags = { "NATURAL_UNDERGROUND" } },
    delete = { flags = { "AUTO_WALL_SYMBOL" } },
    roof = "t_rock_floor_no_roof",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        terrain_from_above = "t_rock_floor_no_roof",
        drops = { { group = "mining_rock", count = 1 } },
    },
}

ccb.content.define_terrain {
    id = "t_ka_moonpool",
    name = ccb.content.text("strange moonpool"),
    description = ccb.content.text("At first glance this looks like a pool filled with deep, dark water, and a ladder leading down into it.  Upon closer inspection, you note that the \"liquid\" is some sort of tense membrane.  When you stare, you see something on the other side, illuminated by pale light."),
    symbol = "~",
    looks_like = "t_water_pool",
    color = "light_blue",
    move_cost = 5,
    flags = { "TRANSPARENT", "LIQUID", "NO_SCENT", "SWIMMABLE", "FISHABLE", "SHALLOW_WATER" },
    connect_groups = "WATER",
    connects_to = "WATER",
    trap = "tr_string_dimension_ka_moonpool",
}
