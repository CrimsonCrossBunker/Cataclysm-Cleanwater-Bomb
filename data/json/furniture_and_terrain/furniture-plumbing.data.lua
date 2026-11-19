local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_bathtub",
    name = ccb.content.text("bathtub"),
    symbol = "~",
    description = ccb.content.text("An ordinary ceramic tub, with a now-functionless steel faucet and a plug fixed over the drain.  Watertight and relatively clean, it would make for a good water trough."),
    color = "white",
    move_cost_mod = 2,
    coverage = 30,
    required_strength = -1,
    flags = {
        "TRANSPARENT",
        "FLAMMABLE_HARD",
        "CONTAINER",
        "PLACE_ITEM",
        "BLOCKSDOOR",
        "MOUNTABLE",
        "LIQUIDCONT",
    },
    max_volume = "200 L",
    builtin_examine = "keg",
    keg_capacity = "150 L",
    bash = {
        minimum_strength = 12,
        maximum_strength = 50,
        sound = ccb.content.text("porcelain breaking!"),
        failure_sound = ccb.content.text("whunk!"),
        drops = {
            { item = "pipe_cpvc", count = { 1, 5 } },
            { item = "water_faucet", chance = 50 },
            { item = "pipe_fittings", count = { 0, 2 } },
            { item = "ceramic_shard", count = { 6, 18 } },
        },
        destroyed_field = { "fd_dirty_water", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_shower",
    name = ccb.content.text("shower"),
    symbol = "~",
    description = ccb.content.text("A small enclosed ceramic room with a glass door and plumbing fixtures for cleaning oneself.  Before it was a commonplace amenity, but now it's hard to imagine wasting that much water."),
    color = "white",
    move_cost_mod = 0,
    coverage = 35,
    required_strength = -1,
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "CONTAINER", "PLACE_ITEM", "BLOCKSDOOR" },
    bash = {
        minimum_strength = 6,
        maximum_strength = 30,
        sound = ccb.content.text("porcelain breaking!"),
        failure_sound = ccb.content.text("whunk!"),
        volume = 16,
        failure_volume = 12,
        drops = {
            { item = "pipe_cpvc", count = { 1, 5 } },
            { item = "scrap_copper", count = { 0, 2 } },
            { item = "pipe_fittings", count = { 0, 2 } },
            { item = "ceramic_shard", count = { 2, 6 } },
            { item = "glass_shard", count = { 8, 16 } },
        },
        destroyed_field = { "fd_dirty_water", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_sink",
    name = ccb.content.text("sink"),
    symbol = "&",
    description = ccb.content.text("A porcelain water basin with a water tap and drain, designed to be fitted into an opening on a countertop."),
    color = "white",
    move_cost_mod = 2,
    coverage = 60,
    required_strength = -1,
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "CONTAINER", "PLACE_ITEM", "MOUNTABLE" },
    connect_groups = "COUNTER",
    connects_to = "COUNTER",
    rotates_to = "INDOORFLOOR",
    bash = {
        minimum_strength = 8,
        maximum_strength = 30,
        sound = ccb.content.text("porcelain breaking!"),
        failure_sound = ccb.content.text("whunk!"),
        drops = {
            {
                distribution = {
                    { item = "pipe_cpvc", chance = 40, count = { 1, 5 } },
                    { item = "cu_pipe", chance = 60, count = { 1, 5 } },
                },
            },
            { item = "water_faucet", chance = 50 },
            { item = "pipe_fittings", count = { 0, 2 } },
            { item = "ceramic_shard", count = { 2, 8 } },
        },
        destroyed_field = { "fd_dirty_water", 2 },
    },
}

-- Currently only used in NPC faction camps. Note that this is an infinite source of water if you use it elsewhere.
ccb.content.define_furniture {
    id = "f_sink_gravity",
    copy_from = "f_sink",
    name = ccb.content.text("sink with gravity-feed tank"),
    symbol = "&",
    description = ccb.content.text("A water basin with flowing water, fed by a tank suspended above.  A luxury when the water main is unavailable.  This one has a hand pump to refill from groundwater."),
    bash = {
        minimum_strength = 8,
        maximum_strength = 30,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("whunk!"),
        drops = {
            { item = "cu_pipe", chance = 50 },
            { item = "water_faucet", chance = 50 },
            { item = "pipe_fittings", count = { 0, 2 } },
            { item = "30gal_barrel", chance = 60 },
        },
        destroyed_field = { "fd_dirty_water", 5 },
    },
    builtin_examine = "water_source",
}

ccb.content.define_furniture {
    id = "f_toilet",
    name = ccb.content.text("toilet"),
    symbol = "o",
    color = "white",
    description = ccb.content.text("An invaluable fixture in any home, it would be a miracle to have one that works.  The standing tank may hold a moderate amount of water, but while better than anything that would be in the bowl, it would not be the cleanest."),
    move_cost_mod = 2,
    coverage = 30,
    required_strength = -1,
    liquid_source = { item = "water", count = 24 },
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "MOUNTABLE", "LIQUIDCONT" },
    builtin_examine = "finite_water_source",
    bash = {
        minimum_strength = 8,
        maximum_strength = 30,
        sound = ccb.content.text("porcelain breaking!"),
        failure_sound = ccb.content.text("whunk!"),
        drops = { { item = "ceramic_shard", count = { 2, 8 } }, { item = "wax_paraffin", count = 1 } },
        destroyed_field = { "fd_dirty_water", 4 },
    },
}

