local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_bigmirror",
    name = ccb.content.text("standing mirror"),
    symbol = "{",
    description = ccb.content.text("A full-length mirror mounted in a sleek aluminum frame.  You can easily see all of the dirt and blood on your clothes, and the weariness in your eyes."),
    color = "white",
    move_cost_mod = 2,
    coverage = 80,
    required_strength = 5,
    mass = "13 kg",
    crafting_pseudo_item = "mirror",
    flags = { "NOITEM", "BLOCKSDOOR", "EASY_DECONSTRUCT" },
    builtin_examine = "change_appearance",
    deconstruct = { drops = { { item = "bigmirror", count = 1 } } },
    bash = {
        minimum_strength = 5,
        maximum_strength = 16,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        furniture = "f_bigmirror_b",
        drops = { { item = "glass_shard", count = { 121, 131 } } },
    },
}

ccb.content.define_furniture {
    id = "f_bigmirror_b",
    name = ccb.content.text("broken standing mirror"),
    description = ccb.content.text("An aluminum frame for a full-length mirror, with most of the mirror missing.  What remains in the frame are large, dangerous-looking shards of fractured glass."),
    symbol = "{",
    color = "light_gray",
    move_cost_mod = 2,
    coverage = 80,
    required_strength = 5,
    mass = "9 kg",
    flags = { "NOITEM", "BLOCKSDOOR" },
    bash = {
        minimum_strength = 8,
        maximum_strength = 30,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "scrap_aluminum", count = { 7, 10 } },
            { item = "glass_shard", count = { 26, 46 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_bitts",
    name = ccb.content.text("bitts"),
    description = ccb.content.text("A pair of vertical iron posts mounted on a wharf, pier, or other form of dock.  They are used to secure mooring lines, ropes, and similar."),
    symbol = "B",
    color = "light_gray",
    move_cost_mod = 2,
    coverage = 30,
    required_strength = -1,
    bash = {
        minimum_strength = 80,
        maximum_strength = 200,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = { { item = "lc_steel_chunk", count = { 5, 10 } } },
    },
    flags = { "TRANSPARENT", "MOUNTABLE", "SHORT" },
}

ccb.content.define_furniture {
    id = "f_cleat",
    name = ccb.content.text("cleat"),
    description = ccb.content.text("A small horn cleat with two \"horns\" extending parallel to the deck or the axis of the spar, and resembling a small anvil.  They are used to secure mooring lines, ropes, and similar."),
    symbol = "B",
    color = "light_gray",
    looks_like = "f_bitts",
    move_cost_mod = 2,
    coverage = 30,
    required_strength = -1,
    bash = {
        minimum_strength = 80,
        maximum_strength = 200,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = { { item = "lc_steel_chunk", count = { 1, 3 } } },
    },
    flags = { "TRANSPARENT", "SHORT" },
}

ccb.content.define_furniture {
    id = "f_shackle",
    name = ccb.content.text("manacles"),
    description = ccb.content.text("A pair of metal shackles with heavy chains mounted to a wall or floor."),
    symbol = "8",
    color = "light_gray",
    move_cost_mod = 1,
    required_strength = -1,
    flags = { "TRANSPARENT", "ALLOW_FIELD_EFFECT", "MOUNTABLE", "SHORT" },
    bash = {
        minimum_strength = 18,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("crack."),
        drops = { { item = "chain", count = { 0, 2 } } },
    },
}

ccb.content.define_furniture {
    id = "f_statue",
    name = ccb.content.text("statue"),
    description = ccb.content.text("A massive block of stone that has been carefully carved into a work of timeless art."),
    symbol = "S",
    color = "dark_gray",
    move_cost_mod = -1,
    coverage = 50,
    required_strength = 10,
    mass = "100 kg",
    flags = { "PLACE_ITEM", "BLOCKSDOOR", "MINEABLE", "SIGN" },
    bash = {
        minimum_strength = 16,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock", count = { 1, 6 } } },
    },
}

ccb.content.define_furniture {
    id = "f_highlands_holy_statue",
    name = ccb.content.text("statue"),
    description = ccb.content.text("All fine details have been eroded away by the passing of time, leaving only a rough humanoid shape carved from dark stone."),
    looks_like = "f_statue",
    copy_from = "f_statue",
    bash = {
        minimum_strength = 16,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = {
            { item = "rock", count = { 10, 14 } },
            { item = "skull_human", count = 1 },
            { item = "bone_human", count = { 4, 8 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_highlands_gatekeeper_statue",
    name = ccb.content.text("statue of a gatekeeper"),
    description = ccb.content.text("A demonic figure carved from dark stone stands guard over the bronze pillars ahead.  It holds a bronze censer with one outstretched hand, while the other points upwards into the sky."),
    looks_like = "f_statue",
    copy_from = "f_statue",
    bash = {
        minimum_strength = 16,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock", count = { 10, 14 } }, { item = "highland_censer", count = 1 } },
    },
}

ccb.content.define_furniture {
    id = "f_mannequin",
    name = ccb.content.text("mannequin"),
    description = ccb.content.text("A life-size wooden figure of a person, most commonly used to display clothing in stores, or for tailors to design outfits on.  Considering all that's happened, something about it is somewhat unnerving."),
    symbol = "@",
    color = "brown",
    move_cost_mod = 2,
    coverage = 40,
    required_strength = 5,
    mass = "10 kg",
    flags = { "PLACE_ITEM", "TRANSPARENT", "FLAMMABLE", "EASY_DECONSTRUCT" },
    deployed_item = "mannequin",
    base_item = "mannequin",
    builtin_examine = "deployed_furniture",
    bash = {
        minimum_strength = 6,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("whump."),
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_birdbath",
    name = ccb.content.text("birdbath"),
    description = ccb.content.text("A wide stone bowl mounted to a pedestal, usually filled with rainwater, meant for birds to play or bathe in."),
    symbol = "o",
    color = "light_gray",
    move_cost_mod = -1,
    required_strength = 10,
    mass = "40 kg",
    flags = { "PLACE_ITEM", "BLOCKSDOOR", "MINEABLE", "LIQUIDCONT", "TRANSPARENT" },
    bash = {
        minimum_strength = 16,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock", count = { 1, 6 } }, { item = "rebar", count = { 1, 2 } } },
    },
}

ccb.content.define_furniture {
    id = "f_gazing_ball",
    name = ccb.content.text("gazing ball"),
    description = ccb.content.text("A mirrored glass globe mounted on a cement pedestal.  It warps your reflection when you look into it."),
    symbol = "o",
    color = "white",
    move_cost_mod = -1,
    required_strength = 10,
    mass = "40 kg",
    flags = { "BLOCKSDOOR", "MINEABLE" },
    bash = {
        minimum_strength = 16,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = {
            { item = "rock", count = { 2, 4 } },
            { item = "rebar", count = { 0, 1 } },
            { item = "glass_shard", count = { 10, 15 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_rotary_clothesline",
    name = ccb.content.text("rotary clothes dryer line"),
    description = ccb.content.text("A central metal pole holding up a wide rotating frame, this would be used to hang up clothes to dry in the sunlight."),
    symbol = "X",
    color = "white",
    move_cost_mod = -2,
    required_strength = 10,
    mass = "10 kg",
    flags = { "TRANSPARENT", "BLOCKSDOOR", "PLACE_ITEM" },
    deconstruct = {
        drops = {
            { item = "pipe", count = 6 },
            { item = "lc_steel_chunk", count = { 2, 6 } },
            { item = "pipe_fittings", count = { 1, 3 } },
            { item = "lc_wire", count = 10 },
        },
    },
    bash = {
        minimum_strength = 6,
        maximum_strength = 10,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "pipe", count = { 1, 6 } },
            { item = "lc_wire", count = { 1, 2 } },
            { item = "scrap", count = { 1, 6 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_floor_lamp",
    name = ccb.content.text("standing lamp"),
    symbol = "T",
    looks_like = "f_rack_coat",
    description = ccb.content.text("A light mounted on the top of a metal pole, this would be plugged into a wall socket to illuminate a room."),
    color = "light_gray",
    move_cost_mod = 2,
    required_strength = 1,
    mass = "2500 g",
    appliance_conversion = { furniture = "f_null", item = "standing_lamp" },
    flags = { "TRANSPARENT", "BLOCKSDOOR", "PLACE_ITEM", "EASY_DECONSTRUCT" },
    base_item = "standing_lamp",
    bash = {
        minimum_strength = 12,
        maximum_strength = 40,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("bonk!"),
    },
}

ccb.content.define_furniture {
    id = "f_lighthouse_light",
    name = ccb.content.text("lighthouse light"),
    description = ccb.content.text("Very high power, modern lighthouse LED light source with attached heatsinks."),
    symbol = "%",
    color = "light_gray",
    required_strength = -1,
    move_cost_mod = -1,
    deconstruct = {
        drops = { { item = "lightstrip_inactive" }, { item = "material_aluminium_ingot", count = 4 } },
    },
    bash = {
        minimum_strength = 18,
        maximum_strength = 80,
        sound = ccb.content.text("clang!"),
        failure_sound = ccb.content.text("ting."),
        drops = {
            { item = "material_aluminium_ingot", count = { 1, 4 } },
            { item = "e_scrap", count = { 1, 4 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_winter_wreath",
    name = ccb.content.text("pine wreath"),
    description = ccb.content.text("A decorative wreath for the winter holidays."),
    symbol = "o",
    color = "light_green",
    move_cost_mod = 2,
    required_strength = 5,
    mass = "7 kg",
    bash = {
        minimum_strength = 20,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = {
            { item = "pine_bough", count = { 4, 6 } },
            { item = "nail", charges = { 5, 14 } },
            { item = "stick", count = { 1, 3 } },
        },
    },
    flags = { "PERMEABLE", "THIN_OBSTACLE", "PLACE_ITEM", "EASY_DECONSTRUCT" },
}

ccb.content.define_furniture {
    id = "f_sand_castle",
    name = ccb.content.text("sand castle"),
    description = ccb.content.text("A glorious castle made of sand.  This mighty fortress will stand tall for the ages to come, a true testament to the skills of its builder."),
    symbol = "m",
    color = "yellow",
    move_cost_mod = 2,
    required_strength = -1,
    bash = {
        minimum_strength = 1,
        maximum_strength = 1,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "material_sand", count = 8 } },
    },
}

ccb.content.define_furniture {
    id = "f_decorative_tree",
    name = ccb.content.text("decorative tree"),
    description = ccb.content.text("A decorative pine tree littered with ornaments for the winter holidays."),
    symbol = "+",
    color = "light_green",
    looks_like = "t_tree_pine",
    move_cost_mod = -1,
    required_strength = 10,
    mass = "50 kg",
    flags = { "BLOCKSDOOR", "PLACE_ITEM", "EASY_DECONSTRUCT" },
    bash = {
        minimum_strength = 20,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = {
            { item = "pine_bough", count = { 4, 6 } },
            { item = "nail", charges = { 5, 14 } },
            { item = "stick", count = { 1, 3 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_styling_station",
    name = ccb.content.text("styling station"),
    symbol = "}",
    description = ccb.content.text("A styling station, is a countertop with a mirror mounted above it and just enough room and cubbies to store a stylist's equipment on it."),
    color = "white",
    move_cost_mod = 5,
    coverage = 80,
    required_strength = -1,
    crafting_pseudo_item = "mirror",
    flags = { "TRANSPARENT", "FLAMMABLE_ASH" },
    builtin_examine = "change_appearance",
    bash = {
        minimum_strength = 7,
        maximum_strength = 16,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        drops = { { item = "glass_shard", count = { 25, 50 } }, { item = "splinter", count = { 5, 15 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_indoor_flagpole",
    name = ccb.content.text("indoor flagpole"),
    description = ccb.content.text("A 2.5-meter tall flagpole on a weighted stand.  You could hoist up a flag here."),
    symbol = "F",
    color = "light_gray",
    move_cost_mod = 2,
    coverage = 20,
    required_strength = 1,
    mass = "1 kg",
    flags = { "TRANSPARENT", "PLACE_ITEM" },
    max_volume = "2 L",
    bash = {
        minimum_strength = 10,
        maximum_strength = 30,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        drops = {
            { item = "material_aluminium_ingot", count = { 4, 8 } },
            { item = "scrap", count = { 2, 6 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_indoor_flagpole_wooden",
    name = ccb.content.text("wooden indoor flagpole"),
    description = ccb.content.text("A 2.5-meter tall wooden flagpole on a weighted stand.  You could hoist up a flag here."),
    symbol = "F",
    color = "brown",
    move_cost_mod = 2,
    coverage = 20,
    required_strength = 1,
    mass = "1 kg",
    flags = { "TRANSPARENT", "FLAMMABLE", "PLACE_ITEM", "ORGANIC" },
    max_volume = "2 L",
    deconstruct = {
        drops = {
            { item = "nail", charges = { 2, 6 } },
            { item = "2x4", count = 1 },
            { item = "stick_long", count = 1 },
        },
    },
    bash = {
        minimum_strength = 10,
        maximum_strength = 30,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        drops = {
            { item = "nail", charges = { 2, 6 } },
            { item = "2x4", count = { 0, 1 } },
            { item = "splinter", count = { 2, 6 } },
        },
    },
}
