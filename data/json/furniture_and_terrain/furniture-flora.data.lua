local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_mutpoppy",
    name = ccb.content.text("mutated poppy flower"),
    description = ccb.content.text("These strange flowers have appeared in the wake of the Cataclysm, and their buds can be used for medicinal purposes, like the buds of the mundane poppy they're named after.  The dirt around it gently churns as its roots writhe beneath the soil, and it's surrounded by an overwhelming floral smell that makes you feel sleepy."),
    symbol = "f",
    color = "light_red",
    looks_like = "f_dandelion",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER", "GRAZER_INEDIBLE" },
    builtin_examine = "flower_poppy",
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_dandelion",
    name = ccb.content.text("dandelion"),
    description = ccb.content.text("A common weed with a yellow flower.  Produces seeds that get carried on the wind by thin, gray filaments."),
    symbol = "f",
    color = "yellow",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "dandelion_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_burdock",
    name = ccb.content.text("burdock"),
    description = ccb.content.text("A common weed with a purple thistle-like flower.  Its seeds tend to stick to clothing and fur."),
    symbol = "f",
    color = "magenta",
    looks_like = "f_dandelion",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = {
        { seasons = { "spring", "autumn" }, harvest = "burdock_harv" },
        { seasons = { "summer" }, harvest = "burdock_summer_harv" },
    },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_carrot_wild",
    name = ccb.content.text("wild carrot"),
    description = ccb.content.text("A common white wildflower which could be harvested for its root."),
    symbol = "f",
    color = "red",
    looks_like = "f_lily",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "spring", "summer" }, harvest = "wild_carrot_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_asparagus_wild",
    name = ccb.content.text("wild asparagus"),
    description = ccb.content.text("A perennial plant cultivated for its young edible shoots, commonly called spears.  When raw and growing naturally, the plant has a distinctive appearance that changes through its life cycle."),
    symbol = "f",
    looks_like = "t_shrub",
    move_cost_mod = 2,
    required_strength = -1,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER", "SHRUB" },
    builtin_examine = "harvest_furn_nectar",
    color = "green",
    harvest_by_season = { { seasons = { "winter", "spring", "summer" }, harvest = "wild_asparagus_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_maianthemum_stellatum",
    name = ccb.content.text("starry false Solomon's seal"),
    description = ccb.content.text("The blossoms of this flower look like stars in the night sky.  Its crimson berries are edible."),
    symbol = "f",
    color = "white",
    looks_like = "f_lily",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "autumn", "winter" }, harvest = "m_stellatum_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

-- Root can always be harvested, but there is no flower to harvest seeds from in winter.
ccb.content.define_furniture {
    id = "f_salsify",
    name = ccb.content.text("salsify"),
    description = ccb.content.text("Tragopogon porrifolius, a ragged-looking purple flower with a nutritious root."),
    symbol = "f",
    color = "light_red",
    looks_like = "f_dahlia",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = {
        { seasons = { "summer", "autumn" }, harvest = "salsify_seed_harv" },
        { seasons = { "autumn", "winter" }, harvest = "salsify_harv" },
    },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_chamomile",
    name = ccb.content.text("chamomile"),
    description = ccb.content.text("A cute white flower with a yellow center, used to brew a soothing tea."),
    symbol = "f",
    color = "white",
    looks_like = "f_dandelion",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "summer", "autumn" }, harvest = "chamomille_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_flower_tulip",
    name = ccb.content.text("tulip"),
    description = ccb.content.text("A bright, colorful flower with petals forming a small cup at its top.  It can be poisonous to livestock."),
    symbol = "f",
    looks_like = "f_mutpoppy",
    color = "light_blue",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER", "GRAZER_INEDIBLE" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "generic_flower_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_flower_spurge",
    name = ccb.content.text("spurge flower"),
    description = ccb.content.text("A yellow-green flower that grows in densely-packed bushes."),
    symbol = "f",
    looks_like = "f_dandelion",
    color = "light_green",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "spurge_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_cattails",
    name = ccb.content.text("cattails"),
    description = ccb.content.text("This useful plant is available all year round.  Many parts of the plant are edible."),
    symbol = "i",
    color = "brown",
    move_cost_mod = 1,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC", "SMALL_HIDE" },
    builtin_examine = "harvest_furn",
    harvest_by_season = {
        { seasons = { "winter" }, harvest = "cattails_winter_harv" },
        { seasons = { "spring", "summer", "autumn" }, harvest = "cattails_summer_harv" },
    },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

-- Add flower and bud spawns once useful.
ccb.content.define_furniture {
    id = "f_black_eyed_susan",
    name = ccb.content.text("black eyed Susan"),
    description = ccb.content.text("A mildly poisonous yellow flower with a dark ball in the middle.  Sometimes known as an ox-eye daisy."),
    looks_like = "f_dandelion",
    symbol = "f",
    color = "light_green",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER", "GRAZER_INEDIBLE" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "generic_flower_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

-- Add flower and bud spawns once useful.
ccb.content.define_furniture {
    id = "f_lily",
    name = ccb.content.text("lily"),
    description = ccb.content.text("A pretty flower that comes in a variety of colors."),
    looks_like = "f_flower_tulip",
    symbol = "f",
    color = "pink",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER", "GRAZER_INEDIBLE" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "generic_flower_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

-- Add flower and bud spawns once useful.
ccb.content.define_furniture {
    id = "f_lotus",
    name = ccb.content.text("lotus"),
    description = ccb.content.text("A lovely flower that grows on the surface of bodies of fresh water.  A traditional symbol of many Eastern cultures."),
    looks_like = "f_lily",
    symbol = "f",
    color = "yellow",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER", "GRAZER_INEDIBLE" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = {
        { seasons = { "spring", "summer", "autumn" }, harvest = "lotus_harv" },
        { seasons = { "summer" }, harvest = "lotus_summer_harv" },
        { seasons = { "autumn" }, harvest = "lotus_autumn_harv" },
    },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_sunflower",
    name = ccb.content.text("sunflower"),
    description = ccb.content.text("A tall, wide-headed flower with a large dark center.  Produces many nutritious seeds."),
    looks_like = "f_dandelion",
    symbol = "f",
    color = "yellow",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "summer" }, harvest = "sunflower_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_jerusalem_artichoke",
    name = ccb.content.text("Jerusalem artichoke plant"),
    description = ccb.content.text("Looking similar to a sunflower, this tall plant has a nutritious tuber."),
    looks_like = "f_sunflower",
    symbol = "f",
    color = "yellow",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "autumn", "winter" }, harvest = "jerusalem_artichoke_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_lilypad",
    name = ccb.content.text("lilypad"),
    description = ccb.content.text("This lilypad doesn't look like it would support the weight of the things you've heard croaking in the swamp."),
    symbol = "f",
    color = "green",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER", "GRAZER_INEDIBLE" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "generic_flower_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_bluebell",
    name = ccb.content.text("bluebell"),
    description = ccb.content.text("A common bluebell flower.  Pretty."),
    looks_like = "f_dandelion",
    symbol = "f",
    color = "blue",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER", "GRAZER_INEDIBLE" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "bluebell_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_dahlia",
    name = ccb.content.text("dahlia"),
    description = ccb.content.text("A puffy flower with many tightly-layered petals."),
    symbol = "f",
    color = "magenta",
    looks_like = "f_dandelion",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "flower_dahlia",
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_chicory",
    name = ccb.content.text("chicory"),
    description = ccb.content.text("A blue flower imported from Europe, also known as a cornflower."),
    symbol = "f",
    color = "cyan",
    looks_like = "f_bluebell",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "chicory_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_datura",
    name = ccb.content.text("datura"),
    description = ccb.content.text("A pretty moonflower."),
    symbol = "*",
    color = "light_green",
    looks_like = "f_dandelion",
    move_cost_mod = 1,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC", "GRAZER_INEDIBLE" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "datura_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_leaves_pile",
    name = ccb.content.text("pile of leaves"),
    symbol = "#",
    description = ccb.content.text("A sizable pile of leaves.  You could sleep on it if you don't care about comfort or warmth."),
    color = "brown",
    looks_like = "t_dirtpile",
    move_cost_mod = 3,
    coverage = 35,
    comfort = 1,
    floor_bedding_warmth = 50,
    required_strength = -1,
    deconstruct = { drops = { { item = "leaves", count = 100 } } },
    flags = {
        "TRANSPARENT",
        "FLAMMABLE_ASH",
        "ORGANIC",
        "MOUNTABLE",
        "SHORT",
        "EASY_DECONSTRUCT",
        "SMALL_HIDE",
    },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump."),
        drops = { { item = "leaves", count = { 62, 75 } } },
    },
}

