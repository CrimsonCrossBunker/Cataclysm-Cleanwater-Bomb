local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_magiclysm_translocator_gate",
    name = ccb.content.text("Translocator Gate"),
    move_cost_mod = 0,
    symbol = "X",
    description = ccb.content.text("A gate for translocation.  Cast the translocation spell or use a translocator to choose this gate as a destination."),
    color = "light_gray",
    required_strength = 25,
    flags = { "TRANSLOCATOR", "MOUNTABLE", "ALLOW_FIELD_EFFECT", "FREE_TO_EXAMINE" },
    builtin_examine = "translocator",
}

ccb.content.define_furniture {
    id = "f_magiclysm_greater_translocator_gate",
    name = ccb.content.text("Translocation Portal"),
    move_cost_mod = 0,
    symbol = "X",
    description = ccb.content.text("A portal that allows translocation.  You may use this portal to teleport to attuned locations or teleport to it if it is attuned."),
    color = "light_gray",
    required_strength = 25,
    looks_like = "f_magiclysm_translocator_gate",
    flags = { "TRANSLOCATOR", "TRANSLOCATOR_GREATER", "MOUNTABLE", "ALLOW_FIELD_EFFECT", "FREE_TO_EXAMINE" },
    builtin_examine = "translocator",
}

ccb.content.define_furniture {
    id = "f_magic_circle",
    name = ccb.content.text("Magic Circle"),
    move_cost_mod = 0,
    symbol = "O",
    color = "red",
    required_strength = -1,
    crafting_pseudo_item = "magic_circle_rank_1",
    flags = { "ALLOW_FIELD_EFFECT", "TRANSPARENT" },
    description = ccb.content.text("This is a rough magic circle, carved into the ground and decorated with blood, candles, and other small knick-knacks."),
}

ccb.content.define_furniture {
    id = "f_magic_circle_2",
    name = ccb.content.text("Magic Circle"),
    looks_like = "f_magic_circle",
    move_cost_mod = 0,
    symbol = "O",
    color = "red",
    required_strength = -1,
    crafting_pseudo_item = "magic_circle_rank_2",
    flags = { "ALLOW_FIELD_EFFECT", "TRANSPARENT" },
    description = ccb.content.text("This is a rough magic circle, carved into the ground and decorated with blood, candles, and other small knick-knacks.  It has been enhanced with silver to channel more mana."),
}

