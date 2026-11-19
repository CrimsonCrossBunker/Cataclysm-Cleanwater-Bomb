local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_tree_abstract",
    looks_like = "t_tree",
    name = ccb.content.text("oak tree"),
    description = ccb.content.text("A massive deciduous tree belonging to the 'Quercus' genus, commonly found throughout the New England region.  If you look closely, you can see some acorns the squirrels haven't gotten yet."),
    symbol = "7",
    color = { "green", "green", "brown_green", "brown" },
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT", "CLIMB_ADJACENT" },
    builtin_examine = "harvest_ter",
    roof = "t_treetop",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree",
    copy_from = "t_tree_abstract",
    transforms_into = "t_tree_harvested",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "oak_harv" } },
    extend = { flags = { "BROWSABLE" } },
}

ccb.content.define_terrain {
    id = "t_tree_harvested",
    copy_from = "t_tree",
    looks_like = "t_tree_dead",
    description = ccb.content.text("A massive deciduous tree belonging to the 'Quercus' genus, commonly found throughout the New England region."),
    delete = { flags = { "BROWSABLE" } },
    transforms_into = "t_tree",
}

ccb.content.define_terrain {
    id = "t_tree_walnut",
    copy_from = "t_tree_abstract",
    name = ccb.content.text("walnut tree"),
    description = ccb.content.text("A massive tree belonging to the 'Juglans' genus.  If you look closely, you can see some unharvested walnuts."),
    extend = { flags = { "BROWSABLE" } },
    color = { "green", "green", "yellow_yellow", "brown" },
    transforms_into = "t_tree_walnut_harvested",
    looks_like = "t_tree_hickory",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "walnut_harv" } },
}

ccb.content.define_terrain {
    id = "t_tree_walnut_harvested",
    copy_from = "t_tree_walnut",
    description = ccb.content.text("A massive tree belonging to the 'Juglans' genus."),
    transforms_into = "t_tree_walnut",
    delete = { flags = { "BROWSABLE" } },
    looks_like = "t_tree_hickory_harvested",
}

ccb.content.define_terrain {
    id = "t_tree_butternut",
    copy_from = "t_tree_abstract",
    name = ccb.content.text("butternut tree"),
    description = ccb.content.text("A massive tree belonging to the 'Juglans' genus, but with lighter bark and more elongated fruits than the more common black walnut.  If you look closely, you can see some unharvested butternuts."),
    color = { "green", "green", "yellow_yellow", "brown" },
    extend = { flags = { "BROWSABLE" } },
    transforms_into = "t_tree_butternut_harvested",
    looks_like = "t_tree_blackjack",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "butternut_harv" } },
}

ccb.content.define_terrain {
    id = "t_tree_butternut_harvested",
    copy_from = "t_tree_butternut",
    description = ccb.content.text("A massive tree belonging to the 'Juglans' genus, but with lighter bark and more elongated fruits than the more common black walnut."),
    delete = { flags = { "BROWSABLE" } },
    transforms_into = "t_tree_butternut",
    looks_like = "t_tree_blackjack_harvested",
}

ccb.content.define_terrain {
    id = "t_tree_blackjack",
    copy_from = "t_tree_abstract",
    name = ccb.content.text("blackjack oak"),
    description = ccb.content.text("A deciduous tree of the genus 'Quercus', with bark cracked into rectangular black plates split by narrow orange fissures.  You could peel off the bark sections if you examined the tree more closely."),
    transforms_into = "t_tree_blackjack_harvested",
    harvest_by_season = {
        { seasons = { "spring", "summer", "autumn", "winter" }, harvest = "blackjack_harv" },
    },
}

ccb.content.define_terrain {
    id = "t_tree_blackjack_harvested",
    copy_from = "t_tree_blackjack",
    looks_like = "t_tree_dead",
    description = ccb.content.text("A deciduous tree of the genus 'Quercus', with bark cracked into rectangular black plates split by narrow orange fissures.  All the usable bark has been stripped off."),
    transforms_into = "t_tree_blackjack",
}

ccb.content.define_terrain {
    id = "t_tree_alder",
    copy_from = "t_tree_abstract",
    name = ccb.content.text("alder tree"),
    description = ccb.content.text("A deciduous flowering tree with serrated, scalloped, round-obovate leaves, commonly forming dense groves alongside water."),
    color = { "green", "green", "yellow_yellow", "brown" },
    transforms_into = "t_tree_alder_harvested",
    looks_like = "t_tree_hickory",
    harvest_by_season = { { seasons = { "spring", "autumn" }, harvest = "alder_harv" } },
}

ccb.content.define_terrain {
    id = "t_tree_alder_harvested",
    copy_from = "t_tree_alder",
    transforms_into = "t_tree_alder",
    looks_like = "t_tree_hickory_harvested",
}

ccb.content.define_terrain {
    id = "t_tree_chestnut",
    copy_from = "t_tree_abstract",
    name = ccb.content.text("chestnut tree"),
    description = ccb.content.text("A massive tree belonging to the 'Castanea' genus.  If you look closely, you can see some unharvested chestnuts."),
    transforms_into = "t_tree_chestnut_harvested",
    looks_like = "t_tree_hickory",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "chestnut_harv" } },
}

ccb.content.define_terrain {
    id = "t_tree_chestnut_harvested",
    copy_from = "t_tree_chestnut",
    description = ccb.content.text("A massive tree belonging to the 'Castanea' genus."),
    transforms_into = "t_tree_chestnut",
    looks_like = "t_tree_hickory_harvested",
}

ccb.content.define_terrain {
    id = "t_tree_beech",
    copy_from = "t_tree_abstract",
    name = ccb.content.text("beech tree"),
    description = ccb.content.text("A massive tree belonging to the 'Fagus' genus.  If you look closely, you can see some unharvested beech nuts."),
    transforms_into = "t_tree_beech_harvested",
    looks_like = "t_tree_hickory",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "beech_harv" } },
}

ccb.content.define_terrain {
    id = "t_tree_beech_harvested",
    copy_from = "t_tree_beech",
    description = ccb.content.text("A massive tree belonging to the 'Fagus' genus."),
    transforms_into = "t_tree_beech",
    looks_like = "t_tree_hickory_harvested",
}

ccb.content.define_terrain {
    id = "t_tree_hazelnut",
    copy_from = "t_tree_abstract",
    name = ccb.content.text("hazelnut tree"),
    description = ccb.content.text("A stubby tree belonging to the 'Corylus' genus.  If you look closely, you can see some unharvested hazelnuts."),
    color = { "green", "green", "light_green_yellow", "brown" },
    extend = { flags = { "BROWSABLE" } },
    transforms_into = "t_tree_hazelnut_harvested",
    looks_like = "t_tree_hickory",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "hazelnut_harv" } },
}

ccb.content.define_terrain {
    id = "t_tree_hazelnut_harvested",
    copy_from = "t_tree_hazelnut",
    name = ccb.content.text("hazelnut tree"),
    description = ccb.content.text("A stubby tree belonging to the 'Corylus' genus."),
    delete = { flags = { "BROWSABLE" } },
    transforms_into = "t_tree_hazelnut",
    looks_like = "t_tree_hickory_harvested",
}

ccb.content.define_terrain {
    id = "t_tree_basswood",
    copy_from = "t_tree_abstract",
    name = ccb.content.text("basswood tree"),
    description = ccb.content.text("The American linden.  It has pretty and sweet-smelling flowers in the summer, and you might be able to eat its young leaves in the spring."),
    builtin_examine = "harvest_ter_nectar",
    transforms_into = "t_tree_basswood_harvested",
    harvest_by_season = { { seasons = { "spring" }, harvest = "young_leaves_harv" } },
}

ccb.content.define_terrain {
    id = "t_tree_basswood_harvested",
    copy_from = "t_tree_basswood",
    description = ccb.content.text("The American linden.  It has pretty and sweet-smelling flowers in the summer, and its edible young leaves have already been harvested."),
    transforms_into = "t_tree_basswood",
}

-- Do something cool with this and have it spread cotton around the area or something.
ccb.content.define_terrain {
    id = "t_tree_cottonwood",
    copy_from = "t_tree_abstract",
    name = ccb.content.text("cottonwood tree"),
    description = ccb.content.text("A large tree belonging to the 'Populus' genus, commonly found throughout the New England region.  You see some cottonwood tree bolls that can be harvested."),
    transforms_into = "t_tree_cottonwood_harvested",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn" }, harvest = "cottonwood_harv" } },
}

ccb.content.define_terrain {
    id = "t_tree_cottonwood_harvested",
    copy_from = "t_tree_cottonwood",
    name = ccb.content.text("cottonwood tree"),
    description = ccb.content.text("A large tree belonging to the 'Populus' genus, commonly found throughout the New England region.  All the cottonwood tree bolls have been harvested."),
    transforms_into = "t_tree_cottonwood",
}

ccb.content.define_terrain {
    id = "t_tree_elm",
    copy_from = "t_tree_abstract",
    name = ccb.content.text("elm tree"),
    looks_like = "t_tree_cottonwood",
    description = ccb.content.text("A large tree belonging to the 'Ulmus' genus, commonly found throughout the New England region."),
}