ccb.content.define_furniture {
    id = "f_mustard",
    name = ccb.content.text("mustard"),
    description = ccb.content.text("A yellow flower known as Brassica Nigra.  Known for its seeds that can be used for making table mustard."),
    symbol = "f",
    color = "yellow",
    looks_like = "f_dandelion",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "summer", "autumn" }, harvest = "mustard_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}

ccb.content.define_furniture {
    id = "f_wild_sarsaparilla",
    name = ccb.content.text("wild sarsaparilla"),
    description = ccb.content.text("A small, flowering plant known as 'Aralia nudicaulis'.  It is colored in vibrant shades of orange and red in autumn, making it easy to spot."),
    symbol = ",",
    looks_like = "f_lily",
    color = { "brown_green", "green", "red", "brown" },
    move_cost_mod = 1,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "wild_sarsaparilla_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        drops = { { item = "withered", chance = 50, count = { 1, 2 } }, { item = "twig", chance = 50 } },
    },
}

-- green all year long
ccb.content.define_furniture {
    id = "f_wintergreen",
    name = ccb.content.text("wintergreen"),
    description = ccb.content.text("A small shrub native to North America.  The leaves, which remain green even in winter, are valued for medicinal purposes.  It produces edible and sweet berries, too!"),
    symbol = ",",
    looks_like = "f_mutpoppy",
    color = "green",
    move_cost_mod = 1,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "FLOWER" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "autumn", "winter" }, harvest = "wintergreen_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        drops = { { item = "withered", chance = 50, count = { 1, 2 } } },
    },
}

