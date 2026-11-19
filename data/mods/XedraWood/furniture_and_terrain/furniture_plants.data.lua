local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_magic_brambles",
    name = ccb.content.text("brambles"),
    looks_like = "f_brambles",
    symbol = "#",
    background_color = "brown",
    description = ccb.content.text("A thick wall of tangled brambles grows here.  Vicious thorns protrude from the stems."),
    move_cost_mod = 8,
    coverage = 75,
    required_strength = -1,
    flags = {
        "TRANSPARENT",
        "FLAMMABLE_ASH",
        "BLOCKSDOOR",
        "PAINFUL",
        "SHARP",
        "PERMEABLE",
        "THIN_OBSTACLE",
        "SHRUB",
    },
    bash = {
        minimum_strength = 30,
        maximum_strength = 80,
        sound = ccb.content.text("smash"),
        failure_sound = ccb.content.text("whump."),
        drops = { { item = "splinter", count = { 10, 15 } } },
    },
}

ccb.content.define_furniture {
    id = "f_morningflower",
    name = ccb.content.text("morningflower"),
    description = ccb.content.text("A brilliant yellow flower that absorbs the sun's rays and then radiates it back as light."),
    symbol = "y",
    color = "yellow",
    looks_like = "f_kampuch",
    move_cost_mod = 1,
    required_strength = -1,
    light_emitted = 5,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "harvest_morningflower" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_harfry",
    name = ccb.content.text("harfry plant"),
    description = ccb.content.text("A set of thick leaves on a short woody stem.  The leaves are an almost-unnaturally brilliant green."),
    symbol = "#",
    color = "green",
    looks_like = "f_moly",
    move_cost_mod = 1,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = {
        { seasons = { "spring", "autumn" }, harvest = "harvest_harfry" },
        { seasons = { "summer" }, harvest = "harvest_harfry_summer" },
    },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_maidenshair",
    name = ccb.content.text("maiden's hair"),
    description = ccb.content.text("A set of long, thin blades waving gently underwater.  They seem to move even when there is no current."),
    symbol = "/",
    color = "light_green",
    looks_like = "f_flowering_fern",
    move_cost_mod = 1,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn",
    harvest_by_season = {
        { seasons = { "spring", "summer", "autumn", "winter" }, harvest = "harvest_maidenshair" },
    },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_starsbreath",
    name = ccb.content.text("stars' breath"),
    description = ccb.content.text("A round, silvery-blue flower.  It often grows near witchwood trees, and only blooms under starlight."),
    symbol = "#",
    color = "green",
    looks_like = "f_olieribos",
    move_cost_mod = 1,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "summer", "autumn" }, harvest = "harvest_starsbreath" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_corpsefire_mushroom",
    name = ccb.content.text("corpsefire caps"),
    looks_like = "f_glowing_mushroom",
    description = ccb.content.text("A cluster of blue-white mushrooms growing from the ground, faintly glowing with a ghastly light."),
    symbol = "#",
    color = "dark_gray",
    move_cost_mod = 0,
    required_strength = -1,
    light_emitted = 5,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE" },
    builtin_examine = "harvest_furn",
    harvest_by_season = {
        { seasons = { "spring", "summer", "autumn", "winter" }, harvest = "harvest_corpsefire" },
    },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}