-- gives a maximum of ~15L and ~8.5kg of wood between sticks and twigs
ccb.content.define_terrain {
    id = "t_tree_dead",
    copy_from = "t_tree_abstract",
    name = ccb.content.text("dead tree"),
    description = ccb.content.text("An indiscernible tree that has withered away due to weather, fire, or otherworldly causes."),
    color = "brown",
    roof = "t_treetop_dead",
    harvest_by_season = {
        { seasons = { "spring", "summer", "autumn", "winter" }, harvest = "tree_dead_harv" },
    },
    transforms_into = "t_tree_very_dead",
    bash = {
        minimum_strength = 70,
        maximum_strength = 140,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = { { item = "stick_long", count = { 3, 10 } }, { item = "splinter", count = { 15, 30 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_very_dead",
    copy_from = "t_tree_dead",
    name = ccb.content.text("dead tree"),
    description = ccb.content.text("An indiscernible tree that has withered away due to weather, fire, or otherworldly causes.  Someone or something has broken most of its dead branches, leaving little but its gnarled trunk."),
    bash = {
        minimum_strength = 70,
        maximum_strength = 140,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = { { item = "stick_long", count = { 2, 6 } }, { item = "splinter", count = { 10, 20 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_dead_warped",
    copy_from = "t_tree_dead",
    symbol = "G",
    name = ccb.content.text("warped dead tree"),
    description = ccb.content.text("This deciduous tree's branches are warped into a spiral.  This appears to have killed it."),
}

ccb.content.define_terrain {
    id = "t_highland_holy_tree",
    copy_from = "t_tree_dead",
    symbol = "G",
    name = ccb.content.text("dead holy tree"),
    description = ccb.content.text("Censers and candlelamps hang from the twisted branches of this tree, which seems to have been revered in the past.  A sword is embedded in its trunk."),
    bash = {
        minimum_strength = 70,
        maximum_strength = 140,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 2, 6 } },
            { item = "splinter", count = { 10, 20 } },
            { item = "khopesh", variant = "highlands_holy" },
            { item = "highland_censer", count = { 6, 12 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_highland_flower_bed",
    copy_from = "t_grass_long",
    symbol = "G",
    name = ccb.content.text("flower bed"),
    looks_like = "f_alien_zapper",
    description = ccb.content.text("Dozens of large blue flowers grow nearly parallel to the ground .  They retain a neat arrangement even when growing wild."),
}

-- barren in winter
ccb.content.define_terrain {
    id = "t_tree_young",
    name = ccb.content.text("young tree"),
    looks_like = "t_tree",
    description = ccb.content.text("A relatively young sapling of an indeterminate species.  It could take decades before reaching maturity, so there's no use waiting around."),
    symbol = "1",
    color = { "green", "green", "green", "brown" },
    move_cost = 4,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "NOITEM", "YOUNG", "REDUCE_SCENT", "CLIMB_ADJACENT" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 50,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 0, 5 } },
            { item = "splinter", count = { 0, 4 } },
            { item = "twig", count = { 2, 7 } },
            { item = "leaves", count = { 5, 20 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- barren in winter
ccb.content.define_terrain {
    id = "t_mega_fern",
    name = ccb.content.text("mega fern"),
    looks_like = "t_tree_young",
    description = ccb.content.text("A gigantic fern like nothing you've seen before.  The leaves are a bright scarlet with a net-like structure of green veins.  The multipronged trunks have the texture of balsa wood."),
    symbol = "1",
    color = { "red_green", "red_green", "red_green", "brown" },
    move_cost = 4,
    roof = "t_treetop_giant_fern",
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "NOITEM", "YOUNG", "REDUCE_SCENT", "CLIMB_ADJACENT" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 50,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = { { item = "alien_fern", count = { 0, 5 } } },
    },
}

ccb.content.define_terrain {
    abstract = "t_tree_fruit_abstract",
    copy_from = "t_tree_abstract",
    looks_like = "t_tree_apple",
    color = { "light_green", "light_green", "red_green", "brown" },
    extend = { flags = { "BROWSABLE" } },
}

ccb.content.define_terrain {
    id = "t_tree_apple",
    copy_from = "t_tree_fruit_abstract",
    name = ccb.content.text("apple tree"),
    description = ccb.content.text("This tree is a member of the 'Malus' genus, producing fruit commonly known as apples.  If you examined the branches more closely, you could probably find a few mature ones in autumn."),
    transforms_into = "t_tree_apple_harvested",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "apple_harv" } },
}

ccb.content.define_terrain {
    id = "t_tree_apple_harvested",
    copy_from = "t_tree_apple",
    looks_like = "t_tree_dead",
    description = ccb.content.text("This tree is a member of the 'Malus' genus, producing fruit commonly known as apples.  There do not appear to be any ripe apples now."),
    color = { "light_green", "light_green", "light_green", "brown" },
    extend = { flags = { "HARVESTED" } },
    delete = { flags = { "BROWSABLE" } },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_apple",
}

ccb.content.define_terrain {
    id = "t_tree_crabapple",
    copy_from = "t_tree_fruit_abstract",
    name = ccb.content.text("crabapple tree"),
    looks_like = "t_tree_hickory",
    description = ccb.content.text("This tree is a member of the 'Malus' genus, though unlike popular cultivars, its fruits are small and sour.  If you examined the branches more closely, you could probably find a few mature ones in autumn."),
    transforms_into = "t_tree_crabapple_harvested",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "crabapple_harv" } },
}

ccb.content.define_terrain {
    id = "t_tree_crabapple_harvested",
    copy_from = "t_tree_crabapple",
    looks_like = "t_tree_dead",
    description = ccb.content.text("This tree is a member of the 'Malus' genus, though unlike popular cultivars, its fruits are small and sour.  There do not appear to be any ripe crabapples now."),
    color = { "light_green", "light_green", "light_green", "brown" },
    extend = { flags = { "HARVESTED" } },
    delete = { flags = { "BROWSABLE" } },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_crabapple",
}

ccb.content.define_terrain {
    id = "t_tree_pear",
    copy_from = "t_tree_fruit_abstract",
    name = ccb.content.text("pear tree"),
    description = ccb.content.text("This is 'Pyrus communis', or the common pear tree, which produces fruit in the fall.  If you examined the branches more closely, you could probably find a few mature ones."),
    color = { "light_green", "light_green", "light_green_green", "brown" },
    transforms_into = "t_tree_pear_harvested",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "pear_harv" } },
}

ccb.content.define_terrain {
    id = "t_tree_pear_harvested",
    copy_from = "t_tree_pear",
    name = ccb.content.text("pear tree"),
    looks_like = "t_tree_apple_harvested",
    description = ccb.content.text("This is 'Pyrus communis', or the common pear tree, which produces fruit in the fall.  Looks like all the ripe pears have been picked."),
    color = { "light_green", "light_green", "light_green", "brown" },
    extend = { flags = { "HARVESTED" } },
    delete = { flags = { "BROWSABLE" } },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_pear",
}

ccb.content.define_terrain {
    id = "t_tree_coffee",
    copy_from = "t_tree_abstract",
    name = ccb.content.text("coffee tree"),
    description = ccb.content.text("This is 'Gymnocladus dioicus', or the Kentucky coffee tree, which produces roastable coffee pods and brewable leaves in the fall.  If you examined the branches more closely, you could probably find a few mature ones."),
    color = { "light_green", "light_green", "light_green_green", "brown" },
    transforms_into = "t_tree_coffee_harvested",
    looks_like = "t_tree_plum",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "coffee_harv" } },
}

ccb.content.define_terrain {
    id = "t_tree_coffee_harvested",
    copy_from = "t_tree_coffee",
    description = ccb.content.text("This is 'Gymnocladus dioicus', or the Kentucky coffee tree, which produces roastable coffee pods and brewable leaves in the fall.  Looks like all the ripe pods have been picked."),
    color = { "light_green", "light_green", "light_green", "brown" },
    extend = { flags = { "HARVESTED" } },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_coffee",
    looks_like = "t_tree_plum_harvested",
}

-- barren in winter, fruits in summer
ccb.content.define_terrain {
    id = "t_tree_cherry",
    name = ccb.content.text("cherry tree"),
    looks_like = "t_tree_apple",
    description = ccb.content.text("One of the several species of 'Prunus' trees found in New England, it bears cherries in the summer.  If you examined the foliage more closely, you could probably find some viable clusters."),
    symbol = "7",
    color = { "light_green", "red_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "BROWSABLE",
        "CLIMB_ADJACENT",
    },
    transforms_into = "t_tree_cherry_harvested",
    builtin_examine = "harvest_ter_nectar",
    harvest_by_season = { { seasons = { "summer" }, harvest = "cherry_harv" } },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- barren in winter, no fruits anymore
ccb.content.define_terrain {
    id = "t_tree_cherry_harvested",
    name = ccb.content.text("cherry tree"),
    looks_like = "t_tree_apple_harvested",
    description = ccb.content.text("One of the several species of 'Prunus' trees found in New England, it bears cherries in the summer.  Looks like all the ripe bunches of cherries have been picked."),
    symbol = "7",
    color = { "light_green", "light_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "HARVESTED",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_cherry",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- Can be picked at any point in the third year assuming the berries have turned blue. But it takes a long time to regrow.
ccb.content.define_terrain {
    id = "t_tree_juniper",
    name = ccb.content.text("juniper tree"),
    looks_like = "t_tree_pine",
    description = ccb.content.text("One of the species of 'Juniperus' that grows in New England, juniper berries grow over two to three years.  It flowers in the first year, produces a green berry the second, and in the third produces the more famed blue varieties.  If you examined the foliage more closely, you could probably find some viable clusters."),
    symbol = "7",
    color = { "light_green", "light_green", "blue_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "BROWSABLE",
        "CLIMB_ADJACENT",
    },
    transforms_into = "t_tree_juniper_harvested",
    builtin_examine = "harvest_ter_nectar",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "juniper_harv" } },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = { { item = "stick_long", count = { 3, 10 } }, { item = "splinter", count = { 10, 25 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- Will take three years to regrow, in reality.
ccb.content.define_terrain {
    id = "t_tree_juniper_harvested",
    name = ccb.content.text("juniper tree"),
    looks_like = "t_tree_pine_harvested",
    description = ccb.content.text("One of the species of 'Juniperus' that grows in New England, juniper berries grow over two to three years.  It flowers in the first year, produces a green berry the second, and in the third produces the more famed blue varieties.  Looks like all the ripe bunches of berries have been picked."),
    symbol = "7",
    color = { "light_green", "light_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "HARVESTED",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_juniper",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = { { item = "stick_long", count = { 3, 10 } }, { item = "splinter", count = { 10, 25 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- barren in winter, fruits in summer
ccb.content.define_terrain {
    id = "t_tree_peach",
    name = ccb.content.text("peach tree"),
    looks_like = "t_tree_apple",
    description = ccb.content.text("One of the several species of 'Prunus' trees found in New England, it bears peaches in the summer.  If you examined the branches more closely, you could probably find some mature peaches."),
    symbol = "7",
    color = { "light_green", "light_red_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "BROWSABLE",
        "CLIMB_ADJACENT",
    },
    transforms_into = "t_tree_peach_harvested",
    builtin_examine = "harvest_ter_nectar",
    harvest_by_season = { { seasons = { "summer" }, harvest = "peach_harv" } },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- barren in winter, no fruits anymore
ccb.content.define_terrain {
    id = "t_tree_peach_harvested",
    name = ccb.content.text("peach tree"),
    looks_like = "t_tree_apple_harvested",
    description = ccb.content.text("One of the several species of 'Prunus' trees found in New England, it bears peaches in the summer.  Looks like all the ripe peaches have been picked."),
    symbol = "7",
    color = { "light_green", "light_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "HARVESTED",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_peach",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- barren in winter, fruits in summer
ccb.content.define_terrain {
    id = "t_tree_apricot",
    name = ccb.content.text("apricot tree"),
    looks_like = "t_tree_peach",
    description = ccb.content.text("A transplanted species of 'Prunus armeniaca', rarely found in New England.  It produces apricots in the summer.  If you examined the spurs more closely, you could probably find some mature apricots."),
    symbol = "7",
    color = { "light_green", "light_red_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "BROWSABLE",
        "CLIMB_ADJACENT",
    },
    transforms_into = "t_tree_apricot_harvested",
    builtin_examine = "harvest_ter_nectar",
    harvest_by_season = { { seasons = { "summer" }, harvest = "apricot_harv" } },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- barren in winter, no fruits anymore
ccb.content.define_terrain {
    id = "t_tree_apricot_harvested",
    name = ccb.content.text("apricot tree"),
    looks_like = "t_tree_peach_harvested",
    description = ccb.content.text("A transplanted species of 'Prunus armeniaca', rarely found in New England.  It produces apricots in the summer.  Looks like all the ripe apricots have been picked."),
    symbol = "7",
    color = { "light_green", "light_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "HARVESTED",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_apricot",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- barren in winter, fruits in summer
ccb.content.define_terrain {
    id = "t_tree_plum",
    name = ccb.content.text("plum tree"),
    looks_like = "t_tree_apple",
    description = ccb.content.text("One of the several species of 'Prunus' trees found in New England, it produces plums in the summer.  If you examined the spurs more closely, you could probably find some ripe plums."),
    symbol = "7",
    color = { "light_green", "magenta_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "BROWSABLE",
        "CLIMB_ADJACENT",
    },
    transforms_into = "t_tree_plum_harvested",
    builtin_examine = "harvest_ter_nectar",
    harvest_by_season = { { seasons = { "summer" }, harvest = "plum_harv" } },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- barren in winter, no fruits anymore
ccb.content.define_terrain {
    id = "t_tree_plum_harvested",
    name = ccb.content.text("plum tree"),
    looks_like = "t_tree_apple_harvested",
    description = ccb.content.text("One of the several species of 'Prunus' trees found in New England, it produces plums in the summer.  Looks like all the ripe plums have been picked."),
    symbol = "7",
    color = { "light_green", "light_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "HARVESTED",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_plum",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- barren in winter, fruits in summer
ccb.content.define_terrain {
    id = "t_tree_mulberry",
    name = ccb.content.text("mulberry tree"),
    description = ccb.content.text("This tree is a member of the 'Morus' genus, producing fruit commonly known as mulberries.  In the summer, many berries can be picked."),
    symbol = "7",
    color = { "light_green", "red_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "BROWSABLE",
        "CLIMB_ADJACENT",
    },
    transforms_into = "t_tree_mulberry_harvested",
    builtin_examine = "harvest_ter_nectar",
    looks_like = "t_tree_apple",
    fruit_climate = {
        harvest = "mulberry_harv",
        growth = {
            base_c = 7,
            optimum_c = 25,
            min_c = -4,
            max_c = 38,
            degree_days = 620,
            water_mm = 240,
            growing_days = 55,
            water_peak = 0.6,
        },
        bearing_days = 30,
    },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- barren in winter, no fruits anymore
ccb.content.define_terrain {
    id = "t_tree_mulberry_harvested",
    name = ccb.content.text("mulberry tree"),
    description = ccb.content.text("This tree is a member of the 'Morus' genus, producing fruit commonly known as mulberries.  There do not appear to be any ripe mulberries now."),
    symbol = "7",
    color = { "light_green", "light_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "HARVESTED",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_mulberry",
    looks_like = "t_tree_apple_harvested",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_tupelo",
    name = ccb.content.text("tupelo tree"),
    description = ccb.content.text("Its name, originating from Native American tongues and garbled by the settlers, approximately means \"swamp tree\".  During autumn it bears cherry-like fruits."),
    symbol = "7",
    color = { "light_green", "red_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "BROWSABLE",
        "CLIMB_ADJACENT",
    },
    transforms_into = "t_tree_tupelo_harvested",
    builtin_examine = "harvest_ter_nectar",
    looks_like = "t_tree_plum",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "tupelo_harv" } },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_tupelo_harvested",
    name = ccb.content.text("tupelo tree"),
    description = ccb.content.text("Its name, originating from Native American tongues and garbled by the settlers, approximately means \"swamp tree\".  During autumn it bears cherry-like fruits, but someone picked this one clean already."),
    symbol = "7",
    color = { "light_green", "light_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "HARVESTED",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_tupelo",
    looks_like = "t_tree_plum_harvested",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_nannyberry",
    name = ccb.content.text("nannyberry tree"),
    description = ccb.content.text("This small tree, it could almost be a large shrub, bears clusters of dark blue berries in autumn."),
    symbol = "7",
    color = { "light_green", "light_green", "red_green", "brown" },
    move_cost = 0,
    coverage = 70,
    flags = { "FLAMMABLE_ASH", "NOITEM", "TREE", "REDUCE_SCENT", "BROWSABLE", "CLIMB_ADJACENT" },
    transforms_into = "t_tree_nannyberry_harvested",
    builtin_examine = "harvest_ter_nectar",
    looks_like = "t_tree_plum",
    fruit_climate = {
        harvest = "nannyberry_harv",
        growth = {
            base_c = 5,
            optimum_c = 23,
            min_c = -4,
            max_c = 35,
            degree_days = 1020,
            water_mm = 350,
            growing_days = 108,
            water_peak = 0.7,
        },
        bearing_days = 44,
    },
    bash = {
        minimum_strength = 40,
        maximum_strength = 120,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_nannyberry_harvested",
    name = ccb.content.text("nannyberry tree"),
    description = ccb.content.text("This small tree, it could almost be a large shrub, bears clusters of dark blue berries in autumn, but someone picked this one clean already."),
    symbol = "7",
    color = { "light_green", "light_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 70,
    flags = { "FLAMMABLE_ASH", "NOITEM", "TREE", "REDUCE_SCENT", "HARVESTED", "CLIMB_ADJACENT" },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_nannyberry",
    looks_like = "t_tree_plum_harvested",
    bash = {
        minimum_strength = 40,
        maximum_strength = 120,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- barren in winter, fruits in summer
ccb.content.define_terrain {
    id = "t_tree_elderberry",
    name = ccb.content.text("elderberry tree"),
    description = ccb.content.text("This tree is a member of the 'Sambucus' genus, producing fruit commonly known as elderberries.  In the summer, many berries can be picked."),
    symbol = "7",
    color = { "light_green", "red_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "BROWSABLE",
        "CLIMB_ADJACENT",
    },
    transforms_into = "t_tree_elderberry_harvested",
    builtin_examine = "harvest_ter_nectar",
    looks_like = "t_tree_plum",
    fruit_climate = {
        harvest = "elderberry_harv",
        growth = {
            base_c = 5,
            optimum_c = 24,
            min_c = -4,
            max_c = 35,
            degree_days = 850,
            water_mm = 340,
            growing_days = 82,
            water_peak = 0.7,
        },
        bearing_days = 34,
    },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- barren in winter, no fruits anymore
ccb.content.define_terrain {
    id = "t_tree_elderberry_harvested",
    name = ccb.content.text("elderberry tree"),
    description = ccb.content.text("This tree is a member of the 'Sambucus' genus, producing fruit commonly known as elderberries.  There do not appear to be any ripe elderberries now."),
    symbol = "7",
    color = { "light_green", "light_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "HARVESTED",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_elderberry",
    looks_like = "t_tree_plum_harvested",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_pine",
    name = ccb.content.text("pine tree"),
    looks_like = "t_tree",
    description = ccb.content.text("A towering coniferous tree that belongs to the 'Pinus' genus, with the New England species varying from 'P. strobus', 'P. resinosa' and 'P. rigida'.  If you examined the tree more closely, you might find usable sticky whorls, resin clumps, and pinecones."),
    symbol = "4",
    color = "green",
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop_evergreen",
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT", "CLIMB_ADJACENT" },
    transforms_into = "t_tree_pine_harvested",
    builtin_examine = "harvest_ter",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn", "winter" }, harvest = "pine_harv" } },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = { { item = "stick_long", count = { 3, 10 } }, { item = "splinter", count = { 10, 25 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_pine_harvested",
    name = ccb.content.text("pine tree"),
    description = ccb.content.text("A towering coniferous tree that belongs to the 'Pinus' genus, with the New England species varying from 'P. strobus', 'P. resinosa' and 'P. rigida'.  Some of the branches and resin clumps have been stripped away and many of the pinecones aren't developed fully yet, but given a season, it could be harvestable again."),
    symbol = "4",
    color = "brown",
    roof = "t_treetop_evergreen",
    copy_from = "t_tree_pine",
    looks_like = "t_tree_deadpine",
    transforms_into = "t_tree_pine",
    builtin_examine = "harvested_plant",
}

ccb.content.define_terrain {
    id = "t_tree_spruce",
    looks_like = "t_tree_pine",
    name = ccb.content.text("spruce tree"),
    description = ccb.content.text("A towering coniferous tree that belongs to the 'Picea' genus, generally growing in northern temperate and boreal climates."),
    symbol = "4",
    color = "green",
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop_evergreen",
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT", "CLIMB_ADJACENT" },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = { { item = "stick_long", count = { 3, 10 } }, { item = "splinter", count = { 10, 25 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_deadpine",
    name = ccb.content.text("dead pine tree"),
    looks_like = "t_tree_dead",
    roof = "t_treetop_dead",
    description = ccb.content.text("A towering coniferous tree that belongs to the 'Pinus' genus, with the New England species varying from 'P. strobus', 'P. resinosa' and 'P. rigida'.  This tree's branches are bare, and it appears to be dead."),
    symbol = "4",
    color = "brown",
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT", "CLIMB_ADJACENT" },
    bash = {
        minimum_strength = 60,
        maximum_strength = 120,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = { { item = "stick_long", count = { 3, 10 } }, { item = "splinter", count = { 10, 25 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_deadpine_warped",
    name = ccb.content.text("warped dead pine tree"),
    copy_from = "t_tree_deadpine",
    looks_like = "t_tree_deadpine",
    symbol = "Y",
    color = "brown",
    description = ccb.content.text("The branches of this pine tree have been twisted into a shape that remind you of Sierpinski triangles.  It did not survive being warped like this."),
}

-- barren in winter, harvestable all year round
ccb.content.define_terrain {
    id = "t_tree_birch",
    name = ccb.content.text("birch tree"),
    looks_like = "t_tree",
    roof = "t_treetop",
    description = ccb.content.text("A tall deciduous tree of the 'Betula' genus, with the characteristic peeling bark.  Species like 'B. alleghaniensis', 'B. papyrifera', and 'B. populifolia' are the most common in the New England region.  You could tear off some strips of bark if you examined the tree more closely."),
    symbol = "7",
    color = "white",
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT", "CLIMB_ADJACENT" },
    builtin_examine = "harvest_ter",
    transforms_into = "t_tree_birch_harvested",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn", "winter" }, harvest = "birch_harv" } },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- dead, not harvestable
ccb.content.define_terrain {
    id = "t_tree_birch_harvested",
    name = ccb.content.text("birch tree"),
    looks_like = "t_tree_harvested",
    roof = "t_treetop",
    description = ccb.content.text("A tall deciduous tree of the 'Betula' genus, with the characteristic peeling bark.  Species like 'B. alleghaniensis', 'B. papyrifera', and 'B. populifolia' are the most common in the New England region.  Looks like there isn't enough rhytidome to peel off yet."),
    symbol = "7",
    color = "green",
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT", "CLIMB_ADJACENT" },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- barren in winter, harvestable all year round
ccb.content.define_terrain {
    id = "t_tree_willow",
    name = ccb.content.text("willow tree"),
    looks_like = "t_tree",
    roof = "t_treetop",
    description = ccb.content.text("A tall, wide deciduous tree of the 'Salix' genus, with long, thin, leafy branches that hang down like curtains.  You could tear off some bark."),
    symbol = "4",
    color = { "light_green", "light_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT", "CLIMB_ADJACENT" },
    builtin_examine = "harvest_ter",
    transforms_into = "t_tree_willow_harvested",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn", "winter" }, harvest = "willow_harv" } },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- barren in winter, not harvestable
ccb.content.define_terrain {
    id = "t_tree_willow_harvested",
    name = ccb.content.text("willow tree"),
    looks_like = "t_tree_harvested",
    description = ccb.content.text("A tall, wide deciduous tree of the 'Salix' genus, with long, thin, leafy branches that hang down like curtains.  Looks like all usable bark has been torn off, and new rhytidomes have not formed yet."),
    symbol = "4",
    roof = "t_treetop",
    color = { "brown", "brown", "brown", "brown" },
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT", "CLIMB_ADJACENT" },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_maple",
    name = ccb.content.text("maple tree"),
    looks_like = "t_tree",
    roof = "t_treetop",
    description = ccb.content.text("A large deciduous tree of the 'Acer' genus.  The leaves are distinctively shaped with five prongs.  It could be tapped in order to extract maple sap."),
    symbol = "7",
    color = { "red", "light_green", "light_green", "red" },
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT", "CLIMB_ADJACENT" },
    builtin_examine = "tree_maple",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_maple_tapped",
    name = ccb.content.text("maple tree"),
    looks_like = "t_tree_maple",
    roof = "t_treetop",
    description = ccb.content.text("A large deciduous tree of the 'Acer' genus.  The leaves are distinctively shaped with five prongs.  A spigot is wedged into the trunk, and sweet maple sap can be extracted."),
    symbol = "7",
    color = { "red", "light_green", "light_green", "red" },
    move_cost = 0,
    coverage = 80,
    flags = {
        "FLAMMABLE_ASH",
        "SEALED",
        "PLACE_ITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "LIQUIDCONT",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "tree_maple_tapped",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- barren in winter, harvestable in autumn
ccb.content.define_terrain {
    id = "t_tree_hickory",
    name = ccb.content.text("hickory tree"),
    looks_like = "t_tree",
    roof = "t_treetop",
    description = ccb.content.text("A tall deciduous tree of the 'Carya' genus.  You could look for hickory nuts if you examined the tree more closely."),
    symbol = "7",
    color = { "light_green", "light_green", "i_light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "BROWSABLE",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "tree_hickory",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "hickory_harv" } },
    transforms_into = "t_tree_hickory_harvested",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- barren in winter, kind of harvestable
ccb.content.define_terrain {
    id = "t_tree_hickory_harvested",
    looks_like = "t_tree_harvested",
    description = ccb.content.text("A tall deciduous tree of the 'Carya' genus.  It looks like the tree has been picked clean of hickory nuts."),
    name = ccb.content.text("hickory tree"),
    symbol = "7",
    color = { "light_green", "light_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "HARVESTED",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "tree_hickory",
    transforms_into = "t_tree_hickory",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- Pistachio tree is not a local native and is only used in specific locations like orchards and gardens.
ccb.content.define_terrain {
    id = "t_tree_pistachio",
    name = ccb.content.text("pistachio tree"),
    description = ccb.content.text("A deciduous tree of the 'Pistacia' genus.  This is a cultivated tree, and is not native to this region.  You could look for pistachio nuts if you examined the tree more closely."),
    looks_like = "t_tree_hickory",
    symbol = "7",
    color = { "light_green", "light_green", "brown_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "BROWSABLE",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "harvest_ter",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "pistachio_harv" } },
    transforms_into = "t_tree_pistachio_harvested",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_pistachio_harvested",
    name = ccb.content.text("pistachio tree"),
    description = ccb.content.text("A deciduous tree of the 'Pistacia' genus.  This is a cultivated tree, and is not native to this region.  Unfortunately, it looks like it has been picked clean of pistachio nuts."),
    looks_like = "t_tree_hickory_harvested",
    roof = "t_treetop",
    symbol = "7",
    color = { "light_green", "light_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "HARVESTED",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_pistachio",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- Almond tree is not a local native and is only used in specific locations like orchards and gardens.
ccb.content.define_terrain {
    id = "t_tree_almond",
    name = ccb.content.text("almond tree"),
    description = ccb.content.text("A deciduous tree of the 'Prunus' genus.  This is a cultivated tree, and is not native to this region.  You could look for fresh almonds if you examined the tree more closely."),
    looks_like = "t_tree_hickory",
    symbol = "7",
    roof = "t_treetop",
    color = { "light_green", "light_green", "brown_green", "brown" },
    move_cost = 0,
    coverage = 80,
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "BROWSABLE",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "harvest_ter",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "almond_harv" } },
    transforms_into = "t_tree_almond_harvested",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_almond_harvested",
    description = ccb.content.text("A deciduous tree of the 'Prunus' genus.  This is a cultivated tree, and is not native to this region.  There are no almonds left to pick on the tree."),
    name = ccb.content.text("almond tree"),
    looks_like = "t_tree_hickory_harvested",
    symbol = "7",
    roof = "t_treetop",
    color = { "light_green", "light_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "HARVESTED",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_almond",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- Pecan tree is not a local native and is only used in specific locations like orchards and gardens.
ccb.content.define_terrain {
    id = "t_tree_pecan",
    name = ccb.content.text("pecan tree"),
    looks_like = "t_tree_walnut",
    description = ccb.content.text("A tall deciduous tree of the 'Carya' genus.  You could look for pecan nuts if you examined the tree more closely."),
    symbol = "7",
    color = { "light_green", "light_green", "brown_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "BROWSABLE",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "harvest_ter",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "pecan_harv" } },
    transforms_into = "t_tree_pecan_harvested",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_pecan_harvested",
    name = ccb.content.text("pecan tree"),
    looks_like = "t_tree_walnut_harvested",
    description = ccb.content.text("A tall deciduous tree of the 'Carya' genus.  It doesn't look like there are any pecan nuts left on the tree."),
    symbol = "7",
    color = { "light_green", "light_green", "light_green", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "HARVESTED",
        "BROWSABLE",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_pecan",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- dead, not usable at all
ccb.content.define_terrain {
    id = "t_tree_hickory_dead",
    name = ccb.content.text("dead hickory tree"),
    looks_like = "t_tree_dead",
    description = ccb.content.text("The dead remnants of a tall deciduous tree of the 'Carya' genus.  Nothing useful can be foraged from this poor, dead tree."),
    symbol = "7",
    color = "brown",
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop_dead",
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT", "CLIMB_ADJACENT" },
    bash = {
        minimum_strength = 60,
        maximum_strength = 120,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = { { item = "stick_long", count = { 3, 10 } }, { item = "splinter", count = { 10, 25 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_tree_sassafras",
    name = ccb.content.text("sassafras tree"),
    looks_like = "t_tree_mulberry",
    roof = "t_treetop",
    description = ccb.content.text("This tree is a member of the 'Sassafras' genus, known for its aromatic qualities.  In the winter and spring, the sap rich roots can be harvested to make a sweet beverage."),
    symbol = "7",
    color = { "light_green", "light_green_yellow", "yellow_red", "brown" },
    move_cost = 0,
    coverage = 80,
    flags = { "FLAMMABLE_ASH", "NOITEM", "SUPPORTS_ROOF", "TREE", "REDUCE_SCENT", "CLIMB_ADJACENT" },
    transforms_into = "t_tree_sassafras_harvested",
    builtin_examine = "harvest_ter",
    harvest_by_season = { { seasons = { "winter", "spring" }, harvest = "sassafras_harv" } },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- Cannot be harvested
ccb.content.define_terrain {
    id = "t_tree_sassafras_harvested",
    name = ccb.content.text("sassafras tree"),
    description = ccb.content.text("This tree is a member of the 'Sassafras' genus, known for its aromatic qualities.  This tree's roots have been harvested, any more and the tree will die."),
    symbol = "7",
    color = { "light_green", "light_green_yellow", "yellow_red", "brown" },
    move_cost = 0,
    coverage = 80,
    roof = "t_treetop",
    flags = {
        "FLAMMABLE_ASH",
        "NOITEM",
        "SUPPORTS_ROOF",
        "TREE",
        "REDUCE_SCENT",
        "HARVESTED",
        "CLIMB_ADJACENT",
    },
    builtin_examine = "harvested_plant",
    transforms_into = "t_tree_sassafras",
    looks_like = "t_tree_mulberry_harvested",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "stick_long", count = { 3, 10 } },
            { item = "splinter", count = { 10, 25 } },
            { item = "leaves", count = { 50, 150 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_underbrush",
    name = ccb.content.text("underbrush"),
    looks_like = "t_shrub",
    description = ccb.content.text("Small plants and shrubs that decorate the forest.  An observant forager could obtain edible plants, acorns, eggs, and mushrooms from it."),
    symbol = "#",
    color = "light_green",
    move_cost = 6,
    coverage = 40,
    flags = {
        "TRANSPARENT",
        "DIGGABLE",
        "CONTAINER",
        "FLAMMABLE_ASH",
        "THIN_OBSTACLE",
        "PLACE_ITEM",
        "SHRUB",
        "SHORT",
        "SMALL_HIDE",
    },
    builtin_examine = "shrub_wildveggies",
    transforms_into = "t_underbrush_harvested",
    bash = {
        minimum_strength = 4,
        maximum_strength = 30,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("brush."),
        terrain = "t_dirt",
        drops = { { item = "withered", chance = 50, count = { 1, 2 } } },
    },
}

ccb.content.define_terrain {
    id = "t_underbrush_harvested",
    copy_from = "t_underbrush",
    looks_like = "t_underbrush_harvested_spring",
    description = ccb.content.text("Small plants and shrubs that decorate the forest.  It has been rummaged through and doesn't have anything useful left to forage from it."),
    color = "green",
    builtin_examine = "harvested_plant",
    extend = { flags = { "HARVESTED" } },
    transforms_into = "t_underbrush",
}

ccb.content.define_terrain {
    id = "t_beehive_natural",
    name = ccb.content.text("bee hive"),
    description = ccb.content.text("A hive of bees located in a cavity inside a tree, swarming in and out at a feverish pace.  There's probably honey inside."),
    symbol = "h",
    color = { "yellow" },
    move_cost = 0,
    coverage = 10,
    flags = { "FLAMMABLE_ASH", "NOITEM" },
    builtin_examine = "harvest_ter",
    harvest_by_season = { { seasons = { "summer", "autumn" }, harvest = "beehive_harv" } },
    transforms_into = "t_tree",
    emissions = { "emit_bees" },
    bash = {
        minimum_strength = 2,
        maximum_strength = 5,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_tree",
        drops = { { item = "wax", count = { 3, 6 } }, { item = "honeycomb", count = { 3, 6 } } },
    },
}

ccb.content.define_terrain {
    id = "t_apiary",
    name = ccb.content.text("apiary"),
    description = ccb.content.text("A man-made wooden box designed to hold honeybees and facilitate the care for a hive.  The modular construction allows for inspecting the bees and harvesting their bounty without destroying the hive completely.  This year's harvest should be ready by now."),
    symbol = "h",
    color = { "yellow" },
    move_cost = 1,
    coverage = 50,
    flags = { "FLAMMABLE_ASH", "NOITEM" },
    builtin_examine = "harvest_ter",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "beehive_harv" } },
    transforms_into = "t_apiary_empty",
    emissions = { "emit_bees" },
    bash = {
        minimum_strength = 10,
        maximum_strength = 15,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = {
            { item = "wax", count = { 3, 6 } },
            { item = "honeycomb", count = { 3, 6 } },
            { item = "2x4", count = { 8, 10 } },
            { item = "nail", charges = { 12, 20 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_apiary_empty",
    name = ccb.content.text("apiary"),
    description = ccb.content.text("A man-made wooden box designed to host honeybees and facilitate the care for a hive.  The modular construction allows for inspecting the bees and harvesting their bounty without destroying the hive completely.  It will be some time before this one is ready to harvest."),
    symbol = "h",
    color = { "light_gray" },
    move_cost = 1,
    coverage = 50,
    flags = { "FLAMMABLE_ASH", "NOITEM", "HARVESTED" },
    transforms_into = "t_apiary",
    emissions = { "emit_bees" },
    bash = {
        minimum_strength = 10,
        maximum_strength = 15,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = { { item = "2x4", count = { 8, 10 } }, { item = "nail", charges = { 12, 20 } } },
    },
}

ccb.content.define_terrain {
    id = "t_shrub_abstract",
    looks_like = "t_shrub",
    name = ccb.content.text("shrub"),
    description = ccb.content.text("A small shrub."),
    symbol = "#",
    color = "green",
    move_cost = 8,
    coverage = 40,
    flags = {
        "TRANSPARENT",
        "CONTAINER",
        "FLAMMABLE_ASH",
        "THIN_OBSTACLE",
        "PLACE_ITEM",
        "SHRUB",
        "SHORT",
        "SMALL_HIDE",
        "BROWSABLE",
    },
    bash = {
        minimum_strength = 4,
        maximum_strength = 30,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("brush."),
        terrain = "t_dirt",
        drops = {
            { item = "withered", chance = 50, count = { 1, 2 } },
            { item = "leaves", count = { 1, 10 } },
            { item = "twig", chance = 80, count = { 1, 5 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_shrub",
    copy_from = "t_shrub_abstract",
    delete = { flags = { "BROWSABLE" } },
}

-- Peanut bushes are not a local native so this is for use in specific locations like farms and gardens.
ccb.content.define_terrain {
    id = "t_shrub_peanut",
    copy_from = "t_shrub_abstract",
    name = ccb.content.text("peanut bush"),
    description = ccb.content.text("A small bush of crunchy peanuts."),
    color = "brown_green",
    transforms_into = "t_shrub_peanut_harvested",
    builtin_examine = "harvest_ter_nectar",
    harvest_by_season = { { seasons = { "autumn" }, harvest = "shrub_peanut_harv" } },
}

ccb.content.define_terrain {
    id = "t_shrub_peanut_harvested",
    copy_from = "t_shrub_peanut",
    description = ccb.content.text("A small peanut bush that's fruitless."),
    color = "light_gray_green",
    extend = { flags = { "HARVESTED" } },
    transforms_into = "t_shrub_peanut",
    builtin_examine = "harvested_plant",
}

ccb.content.define_terrain {
    id = "t_shrub_autumn_olive",
    copy_from = "t_shrub_abstract",
    name = ccb.content.text("autumn olive"),
    looks_like = "t_shrub_raspberry",
    description = ccb.content.text("An invasive species from Japan which is also called silverberry.  Widely planted in the 1940s to combat erosion, it spread far and wide, often even displacing native plants.  As it name says, it bears fruits in autumn, which are quite unlike olives."),
    color = "light_blue_green",
    move_cost = 9,
    coverage = 60,
    transforms_into = "t_shrub_autumn_olive_harvested",
    builtin_examine = "harvest_ter_nectar",
    fruit_climate = {
        harvest = "shrub_autumn_olive_harv",
        growth = {
            base_c = 5,
            optimum_c = 24,
            min_c = -5,
            max_c = 38,
            degree_days = 1410,
            water_mm = 300,
            growing_days = 116,
            water_peak = 0.66,
        },
        bearing_days = 45,
    },
}

ccb.content.define_terrain {
    id = "t_shrub_autumn_olive_harvested",
    copy_from = "t_shrub_autumn_olive",
    description = ccb.content.text("An invasive species from Japan which is also called silverberry.  Widely planted in the 1940s to combat erosion, it spread far and wide, often even displacing native plants.  As it name says, it bears fruits in autumn, which are quite unlike olives, but this particular plant has been harvested already."),
    color = "blue_green",
    extend = { flags = { "HARVESTED" } },
    transforms_into = "t_shrub_autumn_olive",
    builtin_examine = "harvested_plant",
}

ccb.content.define_terrain {
    id = "t_shrub_hobblebush",
    copy_from = "t_shrub_abstract",
    name = ccb.content.text("hobblebush"),
    looks_like = "t_shrub_blueberry",
    description = ccb.content.text("Called hobblebush because it may hinder and trip, hobbles, unwary hikers with its branches bending over and taking root.  It also bears surprisingly sweet berries in autumn."),
    color = "light_blue_green",
    move_cost = 9,
    transforms_into = "t_shrub_hobblebush_harvested",
    builtin_examine = "harvest_ter_nectar",
    fruit_climate = {
        harvest = "shrub_hobblebush_harv",
        growth = {
            base_c = 5,
            optimum_c = 22,
            min_c = -6,
            max_c = 33,
            degree_days = 830,
            water_mm = 330,
            growing_days = 95,
            water_peak = 0.62,
        },
        bearing_days = 36,
    },
}

ccb.content.define_terrain {
    id = "t_shrub_hobblebush_harvested",
    copy_from = "t_shrub_hobblebush",
    description = ccb.content.text("Called hobblebush because it may hinder and trip, hobbles, unwary hikers with its branches bending over and taking root.  It also bears surprisingly sweet berries in autumn, if it hadn't been picked clean already."),
    color = "blue_green",
    extend = { flags = { "HARVESTED" } },
    transforms_into = "t_shrub_hobblebush",
    builtin_examine = "harvested_plant",
}

ccb.content.define_terrain {
    id = "t_shrub_blueberry",
    copy_from = "t_shrub_abstract",
    name = ccb.content.text("blueberry bush"),
    description = ccb.content.text("A small bush of sweet blueberries."),
    color = "light_blue_green",
    transforms_into = "t_shrub_blueberry_harvested",
    builtin_examine = "harvest_ter_nectar",
    fruit_climate = {
        harvest = "shrub_blueberry_harv",
        growth = {
            base_c = 5,
            optimum_c = 22,
            min_c = -4,
            max_c = 34,
            degree_days = 620,
            water_mm = 280,
            growing_days = 68,
            water_peak = 0.65,
        },
        bearing_days = 42,
    },
}

ccb.content.define_terrain {
    id = "t_shrub_blueberry_harvested",
    copy_from = "t_shrub_blueberry",
    description = ccb.content.text("A small blueberry bush that's fruitless."),
    color = "blue_green",
    extend = { flags = { "HARVESTED" } },
    transforms_into = "t_shrub_blueberry",
    builtin_examine = "harvested_plant",
}

ccb.content.define_terrain {
    id = "t_shrub_strawberry",
    copy_from = "t_shrub_abstract",
    name = ccb.content.text("strawberry bush"),
    description = ccb.content.text("A small bush of juicy strawberries."),
    color = "light_red_green",
    transforms_into = "t_shrub_strawberry_harvested",
    builtin_examine = "harvest_ter_nectar",
    fruit_climate = {
        harvest = "shrub_strawberry_harv",
        growth = {
            base_c = 5,
            optimum_c = 22,
            min_c = -3,
            max_c = 34,
            degree_days = 440,
            water_mm = 235,
            growing_days = 51,
            water_peak = 0.65,
        },
        bearing_days = 28,
    },
}

ccb.content.define_terrain {
    id = "t_shrub_strawberry_harvested",
    copy_from = "t_shrub_strawberry",
    description = ccb.content.text("A small strawberry bush that's fruitless."),
    color = "red_green",
    extend = { flags = { "HARVESTED" } },
    transforms_into = "t_shrub_strawberry",
    builtin_examine = "harvested_plant",
}

ccb.content.define_terrain {
    id = "t_shrub_blackberry",
    copy_from = "t_shrub_abstract",
    name = ccb.content.text("blackberry bush"),
    description = ccb.content.text("A small bush of delicious blackberries.  Watch out for its thorns!"),
    color = "black_green",
    extend = { flags = { "SHARP" } },
    transforms_into = "t_shrub_blackberry_harvested",
    builtin_examine = "harvest_ter_nectar",
    looks_like = "t_shrub_blueberry",
    fruit_climate = {
        harvest = "shrub_blackberry_harv",
        growth = {
            base_c = 5,
            optimum_c = 24,
            min_c = -3,
            max_c = 36,
            degree_days = 710,
            water_mm = 330,
            growing_days = 75,
            water_peak = 0.65,
        },
        bearing_days = 35,
    },
}

ccb.content.define_terrain {
    id = "t_shrub_blackberry_harvested",
    copy_from = "t_shrub_blackberry",
    description = ccb.content.text("A small blackberry bush that's fruitless.  Watch out for its thorns!"),
    color = "white_green",
    extend = { flags = { "HARVESTED" } },
    transforms_into = "t_shrub_blackberry",
    builtin_examine = "harvested_plant",
    looks_like = "t_shrub_blueberry_harvested",
}

ccb.content.define_terrain {
    id = "t_shrub_huckleberry",
    copy_from = "t_shrub_abstract",
    name = ccb.content.text("huckleberry bush"),
    description = ccb.content.text("A small bush of huckleberries, often mistaken for blueberries."),
    color = "light_blue_green",
    transforms_into = "t_shrub_huckleberry_harvested",
    builtin_examine = "harvest_ter_nectar",
    looks_like = "t_shrub_blueberry",
    fruit_climate = {
        harvest = "shrub_huckleberry_harv",
        growth = {
            base_c = 5,
            optimum_c = 20,
            min_c = -5,
            max_c = 32,
            degree_days = 570,
            water_mm = 260,
            growing_days = 70,
            water_peak = 0.65,
        },
        bearing_days = 42,
    },
}

ccb.content.define_terrain {
    id = "t_shrub_huckleberry_harvested",
    copy_from = "t_shrub_huckleberry",
    description = ccb.content.text("A small huckleberry bush that's fruitless."),
    color = "blue_green",
    extend = { flags = { "HARVESTED" } },
    transforms_into = "t_shrub_huckleberry",
    builtin_examine = "harvested_plant",
    looks_like = "t_shrub_blueberry_harvested",
}

ccb.content.define_terrain {
    id = "t_shrub_raspberry",
    copy_from = "t_shrub_abstract",
    name = ccb.content.text("raspberry bush"),
    description = ccb.content.text("A small bush of delicious raspberries.  Watch out for its thorns!"),
    color = "light_red_green",
    extend = { flags = { "SHARP" } },
    transforms_into = "t_shrub_raspberry_harvested",
    builtin_examine = "harvest_ter_nectar",
    looks_like = "t_shrub_strawberry",
    fruit_climate = {
        harvest = "shrub_raspberry_harv",
        growth = {
            base_c = 5,
            optimum_c = 22,
            min_c = -4,
            max_c = 34,
            degree_days = 610,
            water_mm = 290,
            growing_days = 67,
            water_peak = 0.65,
        },
        bearing_days = 27,
    },
}

ccb.content.define_terrain {
    id = "t_shrub_raspberry_harvested",
    copy_from = "t_shrub_raspberry",
    description = ccb.content.text("A small raspberry bush that's fruitless.  Watch out for its thorns!"),
    color = "red_green",
    extend = { flags = { "HARVESTED" } },
    transforms_into = "t_shrub_raspberry",
    builtin_examine = "harvested_plant",
    looks_like = "t_shrub_strawberry_harvested",
}

ccb.content.define_terrain {
    id = "t_shrub_grape",
    copy_from = "t_shrub_abstract",
    name = ccb.content.text("grape bush"),
    description = ccb.content.text("A bush of a different species invaded by grape vines."),
    color = "light_green_green",
    transforms_into = "t_shrub_grape_harvested",
    builtin_examine = "harvest_ter_nectar",
    looks_like = "t_shrub_blueberry",
    fruit_climate = {
        harvest = "shrub_grape_harv",
        growth = {
            base_c = 10,
            optimum_c = 26,
            min_c = -2,
            max_c = 39,
            degree_days = 1030,
            water_mm = 470,
            growing_days = 105,
            water_peak = 0.55,
        },
        bearing_days = 42,
    },
}

ccb.content.define_terrain {
    id = "t_shrub_grape_harvested",
    copy_from = "t_shrub_grape",
    description = ccb.content.text("A bush of a different species invaded by grape vines, but they're fruitless."),
    color = "green_green",
    extend = { flags = { "HARVESTED" } },
    transforms_into = "t_shrub_grape",
    builtin_examine = "harvested_plant",
    looks_like = "t_shrub_blueberry_harvested",
}

ccb.content.define_terrain {
    id = "t_shrub_spicebush",
    copy_from = "t_shrub_abstract",
    name = ccb.content.text("spicebush"),
    description = ccb.content.text("A bush that features small, red berries."),
    color = "light_green_green",
    transforms_into = "t_shrub_spicebush_harvested",
    builtin_examine = "harvest_ter_nectar",
    looks_like = "t_shrub_raspberry",
    fruit_climate = {
        harvest = "shrub_spicebush_harv",
        growth = {
            base_c = 5,
            optimum_c = 24,
            min_c = -5,
            max_c = 37,
            degree_days = 1100,
            water_mm = 360,
            growing_days = 108,
            water_peak = 0.66,
        },
        bearing_days = 31,
    },
}

ccb.content.define_terrain {
    id = "t_shrub_spicebush_harvested",
    copy_from = "t_shrub_spicebush",
    description = ccb.content.text("A bush that usually features small, red berries but it was picked clean."),
    color = "green_green",
    extend = { flags = { "HARVESTED" } },
    transforms_into = "t_shrub_spicebush",
    builtin_examine = "harvested_plant",
    looks_like = "t_shrub_blueberry_harvested",
}

ccb.content.define_terrain {
    id = "t_shrub_chokeberry",
    copy_from = "t_shrub_abstract",
    name = ccb.content.text("black chokeberry bush"),
    description = ccb.content.text("Drooping black berries adorn the shrub during autumn.  These have a distinctive star-shaped fold and look quite juicy."),
    color = "light_green_green",
    transforms_into = "t_shrub_chokeberry_harvested",
    builtin_examine = "harvest_ter_nectar",
    looks_like = "t_shrub_blueberry",
    fruit_climate = {
        harvest = "shrub_chokeberry_harv",
        growth = {
            base_c = 5,
            optimum_c = 23,
            min_c = -4,
            max_c = 36,
            degree_days = 1020,
            water_mm = 350,
            growing_days = 104,
            water_peak = 0.65,
        },
        bearing_days = 45,
    },
}

ccb.content.define_terrain {
    id = "t_shrub_chokeberry_harvested",
    copy_from = "t_shrub_chokeberry",
    description = ccb.content.text("Drooping black berries adorned this shrub, but the shrub was picked clean."),
    color = "green_green",
    extend = { flags = { "HARVESTED" } },
    transforms_into = "t_shrub_chokeberry",
    builtin_examine = "harvested_plant",
    looks_like = "t_shrub_blueberry_harvested",
}

-- Insert rose (flower) harvest in summer once flowers have a use (same for other generic flowers).
ccb.content.define_terrain {
    id = "t_shrub_rose",
    copy_from = "t_shrub_abstract",
    name = ccb.content.text("rose bush"),
    description = ccb.content.text("A fat bush of beautiful red roses, if only you could get a date!  Watch out for its thorns!"),
    color = "light_red_green",
    extend = { flags = { "SHARP" } },
    transforms_into = "t_shrub_rose_harvested",
    builtin_examine = "harvest_ter_nectar",
    fruit_climate = {
        harvest = "shrub_rose_harv",
        growth = {
            base_c = 5,
            optimum_c = 24,
            min_c = -5,
            max_c = 35,
            degree_days = 850,
            water_mm = 280,
            growing_days = 90,
            water_peak = 0.6,
        },
        bearing_days = 66,
    },
}

ccb.content.define_terrain {
    id = "t_shrub_rose_harvested",
    copy_from = "t_shrub_rose",
    description = ccb.content.text("A fat rose bush that currently has no blooms.  Watch out for its thorns!"),
    color = "red_green",
    extend = { flags = { "HARVESTED" } },
    transforms_into = "t_shrub_rose",
    builtin_examine = "harvested_plant",
}

ccb.content.define_terrain {
    id = "t_shrub_hydrangea",
    copy_from = "t_shrub_abstract",
    name = ccb.content.text("hydrangea bush"),
    description = ccb.content.text("A dense bush of fragrant blue hydrangeas."),
    color = "light_blue",
    delete = { flags = { "BROWSABLE" } },
    transforms_into = "t_shrub_hydrangea_harvested",
    builtin_examine = "harvest_ter_nectar",
}

ccb.content.define_terrain {
    id = "t_shrub_hydrangea_harvested",
    copy_from = "t_shrub_hydrangea",
    description = ccb.content.text("A fat hydrangea bush that currently has no blooms."),
    color = "blue_green",
    extend = { flags = { "HARVESTED" } },
    transforms_into = "t_shrub_hydrangea",
    builtin_examine = "harvested_plant",
}

ccb.content.define_terrain {
    id = "t_shrub_lilac",
    copy_from = "t_shrub_abstract",
    name = ccb.content.text("lilac bush"),
    description = ccb.content.text("A wide bush of bright pinkish-purple lilacs."),
    color = "magenta",
    delete = { flags = { "BROWSABLE" } },
    transforms_into = "t_shrub_lilac_harvested",
    builtin_examine = "harvest_ter_nectar",
}

ccb.content.define_terrain {
    id = "t_shrub_lilac_harvested",
    copy_from = "t_shrub_lilac",
    description = ccb.content.text("A wide lilac bush that currently has no blooms."),
    color = "magenta_green",
    extend = { flags = { "HARVESTED" } },
    transforms_into = "t_shrub_lilac",
    builtin_examine = "harvested_plant",
}

ccb.content.define_terrain {
    id = "t_trunk",
    name = ccb.content.text("tree trunk"),
    description = ccb.content.text("A section of trunk from a tree that has been cut down.  Can be sawn into logs with the right tool."),
    symbol = "1",
    color = "brown",
    move_cost = 4,
    coverage = 45,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "DIGGABLE", "REDUCE_SCENT", "MOUNTABLE", "SHORT" },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = { { item = "splinter", count = { 5, 15 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

-- Tree trunks sometimes may have shoots growing on them (coppicing)
ccb.content.define_terrain {
    id = "t_stump",
    name = ccb.content.text("tree stump"),
    description = ccb.content.text("A tree stump, a remnant of a tree that has been cut down."),
    symbol = "^",
    color = "brown",
    looks_like = "t_trunk",
    move_cost = 3,
    coverage = 35,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "DIGGABLE", "REDUCE_SCENT", "MOUNTABLE", "SHORT", "FLAT_SURF" },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = { { item = "splinter", count = { 5, 15 } }, { item = "twig", chance = 40, count = { 1, 2 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_woodchips",
    name = ccb.content.text("woodchips"),
    looks_like = "t_dirt",
    description = ccb.content.text("Small splinters of wood laid out in a layer to prevent unwanted plants from growing."),
    symbol = ".",
    color = "brown",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "PLOWABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 40,
        maximum_strength = 100,
        minimum_strength_supported = 100,
    },
}

ccb.content.define_terrain {
    id = "t_moss",
    name = ccb.content.text("moss"),
    looks_like = "t_grass",
    description = ccb.content.text("A patch of moist, spongy moss."),
    symbol = ".",
    color = "light_green",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "PLOWABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 40,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_grass",
    copy_from = "t_natural_floor_abstract",
    name = ccb.content.text("grass"),
    description = ccb.content.text("An area of hardy Kentucky bluegrass about ankle high.  Cutting the grass short enough would destroy the root system, causing this area to turn into a patch of dirt."),
    color = "green",
    transforms_into = "t_grass_grazed",
    extend = { flags = { "PLOWABLE", "GRAZABLE" } },
}

ccb.content.define_terrain {
    id = "t_grass_white",
    copy_from = "t_grass",
    name = ccb.content.text("white grass"),
    description = ccb.content.text("An area of Kentucky bluegrass covered in white latex-based paint, with neat lines designed for recreational sports."),
    color = "white",
    delete = { flags = { "GRAZABLE" } },
}

ccb.content.define_terrain {
    id = "t_grass_long",
    copy_from = "t_grass",
    name = ccb.content.text("long grass"),
    description = ccb.content.text("An area of long, shaggy grass about shin high."),
    transforms_into = "t_grass",
    symbol = ",",
    move_cost = 3,
    extend = { flags = { "SMALL_HIDE" } },
}

ccb.content.define_terrain {
    id = "t_grass_tall",
    copy_from = "t_grass_long",
    name = ccb.content.text("tall grass"),
    description = ccb.content.text("An area of tall grass about head high."),
    looks_like = "t_shrub",
    transforms_into = "t_grass_long",
    symbol = "'",
    move_cost = 5,
    coverage = 50,
}

ccb.content.define_terrain {
    id = "t_grass_dead",
    copy_from = "t_dirt",
    name = ccb.content.text("dead grass"),
    description = ccb.content.text("An area of long, shaggy grass that hasn't been cut recently."),
}

ccb.content.define_terrain {
    id = "t_grass_grazed",
    copy_from = "t_grass_dead",
    name = ccb.content.text("grazed grass"),
    description = ccb.content.text("An area of extremely short green stubble protruding from the dirt.  Something has been clearly grazing here."),
    transforms_into = "t_grass",
    extend = { flags = { "HARVESTED" } },
}

ccb.content.define_terrain {
    id = "t_grass_golf",
    name = ccb.content.text("golf green"),
    description = ccb.content.text("An area of grass mowed very short and neat."),
    looks_like = "t_grass",
    symbol = ".",
    color = "light_green",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "PLOWABLE" },
    bash = {
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_grass_alien",
    name = ccb.content.text("alien grass"),
    description = ccb.content.text("An area of something that almost looks like grass.  The blades are serrated and move on their own."),
    symbol = ".",
    color = "red",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "PLOWABLE", "ROUGH", "PAINFUL" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 40,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_golf_hole",
    name = ccb.content.text("golf hole"),
    looks_like = "t_grass_golf",
    description = ccb.content.text("A small plastic cup embedded in an area of very short, neat grass."),
    symbol = "o",
    color = "white",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "PLOWABLE" },
    bash = {
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_bamboo",
    name = ccb.content.text("young bamboo shoots"),
    description = ccb.content.text("An area of young bamboo shoots about ankle high.  Many shoots are just barely pushing above the ground."),
    looks_like = "t_grass",
    symbol = ".",
    color = "green",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "PLOWABLE", "GRAZABLE" },
    transforms_into = "t_bamboo_harvested",
    builtin_examine = { "harvest_ter", "fertilize_terrain" },
    harvest_by_season = { { seasons = { "spring" }, harvest = "bamboo_harv" } },
    growth = {
        transform = "t_bamboo_long",
        growth_time = "7 days",
        growth_multiplier = 1.0,
        fertilize_seasons = { "spring" },
    },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        terrain = "t_dirt",
        drops = { { item = "withered", chance = 50, count = { 1, 2 } } },
    },
}

ccb.content.define_terrain {
    id = "t_bamboo_harvested",
    name = ccb.content.text("young bamboo shoots"),
    description = ccb.content.text("An area of young bamboo shoots about ankle high.  The smallest shoots have already been harvested."),
    looks_like = "t_grass",
    symbol = ".",
    color = "green",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "PLOWABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 40,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_bamboo_long",
    name = ccb.content.text("long bamboo shoots"),
    description = ccb.content.text("An area of long bamboo shoots about shin high."),
    looks_like = "t_grass",
    symbol = ",",
    color = "green",
    move_cost = 5,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "PLOWABLE", "SMALL_HIDE" },
    builtin_examine = "fertilize_terrain",
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_dirt",
        minimum_strength = 40,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
        drops = {
            { item = "raw_bamboo", chance = 15, count = { 1, 1 } },
            { item = "bamboo_stalk", chance = 5, count = { 1, 1 } },
        },
    },
    growth = {
        transform = "t_bamboo_tall",
        growth_time = "14 days",
        growth_multiplier = 1.0,
        fertilize_seasons = { "spring", "summer" },
    },
}

ccb.content.define_terrain {
    id = "t_bamboo_tall",
    name = ccb.content.text("tall bamboo"),
    description = ccb.content.text("A tall bamboo thicket about head high."),
    looks_like = "t_shrub",
    symbol = "'",
    color = "green",
    move_cost = 10,
    coverage = 50,
    flags = { "TRANSPARENT", "DIGGABLE", "PLOWABLE", "SMALL_HIDE", "TREE", "NO_STUMP" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_dirt",
        minimum_strength = 40,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
        drops = {
            { item = "bamboo_stalk", count = { 1, 3 } },
            { item = "leaves", count = { 0, 50 } },
            { item = "splinter", count = { 0, 4 } },
            { item = "seed_raw_bamboo", chance = 15, count = { 1, 1 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_bamboo_dead",
    name = ccb.content.text("dead bamboo"),
    description = ccb.content.text("An area of long, brown, dead bamboo shoots covered in white fungus."),
    looks_like = "t_dirt",
    symbol = ".",
    color = "brown",
    move_cost = 10,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "PLOWABLE", "SMALL_HIDE" },
    bash = {
        terrain = "t_dirt",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        bash_below = true,
        drops = { { item = "splinter", count = { 0, 3 } }, { item = "withered", count = { 0, 2 } } },
    },
}

ccb.content.define_terrain {
    id = "t_fern",
    name = ccb.content.text("fern"),
    description = ccb.content.text("A short plant with thousands of leaves which grow in a fractal pattern from the stem."),
    symbol = "#",
    looks_like = "t_underbrush",
    color = { "brown_green", "green", "green", "green" },
    move_cost = 3,
    coverage = 20,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "DIGGABLE", "FLAT", "THIN_OBSTACLE", "SHRUB", "SMALL_HIDE" },
    builtin_examine = "harvest_ter",
    harvest_by_season = { { seasons = { "spring" }, harvest = "fern_harv" } },
    transforms_into = "t_fern_harvested",
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        terrain = "t_dirt",
        drops = { { item = "withered", chance = 50, count = { 1, 2 } }, { item = "leaves", count = { 1, 2 } } },
    },
}

ccb.content.define_terrain {
    id = "t_fern_harvested",
    name = ccb.content.text("fern"),
    description = ccb.content.text("A short plant with thousands of leaves which grow in a fractal pattern.  All of the curled shoots have been harvested."),
    symbol = "#",
    looks_like = "t_grass_long",
    color = "green",
    move_cost = 3,
    coverage = 20,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "DIGGABLE", "FLAT", "THIN_OBSTACLE", "SHRUB", "SMALL_HIDE" },
    builtin_examine = "harvested_plant",
    transforms_into = "t_fern",
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        terrain = "t_dirt",
        drops = { { item = "withered", chance = 50, count = { 1, 2 } }, { item = "leaves", count = { 1, 2 } } },
    },
}

ccb.content.define_terrain {
    id = "t_fungus_colony",
    name = ccb.content.text("mushroom colony"),
    description = ccb.content.text("A large pile of organic matter which has molded over with fungus.  The caps of many mundane mushrooms spring from the top, you can even recognize some.  The fungi growing here don't seem edible, though."),
    symbol = "#",
    color = "dark_gray",
    move_cost = 2,
    coverage = 80,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "NOCOLLIDE" },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        terrain = "t_dirt",
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
    },
}