ccb.content.define_furniture {
    id = "f_japanese_knotweed",
    name = ccb.content.text("Japanese knotweed"),
    description = ccb.content.text("An invasive species originating from Japan.  The stem looks like it might contain some water."),
    symbol = ",",
    looks_like = "f_cattails",
    color = { "brown_green", "green", "green", "brown" },
    move_cost_mod = 3,
    coverage = 70,
    required_strength = -1,
    flags = { "TRANSPARENT", "SHORT", "SHRUB", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "spring" }, harvest = "japanese_knotweed_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        drops = { { item = "withered", chance = 50, count = { 1, 2 } }, { item = "leaves", count = { 2, 4 } } },
    },
}

ccb.content.define_furniture {
    id = "f_fireweed",
    name = ccb.content.text("fireweed"),
    description = ccb.content.text("Vibrant purple, it tends to be the first to appear after fires, hence its name."),
    symbol = ",",
    looks_like = "f_dahlia",
    move_cost_mod = 0,
    color = { "brown_green", "magenta", "magenta", "brown" },
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLOWER", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = {
        { seasons = { "summer", "autumn" }, harvest = "generic_edible_flower_spring_harv" },
        { seasons = { "summer", "autumn" }, harvest = "generic_edible_flower_harv" },
    },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        drops = { { item = "withered", chance = 50, count = { 1, 2 } }, { item = "leaves", count = { 2, 4 } } },
    },
}

