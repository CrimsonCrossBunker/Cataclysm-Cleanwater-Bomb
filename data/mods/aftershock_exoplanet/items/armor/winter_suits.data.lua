local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_magellan_suit",
    category = "armor",
    name = ccb.content.plural_text("Magellan exosuit", "Magellan exosuits"),
    description = ccb.content.text("A high-quality, civilian grade EVA suit often employed by well-established frontier research and exploration associations.  Designed to support the exploration of challenging terrain, it offers respectable protection against common environmental hazards like extreme temperatures, inhospitable atmospheres, and light radiation.  It leaves arms and hands relatively unencumbered to aid the manipulation of scientific instruments.\n\nAn integral battery allows the suit to operate for up to 34 hours, but complicates field recharging."),
    mass = "7800 g",
    volume = "14 L",
    price = "4 kUSD",
    symbol = "[",
    looks_like = "robofac_enviro_suit",
    color = "light_gray",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 1000 } } },
    flags = {
        "VARSIZE", "WATERPROOF", "GAS_PROOF", "POCKETS", "RAINPROOF", "RAD_RESIST", "RECHARGE", "OUTER",
        "NO_RELOAD", "NO_UNLOAD",
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 1.0 },
                    { id = "titanium", coverage = 100, thickness = 0.5 },
                },
                encumbrance = 25,
                coverage = 100,
                vitals_coverage = 100,
                covers = { "torso", "leg_l", "leg_r" },
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 1.0 } },
                encumbrance = 2,
                coverage = 100,
                vitals_coverage = 100,
                covers = { "arm_l", "arm_r", "hand_l", "hand_r" },
            },
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 1.0 },
                    { id = "titanium", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 6,
                coverage = 100,
                vitals_coverage = 100,
                covers = { "foot_l", "foot_r" },
            },
        },
        warmth = 20,
        thickness = 1,
        valid_mods = { "steel_padded" },
        environmental_protection = 16,
    },
    artifact = { enchantments = { "afs_ench_climate_control_warm", "afs_ench_cryo_ui" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "afs_magellan_suit_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "afs_magellan_suit_on",
    copy_from = "afs_magellan_suit",
    repair_like = "afs_magellan_suit",
    name = ccb.content.plural_text("Magellan exosuit (on)", "Magellan exosuits (on)"),
    looks_like = "afs_cryopod_bodyglove",
    description = ccb.content.text("The temperature control units of this high-tech garment are currently active, and continuously draining battery power.  Use it to turn them off."),
    revert_to = "afs_magellan_suit",
    inheritance = { add = { flags = { "ACTIVE_CRYOSUIT", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "8170 mW" },
    armor = { warmth = 150 },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "afs_magellan_suit",
        },
    },
}

ccb.content.define_item {
    id = "afs_frontier_cryo",
    category = "armor",
    name = ccb.content.plural_text("frontier cryo suit", "frontier cryo suits"),
    description = ccb.content.text("A sturdy suit meant to protect against the freezing cold, made from a pair of jumpsuits that have been woven around a heavy insulation layer and crisscrossed with the thermal tubing of a heat regulation unit.  The thick insulation allows the suit to function with unrivaled efficiency, but also makes all types of movement difficult."),
    mass = "7800 g",
    volume = "14 L",
    price = "75 USD",
    symbol = "[",
    looks_like = "robofac_enviro_suit",
    color = "cyan",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "afs_heavy_suit_battery_cell",
        },
    },
    flags = { "VARSIZE", "WATERPROOF", "POCKETS", "RAINPROOF", "STURDY", "OUTER" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 2.0 },
                    { id = "cotton", coverage = 100, thickness = 2.0 },
                },
                encumbrance = 25,
                coverage = 100,
                covers = { "leg_l", "leg_r", "arm_l", "arm_r", "hand_l", "hand_r" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 2.0 },
                    { id = "cotton", coverage = 100, thickness = 2.0 },
                },
                encumbrance = 35,
                coverage = 100,
                covers = { "torso" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "nanoprinted_alloy", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 6,
                coverage = 100,
                vitals_coverage = 100,
                covers = { "foot_l", "foot_r" },
            },
        },
        warmth = 20,
        thickness = 3,
        environmental_protection = 2,
    },
    artifact = { enchantments = { "afs_ench_climate_control_warm", "afs_ench_cryo_ui" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "afs_frontier_cryo_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "afs_frontier_cryo_on",
    copy_from = "afs_frontier_cryo",
    repair_like = "afs_frontier_cryo",
    name = ccb.content.plural_text("frontier cryo suit (on)", "frontier cryo suits (on)"),
    looks_like = "robofac_enviro_suit",
    description = ccb.content.text("The temperature control units of this high-tech garment are currently active, and continuously draining battery power.  Use it to turn them off."),
    revert_to = "afs_frontier_cryo",
    inheritance = { add = { flags = { "ACTIVE_CRYOSUIT", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "6944 mW" },
    armor = { warmth = 150 },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "afs_frontier_cryo",
        },
    },
}

ccb.content.define_item {
    id = "afs_combat_cryo",
    category = "armor",
    name = ccb.content.plural_text("combat cryo suit", "combat cryo suits"),
    description = ccb.content.text("A sleek black undersuit criss-crossed with the tubing of a heat regulation unit.  Insulation is kept at a minimum to allow for combat mobility, and the suit is quite power hungry as a result.  Despite the name, it's minimally protective and designed to be worn under a set of armor."),
    mass = "7800 g",
    volume = "14 L",
    price = "12 kUSD",
    materials = { "nylon", "nanoprinted_alloy" },
    symbol = "[",
    looks_like = "afs_cryopod_bodyglove",
    color = "cyan",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "afs_heavy_suit_battery_cell",
        },
    },
    flags = { "VARSIZE", "WATERPROOF", "POCKETS", "RAINPROOF", "STURDY", "NORMAL", "SOFT" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 3.0 } },
                encumbrance = 2,
                coverage = 100,
                vitals_coverage = 100,
                covers = {
                    "head", "torso", "eyes", "mouth", "leg_l", "leg_r", "arm_l", "arm_r", "hand_l",
                    "hand_r", "tail", "animal_paw_l", "animal_paw_r", "paw_default_l", "paw_default_r",
                },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "nanoprinted_alloy", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 6,
                coverage = 100,
                vitals_coverage = 100,
                covers = { "foot_l", "foot_r" },
            },
        },
        warmth = 20,
        thickness = 0.5,
        environmental_protection = 6,
    },
    artifact = { enchantments = { "afs_ench_climate_control_warm", "afs_ench_cryo_ui" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "afs_combat_cryo_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "afs_combat_cryo_on",
    copy_from = "afs_combat_cryo",
    repair_like = "afs_frontier_cryo",
    name = ccb.content.plural_text("combat cryo suit (on)", "combat cryo suits (on)"),
    looks_like = "afs_cryopod_bodyglove",
    description = ccb.content.text("The temperature control units of this high-tech garment are currently active, and continuously draining battery power.  Use it to turn them off."),
    revert_to = "afs_combat_cryo",
    inheritance = { add = { flags = { "ACTIVE_CRYOSUIT", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "11111 mW" },
    armor = { warmth = 150 },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "afs_combat_cryo",
        },
    },
}

ccb.content.define_item {
    id = "afs_frontier_cryo_xl",
    category = "armor",
    name = ccb.content.plural_text("uplift cryo suit", "uplift cryo suits"),
    description = ccb.content.text("A large padded and actively heated suit made for uplifted workers in subzero environments.  It's loose fitting design and the thick insulation don't make it particularly easy to move in."),
    copy_from = "afs_frontier_cryo",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "afs_heavy_suit_battery_cell",
        },
    },
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL", "ALLOWS_NATURAL_ATTACKS" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.5 },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 2.0 },
                    { id = "cotton", coverage = 100, thickness = 2.0 },
                },
                encumbrance = 25,
                coverage = 100,
                covers = {
                    "leg_l",
                    "leg_r",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                    "paw_default_l",
                    "paw_default_r",
                },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 2.0 },
                    { id = "cotton", coverage = 100, thickness = 2.0 },
                },
                encumbrance = 35,
                coverage = 100,
                covers = { "torso", "tail" },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "nanoprinted_alloy", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 6,
                coverage = 100,
                vitals_coverage = 100,
                covers = {
                    "foot_l", "foot_r", "animal_paw_l", "animal_paw_r", "hoof_r", "hoof_l",
                    "animal_paw_rabbit_l", "animal_paw_rabbit_r",
                },
            },
        },
    },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "afs_frontier_cryo_xl_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "afs_frontier_cryo_xl_on",
    name = ccb.content.plural_text("uplift cryo suit (on)", "uplift cryo suits (on)"),
    copy_from = "afs_frontier_cryo_xl",
    revert_to = "afs_frontier_cryo_xl",
    inheritance = { add = { flags = { "ACTIVE_CRYOSUIT", "SPAWN_ACTIVE" } } },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "afs_frontier_cryo_xl",
        },
    },
}

