local ccb = require("ccb")

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