ccb.content.define_furniture {
    id = "f_selfheal",
    name = ccb.content.text("common selfheal"),
    description = ccb.content.text("A small purple flower.  It got its name due to its usage in traditional medicine."),
    symbol = ",",
    looks_like = "f_dahlia",
    color = { "brown_green", "magenta", "magenta", "brown" },
    required_strength = -1,
    move_cost_mod = 0,
    flags = { "TRANSPARENT", "TINY", "FLOWER", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = {
        { seasons = { "summer", "autumn" }, harvest = "generic_edible_flower_spring_harv" },
        { seasons = { "summer", "autumn" }, harvest = "generic_edible_flower_harv" },
    },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        drops = { { item = "withered", chance = 50, count = { 1, 2 } }, { item = "leaves", count = { 2, 4 } } },
    },
}

ccb.content.define_furniture {
    id = "f_dogbane",
    name = ccb.content.text("spreading dogbane"),
    description = ccb.content.text("It is not only toxic to dogs when eaten by them.  Humans and many other animals are affected, too.  Its fibers sure are worth salvaging though.  Despite its name, it is not actually spreading fast."),
    symbol = ",",
    looks_like = "f_chamomile",
    color = { "brown_green", "green", "green", "brown" },
    required_strength = -1,
    move_cost_mod = 0,
    flags = { "TRANSPARENT", "SHORT", "SHRUB", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "dogbane_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        drops = { { item = "withered", chance = 50, count = { 1, 2 } }, { item = "leaves", count = { 2, 4 } } },
    },
}

ccb.content.define_furniture {
    id = "f_thistle",
    name = ccb.content.text("thistle"),
    looks_like = "f_burdock",
    description = ccb.content.text("A prickly and invasive small plant."),
    symbol = ",",
    color = { "brown_green", "green", "green", "brown" },
    required_strength = -1,
    move_cost_mod = 0,
    flags = { "TRANSPARENT", "TINY", "FLOWER", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "thistle_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        drops = { { item = "withered", chance = 50, count = { 1, 2 } } },
    },
}

ccb.content.define_furniture {
    id = "f_purple_loosestrife",
    name = ccb.content.text("purple loosestrife"),
    looks_like = "f_dahlia",
    description = ccb.content.text("A pretty violet flower that likes water.  Unfortunately it is invasive and does not benefit the environment."),
    symbol = ",",
    color = { "brown_green", "magenta", "magenta", "brown" },
    required_strength = -1,
    move_cost_mod = 0,
    flags = { "TRANSPARENT", "SHORT", "FLOWER", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC" },
    builtin_examine = "harvest_furn_nectar",
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        drops = { { item = "withered", chance = 50, count = { 1, 2 } } },
    },
}

ccb.content.define_furniture {
    id = "f_wild_rice",
    name = ccb.content.text("wild rice"),
    description = ccb.content.text("Also called Indian rice, Northern wild rice, or manoomin in Ojibwe, is a species of rice that has been harvested and used by Native American tribes of the northeast for hundreds of years.  It's similar to other types of wild rice, offering a fiber-rich and healthy basis of a meal."),
    symbol = "f",
    looks_like = "f_cattails",
    color = { "brown_green", "green", "green", "brown" },
    move_cost_mod = 3,
    coverage = 70,
    required_strength = -1,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "DIGGABLE", "FLAT", "THIN_OBSTACLE", "SHRUB", "SMALL_HIDE" },
    builtin_examine = "harvest_furn_nectar",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "wild_rice_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        drops = { { item = "withered", chance = 50, count = { 1, 2 } }, { item = "leaves", count = { 2, 4 } } },
    },
}

