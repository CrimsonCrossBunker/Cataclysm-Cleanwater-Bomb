local ccb = require("ccb")

-- These are magically conjured and should not be restricted by caster's anatomical features
ccb.content.define_vehicle_part {
    id = "controls_technomancer",
    copy_from = "controls",
    flags = { "CONTROLS" },
}

-- 30% energy efficiency
ccb.content.define_vehicle_part {
    abstract = "mana_engine",
    copy_from = "engine_combustion",
    fuel_type = "mana",
    m2c = 60,
    description = ccb.content.text("A magically manifested combustion engine.  Despite operating entirely off of mana rather than normal fuel, it otherwise functions exactly as a conventional internal combustion engine.  Somehow."),
}

ccb.content.define_vehicle_part {
    id = "engine_vtwin_magic",
    copy_from = "mana_engine",
    item = "v2_combustion_magic",
    durability = 200,
    epower = "-50 W",
    power = "37300 W",
    energy_consumption = "124500 W",
    folded_volume = "2 L",
    breaks_into = {
        { item = "mc_steel_lump", count = { 10, 20 } },
        { item = "lc_steel_chunk", count = { 10, 20 } },
        { item = "scrap", count = { 10, 20 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 5 } },
        },
    },
    damage_reduction = { all = 60 },
    extend = { flags = { "NO_INSTALL_HIDDEN" } },
}

ccb.content.define_vehicle_part {
    id = "ap_everburning_sconce",
    name = ccb.content.text("everburning torch sconce"),
    description = ccb.content.text("An everburning torch that has been placed into a sconce for easy attachment to a wall."),
    item = "everburning_sconce",
    categories = { "lighting" },
    color = "red",
    broken_color = "blue",
    durability = 20,
    bonus = 60,
    damage_modifier = 10,
    breaks_into = {
        { item = "splinter", count = { 2, 8 } },
        { item = "scrap", count = { 1, 4 } },
        { item = "mtorch_everburning", count = { 0, 1 } },
    },
    flags = { "WALL_MOUNTED", "HALF_CIRCLE_LIGHT", "APPLIANCE" },
    requirements = { removal = { duration = "15 m" } },
    variants = { { symbols = "*", broken_symbols = "-" } },
}
