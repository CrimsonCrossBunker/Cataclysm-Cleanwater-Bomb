local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_lichen",
    name = ccb.content.text("lichen"),
    description = ccb.content.text("Many colorful species of ice-lichen, thriving above an uncharacteristically fertile segment of ice.  Either endemic, or surviving genecraft from an aborted terraforming project."),
    symbol = ".",
    looks_like = "t_underbrush_harvested",
    color = "light_red",
    move_cost = 2,
    coverage = 40,
    flags = { "DIGGABLE", "FLAT", "FLAMMABLE_ASH", "TRANSPARENT" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 30,
        sound = ccb.content.text("splosh."),
        failure_sound = ccb.content.text("brush."),
        terrain = "t_ice",
    },
}

ccb.content.define_terrain {
    id = "t_lichendirt",
    name = ccb.content.text("lichen bed"),
    description = ccb.content.text("Familiar, yet unfamiliar.  Lichens and moss cling to rocks and lifeless dirt here, providing a squishy but colorful grass."),
    symbol = ",",
    looks_like = "t_underbrush_harvested",
    color = "light_red",
    move_cost = 3,
    coverage = 40,
    flags = { "DIGGABLE", "FLAT", "FLAMMABLE_ASH", "TRANSPARENT" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 30,
        sound = ccb.content.text("splosh."),
        failure_sound = ccb.content.text("brush."),
        terrain = "t_deaddirt",
    },
}

ccb.content.define_terrain {
    id = "t_ice",
    name = ccb.content.text("glacial ice"),
    looks_like = "t_dirt_season_winter",
    description = ccb.content.text("A small segment from the near planet-wide glacier of Salus IV.  Gets called 'ground' around these parts."),
    symbol = ".",
    color = "light_blue",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "SNOW_SOURCE", "FLAT", "ROUGH" },
    bash = {
        minimum_strength = 800,
        maximum_strength = 1000,
        sound = ccb.content.text("splosh!"),
        failure_sound = ccb.content.text("fweet!"),
        terrain = "t_null",
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_deaddirt",
    name = ccb.content.text("dirt"),
    looks_like = "t_dirt_season_winter",
    description = ccb.content.text("A relatively flat area of black dirt with no observable growth on it, caked with shards of rock.  The only real ground besides the glacial ice."),
    symbol = ".",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "ROUGH" },
    bash = {
        minimum_strength = 50,
        maximum_strength = 100,
        sound = ccb.content.text("splosh!"),
        failure_sound = ccb.content.text("fweet!"),
        terrain = "t_null",
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_basaltfloor",
    name = ccb.content.text("basalt floor"),
    looks_like = "t_dirt_season_winter",
    description = ccb.content.text("A relatively flat area of gray stone, warm to the touch."),
    symbol = ".",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "ROUGH" },
    bash = {
        minimum_strength = 50,
        maximum_strength = 100,
        sound = ccb.content.text("splosh!"),
        failure_sound = ccb.content.text("fweet!"),
        terrain = "t_null",
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_furniture {
    id = "f_geo_vent",
    name = ccb.content.text("geothermal vent"),
    description = ccb.content.text("A basalt column stands here, perpetually emitting foul-smelling gas, similar to rotten eggs.  It is very warm to the touch, hot enough to burn you if you aren't careful."),
    symbol = "O",
    color = "light_gray",
    move_cost_mod = -1,
    coverage = 65,
    required_strength = -1,
    flags = { "NOITEM", "MINEABLE", "BLOCK_WIND" },
    emissions = { "emit_smoke_plume", "afs_emit_geovent" },
    bash = {
        minimum_strength = 65,
        maximum_strength = 160,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = {
            { item = "rock", count = { 10, 22 } },
            { item = "sharp_rock", count = { 3, 7 } },
            { item = "material_limestone", count = { 2, 5 }, chance = 30 },
            { item = "material_rocksalt", count = { 0, 1 }, chance = 10 },
            { item = "material_rhodonite", count = { 0, 1 }, chance = 1 },
            { item = "material_zincite", count = { 0, 5 }, chance = 2 },
        },
    },
}

ccb.content.define_terrain {
    id = "t_fuma_ice",
    name = ccb.content.text("fumarolic ice tower"),
    description = ccb.content.text("A solid cloud-like structure, formed when water vapor escapes from the crust and meets the freezing air.  It is still emitting some gases."),
    symbol = "T",
    color = "white",
    move_cost = 0,
    coverage = 80,
    flags = { "NOITEM", "MINEABLE", "BLOCK_WIND" },
    emissions = { "emit_smoke_plume", "afs_emit_geovent" },
    bash = {
        minimum_strength = 45,
        maximum_strength = 140,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        terrain = "t_fumarole",
    },
}

ccb.content.define_terrain {
    id = "t_fuma_ice_ina",
    name = ccb.content.text("fumarolic ice tower"),
    description = ccb.content.text("A solid cloud-like structure, formed when water vapor escapes from the crust and meets the freezing air."),
    symbol = "T",
    color = "white",
    move_cost = 0,
    coverage = 80,
    flags = { "NOITEM", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 45,
        maximum_strength = 140,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        terrain = "t_fumarole",
    },
}

ccb.content.define_terrain {
    id = "t_fumarole",
    name = ccb.content.text("fumarole"),
    description = ccb.content.text("A hole in the ground from which steam and other gases are escaping."),
    symbol = ".",
    color = "white",
    move_cost = 10,
    flags = { "TRANSPARENT", "FLAT", "ROUGH" },
    emissions = { "emit_smoke_plume", "afs_emit_geovent" },
}

ccb.content.define_furniture {
    id = "f_basaltspike",
    name = ccb.content.text("basalt rocks"),
    description = ccb.content.text("Various sharp rocks jut out of the ground here."),
    symbol = "#",
    color = "cyan",
    move_cost_mod = 6,
    max_volume = "750 L",
    required_strength = -1,
    flags = { "TRANSPARENT", "UNSTABLE", "ROUGH", "SHARP", "PLACE_ITEM", "MOUNTABLE", "SHORT", "RUBBLE" },
    bash = {
        minimum_strength = 65,
        maximum_strength = 160,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock", count = { 3, 4 } }, { item = "sharp_rock", count = { 1, 2 } } },
    },
}

ccb.content.define_terrain {
    id = "t_polluted_snow",
    name = ccb.content.text("toxic snow"),
    looks_like = "t_dirt_season_winter",
    description = ccb.content.text("Snow freely mingles with industrial runoff, forming orange patches of toxic slush."),
    symbol = ".",
    color = "light_red",
    move_cost = 2,
    emissions = { "weak_toxic_dust" },
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "ROUGH" },
    bash = {
        minimum_strength = 8,
        maximum_strength = 100,
        sound = ccb.content.text("splosh!"),
        failure_sound = ccb.content.text("fweet!"),
        terrain = "t_ice",
        minimum_strength_supported = 100,
    },
}