ccb.content.define_furniture {
    id = "f_hedge_short",
    name = ccb.content.text("short hedge"),
    description = ccb.content.text("A shrub with small green leaves, trimmed into a squared shape."),
    symbol = "#",
    color = "green",
    looks_like = "t_shrub",
    move_cost_mod = 3,
    coverage = 50,
    required_strength = -1,
    connect_groups = "WOODFENCE",
    connects_to = "WOODFENCE",
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "ORGANIC", "PERMEABLE", "SMALL_HIDE" },
    bash = {
        minimum_strength = 10,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        drops = {
            { item = "stick_long", count = { 2, 3 } },
            { item = "splinter", count = { 5, 10 } },
            { item = "leaves", count = { 5, 8 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_hedge_tall",
    name = ccb.content.text("tall hedge"),
    description = ccb.content.text("A tall shrub with small green leaves, trimmed into a squared shape.  You can't see past this thick hedgerow."),
    symbol = "#",
    color = "green",
    looks_like = "t_shrub",
    move_cost_mod = -1,
    coverage = 90,
    required_strength = 14,
    connect_groups = "WOODFENCE",
    connects_to = "WOODFENCE",
    flags = { "FLAMMABLE_ASH", "ORGANIC", "PERMEABLE", "BLOCK_WIND", "NOITEM", "SMALL_HIDE" },
    bash = {
        minimum_strength = 16,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        drops = {
            { item = "stick_long", count = { 3, 6 } },
            { item = "splinter", count = { 8, 16 } },
            { item = "leaves", count = { 7, 10 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_topiary_abstract",
    name = ccb.content.text("abstract topiary"),
    description = ccb.content.text("A tall shrub with small green leaves, trimmed into a fanciful abstract shape."),
    symbol = "^",
    color = "green",
    looks_like = "t_shrub_hydrangea",
    move_cost_mod = 4,
    coverage = 60,
    required_strength = -1,
    flags = { "FLAMMABLE_ASH", "ORGANIC", "PERMEABLE" },
    bash = {
        minimum_strength = 10,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        drops = {
            { item = "stick_long", count = { 3, 6 } },
            { item = "splinter", count = { 8, 16 } },
            { item = "leaves", count = { 7, 10 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_topiary_animal",
    name = ccb.content.text("animal topiary"),
    description = ccb.content.text("A tall shrub with small green leaves, trimmed into an animal shape."),
    symbol = "^",
    color = "green",
    looks_like = "t_shrub_hydrangea",
    move_cost_mod = 4,
    coverage = 60,
    required_strength = -1,
    flags = { "FLAMMABLE_ASH", "ORGANIC", "PERMEABLE" },
    bash = {
        minimum_strength = 10,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        drops = {
            { item = "stick_long", count = { 3, 6 } },
            { item = "splinter", count = { 8, 16 } },
            { item = "leaves", count = { 7, 10 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_topiary_dragon",
    name = ccb.content.text("animal topiary"),
    description = ccb.content.text("A tall shrub with small green leaves, trimmed into a dragon shape."),
    symbol = "^",
    color = "green",
    looks_like = "t_shrub_hydrangea",
    move_cost_mod = 4,
    coverage = 60,
    required_strength = -1,
    flags = { "FLAMMABLE_ASH", "ORGANIC", "PERMEABLE" },
    bash = {
        minimum_strength = 10,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        drops = {
            { item = "stick_long", count = { 3, 6 } },
            { item = "splinter", count = { 8, 16 } },
            { item = "leaves", count = { 7, 10 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_beaver_dam",
    name = ccb.content.text("dam"),
    description = ccb.content.text("A house that beavers built.  The entrance is underwater making it harder for predators to access."),
    symbol = "#",
    color = "brown",
    looks_like = "t_wall_log",
    move_cost_mod = 2,
    required_strength = -1,
    flags = { "FLAMMABLE_ASH", "TRANSPARENT" },
    bash = {
        minimum_strength = 6,
        maximum_strength = 12,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("bonk."),
        drops = {
            { item = "twig", count = { 5, 12 } },
            { item = "stick", count = { 5, 12 } },
            { item = "stick_long", count = { 5, 12 } },
            { item = "splinter", count = { 12, 38 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}