ccb.content.define_item {
    id = "afs_combat_cryo_xl",
    name = ccb.content.plural_text("Mercurial cryo suit", "Mercurial cryo suits"),
    copy_from = "afs_combat_cryo",
    description = ccb.content.text("A sleek black undersuit criss-crossed with the tubing of a heat regulation unit.  Insulation is kept at a minimum to allow for combat mobility, and the suit is quite power hungry as a result.  Despite the name, it's minimally protective and designed to be worn under a set of armor.  Made to fit the uplifted, the heavily augmented, or similarly sized individuals."),
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL", "ALLOWS_NATURAL_ATTACKS" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
    armor = {
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 3.0 } },
                encumbrance = 2,
                coverage = 100,
                vitals_coverage = 100,
                covers = {
                    "head", "torso", "eyes", "mouth", "leg_l", "leg_r", "arm_l", "arm_r", "hand_l",
                    "hand_r", "tail", "animal_paw_l", "animal_paw_r", "paw_default_l", "paw_default_r",
                    "hoof_r", "hoof_l",
                },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "nanoprinted_alloy", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 6,
                coverage = 100,
                vitals_coverage = 100,
                covers = { "foot_l", "foot_r" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "afs_combat_cryo_on_xl",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "afs_combat_cryo_on_xl",
    name = ccb.content.plural_text("Mercurial cryo suit (on)", "Mercurial cryo suits (on)"),
    copy_from = "afs_combat_cryo_xl",
    revert_to = "afs_combat_cryo_xl",
    inheritance = { add = { flags = { "ACTIVE_CRYOSUIT", "SPAWN_ACTIVE" } } },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "afs_combat_cryo_xl",
        },
    },
}

