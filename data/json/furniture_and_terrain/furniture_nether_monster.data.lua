local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_nm_tube",
    name = ccb.content.text("decaying tube"),
    description = ccb.content.text("A decomposing fleshy stalagmite extends from the ceiling to the floor."),
    looks_like = "f_alien_gasper",
    symbol = "|",
    color = "magenta",
    move_cost_mod = 6,
    coverage = 50,
    required_strength = -1,
    flags = { "TRANSPARENT" },
}

ccb.content.define_furniture {
    id = "f_nm_tube_emitter",
    name = ccb.content.text("glowing decaying tube"),
    description = ccb.content.text("A decomposing fleshy stalagmite extends from the ceiling to the floor.  Countless glowing spores weft from within, coating everything nearby."),
    looks_like = "f_alien_gasper",
    symbol = "|",
    color = "magenta_red",
    move_cost_mod = 6,
    coverage = 50,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    emissions = { "emit_monster_gas_1", "emit_monster_gas_2" },
}

-- Its thing is making itself irresistible to the PC. TODO: Make this effect more obvious
ccb.content.define_furniture {
    id = "f_nm_nether_lily",
    name = ccb.content.text("beautiful nether lily"),
    description = ccb.content.text("A very tall, mesmerizing blood red flower.  Its beautiful, pristine form is rooted firmly on the innards of the beast.  The flesh around it is decayed, being consumed to feed its ornate, magnanimous body.  You feel an urge to sit and admire this priceless miracle of life."),
    looks_like = "f_black_eyed_susan",
    symbol = "P",
    color = "red",
    move_cost_mod = 2,
    coverage = 40,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 61,
        sound = ccb.content.text("a chilling scream!"),
        failure_sound = ccb.content.text("squish!"),
        drops = {
            { item = "withered", chance = 50, count = { 1, 2 } },
        },
    },
    examine_handler = "examine_f_nm_nether_lily",
}

ccb.content.define_furniture {
    id = "f_nm_nether_grass",
    name = ccb.content.text("nether grass"),
    description = ccb.content.text("A bed of waist high segmented blue plants that remind you of grass.  As you wade past, they react to your movement and always swivel to face you."),
    looks_like = "t_grass_alien",
    symbol = "^",
    color = "blue",
    move_cost_mod = 1,
    coverage = 10,
    required_strength = -1,
    flags = { "TRANSPARENT", "ROUGH", "PAINFUL" },
    bash = {
        minimum_strength = 15,
        maximum_strength = 25,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("smash!"),
    },
}

ccb.content.define_furniture {
    id = "f_nm_nether_grass_tall",
    name = ccb.content.text("tall nether grass"),
    description = ccb.content.text("A clump of tall, segmented blue plants that remind you of grass.  As you approach, they bend towards you, hugging your body and making movement difficult."),
    looks_like = "t_grass_alien",
    symbol = "^",
    color = "blue",
    move_cost_mod = 2,
    coverage = 10,
    required_strength = -1,
    flags = { "PAINFUL" },
    bash = {
        minimum_strength = 15,
        maximum_strength = 25,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("smash!"),
    },
}

ccb.content.define_furniture {
    id = "f_nm_nether_patchwork",
    name = ccb.content.text("nether patchwork"),
    description = ccb.content.text("A peculiar plant that is hard to distinguish, resembling a tangled mess of different terrestrial flowers and weeds firmly wedged into the monstrous flesh.  It pulses rhythmically as it rearranges its form into even weirder shapes."),
    looks_like = "t_grass_alien",
    symbol = "Y",
    color = "green",
    move_cost_mod = 1,
    coverage = 10,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 61,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("squish!"),
        drops = { { item = "withered", chance = 50, count = { 1, 2 } } },
    },
}

ccb.content.define_furniture {
    id = "f_nm_nether_lichen",
    name = ccb.content.text("nether lichen"),
    description = ccb.content.text("A bed of orange, flowering lichen, covering the surface of the yellow ichor.  Every now and then, a flower disappears into the liquid, but seems to reappear the moment you look away."),
    looks_like = "f_shrub_moss",
    symbol = "L",
    color = "green",
    move_cost_mod = 1,
    coverage = 10,
    required_strength = -1,
    flags = { "TRANSPARENT", "ROUGH", "PAINFUL" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 61,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("squish!"),
        drops = { { item = "withered", chance = 50, count = { 1, 2 } } },
    },
}
