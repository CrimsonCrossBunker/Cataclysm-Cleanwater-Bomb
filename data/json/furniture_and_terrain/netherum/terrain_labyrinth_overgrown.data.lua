local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_nl_metal_wall_overgrown",
    name = ccb.content.text("overgrown metal wall"),
    description = ccb.content.text("A durable wall of sheet metal with fractal welds and joins.  All manner of strange, plastic-like plants are poking their way through the crevices.  The plants glow and hum like old, dim fluorescent lights."),
    symbol = "#",
    color = "green",
    move_cost = 0,
    coverage = 100,
    light_emitted = 5,
    light_color = { 240, 245, 200 },
    roof = "t_nl_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "MINEABLE", "BLOCK_WIND" },
    oxytorch = {
        result = "t_nl_broken_metal_floor",
        duration = "24 seconds",
        byproducts = {
            { item = "steel_plate", count = { 2, 3 } },
            { item = "steel_chunk", count = { 12, 20 } },
        },
    },
    bash = {
        minimum_strength = 150,
        maximum_strength = 400,
        sound = ccb.content.text("metal wailing!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_nl_broken_metal_floor",
        drops = {
            { item = "steel_lump", count = { 1, 4 } },
            { item = "steel_chunk", count = { 3, 12 } },
            { item = "scrap", count = { 9, 36 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_nl_metal_floor_overgrown",
    name = ccb.content.text("overgrown metallic floor"),
    description = ccb.content.text("Flooring made of rectangular metal tiles.  Something seems off about the spaces between; you keep imagining that the gaps spell out words, but when you look closer they're in very ordinary patterns.  Beyond that, small blades of glowing, plastic grass are forcing their way through the cracks."),
    symbol = ".",
    color = "light_cyan",
    connect_groups = "METALFLOOR",
    connects_to = "METALFLOOR",
    looks_like = "t_metal_floor",
    move_cost = 2,
    roof = "t_nl_roof",
    flags = { "TRANSPARENT", "INDOORS", "FLAT", "ROAD" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_nl_broken_metal_floor",
        minimum_strength = 200,
        maximum_strength = 500,
        minimum_strength_supported = 200,
        drops = { { item = "steel_chunk", count = { 2, 4 } }, { item = "scrap", count = { 1, 3 } } },
    },
}

ccb.content.define_terrain {
    id = "t_nl_metal_floor_grass",
    copy_from = "t_natural_floor_abstract",
    looks_like = "t_grass",
    name = ccb.content.text("cybergrass"),
    description = ccb.content.text("An area of metallic flooring covered in bladed, plastic grass, about ankle high.  The blades are softly glowing."),
    color = "green",
    light_emitted = 5,
    light_color = { 240, 245, 200 },
    transforms_into = "t_grass_grazed",
    extend = { flags = { "PLOWABLE", "GRAZABLE" } },
}

ccb.content.define_terrain {
    id = "t_nl_metal_floor_grass_long",
    copy_from = "t_nl_grass",
    looks_like = "t_grass_long",
    name = ccb.content.text("long cybergrass"),
    description = ccb.content.text("An area of shattered metallic flooring and dirt covered in long, shaggy, plastic grass about shin high.  The blades are softly glowing.  They move on their own, angling away from things that disturb them."),
    transforms_into = "t_nl_grass",
    symbol = ",",
    light_emitted = 5,
    light_color = { 240, 245, 200 },
    extend = { flags = { "SMALL_HIDE" } },
}

ccb.content.define_terrain {
    id = "t_nl_metal_floor_grass_tall",
    copy_from = "t_nl_grass_long",
    looks_like = "t_grass_long",
    name = ccb.content.text("tall cybergrass"),
    description = ccb.content.text("An area of shattered metallic flooring and dirt covered in tall, plastic grass, about head high.  The long blades glow and hum like old, dim fluorescent lights."),
    transforms_into = "t_nl_grass_long",
    symbol = "'",
    move_cost = 5,
    coverage = 50,
}

ccb.content.define_terrain {
    id = "t_nl_grass",
    copy_from = "t_natural_floor_abstract",
    looks_like = "t_grass",
    name = ccb.content.text("cybergrass"),
    description = ccb.content.text("An area of shining dirt covered in bladed, plastic grass, about ankle high.  The blades are softly glowing."),
    color = "green",
    light_emitted = 5,
    light_color = { 240, 245, 200 },
    transforms_into = "t_grass_grazed",
    extend = { flags = { "PLOWABLE", "GRAZABLE" } },
}

ccb.content.define_terrain {
    id = "t_nl_grass_long",
    copy_from = "t_nl_grass",
    looks_like = "t_grass_long",
    name = ccb.content.text("long cybergrass"),
    description = ccb.content.text("An area of shining dirt covered in long, shaggy, plastic grass about shin high.  The blades are softly glowing.  They move on their own, angling away from things that disturb them."),
    transforms_into = "t_nl_grass",
    symbol = ",",
    light_emitted = 5,
    light_color = { 240, 245, 200 },
    extend = { flags = { "SMALL_HIDE" } },
}

ccb.content.define_terrain {
    id = "t_nl_grass_tall",
    copy_from = "t_nl_grass_long",
    looks_like = "t_grass_long",
    name = ccb.content.text("tall cybergrass"),
    description = ccb.content.text("An area of shining dirt covered in tall, plastic grass, about head high.  The long blades glow and hum like old, dim fluorescent lights."),
    transforms_into = "t_nl_grass_long",
    symbol = "'",
    move_cost = 5,
    coverage = 50,
}

ccb.content.define_terrain {
    id = "t_nl_soil",
    copy_from = "t_abstract_wall_earthen",
    name = ccb.content.text("solid earth"),
    description = ccb.content.text("A wall of solid earth, you think, but full of small, sparkling grains, which seem to twist at the edge of your vision."),
    extend = { flags = { "NATURAL_UNDERGROUND" } },
    delete = { flags = { "AUTO_WALL_SYMBOL" } },
    roof = "t_nl_dirt",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("wham!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_nl_dirt",
        terrain_from_above = "t_nl_dirt",
        drops = { { group = "digging_soil_loam_50L", count = 20 } },
    },
}

ccb.content.define_terrain {
    id = "t_nl_rock",
    copy_from = "t_abstract_wall_earthen",
    name = ccb.content.text("mysterious cavern wall"),
    looks_like = "t_rock",
    description = ccb.content.text("A wall of solid rock, or is it?  Despite its color and surface topology, it bares the striations and density of petrified wood."),
    color = "white",
    extend = { flags = { "NATURAL_UNDERGROUND" } },
    delete = { flags = { "AUTO_WALL_SYMBOL" } },
    roof = "t_rock_floor_no_roof",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_nl_rock_floor",
        terrain_from_above = "t_rock_floor_no_roof",
        drops = { { group = "mining_rock", count = 1 } },
    },
}

ccb.content.define_terrain {
    id = "t_nl_rock_floor",
    name = ccb.content.text("mysterious cavern"),
    looks_like = "t_rock_floor",
    description = ccb.content.text("A relatively flat area of rock and stone, or is it?  Despite its color and surface topology, it bares the striations and density of petrified wood."),
    symbol = ".",
    color = "light_gray",
    connect_groups = { "INDOORFLOOR", "ROCKFLOOR" },
    connects_to = "ROCKFLOOR",
    move_cost = 2,
    roof = "t_rock_roof",
    flags = { "TRANSPARENT", "INDOORS", "COLLAPSES", "SUPPORTS_ROOF", "FLAT", "ROAD" },
    bash = {
        terrain = "t_nl_chasm",
        minimum_strength = 75,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_nl_dirt",
    name = ccb.content.text("sparkling dirt"),
    looks_like = "t_dirt",
    description = ccb.content.text("It's dirt, you think, but full of small, sparkling grains, which seem to twist at the edge of your vision."),
    symbol = ".",
    color = "brown",
    light_emitted = 1,
    connect_groups = { "DIRT", "INDOORFLOOR" },
    connects_to = "DIRT",
    move_cost = 2,
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD", "PLOWABLE", "DIGGABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_nl_shrub_glowberries",
    copy_from = "t_shrub_abstract",
    name = ccb.content.text("glowberry bush"),
    description = ccb.content.text("This lifelike plant seems to be entirely made of plastic.  At its base are copper wires, whirled and gnarled like roots.  It glows softly, like a dim fluorescent bulb.  Despite its otherworldly nature, very real looking berries are hanging from the stems."),
    color = "light_red_green",
    light_emitted = 20,
    light_color = { 242, 230, 255 },
    transforms_into = "t_nl_shrub_glowberries_harvested",
    looks_like = "t_alien_meadow_shrub_2",
    builtin_examine = "harvest_ter_nectar",
    harvest_by_season = {
        { seasons = { "summer", "spring", "winter", "autumn" }, harvest = "nl_shrub_glowberries_harv" },
    },
}

ccb.content.define_terrain {
    id = "t_nl_shrub_glowberries_harvested",
    copy_from = "t_nl_shrub_glowberries",
    description = ccb.content.text("At first glance this appears to be a simple bush, but closer inspection reveals that the plant seems to be entirely plastic, but of the most realistic design you have ever seen.  It glows softly, like a dim fluorescent bulb."),
    color = "red_green",
    light_emitted = 20,
    light_color = { 242, 230, 255 },
    extend = { flags = { "HARVESTED" } },
    looks_like = "t_alien_meadow_shrub_2_harvested",
    transforms_into = "t_nl_shrub_glowberries",
    builtin_examine = "harvested_plant",
}
