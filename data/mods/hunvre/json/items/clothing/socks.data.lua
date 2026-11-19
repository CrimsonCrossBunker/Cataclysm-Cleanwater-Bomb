local ccb = require("ccb")

ccb.content.define_item {
    id = "abstract_socks",
    copy_from = "abstract_garment_advanced_variants",
    symbol = "[",
    color = "blue",
    looks_like = "shorts",
    name = ccb.content.plural_text("abstract socks", "abstract socks"),
    description = ccb.content.text("Abstract socks.  If you see this it's a bug, please report."),
    materials = { "lycra" },
    mass = "50 g",
    volume = "50 ml",
    survival_price = "1 USD",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = { warmth = 5, thickness = 0.2 },
}

ccb.content.define_item {
    id = "short_socks",
    copy_from = "abstract_socks",
    name = ccb.content.plural_text("short socks", "short socks"),
    description = ccb.content.text("Socks reaching below the ankle."),
    armor = {
        portions = {
            {
                coverage = 100,
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_sole_l",
                    "foot_sole_r",
                    "foot_arch_l",
                    "foot_arch_r",
                    "foot_toes_l",
                    "foot_toes_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "socks",
    copy_from = "abstract_socks",
    name = ccb.content.plural_text("socks", "socks"),
    description = ccb.content.text("Socks reaching above the ankle."),
    armor = { portions = { { coverage = 100, covers = { "foot_l", "foot_r" } } } },
}

ccb.content.define_item {
    id = "long_socks",
    copy_from = "abstract_socks",
    name = ccb.content.plural_text("long socks", "long socks"),
    description = ccb.content.text("Socks reaching the middle of the calves."),
    armor = {
        portions = {
            { coverage = 100, covers = { "foot_l", "foot_r" } },
            {
                coverage = 60,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "thermal_socks",
    copy_from = "abstract_socks",
    name = ccb.content.plural_text("socks", "socks"),
    description = ccb.content.text("Thick socks reaching above the ankle."),
    armor = { thickness = 0.4, portions = { { coverage = 100, covers = { "foot_l", "foot_r" } } } },
    inheritance = { scale = { mass = 2, volume = 2, warmth = 2 } },
}

ccb.content.define_item {
    id = "long_thermal_socks",
    copy_from = "abstract_socks",
    name = ccb.content.plural_text("long socks", "long socks"),
    description = ccb.content.text("Thick socks reaching the middle of the calves."),
    armor = {
        thickness = 0.4,
        portions = {
            { coverage = 100, covers = { "foot_l", "foot_r" } },
            {
                coverage = 60,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r" },
            },
        },
    },
    inheritance = { scale = { mass = 2, volume = 2, warmth = 2 } },
}
