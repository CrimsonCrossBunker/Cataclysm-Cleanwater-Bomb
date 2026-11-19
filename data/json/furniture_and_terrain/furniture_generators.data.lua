local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_active_backup_generator",
    name = ccb.content.text("active backup generator"),
    looks_like = "t_plut_generator",
    description = ccb.content.text("A ubiquitous piece of compact machinery meant for running anything from the bathroom lights to electric stoves and other necessities when grid electricity is unavailable.  This one is currently running.  You can hear it humming slightly when you are very close."),
    symbol = "0",
    color = "green_white",
    move_cost_mod = -1,
    coverage = 80,
    required_strength = 8,
    mass = "168 kg",
    appliance_conversion = { furniture = "f_null", item = "diesel_generator" },
    flags = { "NOITEM", "SEALED", "REDUCE_SCENT", "PERMEABLE", "ACTIVE_GENERATOR", "EASY_DECONSTRUCT" },
    bash = {
        minimum_strength = 1,
        maximum_strength = 1,
        explosive = 1,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = { { item = "diesel_generator", contents_group = "some_diesel", damage = { 0, 1 } } },
    },
    deconstruct = { drops = { { item = "diesel_generator", contents_group = "some_diesel" } } },
}

ccb.content.define_furniture {
    id = "f_portable_generator",
    copy_from = "f_active_backup_generator",
    name = ccb.content.text("portable generator"),
    looks_like = "t_plut_generator",
    description = ccb.content.text("A small, portable generator, one that people buy for a camp."),
    mass = "22 kg",
    appliance_conversion = { furniture = "f_null", item = "portable_generator" },
    bash = {
        minimum_strength = 1,
        maximum_strength = 1,
        explosive = 1,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = { { item = "portable_generator", damage = { 0, 1 } } },
    },
    deconstruct = { drops = { { item = "portable_generator" } } },
}

ccb.content.define_furniture {
    id = "f_diesel_generator",
    copy_from = "f_active_backup_generator",
    name = ccb.content.text("diesel generator"),
    looks_like = "t_plut_generator",
    description = ccb.content.text("Big and powerful generator, used for street works."),
    mass = "168 kg",
    appliance_conversion = { furniture = "f_null", item = "diesel_generator" },
    bash = {
        minimum_strength = 1,
        maximum_strength = 1,
        explosive = 1,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = { { item = "diesel_generator", damage = { 0, 1 } } },
    },
    deconstruct = { drops = { { item = "diesel_generator" } } },
}

ccb.content.define_furniture {
    id = "f_military_generator",
    copy_from = "f_active_backup_generator",
    name = ccb.content.text("military diesel generator"),
    looks_like = "t_plut_generator",
    description = ccb.content.text("Big and powerful generator, painted in camo."),
    mass = "536 kg",
    appliance_conversion = { furniture = "f_null", item = "military_generator" },
    bash = {
        minimum_strength = 1,
        maximum_strength = 1,
        explosive = 1,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = { { item = "military_generator", damage = { 0, 1 } } },
    },
    deconstruct = { drops = { { item = "military_generator" } } },
}

ccb.content.define_furniture {
    id = "f_12000_gasoline_generator",
    copy_from = "f_active_backup_generator",
    name = ccb.content.text("powerful gasoline generator"),
    looks_like = "t_plut_generator",
    description = ccb.content.text("Big and powerful, yet portable generator."),
    mass = "150 kg",
    appliance_conversion = { furniture = "f_null", item = "12000_gasoline_generator" },
    bash = {
        minimum_strength = 1,
        maximum_strength = 1,
        explosive = 1,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = { { item = "12000_gasoline_generator", damage = { 0, 1 } } },
    },
    deconstruct = { drops = { { item = "12000_gasoline_generator" } } },
}
