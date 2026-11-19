local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_algae_red",
    name = ccb.content.text("red algae"),
    description = ccb.content.text("One of the thousands of species of grassy reddish marine plants that inhabit intertidal zones the world over.  Its rubbery little fronds don't look particularly edible."),
    symbol = ",",
    color = "red",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn", "winter" }, harvest = "seaweed_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("splat."),
        failure_sound = ccb.content.text("squelch."),
    },
}

ccb.content.define_furniture {
    id = "f_algae_green",
    name = ccb.content.text("green algae"),
    description = ccb.content.text("A short patch of grassy green seaweed, wholly unremarkable."),
    symbol = ",",
    color = "green",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "spring", "summer", "autumn", "winter" }, harvest = "seaweed_harv" } },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("splat."),
        failure_sound = ccb.content.text("squelch."),
    },
}

ccb.content.define_furniture {
    id = "f_kelp_sugar",
    name = ccb.content.text("sugar kelp"),
    description = ccb.content.text("Also known as kombu, this brown algae grows in a single leaflike blade that can reach more than twice the height of a man.  Young fronds make for excellent soup stock and can even be eaten raw."),
    symbol = "i",
    color = "brown",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "FLAMMABLE_ASH", "ORGANIC", "SMALL_HIDE", "HARVEST_REQ_CUT1" },
    builtin_examine = "harvest_furn",
    harvest_by_season = { { seasons = { "spring", "summer" }, harvest = "kelp_sugar_harv" } },
    bash = {
        minimum_strength = 8,
        maximum_strength = 16,
        sound = ccb.content.text("splat."),
        failure_sound = ccb.content.text("squelch."),
    },
}

ccb.content.define_furniture {
    id = "f_sea_lettuce",
    name = ccb.content.text("sea lettuce"),
    description = ccb.content.text("Sometimes known as green laver, this leafy algae from the Ulva genus grows in leafy little patches around shallows and tide pools.  Though small, it makes a tasty snack."),
    looks_like = "f_algae_green",
    symbol = ",",
    color = "green",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC" },
    harvest_by_season = {
        { seasons = { "spring", "summer", "autumn", "winter" }, harvest = "sea_lettuce_harv" },
    },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("splat."),
        failure_sound = ccb.content.text("squelch."),
    },
}

ccb.content.define_furniture {
    id = "f_bladderwrack",
    name = ccb.content.text("bladderwrack"),
    description = ccb.content.text("Named for the air bladders that grow all over its leafy fronds, this leafy seaweed is technically edible and has a long history of use in folk medicine."),
    looks_like = "f_algae_green",
    symbol = ",",
    color = "green",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "ORGANIC" },
    harvest_by_season = {
        { seasons = { "spring", "summer", "autumn", "winter" }, harvest = "bladderwrack_harv" },
    },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("splat."),
        failure_sound = ccb.content.text("squelch."),
    },
}

ccb.content.define_furniture {
    id = "f_sea_anemone",
    name = ccb.content.text("sea anemone"),
    description = ccb.content.text("This sessile polyp waves its stinging tentacles with the motion of the tides, hoping to capture a tiny fish or crab.  It's wholly inedible and poses no danger to anything bigger than a shrimp."),
    symbol = "f",
    color = "pink",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "GRAZER_INEDIBLE", "ORGANIC" },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("splat."),
        failure_sound = ccb.content.text("squelch."),
    },
}

ccb.content.define_furniture {
    id = "f_sea_sponge",
    name = ccb.content.text("sea sponge"),
    description = ccb.content.text("An immobile, lumpy little creature that looks nothing like a square kitchen sponge.  Anchored to the sea floor, its porous body passively filters plankton from the water that freely passes through it."),
    symbol = "f",
    color = "brown",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "TINY", "FLAMMABLE_ASH", "NOCOLLIDE", "GRAZER_INEDIBLE", "ORGANIC" },
    bash = {
        minimum_strength = 6,
        maximum_strength = 12,
        sound = ccb.content.text("splat."),
        failure_sound = ccb.content.text("squelch."),
    },
}