-- keg_capacity assumed to be from model XE36S06ST45U0 water heater <https://images.thdstatic.com/catalog/pdfImages/2d/2d7ed116-1a8c-439d-b7fe-a62a0a98f806.pdf>
ccb.content.define_furniture {
    id = "f_water_heater",
    name = ccb.content.text("water heater"),
    looks_like = "f_standing_tank",
    description = ccb.content.text("An insulated metal tank with a small fire used to maintain near-boiling temperatures.  There's no longer any way to power it, but any water left in the large tank from before the power went out should be pretty clean, and it could be used to store large quantities of other liquids too."),
    symbol = "0",
    background_color = "white",
    move_cost_mod = -1,
    coverage = 55,
    required_strength = -1,
    flags = { "CONTAINER", "PLACE_ITEM", "LIQUIDCONT", "NOITEM", "SEALED", "EASY_DECONSTRUCT", "SMALL_HIDE" },
    builtin_examine = "keg",
    keg_capacity = "100 L",
    base_item = "household_water_heater",
    bash = {
        minimum_strength = 18,
        maximum_strength = 50,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        destroyed_field = { "fd_dirty_water", 4 },
    },
}

-- keg_capacity assumed to be from model XG55T06EC50UO water heater <https://images.thdstatic.com/catalog/pdfImages/7e/7e7928b1-8b4f-472a-8ee8-b48eb1e7932a.pdf>
ccb.content.define_furniture {
    id = "f_water_heater_family",
    name = ccb.content.text("family–sized water heater"),
    looks_like = "f_water_heater",
    description = ccb.content.text("An insulated metal tank with a small fire used to maintain near-boiling temperatures.  There's no longer any way to power it, but any water left in the large tank from before the power went out should be pretty clean, and it could be used to store large quantities of other liquids too."),
    symbol = "0",
    background_color = "white",
    move_cost_mod = -1,
    coverage = 55,
    required_strength = -1,
    flags = { "CONTAINER", "PLACE_ITEM", "LIQUIDCONT", "NOITEM", "SEALED", "EASY_DECONSTRUCT", "SMALL_HIDE" },
    builtin_examine = "keg",
    keg_capacity = "200 L",
    base_item = "household_water_heater_family",
    bash = {
        minimum_strength = 18,
        maximum_strength = 50,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        destroyed_field = { "fd_dirty_water", 4 },
    },
}

ccb.content.define_furniture {
    id = "f_water_purifier",
    looks_like = "f_water_heater",
    name = ccb.content.text("water purifier"),
    description = ccb.content.text("This device effectively sterilizes water.  You can plug it into a power grid to use it."),
    symbol = "W",
    background_color = "blue",
    move_cost_mod = -1,
    coverage = 50,
    required_strength = -1,
    appliance_conversion = { furniture = "f_null", item = "stationary_water_purifier" },
    flags = { "EASY_DECONSTRUCT", "SMALL_HIDE" },
    base_item = "stationary_water_purifier",
    bash = {
        minimum_strength = 15,
        maximum_strength = 50,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        destroyed_field = { "fd_dirty_water", 4 },
    },
}
