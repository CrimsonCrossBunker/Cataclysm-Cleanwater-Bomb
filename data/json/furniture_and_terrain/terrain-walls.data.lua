local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_terrain {
    abstract = "t_abstract_column",
    name = ccb.content.text_without_extraction("abstract column"),
    description = ccb.content.text_without_extraction("Encompasses rock columns.  If you see this in-game, it's a bug."),
    color = "light_gray",
    symbol = "1",
    move_cost = 0,
    coverage = 80,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "WALL", "PERMEABLE", "MINEABLE" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_terrain {
    abstract = "t_abstract_wall",
    name = ccb.content.text_without_extraction("abstract wall"),
    description = ccb.content.text_without_extraction("Encompasses most undamaged natural and building-grade artificial walls.  SUPPORTS_ROOF, but the roof field must be defined in child terrain.  If you see this in-game, it's a bug."),
    color = "light_gray",
    symbol = "#",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "BLOCK_WIND", "MINEABLE" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_terrain {
    abstract = "t_abstract_wall_wood",
    copy_from = "t_abstract_wall",
    name = ccb.content.text_without_extraction("abstract wooden wall"),
    description = ccb.content.text_without_extraction("Encompasses most wood-like walls.  If you see this in-game, it's a bug."),
    roof = "t_wood_roof",
    extend = { flags = { "FLAMMABLE" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_terrain {
    abstract = "t_abstract_wall_concrete",
    copy_from = "t_abstract_wall",
    name = ccb.content.text_without_extraction("abstract concrete wall"),
    description = ccb.content.text_without_extraction("Encompasses most concrete-like walls.  If you see this in-game, it's a bug."),
    roof = "t_concrete_roof",
    color = "light_gray",
    extend = { flags = { "WIRED_WALL" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_terrain {
    abstract = "t_abstract_wall_brick",
    copy_from = "t_abstract_wall",
    name = ccb.content.text_without_extraction("abstract brick wall"),
    description = ccb.content.text_without_extraction("Encompasses most brick-like walls.  If you see this in-game, it's a bug."),
    roof = "t_brick_roof",
    color = "brown",
    extend = { flags = { "WIRED_WALL" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_terrain {
    abstract = "t_abstract_wall_stone",
    copy_from = "t_abstract_wall",
    name = ccb.content.text_without_extraction("abstract stone wall"),
    description = ccb.content.text_without_extraction("Encompasses most stone-like walls.  If you see this in-game, it's a bug."),
    color = "light_gray",
    roof = "t_rock_roof",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_terrain {
    abstract = "t_abstract_wall_metal",
    copy_from = "t_abstract_wall",
    name = ccb.content.text_without_extraction("abstract metal wall"),
    description = ccb.content.text_without_extraction("Encompasses most metal-like walls.  If you see this in-game, it's a bug."),
    color = "cyan",
    roof = "t_metal_flat_roof",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_terrain {
    abstract = "t_abstract_wall_earthen",
    copy_from = "t_abstract_wall",
    name = ccb.content.text_without_extraction("abstract earthen wall"),
    description = ccb.content.text_without_extraction("Encompasses most below-ground walls.  If you see this in-game, it's a bug."),
    color = "brown",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_terrain {
    abstract = "t_abstract_wall_glass",
    copy_from = "t_abstract_wall",
    name = ccb.content.text_without_extraction("abstract glass wall"),
    description = ccb.content.text_without_extraction("Encompasses most wall-sized glass panes.  If you see this in-game, it's a bug."),
    color = "cyan",
    roof = "t_flat_roof",
    coverage = 0,
    extend = { flags = { "TRANSPARENT" } },
    delete = { flags = { "SUPPORTS_ROOF" } },
}

ccb.content.define_terrain {
    id = "t_wall",
    copy_from = "t_abstract_wall_wood",
    name = ccb.content.text("wall"),
    description = ccb.content.text("A standard wall consisting of a wooden support structure filled with insulation and drywalled.  Painted a neutral off-white or cream color, it could use some more vibrant paint.  Looks flammable."),
    roof = "t_flat_roof",
    extend = { flags = { "WIRED_WALL" } },
    bash = {
        minimum_strength = 30,
        maximum_strength = 210,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = "wall_bash_results",
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_terrain {
    abstract = "t_wall_color",
    copy_from = "t_wall",
    name = ccb.content.text_without_extraction("abstract colored wall"),
    description = ccb.content.text_without_extraction("An abstract for t_wall color variants.  If you see this in-game, it's a bug."),
    extend = { flags = { "CHIP" } },
}

ccb.content.define_terrain {
    id = "t_wall_half",
    name = ccb.content.text("half-built wall"),
    looks_like = "t_wall",
    description = ccb.content.text("An incomplete wall of refined wood, dotted with carefully placed nails to provide proper support.  It requires some more planks and nails before it'd be considered a suitable wall."),
    symbol = "#",
    color = "light_red",
    move_cost = 4,
    coverage = 60,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "NOITEM", "REDUCE_SCENT", "MOUNTABLE" },
    connect_groups = "WALL",
    connects_to = "WALL",
    bash = {
        minimum_strength = 10,
        maximum_strength = 70,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = {
            { item = "2x4", count = { 0, 5 } },
            { item = "nail", charges = { 0, 5 } },
            { item = "splinter", count = { 5, 10 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_ponywall",
    name = ccb.content.text("pony wall"),
    description = ccb.content.text("A short divider wall consisting of a wooden support structure with drywall.  Painted an all-too-common and neutral off-white or cream color.  Looks flammable."),
    symbol = "#",
    looks_like = "f_counter",
    color = "light_gray",
    move_cost = 0,
    coverage = 60,
    connect_groups = { "INDOORFLOOR", "WALL" },
    connects_to = "WALL",
    roof = "t_flat_roof",
    flags = {
        "TRANSPARENT",
        "PERMEABLE",
        "FLAMMABLE",
        "PLACE_ITEM",
        "INDOORS",
        "AUTO_WALL_SYMBOL",
        "THIN_OBSTACLE",
        "MOUNTABLE",
        "SHORT",
    },
    deconstruct = {
        terrain = "t_floor",
        drops = { { item = "2x4", count = 5 }, { item = "nail", charges = 20 } },
    },
    bash = {
        minimum_strength = 8,
        maximum_strength = 20,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = "wall_bash_results",
    },
}

ccb.content.define_terrain {
    id = "t_wall_wood",
    copy_from = "t_abstract_wall_wood",
    name = ccb.content.text("wooden wall"),
    looks_like = "t_wall",
    description = ccb.content.text("A finished wall of planks and support beams, capable of supporting an upper level or roof.  Highly flammable."),
    color = "light_red",
    roof = "t_wood_roof",
    delete = { flags = { "MINEABLE" } },
    bash = {
        minimum_strength = 12,
        maximum_strength = 150,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_wall_wood_chipped",
        drops = {
            { item = "2x4", count = { 0, 3 } },
            { item = "wood_panel", count = { 0, 2 } },
            { item = "nail", charges = { 1, 5 } },
            { item = "splinter", count = { 1, 4 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_concrete_wall",
    copy_from = "t_abstract_wall_concrete",
    name = ccb.content.text("concrete wall"),
    looks_like = "t_rock",
    description = ccb.content.text("An aesthetically pleasing design with simple lines, this type of concrete was used with a weaker chemical mixture in order to have faster setting times.  Not ideal for multi-story buildings, but still capable of supporting a roof."),
    color = "dark_gray",
    bash = {
        minimum_strength = 70,
        maximum_strength = 300,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_reb_cage",
        drops = { { item = "rock", count = { 10, 22 } } },
    },
}

ccb.content.define_terrain {
    id = "t_sconc_wall",
    copy_from = "t_abstract_wall_concrete",
    name = ccb.content.text("simple concrete wall"),
    looks_like = "t_concrete_wall",
    description = ccb.content.text("A durable and uniform concrete wall, quite drab without decoration.  More than capable of supporting a roof, as well as keeping out most anything, save for vehicles."),
    bash = {
        minimum_strength = 90,
        maximum_strength = 350,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_pit_shallow",
        drops = { { item = "rock", count = { 10, 22 } } },
    },
}

ccb.content.define_terrain {
    id = "t_strconc_wall",
    copy_from = "t_abstract_wall_concrete",
    name = ccb.content.text("reinforced concrete wall"),
    looks_like = "t_concrete_wall",
    description = ccb.content.text("An extremely resilient wall, filled with concrete and rebar.  Best suited for supporting multi-level buildings, only serious explosives and high-speed impacts would be capable of damaging this wall."),
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
    id = "t_wall_r",
    copy_from = "t_wall_color",
    looks_like = "t_wall",
    name = ccb.content.text("red wall"),
    description = ccb.content.text("A wall, painted red."),
    color = "red",
}

ccb.content.define_terrain {
    id = "t_wall_w",
    copy_from = "t_wall_color",
    looks_like = "t_wall",
    name = ccb.content.text("white wall"),
    description = ccb.content.text("A wall, painted white."),
    color = "white",
}

ccb.content.define_terrain {
    id = "t_wall_b",
    copy_from = "t_wall_color",
    looks_like = "t_wall",
    name = ccb.content.text("blue wall"),
    description = ccb.content.text("A wall, painted blue."),
    color = "blue",
}

ccb.content.define_terrain {
    id = "t_wall_g",
    copy_from = "t_wall_color",
    looks_like = "t_wall",
    name = ccb.content.text("green wall"),
    description = ccb.content.text("A wall, painted green."),
    color = "green",
}

ccb.content.define_terrain {
    id = "t_wall_y",
    copy_from = "t_wall_color",
    looks_like = "t_wall",
    name = ccb.content.text("yellow wall"),
    description = ccb.content.text("A wall, painted yellow."),
    color = "yellow",
}

ccb.content.define_terrain {
    id = "t_wall_P",
    copy_from = "t_wall_color",
    looks_like = "t_wall",
    name = ccb.content.text("pink wall"),
    description = ccb.content.text("A wall, painted pink."),
    color = "pink",
}

ccb.content.define_terrain {
    id = "t_wall_p",
    copy_from = "t_wall_color",
    looks_like = "t_wall",
    name = ccb.content.text("purple wall"),
    description = ccb.content.text("A wall, painted purple."),
    color = "magenta",
}

ccb.content.define_terrain {
    id = "t_wall_orange",
    copy_from = "t_wall_color",
    looks_like = "t_wall",
    name = ccb.content.text("orange wall"),
    description = ccb.content.text("A wall, painted orange."),
    color = "light_red",
}

ccb.content.define_terrain {
    id = "t_wall_gray",
    copy_from = "t_wall_color",
    looks_like = "t_wall",
    name = ccb.content.text("gray wall"),
    description = ccb.content.text("A wall, painted gray."),
    color = "light_gray",
}

ccb.content.define_terrain {
    id = "t_wall_brown",
    copy_from = "t_wall_color",
    looks_like = "t_wall",
    name = ccb.content.text("brown wall"),
    description = ccb.content.text("A wall, painted brown."),
    color = "brown",
}

ccb.content.define_terrain {
    id = "t_wall_cyan",
    copy_from = "t_wall_color",
    looks_like = "t_wall",
    name = ccb.content.text("cyan wall"),
    description = ccb.content.text("A wall, painted cyan."),
    color = "cyan",
}

ccb.content.define_terrain {
    id = "t_wall_black",
    copy_from = "t_wall_color",
    looks_like = "t_wall",
    name = ccb.content.text("black wall"),
    description = ccb.content.text("A wall, painted black."),
    color = "yellow",
}

ccb.content.define_terrain {
    id = "t_wood_wall_b",
    copy_from = "t_wall_wood",
    name = ccb.content.text("blue wood wall"),
    looks_like = "t_wall_b",
    description = ccb.content.text("A wooden wall, painted blue."),
    color = "blue",
}

ccb.content.define_terrain {
    id = "t_wood_wall_g",
    copy_from = "t_wall_wood",
    name = ccb.content.text("green wood wall"),
    looks_like = "t_wall_g",
    description = ccb.content.text("A wooden wall, painted green."),
    color = "green",
}

ccb.content.define_terrain {
    id = "t_wood_wall_r",
    copy_from = "t_wall_wood",
    name = ccb.content.text("red wood wall"),
    looks_like = "t_wall_r",
    description = ccb.content.text("A wooden wall, painted red."),
    color = "red",
}

ccb.content.define_terrain {
    id = "t_wood_wall_w",
    copy_from = "t_wall_wood",
    name = ccb.content.text("white wood wall"),
    looks_like = "t_wall_w",
    description = ccb.content.text("A wooden wall, painted white."),
    color = "white",
}

ccb.content.define_terrain {
    id = "t_wood_wall_p",
    copy_from = "t_wall_wood",
    name = ccb.content.text("purple wood wall"),
    looks_like = "t_wall_p",
    description = ccb.content.text("A wooden wall, painted purple."),
    color = "magenta",
}

ccb.content.define_terrain {
    id = "t_wood_wall_P",
    copy_from = "t_wall_wood",
    name = ccb.content.text("pink wood wall"),
    looks_like = "t_wall_P",
    description = ccb.content.text("A wooden wall, painted pink."),
    color = "pink",
}

ccb.content.define_terrain {
    id = "t_wood_wall_y",
    copy_from = "t_wall_wood",
    name = ccb.content.text("yellow wood wall"),
    looks_like = "t_wall_y",
    description = ccb.content.text("A wooden wall, painted yellow."),
    color = "yellow",
}

ccb.content.define_terrain {
    id = "t_wood_wall_orange",
    copy_from = "t_wall_wood",
    name = ccb.content.text("orange wood wall"),
    looks_like = "t_wall_orange",
    description = ccb.content.text("A wooden wall, painted orange."),
    color = "light_red",
}

ccb.content.define_terrain {
    id = "t_wood_wall_gray",
    copy_from = "t_wall_wood",
    name = ccb.content.text("gray wood wall"),
    looks_like = "t_wall_gray",
    description = ccb.content.text("A wooden wall, painted gray."),
    color = "light_gray",
}

ccb.content.define_terrain {
    id = "t_wood_wall_brown",
    copy_from = "t_wall_wood",
    name = ccb.content.text("brown wood wall"),
    looks_like = "t_wall_brown",
    description = ccb.content.text("A wooden wall, painted brown."),
    color = "brown",
}

ccb.content.define_terrain {
    id = "t_wood_wall_cyan",
    copy_from = "t_wall_wood",
    name = ccb.content.text("cyan wood wall"),
    looks_like = "t_wall_cyan",
    description = ccb.content.text("A wooden wall, painted cyan."),
    color = "cyan",
}

ccb.content.define_terrain {
    id = "t_wood_wall_black",
    copy_from = "t_wall_wood",
    name = ccb.content.text("black wood wall"),
    looks_like = "t_wall_black",
    description = ccb.content.text("A wooden wall, painted black."),
    color = "dark_gray",
}

ccb.content.define_terrain {
    id = "t_concrete_wall_b",
    copy_from = "t_concrete_wall",
    name = ccb.content.text("blue concrete wall"),
    looks_like = "t_wall_b",
    description = ccb.content.text("A concrete wall, painted blue."),
    color = "blue",
}

ccb.content.define_terrain {
    id = "t_concrete_wall_g",
    copy_from = "t_concrete_wall",
    name = ccb.content.text("green concrete wall"),
    looks_like = "t_wall_g",
    description = ccb.content.text("A concrete wall, painted green."),
    color = "green",
}

ccb.content.define_terrain {
    id = "t_concrete_wall_r",
    copy_from = "t_concrete_wall",
    name = ccb.content.text("red concrete wall"),
    looks_like = "t_wall_r",
    description = ccb.content.text("A concrete wall, painted red."),
    color = "red",
}

ccb.content.define_terrain {
    id = "t_concrete_wall_w",
    copy_from = "t_concrete_wall",
    name = ccb.content.text("white concrete wall"),
    looks_like = "t_wall_w",
    description = ccb.content.text("A concrete wall, painted white."),
    color = "white",
}

ccb.content.define_terrain {
    id = "t_concrete_wall_p",
    copy_from = "t_concrete_wall",
    name = ccb.content.text("purple concrete wall"),
    looks_like = "t_wall_p",
    description = ccb.content.text("A concrete wall, painted purple."),
    color = "magenta",
}

ccb.content.define_terrain {
    id = "t_concrete_wall_P",
    copy_from = "t_concrete_wall",
    name = ccb.content.text("pink concrete wall"),
    looks_like = "t_wall_P",
    description = ccb.content.text("A concrete wall, painted pink."),
    color = "pink",
}

ccb.content.define_terrain {
    id = "t_concrete_wall_y",
    copy_from = "t_concrete_wall",
    name = ccb.content.text("yellow concrete wall"),
    looks_like = "t_wall_y",
    description = ccb.content.text("A concrete wall, painted yellow."),
    color = "yellow",
}

ccb.content.define_terrain {
    id = "t_concrete_wall_orange",
    copy_from = "t_concrete_wall",
    name = ccb.content.text("orange concrete wall"),
    looks_like = "t_wall_orange",
    description = ccb.content.text("A concrete wall, painted orange."),
    color = "light_red",
}

ccb.content.define_terrain {
    id = "t_concrete_wall_gray",
    copy_from = "t_concrete_wall",
    name = ccb.content.text("gray concrete wall"),
    looks_like = "t_wall_gray",
    description = ccb.content.text("A concrete wall, painted gray."),
    color = "light_gray",
}

ccb.content.define_terrain {
    id = "t_concrete_wall_brown",
    copy_from = "t_concrete_wall",
    name = ccb.content.text("brown concrete wall"),
    looks_like = "t_wall_brown",
    description = ccb.content.text("A concrete wall, painted brown."),
    color = "brown",
}

ccb.content.define_terrain {
    id = "t_concrete_wall_cyan",
    copy_from = "t_concrete_wall",
    name = ccb.content.text("cyan concrete wall"),
    looks_like = "t_wall_cyan",
    description = ccb.content.text("A concrete wall, painted cyan."),
    color = "cyan",
}

ccb.content.define_terrain {
    id = "t_concrete_wall_black",
    copy_from = "t_concrete_wall",
    name = ccb.content.text("black concrete wall"),
    looks_like = "t_wall_p",
    description = ccb.content.text("A concrete wall, painted black."),
    color = "dark_gray",
}

ccb.content.define_terrain {
    id = "t_strconc_wall_b",
    copy_from = "t_strconc_wall",
    name = ccb.content.text("reinforced blue concrete wall"),
    looks_like = "t_wall_b",
    description = ccb.content.text("A reinforced concrete wall, painted blue."),
    color = "blue",
}

ccb.content.define_terrain {
    id = "t_strconc_wall_g",
    copy_from = "t_strconc_wall",
    name = ccb.content.text("reinforced green concrete wall"),
    looks_like = "t_wall_g",
    description = ccb.content.text("A reinforced concrete wall, painted green."),
    color = "green",
}

ccb.content.define_terrain {
    id = "t_strconc_wall_r",
    copy_from = "t_strconc_wall",
    name = ccb.content.text("reinforced red concrete wall"),
    looks_like = "t_wall_r",
    description = ccb.content.text("A reinforced concrete wall, painted red."),
    color = "red",
}

ccb.content.define_terrain {
    id = "t_strconc_wall_w",
    copy_from = "t_strconc_wall",
    name = ccb.content.text("reinforced white concrete wall"),
    looks_like = "t_wall_w",
    description = ccb.content.text("A reinforced concrete wall, painted white."),
    color = "white",
}

ccb.content.define_terrain {
    id = "t_strconc_wall_p",
    copy_from = "t_strconc_wall",
    name = ccb.content.text("reinforced purple concrete wall"),
    looks_like = "t_wall_p",
    description = ccb.content.text("A reinforced concrete wall, painted purple."),
    color = "magenta",
}

ccb.content.define_terrain {
    id = "t_strconc_wall_P",
    copy_from = "t_strconc_wall",
    name = ccb.content.text("reinforced pink concrete wall"),
    looks_like = "t_wall_P",
    description = ccb.content.text("A reinforced concrete wall, painted pink."),
    color = "pink",
}

ccb.content.define_terrain {
    id = "t_strconc_wall_y",
    copy_from = "t_strconc_wall",
    name = ccb.content.text("reinforced yellow concrete wall"),
    looks_like = "t_wall_y",
    description = ccb.content.text("A reinforced concrete wall, painted yellow."),
    color = "yellow",
}

ccb.content.define_terrain {
    id = "t_strconc_wall_orange",
    copy_from = "t_strconc_wall",
    name = ccb.content.text("reinforced orange concrete wall"),
    looks_like = "t_wall_orange",
    description = ccb.content.text("A reinforced concrete wall, painted orange."),
    color = "light_red",
}

ccb.content.define_terrain {
    id = "t_strconc_wall_gray",
    copy_from = "t_strconc_wall",
    name = ccb.content.text("reinforced gray concrete wall"),
    looks_like = "t_wall_gray",
    description = ccb.content.text("A reinforced concrete wall, painted gray."),
    color = "light_gray",
}

ccb.content.define_terrain {
    id = "t_strconc_wall_brown",
    copy_from = "t_strconc_wall",
    name = ccb.content.text("reinforced brown concrete wall"),
    looks_like = "t_wall_brown",
    description = ccb.content.text("Reinforced concrete wall painted brown."),
    color = "brown",
}

ccb.content.define_terrain {
    id = "t_strconc_wall_cyan",
    copy_from = "t_strconc_wall",
    name = ccb.content.text("reinforced cyan concrete wall"),
    looks_like = "t_wall_cyan",
    description = ccb.content.text("A reinforced concrete wall, painted cyan."),
    color = "cyan",
}

ccb.content.define_terrain {
    id = "t_strconc_wall_black",
    copy_from = "t_strconc_wall",
    name = ccb.content.text("reinforced black concrete wall"),
    looks_like = "t_wall_black",
    description = ccb.content.text("A reinforced concrete wall, painted black."),
    color = "dark_gray",
}

ccb.content.define_terrain {
    id = "t_sconc_wall_b",
    copy_from = "t_sconc_wall",
    name = ccb.content.text("simple blue concrete wall"),
    looks_like = "t_wall_b",
    description = ccb.content.text("A simple concrete wall, painted blue."),
    color = "blue",
}

ccb.content.define_terrain {
    id = "t_sconc_wall_g",
    copy_from = "t_sconc_wall",
    name = ccb.content.text("simple green concrete wall"),
    looks_like = "t_wall_g",
    description = ccb.content.text("A simple concrete wall, painted green."),
    color = "green",
}

ccb.content.define_terrain {
    id = "t_sconc_wall_r",
    copy_from = "t_sconc_wall",
    name = ccb.content.text("simple red concrete wall"),
    looks_like = "t_wall_r",
    description = ccb.content.text("A simple concrete wall, painted red."),
    color = "red",
}

ccb.content.define_terrain {
    id = "t_sconc_wall_w",
    copy_from = "t_sconc_wall",
    name = ccb.content.text("simple white concrete wall"),
    looks_like = "t_wall_w",
    description = ccb.content.text("A simple concrete wall, painted white."),
    color = "white",
}

ccb.content.define_terrain {
    id = "t_sconc_wall_p",
    copy_from = "t_sconc_wall",
    name = ccb.content.text("simple purple concrete wall"),
    looks_like = "t_wall_p",
    description = ccb.content.text("A simple concrete wall, painted purple."),
    color = "magenta",
}

ccb.content.define_terrain {
    id = "t_sconc_wall_P",
    copy_from = "t_sconc_wall",
    name = ccb.content.text("simple pink concrete wall"),
    looks_like = "t_wall_P",
    description = ccb.content.text("A simple concrete wall, painted pink."),
    color = "pink",
}

ccb.content.define_terrain {
    id = "t_sconc_wall_y",
    copy_from = "t_sconc_wall",
    name = ccb.content.text("simple yellow concrete wall"),
    looks_like = "t_wall_y",
    description = ccb.content.text("A simple concrete wall, painted yellow."),
    color = "yellow",
}

ccb.content.define_terrain {
    id = "t_sconc_wall_orange",
    copy_from = "t_sconc_wall",
    name = ccb.content.text("simple orange concrete wall"),
    looks_like = "t_wall_orange",
    description = ccb.content.text("A simple concrete wall, painted orange."),
    color = "light_red",
}

ccb.content.define_terrain {
    id = "t_sconc_wall_gray",
    copy_from = "t_sconc_wall",
    name = ccb.content.text("simple gray concrete wall"),
    looks_like = "t_wall_gray",
    description = ccb.content.text("A simple concrete wall, painted gray."),
    color = "light_gray",
}

ccb.content.define_terrain {
    id = "t_sconc_wall_brown",
    copy_from = "t_sconc_wall",
    name = ccb.content.text("simple brown concrete wall"),
    looks_like = "t_wall_brown",
    description = ccb.content.text("A simple concrete wall, painted brown."),
    color = "red",
}

ccb.content.define_terrain {
    id = "t_sconc_wall_cyan",
    copy_from = "t_sconc_wall",
    name = ccb.content.text("simple cyan concrete wall"),
    looks_like = "t_wall_cyan",
    description = ccb.content.text("A simple concrete wall, painted cyan."),
    color = "cyan",
}

ccb.content.define_terrain {
    id = "t_sconc_wall_black",
    copy_from = "t_sconc_wall",
    name = ccb.content.text("simple black concrete wall"),
    looks_like = "t_wall_p",
    description = ccb.content.text("A simple concrete wall, painted black."),
    color = "dark_gray",
}

ccb.content.define_terrain {
    id = "t_brick_wall_halfway",
    looks_like = "t_brick_wall",
    name = ccb.content.text("half-built brick wall"),
    description = ccb.content.text("Half of a brick wall.  It requires some more resources and effort before it'd be considered a suitable wall."),
    symbol = "#",
    color = "brown",
    move_cost = 5,
    coverage = 60,
    flags = { "TRANSPARENT", "NOITEM", "MOUNTABLE", "REDUCE_SCENT", "MINEABLE" },
    bash = {
        minimum_strength = 30,
        maximum_strength = 100,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("bash!"),
        terrain = "t_null",
        drops = { { item = "rock", count = { 5, 8 } }, { item = "brick", count = { 1, 3 } } },
    },
}

ccb.content.define_terrain {
    id = "t_brick_wall",
    copy_from = "t_abstract_wall_brick",
    name = ccb.content.text("brick wall"),
    description = ccb.content.text("A solid brick wall, sturdy enough to support a roof with enough walls and to keep out any unwanted visitors."),
    bash = {
        minimum_strength = 60,
        maximum_strength = 160,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("bash!"),
        terrain = "t_null",
        drops = { { item = "rock", count = { 8, 15 } }, { item = "brick", count = { 2, 6 } } },
    },
}

ccb.content.define_terrain {
    id = "t_rock_wall",
    copy_from = "t_abstract_wall_stone",
    name = ccb.content.text("stone wall"),
    looks_like = "t_rock",
    description = ccb.content.text("A sturdy stone wall."),
    bash = {
        minimum_strength = 80,
        maximum_strength = 300,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = { { item = "rock", count = { 8, 18 } } },
    },
}

ccb.content.define_terrain {
    id = "t_rock_wall_fake",
    copy_from = "t_abstract_wall_stone",
    name = ccb.content.text("stone wall"),
    looks_like = "t_rock",
    description = ccb.content.text("A sturdy stone wall."),
    bash = {
        minimum_strength = 8,
        maximum_strength = 30,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = { { item = "rock", count = { 8, 18 } } },
    },
}

ccb.content.define_terrain {
    id = "t_stone_masonry_wall_whitewashed",
    copy_from = "t_abstract_wall_stone",
    name = ccb.content.text("whitewashed stone masonry wall"),
    looks_like = "t_rock_wall",
    description = ccb.content.text("A wall of carefully cut and laid stones, joined with mortar.  The exterior has been finished with plaster and whitewashed."),
    bash = {
        minimum_strength = 80,
        maximum_strength = 300,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = { { item = "rock", count = { 8, 18 } } },
    },
}

ccb.content.define_terrain {
    id = "t_rock_wall_half",
    looks_like = "t_rock_wall",
    name = ccb.content.text("half-built stone wall"),
    description = ccb.content.text("Half of a sturdy stone wall.  Some work still needs to be done before it can be considered a suitable wall."),
    symbol = "#",
    color = "light_gray",
    move_cost = 4,
    coverage = 60,
    flags = { "TRANSPARENT", "NOITEM", "REDUCE_SCENT", "MOUNTABLE", "MINEABLE" },
    connect_groups = "WALL",
    connects_to = "WALL",
    bash = {
        minimum_strength = 40,
        maximum_strength = 200,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = { { item = "rock", count = { 3, 8 } } },
    },
}

-- use pillars, 't_column', as a compliment.
ccb.content.define_terrain {
    id = "t_rock_smooth",
    copy_from = "t_abstract_wall_stone",
    name = ccb.content.text("smoothed rock"),
    looks_like = "t_rock",
    description = ccb.content.text("A block of stone that's been smoothed and shaped, commonly granite or marble for funerary chapels and mausoleums."),
    color = "white",
    bash = {
        minimum_strength = 120,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = {
            { item = "rock", count = { 6, 12 } },
            { item = "material_rocksalt", count = { 0, 1 }, chance = 10 },
        },
    },
}

ccb.content.define_terrain {
    id = "t_adobe_brick_wall_halfway",
    name = ccb.content.text("half-built adobe wall"),
    description = ccb.content.text("Half of an adobe brick wall.  It requires some more resources and effort before it'd be considered a suitable wall."),
    symbol = "#",
    color = "brown",
    looks_like = "t_brick_wall_halfway",
    move_cost = 5,
    coverage = 60,
    flags = { "TRANSPARENT", "NOITEM", "MOUNTABLE", "REDUCE_SCENT", "MINEABLE" },
    bash = {
        minimum_strength = 20,
        maximum_strength = 90,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("bash!"),
        terrain = "t_null",
        drops = { { item = "material_soil", count = { 4, 10 } }, { item = "adobe_brick", count = { 5, 20 } } },
    },
}

ccb.content.define_terrain {
    id = "t_adobe_brick_wall",
    copy_from = "t_abstract_wall_brick",
    name = ccb.content.text("adobe wall"),
    description = ccb.content.text("A solid adobe brick wall that's both sturdy enough to support a roof and keep out any unwanted visitors."),
    looks_like = "t_brick_wall",
    bash = {
        minimum_strength = 40,
        maximum_strength = 120,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("bash!"),
        terrain = "t_null",
        drops = { { item = "material_soil", count = { 8, 20 } }, { item = "adobe_brick", count = { 5, 40 } } },
    },
}

ccb.content.define_terrain {
    id = "t_concrete_wall_rope",
    copy_from = "t_concrete_wall",
    name = ccb.content.text("concrete wall with ropes"),
    description = ccb.content.text("A boxlike wall of concrete with ropes attached to the exterior edges."),
    move_cost = 10,
    extend = { flags = { "MOUNTABLE" } },
    delete = { flags = { "SUPPORTS_ROOF" } },
    bash = {
        minimum_strength = 70,
        maximum_strength = 300,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_reb_cage",
        drops = { { item = "rock", count = { 10, 22 } }, { item = "rope_6", count = { 2, 4 } } },
    },
}

ccb.content.define_terrain {
    id = "t_wall_metal",
    copy_from = "t_abstract_wall_metal",
    name = ccb.content.text("metal wall"),
    extend = { flags = { "WIRED_WALL" } },
    description = ccb.content.text("An industrially fabricated thick sheet carefully positioned and joined seamlessly with perimeter sealant, this wall is capable of resisting extreme elements as well as hostile forces.  Blast load rated and extremely fire-retardant, breaching it will require specialized tools or an industrial vehicle."),
    oxytorch = {
        result = "t_scrap_wall_halfway",
        duration = "14 seconds",
        byproducts = {
            { item = "steel_plate", count = { 2, 3 } },
            { item = "lc_steel_chunk", count = { 12, 20 } },
        },
    },
    bash = {
        minimum_strength = 200,
        maximum_strength = 600,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = {
            { item = "lc_steel_lump", count = { 1, 4 } },
            { item = "lc_steel_chunk", count = { 3, 12 } },
            { item = "scrap", count = { 9, 36 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_wall_metal_corrugated",
    copy_from = "t_abstract_wall_metal",
    name = ccb.content.text("corrugated metal wall"),
    description = ccb.content.text("A wall made from a thin sheet of corrugated steel held in a frame, weather- and windproof but not very insulating or durable."),
    looks_like = "t_wall_metal",
    bash = {
        minimum_strength = 30,
        maximum_strength = 210,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = { { item = "lc_steel_chunk", count = { 1, 4 } }, { item = "scrap", count = { 3, 12 } } },
    },
}

ccb.content.define_terrain {
    id = "t_wall_metal_shipping_container",
    copy_from = "t_abstract_wall_metal",
    name = ccb.content.text("shipping container wall"),
    description = ccb.content.text("A shipping container made of corrugated weathering steel."),
    symbol = "#",
    color = "light_gray",
    bash = {
        minimum_strength = 60,
        maximum_strength = 350,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = { { item = "lc_steel_chunk", count = { 1, 4 } }, { item = "scrap", count = { 3, 12 } } },
    },
}

ccb.content.define_terrain {
    id = "t_wall_metal_shipping_container_black",
    copy_from = "t_wall_metal_shipping_container",
    color = "black",
}

ccb.content.define_terrain {
    id = "t_wall_metal_shipping_container_white",
    copy_from = "t_wall_metal_shipping_container",
    color = "white",
}

ccb.content.define_terrain {
    id = "t_wall_metal_shipping_container_red",
    copy_from = "t_wall_metal_shipping_container",
    color = "red",
}

ccb.content.define_terrain {
    id = "t_wall_metal_shipping_container_light_red",
    copy_from = "t_wall_metal_shipping_container",
    color = "light_red",
}

ccb.content.define_terrain {
    id = "t_wall_metal_shipping_container_green",
    copy_from = "t_wall_metal_shipping_container",
    color = "green",
}

ccb.content.define_terrain {
    id = "t_wall_metal_shipping_container_light_green",
    copy_from = "t_wall_metal_shipping_container",
    color = "light_green",
}

ccb.content.define_terrain {
    id = "t_wall_metal_shipping_container_blue",
    copy_from = "t_wall_metal_shipping_container",
    color = "blue",
}

ccb.content.define_terrain {
    id = "t_wall_metal_shipping_container_light_blue",
    copy_from = "t_wall_metal_shipping_container",
    color = "light_blue",
}

ccb.content.define_terrain {
    id = "t_wall_metal_shipping_container_cyan",
    copy_from = "t_wall_metal_shipping_container",
    color = "cyan",
}

ccb.content.define_terrain {
    id = "t_wall_metal_shipping_container_light_cyan",
    copy_from = "t_wall_metal_shipping_container",
    color = "light_cyan",
}

ccb.content.define_terrain {
    id = "t_wall_metal_shipping_container_magenta",
    copy_from = "t_wall_metal_shipping_container",
    color = "magenta",
}

ccb.content.define_terrain {
    id = "t_wall_metal_shipping_container_brown",
    copy_from = "t_wall_metal_shipping_container",
    color = "brown",
}

ccb.content.define_terrain {
    id = "t_wall_metal_shipping_container_pink",
    copy_from = "t_wall_metal_shipping_container",
    color = "pink",
}

ccb.content.define_terrain {
    id = "t_wall_metal_shipping_container_yellow",
    copy_from = "t_wall_metal_shipping_container",
    color = "yellow",
}

-- identical to t_wall_metal, but gray and cannot be oxytorched
ccb.content.define_terrain {
    id = "t_wall_bulkhead",
    copy_from = "t_abstract_wall_metal",
    name = ccb.content.text("bulkhead"),
    description = ccb.content.text("An industrially fabricated thick sheet carefully positioned, this wall is capable of resisting extreme elements as well as hostile forces."),
    color = "light_gray",
    looks_like = "t_wall_metal",
}

ccb.content.define_terrain {
    id = "t_sconc_wall_halfway",
    name = ccb.content.text("half-built simple concrete wall"),
    looks_like = "t_sconc_wall",
    description = ccb.content.text("A partially-poured concrete wall that could probably keep anything behind it quite safe if it were finished."),
    symbol = "*",
    color = "light_gray",
    move_cost = 4,
    coverage = 60,
    flags = { "NOITEM", "TRANSPARENT", "MOUNTABLE", "REDUCE_SCENT", "MINEABLE" },
    connect_groups = "WALL",
    connects_to = "WALL",
    bash = {
        minimum_strength = 40,
        maximum_strength = 350,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_pit_shallow",
        drops = { { item = "rock", count = { 5, 11 } } },
    },
}

ccb.content.define_terrain {
    id = "t_strconc_wall_halfway",
    name = ccb.content.text("half-built reinforced concrete wall"),
    looks_like = "t_sconc_wall_halfway",
    description = ccb.content.text("Poured concrete with methodically placed rebar sticking out, which isn't practical for supporting roofs or shelter.  It needs more resources before it could be considered complete."),
    symbol = "*",
    color = "light_gray",
    move_cost = 5,
    coverage = 60,
    flags = { "TRANSPARENT", "NOITEM", "MOUNTABLE", "REDUCE_SCENT", "MINEABLE" },
    connect_groups = "WALL",
    connects_to = "WALL",
    bash = {
        minimum_strength = 60,
        maximum_strength = 460,
        sound = ccb.content.text("scrrrash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_reb_cage",
        drops = { { item = "rock", count = { 5, 11 } } },
    },
}

ccb.content.define_terrain {
    id = "t_reb_cage",
    name = ccb.content.text("rebar cage"),
    description = ccb.content.text("A structural support system made of rebar that appears to be the early stages of a reinforced concrete wall, just missing the poured concrete."),
    symbol = "#",
    color = "dark_gray",
    move_cost = 0,
    hacksaw = {
        result = "t_pit",
        duration = "10 minutes",
        message = ccb.content.text("You finish cutting the metal."),
        byproducts = { { item = "spike", count = 19 }, { item = "scrap", count = 8 } },
    },
    flags = { "TRANSPARENT", "NOITEM", "PERMEABLE", "THIN_OBSTACLE" },
    connect_groups = "WALL",
    connects_to = "WALL",
    oxytorch = {
        result = "t_pit",
        duration = "9 seconds",
        byproducts = { { item = "spike", count = { 1, 19 } }, { item = "scrap", count = { 1, 8 } } },
    },
    bash = {
        minimum_strength = 20,
        maximum_strength = 100,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_thconc_floor",
        drops = { { item = "scrap", count = { 4, 12 } }, { item = "rebar", count = { 0, 4 } } },
    },
}

ccb.content.define_terrain {
    id = "t_scrap_wall",
    copy_from = "t_abstract_wall_metal",
    name = ccb.content.text("simple metal wall"),
    looks_like = "t_wall_metal",
    description = ccb.content.text("A relatively simple wall made of cobbled-together scrap metal.  It's still capable of blocking intruders and supporting a roof with adjacent walls."),
    color = "dark_gray",
    bash = {
        minimum_strength = 80,
        maximum_strength = 200,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_pit_shallow",
        drops = { { item = "lc_steel_chunk", count = { 10, 22 } } },
    },
}

ccb.content.define_terrain {
    id = "t_scrap_wall_halfway",
    name = ccb.content.text("half-built simple metal wall"),
    looks_like = "t_scrap_wall",
    description = ccb.content.text("A partially-built makeshift metal wall that could potentially support a roof if it were completed."),
    symbol = "#",
    color = "dark_gray",
    move_cost = 4,
    coverage = 60,
    flags = { "NOITEM", "TRANSPARENT", "MOUNTABLE", "REDUCE_SCENT", "MINEABLE" },
    bash = {
        minimum_strength = 50,
        maximum_strength = 130,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_pit_shallow",
        drops = { { item = "lc_steel_chunk", count = { 5, 11 } } },
    },
}

ccb.content.define_terrain {
    id = "t_wall_wood_chipped",
    copy_from = "t_wall_wood",
    name = ccb.content.text("chipped wood wall"),
    looks_like = "t_wall_wood",
    description = ccb.content.text("A wall of aligned planks that's starting to crack and break open.  Some replacement wood and a number of nails could patch this up quick."),
    extend = { flags = { "REDUCE_SCENT" } },
    delete = { flags = { "NO_SCENT" } },
    bash = {
        minimum_strength = 8,
        maximum_strength = 150,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_wall_wood_broken",
        drops = {
            { item = "2x4", count = { 1, 4 } },
            { item = "wood_panel", count = { 0, 2 } },
            { item = "nail", charges = { 1, 3 } },
            { item = "splinter", count = { 1, 4 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_wall_wood_broken",
    name = ccb.content.text("broken wood wall"),
    looks_like = "t_wall_wood_chipped",
    description = ccb.content.text("A number of planks are missing and the structure is beginning to sag and fall apart.  It's going to need quite a bit of work to repair."),
    symbol = "&",
    color = "light_red",
    move_cost = 0,
    coverage = 35,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "REDUCE_SCENT", "PERMEABLE" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 110,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = {
            { item = "2x4", count = { 2, 5 } },
            { item = "wood_panel", count = { 0, 2 } },
            { item = "nail", charges = { 4, 10 } },
            { item = "splinter", count = { 1, 5 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
    shoot = {
        chance_to_hit = 25,
        reduce_damage = { 20, 40 },
        reduce_damage_laser = { 10, 30 },
        destroy_damage = { 30, 100 },
    },
}

ccb.content.define_terrain {
    id = "t_wall_burnt",
    name = ccb.content.text("burnt wall"),
    looks_like = "t_wall_wood_broken",
    description = ccb.content.text("Whatever this wall used to be made of, it's little more than charred remains now."),
    symbol = "#",
    color = "dark_gray",
    move_cost = 0,
    coverage = 35,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "TRANSPARENT", "NOITEM", "SUPPORTS_ROOF", "REDUCE_SCENT", "PERMEABLE" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 20,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = { { item = "ash", count = { 20, 50 } }, { item = "scrap", count = { 2, 5 } } },
    },
    shoot = {
        chance_to_hit = 25,
        reduce_damage = { 5, 10 },
        reduce_damage_laser = { 10, 30 },
        destroy_damage = { 5, 20 },
    },
}

ccb.content.define_terrain {
    id = "t_wall_log_half",
    name = ccb.content.text("half-built log wall"),
    looks_like = "t_wall_log",
    description = ccb.content.text("A half-constructed wall of notched logs that interlock to provide stability.  Needs a few more logs to hold up a roof.  Looks flammable."),
    symbol = "#",
    color = "brown",
    move_cost = 4,
    coverage = 60,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "NOITEM", "REDUCE_SCENT", "MOUNTABLE", "MINEABLE" },
    connect_groups = "WALL",
    connects_to = "WALL",
    bash = {
        minimum_strength = 40,
        maximum_strength = 120,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = { { item = "splinter", count = { 10, 20 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_wall_log",
    copy_from = "t_abstract_wall_wood",
    name = ccb.content.text("log wall"),
    looks_like = "t_wall_wood",
    description = ccb.content.text("A tall wall of timber suitable for housing and insulating from the weather.  Quite flammable."),
    color = "brown",
    roof = "t_wood_roof",
    bash = {
        minimum_strength = 60,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_wall_log_chipped",
        drops = { { item = "splinter", count = { 5, 10 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_wall_log_chipped",
    copy_from = "t_wall_log",
    name = ccb.content.text("chipped log wall"),
    description = ccb.content.text("A moderately damaged log wall, it could probably be patched up with some planks and nails."),
    extend = { flags = { "REDUCE_SCENT" } },
    delete = { flags = { "NO_SCENT" } },
    bash = {
        minimum_strength = 40,
        maximum_strength = 160,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_wall_log_broken",
        drops = { { item = "splinter", count = { 5, 10 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_wall_log_broken",
    name = ccb.content.text("broken log wall"),
    looks_like = "t_wall_log_chipped",
    description = ccb.content.text("A destroyed log wall, with only a supporting log left, ready to collapse.  Looks repairable if the damage was replaced and patched together with nails and planks."),
    symbol = "&",
    color = "brown",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "REDUCE_SCENT", "PERMEABLE" },
    bash = {
        minimum_strength = 8,
        maximum_strength = 150,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = { { item = "splinter", count = { 10, 20 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
    shoot = {
        chance_to_hit = 25,
        reduce_damage = { 20, 50 },
        reduce_damage_laser = { 10, 40 },
        destroy_damage = { 40, 120 },
    },
}

ccb.content.define_terrain {
    id = "t_palisade",
    name = ccb.content.text("palisade wall"),
    looks_like = "t_wall_log",
    description = ccb.content.text("An age-old type of fortification consisting of hefty lumber staked into the ground and cabled together."),
    symbol = "#",
    color = "brown",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "FLAMMABLE", "NOITEM", "SUPPORTS_ROOF", "REDUCE_SCENT", "WALL", "BLOCK_WIND" },
    bash = {
        minimum_strength = 35,
        maximum_strength = 150,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = { { item = "splinter", count = { 10, 30 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_wall_wattle",
    copy_from = "t_abstract_wall_wood",
    name = ccb.content.text("wattle-and-daub wall"),
    looks_like = "t_wall_wood",
    description = ccb.content.text("A relatively primitive wall made by daubing together a lattice of wooden strips using some combination of wet soil, clay, sand, animal dung, and straw."),
    color = "light_red",
    roof = "t_thatch_roof",
    extend = { flags = { "FLAMMABLE_HARD" } },
    delete = { flags = { "FLAMMABLE", "MINEABLE" } },
    bash = {
        minimum_strength = 10,
        maximum_strength = 140,
        terrain = "t_wall_wattle_broken",
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        drops = { { item = "2x4", count = { 0, 3 } }, { item = "splinter", count = { 0, 6 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_wall_wattle_broken",
    name = ccb.content.text("broken wattle-and-daub wall"),
    looks_like = "t_wall_wattle",
    description = ccb.content.text("A wattle-and-daub wall section that has been destroyed, leaving mostly just the frame, and even that is barely held together."),
    symbol = "&",
    color = "light_red",
    move_cost = 0,
    bash = {
        minimum_strength = 4,
        maximum_strength = 110,
        terrain = "t_null",
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        drops = { { item = "2x4", count = { 0, 3 } }, { item = "splinter", count = { 3, 6 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
    shoot = {
        chance_to_hit = 25,
        reduce_damage = { 20, 40 },
        reduce_damage_laser = { 20, 50 },
        destroy_damage = { 30, 100 },
    },
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "NOITEM", "SUPPORTS_ROOF", "REDUCE_SCENT", "PERMEABLE" },
}

ccb.content.define_terrain {
    id = "t_wall_wattle_half",
    name = ccb.content.text("half-built wattle-and-daub wall"),
    looks_like = "t_wall_wattle",
    description = ccb.content.text("A partially-complete wattle-and-daub wall with some of the wooden strip lattice in place.  It still requires the rest of the lattice and supporting wet compound to be filled in."),
    symbol = "#",
    color = "light_red",
    move_cost = 4,
    coverage = 60,
    bash = {
        minimum_strength = 8,
        maximum_strength = 75,
        terrain = "t_null",
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        drops = { { item = "2x4", count = { 1, 3 } }, { item = "splinter", count = { 6, 6 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "NOITEM", "REDUCE_SCENT", "MOUNTABLE" },
}

ccb.content.define_terrain {
    id = "t_junk_wall",
    name = ccb.content.text("junk metal wall"),
    looks_like = "t_scrap_wall",
    description = ccb.content.text("A wall of rusty scrap metal bolted and wire-tied to a sturdy frame.  Very fashionable in post-apocalyptic shantytowns.  Can support a roof."),
    symbol = "#",
    color = "dark_gray",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "WALL", "PERMEABLE", "SUPPORTS_ROOF", "AUTO_WALL_SYMBOL", "MINEABLE" },
    bash = {
        minimum_strength = 60,
        maximum_strength = 200,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_pit_shallow",
        drops = {
            { item = "pipe", count = { 1, 6 } },
            { item = "scrap", count = { 1, 40 } },
            { item = "sheet_metal", count = { 1, 2 } },
            { item = "budget_steel_chunk", count = { 1, 30 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_wall_rammed_earth",
    copy_from = "t_abstract_wall_earthen",
    name = ccb.content.text("rammed earth wall"),
    looks_like = "t_rock",
    description = ccb.content.text("A solid wall of compressed dirt, sturdy enough to support a roof with enough walls and to keep out some unwanted visitors."),
    roof = "t_dirt",
    bash = {
        minimum_strength = 60,
        maximum_strength = 200,
        sound = ccb.content.text("heavy rumbling!"),
        failure_sound = ccb.content.text("thump"),
        terrain = "t_fence_post",
        drops = { { item = "material_soil", count = { 100, 150 } } },
    },
}

ccb.content.define_terrain {
    id = "t_wall_dirt",
    copy_from = "t_abstract_wall_earthen",
    name = ccb.content.text("smooth dirt wall"),
    looks_like = "t_wall_rammed_earth",
    description = ccb.content.text("A solid wall of compressed dirt, mixed with… something to keep it stable.  Its surface glistens slightly, and it smells like rotten milk."),
    roof = "t_dirt",
    bash = {
        minimum_strength = 30,
        maximum_strength = 200,
        sound = ccb.content.text("heavy rumbling!"),
        failure_sound = ccb.content.text("thump"),
        terrain = "t_mud_underground",
        drops = { { item = "material_soil", count = { 50, 100 } } },
    },
}

ccb.content.define_terrain {
    id = "t_wall_warped",
    name = ccb.content.text("warped wall"),
    description = ccb.content.text("At first glance, this looks like a simple stone wall.  But the angles don't add up, and the shadows are wrong.  Whatever this is, it doesn't belong here."),
    symbol = "#",
    color = "magenta",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "BLOCK_WIND" },
}

ccb.content.define_terrain {
    id = "t_junk_palisade",
    name = ccb.content.text("junk metal barrier"),
    looks_like = "t_scrap_wall_halfway",
    description = ccb.content.text("A simple wall of rusty scrap metal bolted and wire-tied to a makeshift frame.  Very fashionable in post-apocalyptic shantytowns.  This one isn't quite strong enough to support a roof, but could be reinforced."),
    symbol = "#",
    color = "dark_gray",
    move_cost = 0,
    coverage = 60,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "WALL", "PERMEABLE", "AUTO_WALL_SYMBOL", "MINEABLE" },
    bash = {
        minimum_strength = 30,
        maximum_strength = 200,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_pit_shallow",
        drops = { { item = "pipe", count = { 1, 2 } }, { item = "scrap", count = { 1, 40 } } },
    },
}

ccb.content.define_terrain {
    id = "t_wall_glass",
    copy_from = "t_abstract_wall_glass",
    name = ccb.content.text("glass wall"),
    looks_like = "t_window",
    description = ccb.content.text("A barrier made of glass, it's nothing complicated, and looks extremely fragile.  Some contain glass break sensors or window sensors that trigger an alarm if the glass is damaged."),
    coverage = 30,
    rotates_to = "INDOORFLOOR",
    delete = { flags = { "MINEABLE" } },
    bash = {
        minimum_strength = 4,
        maximum_strength = 12,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        failure_volume = 10,
        terrain = "t_floor",
        drops = { { item = "glass_shard", count = { 42, 84 } } },
    },
    shoot = {
        reduce_damage = { 1, 8 },
        reduce_damage_laser = { 0, 5 },
        destroy_damage = { 2, 8 },
        no_laser_destroy = true,
    },
}

ccb.content.define_terrain {
    id = "t_wall_glass_alarm",
    copy_from = "t_wall_glass",
    name = ccb.content.text("glass wall"),
    description = ccb.content.text("A barrier made of glass, it's nothing complicated, and looks extremely fragile.  Some contain glass break sensors or window sensors that trigger an alarm if the glass is damaged."),
    extend = { flags = { "ALARMED" } },
}

ccb.content.define_terrain {
    id = "t_wall_glass_lab",
    copy_from = "t_wall_glass",
    bash = {
        minimum_strength = 4,
        maximum_strength = 12,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        failure_volume = 10,
        terrain = "t_strconc_floor",
        drops = { { item = "glass_shard", count = { 42, 84 } } },
    },
}

ccb.content.define_terrain {
    id = "t_laminated_glass",
    copy_from = "t_abstract_wall_glass",
    name = ccb.content.text("laminated glass"),
    looks_like = "t_reinforced_glass",
    description = ccb.content.text("A laminated glass barrier, composed of layers of glass and plastic held together by an interlayer."),
    bash = {
        minimum_strength = 100,
        maximum_strength = 180,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 20,
        failure_volume = 14,
        terrain = "t_floor",
        drops = { { item = "glass_shard", count = { 42, 84 } } },
    },
    shoot = {
        reduce_damage = { 2, 12 },
        reduce_damage_laser = { 0, 7 },
        destroy_damage = { 40, 120 },
        no_laser_destroy = true,
    },
}

ccb.content.define_terrain {
    id = "t_ballistic_glass",
    copy_from = "t_abstract_wall_glass",
    name = ccb.content.text("ballistic glass"),
    looks_like = "t_reinforced_glass",
    description = ccb.content.text("A ballistic glass barrier, consisting of layers of laminated glass."),
    bash = {
        minimum_strength = 200,
        maximum_strength = 400,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 20,
        failure_volume = 14,
        terrain = "t_floor",
        drops = { { item = "glass_shard", count = { 42, 84 } } },
    },
    shoot = {
        reduce_damage = { 30, 60 },
        reduce_damage_laser = { 0, 10 },
        destroy_damage = { 80, 200 },
        no_laser_destroy = true,
    },
}

ccb.content.define_terrain {
    id = "t_reinforced_glass",
    copy_from = "t_abstract_wall_glass",
    name = ccb.content.text("reinforced glass"),
    description = ccb.content.text("A thicker pane of glass with thin metal wires embedded throughout, strengthening the structural properties.  Still weaker than other types of walls, and not made to support a roof either."),
    bash = {
        minimum_strength = 40,
        maximum_strength = 210,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 20,
        failure_volume = 14,
        terrain = "t_floor",
        drops = { { item = "glass_shard", count = { 42, 84 } }, { item = "mc_wire", chance = 20 } },
    },
    shoot = {
        reduce_damage = { 15, 30 },
        reduce_damage_laser = { 0, 10 },
        destroy_damage = { 60, 160 },
        no_laser_destroy = true,
    },
}

ccb.content.define_terrain {
    id = "t_reinforced_glass_lab",
    copy_from = "t_reinforced_glass",
    description = ccb.content.text("A thicker pane of glass with thin metal wires embedded throughout, strengthening the structural properties.  Still weaker than other types of walls, and not made to support a roof either.  Not the type of glass to stop a bullet, you realize."),
    bash = {
        minimum_strength = 40,
        maximum_strength = 210,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 20,
        failure_volume = 14,
        terrain = "t_strconc_floor",
        drops = { { item = "glass_shard", count = { 42, 84 } }, { item = "mc_wire", chance = 20 } },
    },
}

ccb.content.define_terrain {
    id = "t_reinforced_glass_shutter",
    name = ccb.content.text("reinforced glass with closed shutters"),
    looks_like = "t_wall_metal",
    description = ccb.content.text("A secondary layer of protection over reinforced glass, these metal shutters are typically used to ward off criminals or protect against damage from extreme weather.  Looks like it can only be opened from the inside.  Even with the installed shutters, it isn't feasible in supporting a roof."),
    symbol = "#",
    color = "light_gray",
    move_cost = 0,
    roof = "t_flat_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "OPENCLOSE_INSIDE", "MINEABLE", "BLOCK_WIND" },
    open = "t_reinforced_glass_shutter_open",
    bash = {
        minimum_strength = 60,
        maximum_strength = 210,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 20,
        failure_volume = 14,
        terrain = "t_floor",
        drops = {
            { item = "glass_shard", count = { 42, 84 } },
            { item = "mc_wire", chance = 20 },
            { item = "scrap", count = { 3, 5 } },
        },
    },
    shoot = {
        reduce_damage = { 20, 40 },
        reduce_damage_laser = { 15, 25 },
        destroy_damage = { 60, 160 },
        no_laser_destroy = true,
    },
}

ccb.content.define_terrain {
    id = "t_reinforced_glass_shutter_open",
    name = ccb.content.text("reinforced glass with open shutters"),
    looks_like = "t_reinforced_glass",
    description = ccb.content.text("Hanging metal shutters that haven't been deployed, exposing the reinforced glass.  It appears as though the metal shutters can only be activated from the inside."),
    symbol = "#",
    color = "light_cyan",
    move_cost = 0,
    roof = "t_flat_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = {
        "TRANSPARENT",
        "NOITEM",
        "WALL",
        "NO_SCENT",
        "AUTO_WALL_SYMBOL",
        "OPENCLOSE_INSIDE",
        "MINEABLE",
        "BLOCK_WIND",
    },
    close = "t_reinforced_glass_shutter",
    bash = {
        minimum_strength = 40,
        maximum_strength = 210,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 20,
        failure_volume = 14,
        terrain = "t_floor",
        drops = {
            { item = "glass_shard", count = { 42, 84 } },
            { item = "mc_wire", chance = 20 },
            { item = "scrap", count = { 3, 5 } },
        },
    },
    shoot = {
        reduce_damage = { 20, 40 },
        reduce_damage_laser = { 15, 25 },
        destroy_damage = { 60, 160 },
        no_laser_destroy = true,
    },
}

ccb.content.define_terrain {
    id = "t_wall_lighthouse_lens",
    name = ccb.content.text("lighthouse lens"),
    looks_like = "t_wall_glass",
    description = ccb.content.text("An intricate arrangement of glass, designed to focus light from within to be visible over long distances."),
    symbol = "#",
    color = "light_cyan",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "TRANSPARENT", "NOITEM", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "BLOCK_WIND" },
    rotates_to = "INDOORFLOOR",
    bash = {
        minimum_strength = 4,
        maximum_strength = 20,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        failure_volume = 10,
        terrain = "t_null",
        drops = { { item = "glass_shard", count = { 42, 84 } }, { item = "scrap", count = { 3, 6 } } },
    },
}

ccb.content.define_terrain {
    id = "t_bars",
    name = ccb.content.text("metal bars"),
    description = ccb.content.text("Thick, heavy bars from the floor to the ceiling, interlaced wall to wall.  Not made to support roofs, but great for blocking paths."),
    builtin_examine = "bars",
    symbol = "\"",
    color = "light_gray",
    move_cost = 0,
    hacksaw = {
        result = "t_floor",
        duration = "15 minutes",
        message = ccb.content.text("You finish cutting the metal."),
        byproducts = { { item = "pipe", count = 3 } },
    },
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "TRANSPARENT", "NOITEM", "PERMEABLE", "THIN_OBSTACLE" },
    oxytorch = {
        result = "t_floor",
        duration = "9 seconds",
        byproducts = { { item = "pipe", count = { 1, 2 } } },
    },
    bash = {
        minimum_strength = 60,
        maximum_strength = 250,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_floor",
        drops = {
            { item = "mc_steel_lump", chance = 25 },
            { item = "mc_steel_chunk", count = { 1, 4 } },
            { item = "scrap", count = { 1, 5 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_paper",
    name = ccb.content.text("paper wall"),
    description = ccb.content.text("A huge wall of ambiguous pulpy matter, covered in sticky wasp saliva.  You could smash it down effortlessly."),
    symbol = "#",
    color = "white",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "FLAMMABLE_ASH", "NOITEM", "WALL", "NO_SCENT" },
    bash = {
        minimum_strength = 1,
        maximum_strength = 6,
        sound = ccb.content.text("rrrrip!"),
        failure_sound = ccb.content.text("slap!"),
        volume = 8,
        failure_volume = 4,
        terrain = "t_floor_paper",
    },
    shoot = { reduce_damage = { 2, 12 }, reduce_damage_laser = { 4, 16 }, destroy_damage = { 10, 40 } },
}

ccb.content.define_terrain {
    id = "t_paper_brood",
    copy_from = "t_paper",
    bash = {
        minimum_strength = 1,
        maximum_strength = 6,
        sound = ccb.content.text("rrrrip!"),
        failure_sound = ccb.content.text("slap!"),
        volume = 8,
        failure_volume = 4,
        terrain = "t_floor_paper_noroof",
    },
}

ccb.content.define_terrain {
    id = "t_paper_hard",
    name = ccb.content.text("layered paper wall"),
    description = ccb.content.text("A thick wall of layered tree pulp and wasp saliva, hardened to withstand the elements.  You could break through this, but it won't be easy."),
    symbol = "#",
    color = "dark_gray",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "FLAMMABLE_HARD", "NOITEM", "MINEABLE", "WALL", "NO_SCENT" },
    bash = {
        minimum_strength = 30,
        maximum_strength = 150,
        sound = ccb.content.text("rrrrip!"),
        failure_sound = ccb.content.text("slap!"),
        volume = 20,
        failure_volume = 10,
        terrain = "t_floor_paper_hard",
    },
    shoot = { reduce_damage = { 2, 12 }, reduce_damage_laser = { 4, 16 }, destroy_damage = { 10, 40 } },
}

ccb.content.define_terrain {
    id = "t_root_wall",
    copy_from = "t_abstract_wall_earthen",
    name = ccb.content.text("root wall"),
    looks_like = "t_rock",
    description = ccb.content.text("A dirt wall covered with roots."),
    delete = { flags = { "MINEABLE", "BLOCK_WIND" } },
    bash = {
        minimum_strength = 12,
        maximum_strength = 150,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = { { item = "splinter", count = { 2, 5 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_wax",
    name = ccb.content.text("wax wall"),
    description = ccb.content.text("A wall made entirely out of wax."),
    symbol = "#",
    color = "yellow",
    move_cost = 0,
    coverage = 100,
    roof = "t_floor_wax",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "PLACE_ITEM", "WALL", "NO_SCENT" },
    bash = {
        minimum_strength = 12,
        maximum_strength = 150,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_floor_wax",
        drops = { { item = "wax", count = { 3, 5 } } },
    },
}

ccb.content.define_terrain {
    id = "t_soil",
    copy_from = "t_abstract_wall_earthen",
    name = ccb.content.text("solid earth"),
    description = ccb.content.text("A wall of solid earth."),
    extend = { flags = { "NATURAL_UNDERGROUND" } },
    delete = { flags = { "AUTO_WALL_SYMBOL" } },
    roof = "t_dirt",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("wham!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_dirt",
        terrain_from_above = "t_dirt",
        drops = { { group = "digging_soil_loam_50L", count = 20 } },
    },
}

ccb.content.define_terrain {
    id = "t_rock",
    copy_from = "t_abstract_wall_earthen",
    name = ccb.content.text("solid rock"),
    description = ccb.content.text("A wall of solid rock, could be full of all kinds of interesting things.  Best grab your pickaxe or equivalent digging implement, and strike the earth!"),
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
    id = "t_highland_bronze_pillar",
    name = ccb.content.text("gigantic bronze pillar"),
    looks_like = "t_wall_metal",
    description = ccb.content.text("A gigantic, monolithic pillar of bronze, stained green with age and crisscrossed with curved grooves.  The air around it feels heavy, and you get the distinct impression that this is not something you should be messing with."),
    symbol = "#",
    color = "green",
    light_emitted = 20,
    light_color = { 255, 0, 255 },
    move_cost = 0,
    coverage = 100,
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = { { item = "rock", count = { 17, 37 } }, { item = "rock_large", count = { 1, 3 } } },
    },
}

ccb.content.define_terrain {
    id = "t_rock_red",
    name = ccb.content.text("red stone"),
    looks_like = "t_rock",
    description = ccb.content.text("A wall of red stone."),
    symbol = "#",
    color = "red",
    move_cost = 0,
    coverage = 100,
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = { { item = "rock", count = { 17, 37 } }, { item = "rock_large", count = { 1, 3 } } },
    },
}

ccb.content.define_terrain {
    id = "t_rock_green",
    name = ccb.content.text("green stone"),
    looks_like = "t_rock",
    description = ccb.content.text("A wall of green stone."),
    symbol = "#",
    color = "green",
    move_cost = 0,
    coverage = 100,
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = { { item = "rock", count = { 17, 37 } }, { item = "rock_large", count = { 1, 3 } } },
    },
}

ccb.content.define_terrain {
    id = "t_rock_blue",
    name = ccb.content.text("blue stone"),
    looks_like = "t_rock",
    description = ccb.content.text("A wall of blue stone."),
    symbol = "#",
    color = "blue",
    move_cost = 0,
    coverage = 100,
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = { { item = "rock", count = { 17, 37 } }, { item = "rock_large", count = { 1, 3 } } },
    },
}

ccb.content.define_terrain {
    id = "t_little_column",
    copy_from = "t_abstract_column",
    name = ccb.content.text("little column"),
    looks_like = "t_column",
    description = ccb.content.text("A small support column."),
    extend = { flags = { "TRANSPARENT" } },
    delete = { flags = { "MINEABLE" } },
    bash = {
        minimum_strength = 40,
        maximum_strength = 200,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = { { item = "rock", count = { 1, 3 } }, { item = "rebar", count = { 0, 2 } } },
    },
}

ccb.content.define_terrain {
    id = "t_column_halfway",
    name = ccb.content.text("half-built column"),
    looks_like = "t_column",
    description = ccb.content.text("An empty wooden frame in the shape of a column, built around a concrete and rebar foundation.  It isn't capable of supporting roofs or shelter, and needs more resources before it could be considered complete."),
    symbol = "*",
    color = "light_gray",
    move_cost = 5,
    flags = { "TRANSPARENT", "NOITEM", "MOUNTABLE", "PERMEABLE", "MINEABLE" },
    connect_groups = "WALL",
    connects_to = "WALL",
    bash = {
        minimum_strength = 60,
        maximum_strength = 460,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_reb_cage",
        drops = { { item = "rock", count = { 5, 11 } } },
    },
}

ccb.content.define_terrain {
    id = "t_column",
    copy_from = "t_abstract_column",
    name = ccb.content.text("column"),
    looks_like = "t_rock_wall",
    description = ccb.content.text("A concrete column."),
    bash = {
        minimum_strength = 120,
        maximum_strength = 200,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_reb_cage",
        drops = { { item = "rock", count = { 10, 22 } } },
    },
}

ccb.content.define_terrain {
    id = "t_highlands_conqueror_statue",
    name = ccb.content.text("statue of a conqueror"),
    description = ccb.content.text("The regal countenance of this long-dead conqueror still gazes down upon the world, but only ruins remain of the empire they once built."),
    looks_like = "f_statue",
    copy_from = "t_column",
    bash = {
        minimum_strength = 120,
        maximum_strength = 200,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        terrain = "t_stone_masonry_floor",
        drops = { { item = "rock", count = { 10, 14 } } },
    },
}

ccb.content.define_terrain {
    id = "t_bollard",
    name = ccb.content.text("bollard"),
    looks_like = "t_fence_post",
    description = ccb.content.text("A set of concrete and steel bollards sticking out of the ground, designed to protect areas against vehicle ram attacks.  It requires a few more steps for you to walk between the bollards."),
    symbol = "1",
    color = "light_gray",
    move_cost = 6,
    coverage = 20,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "TRANSPARENT", "WALL", "SHORT", "PERMEABLE", "THIN_OBSTACLE" },
    bash = {
        minimum_strength = 350,
        maximum_strength = 650,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_sidewalk",
        drops = { { item = "rock", count = { 6, 13 } }, { item = "mc_steel_chunk", count = { 1, 3 } } },
    },
}

ccb.content.define_terrain {
    id = "t_support_l",
    name = ccb.content.text("large metal support"),
    looks_like = "t_wall_metal",
    description = ccb.content.text("A heavy-duty metal support beam."),
    symbol = "T",
    color = "light_gray",
    move_cost = 0,
    coverage = 80,
    roof = "t_metal_flat_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "WALL", "REDUCE_SCENT", "SUPPORTS_ROOF", "MINEABLE" },
    bash = {
        minimum_strength = 40,
        maximum_strength = 200,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_concrete",
        drops = {
            { item = "mc_steel_lump", count = { 0, 2 } },
            { item = "mc_steel_chunk", count = { 2, 6 } },
            { item = "scrap", count = { 5, 18 } },
        },
    },
    deconstruct = {
        terrain = "t_concrete",
        drops = {
            { item = "frame", count = { 6, 8 } },
            { item = "mc_steel_lump", count = { 1, 2 } },
            { item = "mc_steel_chunk", count = { 1, 6 } },
            { item = "scrap", count = { 4, 8 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_support_s",
    name = ccb.content.text("small metal support"),
    looks_like = "t_support_l",
    description = ccb.content.text("A metal support beam."),
    symbol = "l",
    color = "light_gray",
    move_cost = 0,
    coverage = 55,
    roof = "t_metal_flat_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "WALL", "PERMEABLE", "SUPPORTS_ROOF", "MINEABLE" },
    bash = {
        minimum_strength = 20,
        maximum_strength = 120,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_concrete",
        drops = {
            { item = "mc_steel_lump", chance = 50 },
            { item = "mc_steel_chunk", count = { 1, 3 } },
            { item = "scrap", count = { 2, 9 } },
        },
    },
    deconstruct = {
        terrain = "t_concrete",
        drops = {
            { item = "pipe", count = { 4, 6 } },
            { item = "mc_steel_lump", count = { 1, 2 } },
            { item = "mc_steel_chunk", count = { 1, 6 } },
            { item = "scrap", count = { 2, 4 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_drystone_wall",
    copy_from = "t_abstract_wall_stone",
    name = ccb.content.text("field stone wall"),
    looks_like = "t_rock_wall",
    description = ccb.content.text("A sturdy, dry stone wall.  Just rocks fitted together without mortar."),
    roof = "t_drystone_roof",
    bash = {
        minimum_strength = 50,
        maximum_strength = 200,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = {
            { item = "field_stone", count = { 500, 800 } },
            { item = "rock", count = { 200, 400 } },
            { item = "pebble", count = { 100, 200 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_drystone_wall_half",
    looks_like = "t_rock_wall_half",
    name = ccb.content.text("field stone half-wall"),
    description = ccb.content.text("A sturdy, half-height, dry stone wall.  Just rocks fitted together without mortar."),
    symbol = "#",
    color = "light_gray",
    move_cost = 0,
    coverage = 60,
    builtin_examine = "chainfence",
    flags = {
        "TRANSPARENT",
        "NOITEM",
        "REDUCE_SCENT",
        "MOUNTABLE",
        "MINEABLE",
        "THIN_OBSTACLE",
        "SHORT",
        "CLIMBABLE",
        "BURROWABLE",
        "PERMEABLE",
    },
    connect_groups = "WALL",
    connects_to = "WALL",
    bash = {
        minimum_strength = 30,
        maximum_strength = 120,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        drops = {
            { item = "field_stone", count = { 200, 300 } },
            { item = "rock", count = { 200, 400 } },
            { item = "pebble", count = { 100, 200 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_pillar",
    copy_from = "t_column",
    name = ccb.content.text("pillar"),
    description = ccb.content.text("A concrete column that helps keep the mine's ceiling and walls from collapsing."),
}

ccb.content.define_terrain {
    id = "t_foam_wall",
    copy_from = "t_abstract_wall_concrete",
    name = ccb.content.text("hardened resin mass"),
    looks_like = "t_wax",
    color = "white",
    flags = { "NOITEM", "MINEABLE", "SUPPORTS_ROOF", "WALL", "MINEABLE" },
    roof = "t_foam_roof",
    description = ccb.content.text("A mass of expansive foam that has hardened like a rock, tough enough to stop most zombies from breaking through.  It's big enough to walk on top of."),
    bash = {
        minimum_strength = 38,
        maximum_strength = 120,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
    },
}

ccb.content.define_terrain {
    id = "t_wood_sunshade_pole",
    name = ccb.content.text("wooden pole"),
    description = ccb.content.text("A wooden pole supporting a canvas sunshade."),
    color = "brown",
    symbol = "1",
    move_cost = 0,
    coverage = 80,
    flags = { "WALL", "PERMEABLE" },
    bash = {
        minimum_strength = 20,
        maximum_strength = 30,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_dirt",
        drops = { { item = "splinter", count = { 10, 22 } } },
    },
}