ccb.content.define_terrain {
    id = "t_snow",
    name = ccb.content.text("snow"),
    looks_like = "t_dirt_season_winter",
    description = ccb.content.text("A patch of thick snow, very cold."),
    symbol = ".",
    color = "light_blue",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "SNOW_SOURCE", "FLAT", "ROUGH" },
    bash = {
        minimum_strength = 8,
        maximum_strength = 100,
        sound = ccb.content.text("splosh!"),
        failure_sound = ccb.content.text("fweet!"),
        terrain = "t_ice",
        minimum_strength_supported = 100,
    },
}

ccb.content.define_terrain {
    id = "t_snow_metal_floor",
    name = ccb.content.text("snow"),
    looks_like = "t_snow",
    description = ccb.content.text("A patch of thick snow, very cold."),
    symbol = ".",
    color = "light_blue",
    move_cost = 2,
    flags = { "TRANSPARENT", "SNOW_SOURCE", "FLAT", "ROUGH" },
    bash = {
        minimum_strength = 8,
        maximum_strength = 100,
        sound = ccb.content.text("splosh!"),
        failure_sound = ccb.content.text("fweet!"),
        terrain = "t_metal_floor",
        minimum_strength_supported = 100,
    },
}

ccb.content.define_terrain {
    id = "t_snowrock",
    name = ccb.content.text("snow"),
    looks_like = "t_dirt_season_winter",
    description = ccb.content.text("A patch of thick snow on top of rocks, very cold."),
    symbol = ".",
    color = "light_blue",
    move_cost = 4,
    flags = { "TRANSPARENT", "DIGGABLE", "SNOW_SOURCE", "FLAT" },
    bash = {
        minimum_strength = 8,
        maximum_strength = 100,
        sound = ccb.content.text("splosh!"),
        failure_sound = ccb.content.text("fweet!"),
        terrain = "t_basaltfloor",
        minimum_strength_supported = 100,
    },
}