ccb.content.define_item {
    id = "afs_cryopod_bodyglove",
    category = "clothing",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("cryopod bodyglove", "cryopod bodygloves"),
    looks_like = "jumpsuit",
    description = ccb.content.text("A dark orange bodyglove, hundreds of tubes curl over its surface, tracing the contours of human musculature.  Meant to control body temperature during prolonged cryopreservation, it could easily keep you comfortable in any earthly climate.  Use it to activate its climate control functionality."),
    price = "15 kUSD",
    survival_price = "1 kUSD 500 USD",
    materials = { "nylon", "nanoprinted_alloy" },
    mass = "1250 g",
    volume = "4500 ml",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "afs_heavy_suit_battery_cell",
        },
    },
    flags = { "VARSIZE", "NORMAL", "RAINPROOF", "STURDY", "WATERPROOF", "PADDED" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 5, ammo_types = "battery" },
    armor = {
        warmth = 20,
        environmental_protection = 10,
        thickness = 1,
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 3.0 } },
                encumbrance = 2,
                coverage = 100,
                vitals_coverage = 100,
                covers = {
                    "head",
                    "torso",
                    "eyes",
                    "mouth",
                    "leg_l",
                    "leg_r",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                },
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "nanoprinted_alloy", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 6,
                coverage = 100,
                vitals_coverage = 100,
                covers = { "foot_l", "foot_r" },
            },
        },
    },
    artifact = { enchantments = { "afs_ench_climate_control_warm", "afs_ench_cryo_ui" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "afs_cryopod_bodyglove_on",
            need_charges = 5,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "afs_cryopod_bodyglove_on",
    copy_from = "afs_cryopod_bodyglove",
    repair_like = "afs_cryopod_bodyglove",
    name = ccb.content.plural_text("cryopod bodyglove (on)", "cryopod bodygloves (on)"),
    looks_like = "afs_cryopod_bodyglove",
    description = ccb.content.text("A dark orange bodyglove, hundreds of tubes curl over its surface, tracing the contours of human musculature.  Meant to control body temperature during prolonged cryopreservation, it could easily keep you comfortable in any earthly climate.  The temperature control units of this high-tech garment are currently active, and continuously draining battery power.  Use it to turn them off."),
    revert_to = "afs_cryopod_bodyglove",
    flags = {
        "VARSIZE", "SKINTIGHT", "RAINPROOF", "STURDY", "WATERPROOF", "PADDED", "THERMOMETER",
        "HYGROMETER", "ACTIVE_CRYOSUIT", "SPAWN_ACTIVE",
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "90 W" },
    armor = { warmth = 150 },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "afs_cryopod_bodyglove",
        },
    },
}