ccb.content.define_furniture {
    id = "f_glow_boulder",
    looks_like = "f_boulder_large",
    name = ccb.content.text("large glowing boulder"),
    description = ccb.content.text("Something about this doesn't look right."),
    symbol = "O",
    color = "green",
    move_cost_mod = -1,
    coverage = 65,
    required_strength = 32,
    flags = { "NOITEM", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 64,
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
            { item = "orichalcum_lump", count = { 0, 2 } },
            { item = "orichalcum_sliver", count = { 4, 10 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_magic_bench",
    name = ccb.content.text("enchanter's workbench"),
    looks_like = "f_table",
    description = ccb.content.text("An ornate oak cabinet topped by a durable resin countertop resistant to most alchemical spills and burns.  It has wired in electrical and gas fittings, and has been decorated with several protection runes - mostly ornamental."),
    symbol = "0",
    background_color = "white",
    move_cost_mod = 2,
    coverage = 60,
    required_strength = -1,
    flags = { "TRANSPARENT", "PLACE_ITEM", "MOUNTABLE", "FLAT_SURF" },
    deconstruct = {
        drops = {
            { item = "pipe", count = { 6, 12 } },
            { item = "cu_pipe", count = { 1, 4 } },
            { item = "cable", count = { 1, 2 } },
            { item = "plastic_chunk", count = { 50, 75 } },
            { item = "wood_panel", count = { 1, 2 } },
            { item = "2x4", count = { 3, 4 } },
        },
    },
    max_volume = "1750 L",
    bash = {
        minimum_strength = 35,
        maximum_strength = 80,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "splinter", count = { 2, 8 } },
            { item = "2x4", count = { 0, 2 } },
            { item = "wood_panel", count = { 0, 1 } },
            { item = "plastic_chunk", count = { 30, 50 } },
            { item = "pipe", count = 1 },
            { item = "cable", count = { 1, 2 } },
            { item = "cu_pipe", count = 1 },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
    builtin_examine = "workbench",
    workbench = { multiplier = 1.15, mass = "300 kg", volume = "100L" },
}

ccb.content.define_furniture {
    id = "f_alembic",
    name = ccb.content.text("standing alembic"),
    looks_like = "f_still",
    description = ccb.content.text("A large glass and copper alembic for distilling alchemical concoctions.  It consists of a copper pot with rising spires of twisted glass draining into various removable bottles."),
    symbol = "&",
    color = "light_blue",
    move_cost_mod = -1,
    coverage = 40,
    required_strength = -1,
    crafting_pseudo_item = "still_lab",
    flags = { "TRANSPARENT", "NOITEM" },
    deconstruct = {
        drops = {
            { item = "pot_copper", count = 1 },
            { item = "pipe_glass", count = { 1, 4 } },
            { item = "glass_tube_small", count = { 5, 10 } },
            { item = "stopcock", count = { 1, 5 } },
            { item = "flask_glass", count = { 1, 3 } },
        },
    },
    max_volume = "1750 L",
    bash = {
        minimum_strength = 4,
        maximum_strength = 10,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "scrap_copper", count = { 10, 20 } },
            { item = "stopcock", count = { 1, 5 } },
            { item = "glass_shard", count = { 25, 50 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_orrery",
    name = ccb.content.text("orrery"),
    looks_like = "f_statue",
    description = ccb.content.text("This is a beautiful, non-scale model of the solar system.  A complex series of gears allows the relative motions of the planets to be studied at the turn of a crank.  This more modern version also has bluetooth and could have been controlled with an app, if there was any power anymore."),
    symbol = "@",
    color = "brown",
    move_cost_mod = -1,
    coverage = 40,
    required_strength = -1,
    flags = { "TRANSPARENT", "NOITEM", "EASY_DECONSTRUCT" },
    deconstruct = { drops = { { item = "orrery_item", count = 1 } } },
    max_volume = "1750 L",
    bash = {
        minimum_strength = 20,
        maximum_strength = 60,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "scrap", count = { 10, 100 } },
            { item = "pipe", count = { 1, 5 } },
            { item = "wire", count = { 3, 10 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_huge_mana_crystal",
    name = ccb.content.text("huge mana crystal"),
    description = ccb.content.text("This is a mana crystal that juts from the ground as if it had sprouted up like a weed.  It pulses with a delicate yellow energy, occasionally bursting with flashes of pent-up light."),
    symbol = "]",
    color = "white_yellow",
    move_cost_mod = -1,
    coverage = 75,
    required_strength = -1,
    looks_like = "f_boulder_large",
    flags = { "TRANSPARENT" },
    emissions = { "emit_glimmer" },
    light_emitted = 12,
    bash = {
        minimum_strength = 40,
        maximum_strength = 160,
        sound = ccb.content.text("crystal shattering!"),
        failure_sound = ccb.content.text("mana crackling!"),
        hit_field = { "fd_mana_overload", 1 },
        destroyed_field = { "fd_mana_overload", 3 },
        drops = {
            { item = "crystallized_mana_raw", count = { 4, 8 } },
            { item = "small_mana_crystal", count = { 0, 2 } },
            { item = "glass_shard", count = { 8, 12 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_altar",
    name = ccb.content.text("stone altar"),
    move_cost_mod = 10,
    symbol = "H",
    color = "light_gray",
    coverage = 40,
    required_strength = 30,
    description = ccb.content.text("This is a big stone altar.  Most commonly used in morally questionable rituals."),
    bash = {
        minimum_strength = 30,
        maximum_strength = 160,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock", count = { 5, 15 } }, { item = "sharp_rock", count = { 3, 5 } } },
    },
}