ccb.content.define_terrain {
    id = "t_snow_roof",
    name = ccb.content.text("snow"),
    looks_like = "t_dirt_season_winter",
    description = ccb.content.text("A patch of thick snow, very cold."),
    symbol = ".",
    color = "light_blue",
    move_cost = 4,
    flags = { "TRANSPARENT", "DIGGABLE", "SNOW_SOURCE", "FLAT" },
    bash = {
        minimum_strength = 80,
        maximum_strength = 100,
        sound = ccb.content.text("splosh!"),
        failure_sound = ccb.content.text("fweet!"),
        terrain = "t_null",
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_basalt_wall",
    name = ccb.content.text("basalt wall"),
    looks_like = "t_rock",
    description = ccb.content.text("A sturdy basalt wall."),
    symbol = "#",
    color = "light_gray",
    move_cost = 0,
    coverage = 100,
    roof = "t_basaltfloor",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "MINEABLE", "BLOCK_WIND" },
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
    id = "t_ice_wall",
    name = ccb.content.text("glacial ice wall"),
    description = ccb.content.text("A solid wall of glacial ice."),
    symbol = "#",
    color = "light_blue",
    move_cost = 0,
    coverage = 100,
    roof = "t_ice",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 50,
        maximum_strength = 100,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_ice",
    },
}

ccb.content.define_terrain {
    id = "t_snow_wall",
    name = ccb.content.text("snow wall"),
    description = ccb.content.text("A solid mass of piled snow."),
    symbol = "#",
    color = "white",
    move_cost = 0,
    coverage = 100,
    roof = "t_snow_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 50,
        maximum_strength = 100,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_snowslope_down",
    name = ccb.content.text("downward snow slope"),
    description = ccb.content.text("A downward-facing slope of snow."),
    symbol = ">",
    color = "white",
    move_cost = 2,
    flags = { "TRANSPARENT", "RAMP_DOWN", "PLACE_ITEM" },
}

ccb.content.define_terrain {
    id = "t_snowslope_up",
    name = ccb.content.text("upward snow slope"),
    description = ccb.content.text("An upward-facing slope of snow."),
    symbol = "<",
    color = "white",
    move_cost = 2,
    flags = { "TRANSPARENT", "RAMP_UP", "PLACE_ITEM" },
}

ccb.content.define_terrain {
    id = "t_iceslope_down",
    name = ccb.content.text("downward glacial ice slope"),
    description = ccb.content.text("A downward-facing glacial slope."),
    symbol = ">",
    color = "light_blue",
    move_cost = 2,
    flags = { "TRANSPARENT", "RAMP_DOWN", "PLACE_ITEM" },
}

ccb.content.define_terrain {
    id = "t_iceslope_up",
    name = ccb.content.text("upward glacial ice slope"),
    description = ccb.content.text("An upward-facing glacial slope."),
    symbol = "<",
    color = "light_blue",
    move_cost = 2,
    flags = { "TRANSPARENT", "RAMP_UP", "PLACE_ITEM" },
}

ccb.content.define_terrain {
    id = "t_basaltslope_down",
    name = ccb.content.text("downward basalt slope"),
    description = ccb.content.text("A downward-facing slope of basalt."),
    symbol = ">",
    color = "light_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "RAMP_DOWN", "PLACE_ITEM" },
}

ccb.content.define_terrain {
    id = "t_basaltslope_up",
    name = ccb.content.text("upward basalt slope"),
    description = ccb.content.text("An upward-facing slope of basalt."),
    symbol = "<",
    color = "light_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "RAMP_UP", "PLACE_ITEM" },
}

ccb.content.define_furniture {
    id = "f_snow_small",
    name = ccb.content.text("small snow mound"),
    description = ccb.content.text("A small pile of snow."),
    symbol = "o",
    color = "light_blue",
    move_cost_mod = 3,
    coverage = 30,
    required_strength = 10,
    flags = { "TRANSPARENT", "UNSTABLE", "MOUNTABLE", "TINY" },
    bash = {
        minimum_strength = 8,
        maximum_strength = 40,
        sound = ccb.content.text("flump!"),
        failure_sound = ccb.content.text("thump."),
    },
}

