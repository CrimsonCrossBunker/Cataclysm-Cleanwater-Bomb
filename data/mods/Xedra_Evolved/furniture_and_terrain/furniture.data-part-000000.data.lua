local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_statue_fae_ozymandius",
    name = ccb.content.text("broken statue"),
    description = ccb.content.text("All that remains of this previously grand statue are a pair of feet and a set of broken wings."),
    looks_like = "f_statue",
    copy_from = "f_statue",
    bash = {
        minimum_strength = 16,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = {
            { item = "rock", count = { 10, 14 } },
            { item = "rock_large", count = 2 },
            { item = "pebble", count = { 4, 8 } },
        },
    },
}

-- The golden monolith produces mist that summons changelings, basically the equivalent of a tear in reality.
ccb.content.define_furniture {
    id = "f_golden_monolith",
    name = ccb.content.text("golden monolith"),
    move_cost_mod = -1,
    symbol = "H",
    color = "white_yellow",
    coverage = 60,
    description = ccb.content.text("A shiny golden monolith covered in shimmering pictograms.  There is a mist condensing near it.  A light seems to emanate from it."),
    light_emitted = 15,
    emissions = { "emit_changeling_mist" },
    required_strength = -1,
    bash = {
        minimum_strength = 600,
        maximum_strength = 860,
        furniture = "f_broken_golden_monolith",
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock", count = { 5, 15 } }, { item = "sharp_rock", count = { 3, 5 } } },
    },
}

ccb.content.define_furniture {
    id = "f_broken_golden_monolith",
    name = ccb.content.text("broken golden monolith"),
    move_cost_mod = -1,
    symbol = "H",
    color = "white_yellow",
    coverage = 60,
    description = ccb.content.text("A dully glowing golden monolith, the golden pictograms covering it have been scarred by a tremendous force."),
    light_emitted = 3,
    required_strength = -1,
    bash = {
        minimum_strength = 600,
        maximum_strength = 860,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock", count = { 5, 15 } }, { item = "sharp_rock", count = { 3, 5 } } },
    },
}

ccb.content.define_terrain {
    id = "t_radio_equipment",
    name = ccb.content.text("radio controls"),
    description = ccb.content.text("This specialized looking radio receiver equipment covers most of a table.  It doesn't seem to be fully operational."),
    symbol = "6",
    color = "green",
    looks_like = "f_console_broken",
    move_cost = 0,
    coverage = 50,
    flags = { "TRANSPARENT", "NOITEM", "PERMEABLE" },
    deconstruct = {
        terrain = "t_concrete",
        drops = {
            { item = "processor", count = { 1, 2 } },
            { item = "RAM", count = { 4, 8 } },
            { item = "cable", count = { 1, 2 } },
            { item = "large_lcd_screen", count = 1 },
            { item = "e_scrap", count = { 10, 16 } },
            { item = "circuit", count = { 6, 10 } },
            { item = "power_supply", count = { 2, 4 } },
            { item = "amplifier", count = { 2, 4 } },
            { item = "plastic_chunk", count = { 10, 12 } },
            { item = "scrap", count = { 6, 8 } },
        },
    },
    bash = {
        minimum_strength = 8,
        maximum_strength = 150,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_metal_floor",
        drops = {
            { item = "processor", chance = 25 },
            { item = "RAM", count = { 0, 2 }, chance = 50 },
            { item = "cable", count = { 1, 2 }, chance = 50 },
            { item = "large_lcd_screen", chance = 25 },
            { item = "e_scrap", count = { 1, 4 }, chance = 50 },
            { item = "circuit", count = { 0, 2 }, chance = 50 },
            { item = "power_supply", chance = 25 },
            { item = "amplifier", chance = 25 },
            { item = "plastic_chunk", count = { 4, 10 }, chance = 50 },
            { item = "scrap", count = { 2, 6 }, chance = 50 },
        },
    },
}

