local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_platonic_flower",
    name = ccb.content.text("platonic flower"),
    description = ccb.content.text("Small bush, that looks like a pair of dragon curves, with a flower in the very center.  The branches of the plant can be used as a perfect ruler."),
    symbol = "S",
    color = "light_cyan",
    looks_like = "f_bluebell",
    move_cost_mod = 2,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "platonic_flower_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_moonflower",
    name = ccb.content.text("moonflower bush"),
    description = ccb.content.text("A silver colored vine, whose luminescent flowers will only bloom during night.\n\nAmazingly rare, it grows only in places where heroic deeds took place, or so it's believed."),
    symbol = "y",
    color = "light_cyan",
    looks_like = "f_datura",
    move_cost_mod = 2,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "moonflower_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_kampuch",
    name = ccb.content.text("kampuch"),
    description = ccb.content.text("The tiny and lethal rod flowers of the Kämpuch break the underbrush like small ivory thorns."),
    symbol = "i",
    color = "cyan",
    looks_like = "f_burdock",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "kampuch_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_olieribos",
    name = ccb.content.text("olieribos"),
    description = ccb.content.text("Dark colored leaves and bitter roots, firmly entrenched in untrodden earth.  They can be used to ward against evil, or to attract it."),
    symbol = "f",
    color = "cyan",
    looks_like = "f_chicory",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "olieribos_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_glowing_mushroom",
    name = ccb.content.text("glowing mushrooms"),
    description = ccb.content.text("A bioluminescent mushroom shaped like a small nest.  Motes of light occasionally detach from its surface and float upwards before fading."),
    symbol = "o",
    color = "light_cyan",
    looks_like = "f_glowingbulb",
    move_cost_mod = 0,
    required_strength = -1,
    light_emitted = 10,
    light_color = { 0, 80, 160 },
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "glowing_mushroom_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_terrain {
    id = "t_horn_moss",
    name = ccb.content.text("horn moss"),
    looks_like = "t_grass_dead",
    description = ccb.content.text("A cluster of red moss, so called for the white capsules that it will grow during spring."),
    symbol = ".",
    color = "light_red",
    move_cost = 2,
    builtin_examine = "harvest_ter_nectar",
    transforms_into = "t_grass_dead",
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT" },
    harvest_by_season = { { seasons = { "spring" }, harvest = "horn_moss_harv" } },
}

ccb.content.define_furniture {
    id = "f_golden_reed",
    name = ccb.content.text("golden reed"),
    description = ccb.content.text("Thin stalks colored deep yellow, crowned with blue feather-like leaves."),
    symbol = "i",
    color = "yellow",
    looks_like = "f_cattails",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "golden_reed_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_barnacle_weed",
    name = ccb.content.text("barnacle weed"),
    description = ccb.content.text("A wooden pod kept aloft by a spiral stalk and the short, dagger-shaped leaves growing at its base."),
    symbol = "i",
    color = "brown",
    looks_like = "f_cattails",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "wood_barnacle_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_dragonail",
    name = ccb.content.text("dragonails"),
    description = ccb.content.text("A small tangle of old and crooked wood, completely covered with black menacing thorns."),
    symbol = "y",
    color = "brown",
    looks_like = "f_leaves_pile",
    move_cost_mod = 2,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "dragon_nail_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_moly",
    name = ccb.content.text("moly"),
    description = ccb.content.text("A small herb with milk white flowers and pitch black roots.  Known since Ancient Greece, it was brought to the New World by European druids long ago."),
    symbol = "f",
    color = "white",
    looks_like = "f_lotus",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "moly_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_flowering_fern",
    name = ccb.content.text("flowering fern"),
    description = ccb.content.text("A seemingly normal fern, which has somehow produced a single red flower."),
    symbol = "y",
    color = "light_green",
    looks_like = "f_mutpoppy",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "flowering_fern_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_funnelcap",
    name = ccb.content.text("funnelcap"),
    description = ccb.content.text("A man-sized mushroom, with most of its bulk defined by a tall funnel shaped pileus, which collects rainfall."),
    symbol = "V",
    color = "white",
    looks_like = "t_fungal_tree",
    move_cost_mod = 3,
    required_strength = -1,
    flags = { "FLAMMABLE_ASH", "ORGANIC", "REDUCE_SCENT" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "summer", "autumn" }, harvest = "funnelcap_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_sojourners_palm",
    name = ccb.content.text("sojourner's palm"),
    description = ccb.content.text("A large magical palm tree, normally you would find it in the tropics, but this plant also has the well documented ability to teleport randomly."),
    symbol = "Y",
    color = "green",
    looks_like = "t_fungal_tree",
    move_cost_mod = 3,
    required_strength = -1,
    flags = { "FLAMMABLE_ASH", "ORGANIC", "REDUCE_SCENT" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "summer", "autumn" }, harvest = "sojourners_palm_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_whiskflower",
    name = ccb.content.text("whiskflower bush"),
    description = ccb.content.text("A small plant with curled leaves and pink whisk-shaped flowers.  It has a very strong alcoholic smell."),
    symbol = "v",
    color = "pink",
    looks_like = "f_dahlia",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "whiskflower_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}
