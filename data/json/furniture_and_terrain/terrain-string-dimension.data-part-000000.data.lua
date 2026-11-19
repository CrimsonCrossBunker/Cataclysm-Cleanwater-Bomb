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