ccb.content.define_furniture {
    id = "xe_f_throne",
    name = ccb.content.text("throne"),
    symbol = "#",
    description = ccb.content.text("An ornate wooden throne, with four legs, a seat, and a back.  It's good to be king, if just for a while.  It appears to have been joined without any nails."),
    color = "brown",
    move_cost_mod = 1,
    coverage = 40,
    comfort = 1,
    floor_bedding_warmth = -1500,
    bonus_fire_warmth_feet = 1000,
    required_strength = 8,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "ORGANIC", "MOUNTABLE", "CAN_SIT", "ALIGN_WORKBENCH" },
    bash = {
        minimum_strength = 6,
        maximum_strength = 20,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("whump."),
        drops = { { item = "splinter", count = { 15, 30 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "xe_f_balefire",
    name = ccb.content.text("Balefire"),
    description = ccb.content.text("A giant blue white fire produces a cool light and almost no heat."),
    symbol = "O",
    required_strength = -1,
    move_cost_mod = -1,
    color = "light_blue",
    coverage = 30,
    light_emitted = 55,
    light_color = { 94, 175, 237 },
    flags = { "TRANSPARENT", "NOITEM", "BLOCKSDOOR" },
    bash = {
        minimum_strength = 20,
        maximum_strength = 30,
        failure_sound = ccb.content.text("smash!"),
        drops = {
            { item = "glass_shard", count = { 8, 12 } },
            { item = "scrap_dreamdross", count = { 2, 10 } },
        },
    },
}

-- Need to add uses for bat guano so this item makes sense.
ccb.content.define_furniture {
    id = "f_bat_roost",
    name = ccb.content.text("bat roost"),
    description = ccb.content.text("A series of raised horizontal slats for bats to rest on right above eye level, covered in tiny claw marks.  Below, there is a pull-out drawer that collects guano so it can be easily washed out, similar to a litter box."),
    symbol = "^",
    color = "brown",
    move_cost_mod = 1,
    required_strength = 10,
    looks_like = "f_rack_wood",
    flags = { "TRANSPARENT", "FLAT", "MOUNTABLE" },
    deconstruct = {
        drops = {
            { item = "2x4", count = { 11, 12 } },
            { item = "nail", charges = { 30, 36 } },
            { item = "pebble", charges = { 180, 200 } },
            { item = "feces_bat", count = { 70, 75 } },
        },
    },
    bash = {
        minimum_strength = 6,
        maximum_strength = 14,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        drops = {
            { item = "2x4", count = { 4, 10 } },
            { item = "nail", charges = { 15, 30 } },
            { item = "pebble", charges = { 150, 200 } },
            { item = "feces_bat", count = { 60, 75 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_elemental_altar",
    name = ccb.content.text("altar of elements"),
    move_cost_mod = 10,
    symbol = "H",
    color = "light_gray",
    coverage = 40,
    required_strength = 30,
    light_emitted = 4,
    crafting_pseudo_item = "sacrifice_table",
    builtin_examine = "workbench",
    workbench = { multiplier = 1.1, mass = "200 kg", volume = "75L" },
    description = ccb.content.text("This is a dramatic stone altar, it glows faintly in the dark.  Each of the four corners has a place for one of the cardinal elements as well as several recessed spaces around the center of the altar."),
    bash = {
        minimum_strength = 30,
        maximum_strength = 160,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock", count = { 5, 15 } }, { item = "sharp_rock", count = { 3, 5 } } },
    },
}

ccb.content.define_terrain {
    id = "t_barkfloor_no_roof",
    looks_like = "t_barkfloor",
    name = ccb.content.text("bark"),
    description = ccb.content.text("A solid piece of bark covers the floor here, open to the sky."),
    symbol = ".",
    color = "brown",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "FLAT", "ROAD" },
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_dirt",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        drops = { { item = "splinter", count = { 2, 8 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_dreamforged_bed_of_restful_repose",
    name = ccb.content.text("dreamforged bed of restful repose"),
    symbol = "#",
    description = ccb.content.text("A bed made solely for dreaming, by a dreamsmith.  When you lay upon this bed, your mind renews and your body recuperates.  Said to be so comfortable that if you die while in this bed, your mind detaches without pain from your body and sets forth upon the dream realms."),
    color = "cyan_green",
    move_cost_mod = 3,
    coverage = 40,
    comfort = 500,
    floor_bedding_warmth = 3000,
    required_strength = -1,
    deconstruct = { drops = { { item = "dreamforged_bed_of_restful_repose", count = 1 } } },
    flags = {
        "TRANSPARENT",
        "PLACE_ITEM",
        "ORGANIC",
        "MOUNTABLE",
        "CAN_SIT",
        "EASY_DECONSTRUCT",
        "SMALL_HIDE",
    },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump."),
        drops = { { item = "scrap_dreamdross", count = { 50, 80 } } },
    },
}

ccb.content.define_furniture {
    id = "f_homullus_translocator_location",
    name = ccb.content.text("civilization"),
    symbol = "+",
    description = ccb.content.text("A part of one of the last bastions of civilization.  You could travel here in moments from any road you found yourself on."),
    color = "brown",
    required_strength = -1,
    move_cost_mod = 0,
    flags = {
        "TRANSLOCATOR",
        "MOUNTABLE",
        "TRANSPARENT",
        "ALLOW_FIELD_EFFECT",
        "EASY_DECONSTRUCT",
        "FREE_TO_EXAMINE",
    },
    builtin_examine = "translocator",
    deconstruct = { drops = {} },
}

ccb.content.define_furniture {
    id = "f_ierde_translocator_location",
    name = ccb.content.text("living earth"),
    symbol = "+",
    description = ccb.content.text("The rock of the living earth.  You could travel here in moments as long as you are deep underground."),
    color = "light_gray",
    required_strength = -1,
    move_cost_mod = 0,
    flags = {
        "TRANSLOCATOR",
        "MOUNTABLE",
        "TRANSPARENT",
        "ALLOW_FIELD_EFFECT",
        "EASY_DECONSTRUCT",
        "FREE_TO_EXAMINE",
    },
    builtin_examine = "translocator",
    deconstruct = { drops = {} },
}

ccb.content.define_furniture {
    id = "f_sylph_translocator_location",
    name = ccb.content.text("open to the sky"),
    symbol = "+",
    description = ccb.content.text("Above the base earth and beneath the firmament.  You could travel here in moments as long as you are high above the earth or surrounded by the blowing wind."),
    color = "white",
    required_strength = -1,
    move_cost_mod = 0,
    flags = {
        "TRANSLOCATOR",
        "MOUNTABLE",
        "TRANSPARENT",
        "ALLOW_FIELD_EFFECT",
        "EASY_DECONSTRUCT",
        "FREE_TO_EXAMINE",
    },
    builtin_examine = "translocator",
    deconstruct = { drops = {} },
}

ccb.content.define_furniture {
    id = "xedra_chronomancer_memorized_terrain",
    name = ccb.content.text("memorized location"),
    symbol = "+",
    description = ccb.content.text("You remember the exact moment of time your were at this spot."),
    color = "light_gray",
    required_strength = -1,
    move_cost_mod = 0,
    flags = {
        "TRANSLOCATOR",
        "MOUNTABLE",
        "TRANSPARENT",
        "ALLOW_FIELD_EFFECT",
        "EASY_DECONSTRUCT",
        "FREE_TO_EXAMINE",
    },
    builtin_examine = "translocator",
    deconstruct = { drops = {} },
}

ccb.content.define_furniture {
    id = "f_ierde_lithic_gaol_fang",
    name = ccb.content.text("Rocky fang"),
    description = ccb.content.text("A thick, jagged spike of rock."),
    symbol = "|",
    required_strength = -1,
    move_cost_mod = -1,
    color = "light_gray",
    coverage = 85,
    flags = { "MINEABLE", "NOITEM", "TRANSPARENT", "BLOCKSDOOR", "PERMEABLE" },
    bash = {
        minimum_strength = 20,
        maximum_strength = 50,
        failure_sound = ccb.content.text("smash!"),
        drops = { { item = "rock", count = { 20, 100 } } },
    },
}