ccb.content.define_furniture {
    id = "f_snow_medium",
    name = ccb.content.text("snow mound"),
    description = ccb.content.text("A large pile of snow"),
    symbol = "0",
    color = "light_blue",
    move_cost_mod = 6,
    coverage = 45,
    required_strength = 16,
    flags = { "NOITEM", "TRANSPARENT", "UNSTABLE", "MOUNTABLE", "SHORT", "CLIMBABLE" },
    bash = {
        minimum_strength = 12,
        maximum_strength = 80,
        sound = ccb.content.text("flump!"),
        failure_sound = ccb.content.text("thump."),
    },
}

ccb.content.define_furniture {
    id = "f_snow_large",
    name = ccb.content.text("large snow mound"),
    description = ccb.content.text("A large pile of snow blocks your path here."),
    symbol = "O",
    color = "white",
    move_cost_mod = -1,
    coverage = 65,
    required_strength = 20,
    flags = { "NOITEM", "BLOCK_WIND" },
    bash = {
        minimum_strength = 24,
        maximum_strength = 160,
        sound = ccb.content.text("flump!"),
        failure_sound = ccb.content.text("thump."),
    },
}

ccb.content.define_furniture {
    id = "f_icebold_small",
    name = ccb.content.text("small ice boulder"),
    description = ccb.content.text("A small chunk of ice sits in the ground here."),
    symbol = "o",
    color = "light_blue",
    move_cost_mod = 3,
    coverage = 30,
    required_strength = 10,
    flags = { "TRANSPARENT", "MINEABLE", "UNSTABLE", "MOUNTABLE", "TINY" },
    bash = {
        minimum_strength = 16,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
    },
}

ccb.content.define_furniture {
    id = "f_icebold_medium",
    name = ccb.content.text("ice boulder"),
    description = ccb.content.text("A large chunk of ice juts out of the ground here."),
    symbol = "0",
    color = "light_blue",
    move_cost_mod = 6,
    coverage = 45,
    required_strength = 16,
    flags = { "NOITEM", "TRANSPARENT", "MINEABLE", "UNSTABLE", "MOUNTABLE", "SHORT" },
    bash = {
        minimum_strength = 32,
        maximum_strength = 80,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
    },
}

ccb.content.define_furniture {
    id = "f_icebold_large",
    name = ccb.content.text("large ice boulder"),
    description = ccb.content.text("A large piece of glacial ice stands here, blocking your path."),
    symbol = "O",
    color = "light_blue",
    move_cost_mod = -1,
    coverage = 65,
    required_strength = 32,
    flags = { "NOITEM", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 64,
        maximum_strength = 160,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
    },
}

ccb.content.define_furniture {
    id = "f_snow_bowl",
    name = ccb.content.text("snow bowl"),
    symbol = "o",
    description = ccb.content.text("A small depression dug from mostly clean snow.  Can hold small amounts of liquid."),
    color = "white",
    move_cost_mod = 2,
    coverage = 30,
    required_strength = -1,
    flags = {
        "TRANSPARENT",
        "FLAMMABLE_HARD",
        "CONTAINER",
        "PLACE_ITEM",
        "LIQUIDCONT",
        "UNSTABLE",
        "MOUNTABLE",
        "TINY",
    },
    max_volume = "8 L",
    builtin_examine = "keg",
    keg_capacity = "8 L",
}

ccb.content.define_terrain {
    id = "t_moxfloor",
    name = ccb.content.text("bleached coral floor"),
    description = ccb.content.text("Small outgrowths of white coral spring from an underlying lattice of black, pulsating veins."),
    symbol = ".",
    looks_like = "t_fungus",
    color = "light_red",
    move_cost = 3,
    coverage = 40,
    flags = { "DIGGABLE", "FLAT", "ROUGH", "FLAMMABLE_ASH", "TRANSPARENT" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 30,
        sound = ccb.content.text("splosh."),
        failure_sound = ccb.content.text("brush."),
        terrain = "t_deaddirt",
    },
}

ccb.content.define_terrain {
    id = "t_toxic_water",
    name = ccb.content.text("toxic sewage"),
    description = ccb.content.text("A pond of rust colored water, a thin sheen of iridescent murk reflects light across its surface.  Even brief immersion is likely to prove fatal."),
    symbol = "~",
    looks_like = "t_water_murky",
    emissions = { "weak_toxic_dust" },
    color = "light_red",
    move_cost = 6,
    liquid_source = { item = "water_sewage", minimum_temperature = 18 },
    flags = { "TRANSPARENT", "SWIMMABLE", "SHALLOW_WATER" },
    builtin_examine = "water_source",
}
