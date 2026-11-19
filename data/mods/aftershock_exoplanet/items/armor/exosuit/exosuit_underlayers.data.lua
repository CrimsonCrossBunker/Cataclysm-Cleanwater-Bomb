local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_exo_standard_underlayer",
    copy_from = "jumpsuit",
    looks_like = "robofac_enviro_suit",
    name = ccb.content.plural_text("exosuit underlayer", "exosuit underlayers"),
    description = ccb.content.text("A form-fitting suit meant to be worn by an exosuit pilot.  Although not a requirement for the operation of an exosuit, it features haptic feedback systems that offer improved performance and comfort while doing so.  The suit is not designed for use outside of armor.  This standard model uses a scale mail of overlapping plastic disks for incidental protection.\n\nIts temperature control unit can either draw power from an active frame or be powered by its own battery port."),
    mass = "610 g",
    volume = "3500 ml",
    color = "brown",
    materials = { "nylon", "afs_plastic_armor" },
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "afs_heavy_suit_battery_cell",
        },
    },
    flags = { "EXO_UNDERLAYER", "SKINTIGHT", "WATERPROOF", "POWERARMOR_COMPATIBLE", "SOFT" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        environmental_protection = 5,
        portions = {
            {
                materials = { { id = "lvl4ballisticglass", coverage = 100, thickness = 3 } },
                covers = { "eyes" },
                coverage = 100,
            },
            {
                materials = {
                    { id = "afs_plastic_armor", coverage = 80, thickness = 1 },
                    { id = "nylon", coverage = 100, thickness = 0.8 },
                },
                covers = { "head", "mouth", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l", "leg_r" },
                coverage = 100,
            },
            {
                materials = {
                    { id = "nanoprinted_alloy", coverage = 80, thickness = 1 },
                    { id = "nylon", coverage = 100, thickness = 1 },
                },
                covers = { "foot_l", "foot_r" },
                coverage = 100,
            },
        },
        warmth = 10,
    },
    artifact = { enchantments = { "afs_ench_climate_control_warm", "afs_ench_cryo_ui" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "afs_exo_standard_underlayer_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "afs_exo_standard_underlayer_on",
    copy_from = "afs_exo_standard_underlayer",
    repair_like = "afs_exo_standard_underlayer",
    name = ccb.content.plural_text("exosuit underlayer (on)", "exosuit underlayers (on)"),
    description = ccb.content.text("A form-fitting suit meant to be worn by an exosuit pilot.  Although not a requirement for the operation of an exosuit, it features haptic feedback systems that offer improved performance and comfort while doing so.  The suit is not designed for use outside of armor.  This standard model uses a scale mail of overlapping plastic disks for incidental protection.\n\nIts temperature control unit is active and drawing power from its own battery port."),
    revert_to = "afs_exo_standard_underlayer",
    inheritance = { add = { flags = { "ACTIVE_CRYOSUIT", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "10288 mW" },
    armor = { warmth = 150 },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "afs_exo_standard_underlayer",
        },
    },
}

ccb.content.define_item {
    id = "afs_exo_combat_underlayer",
    copy_from = "jumpsuit",
    looks_like = "robofac_enviro_suit",
    name = ccb.content.plural_text("exosuit combat underlayer", "exosuit combat underlayers"),
    description = ccb.content.text("A form-fitting suit meant to be worn by an exosuit pilot.  Although not a requirement for the operation of an exosuit, it features haptic feedback systems that offer improved performance and comfort while doing so.  The suit is not designed for use outside of armor.  This model includes tough Kevlar to protect from spalling.\n\nIts temperature control unit can either draw power from an active frame or be powered by its own battery port."),
    mass = "610 g",
    volume = "3500 ml",
    color = "brown",
    materials = { "afs_kevlar" },
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "afs_heavy_suit_battery_cell",
        },
    },
    flags = { "EXO_UNDERLAYER", "SKINTIGHT", "WATERPROOF", "POWERARMOR_COMPATIBLE", "SOFT", "FRAGILE" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        environmental_protection = 5,
        portions = {
            {
                materials = { { id = "lvl4ballisticglass", coverage = 100, thickness = 3 } },
                covers = { "eyes" },
                coverage = 100,
            },
            {
                materials = {
                    { id = "afs_kevlar", coverage = 80, thickness = 2 },
                    { id = "nylon", coverage = 100, thickness = 1 },
                },
                covers = { "torso" },
                coverage = 100,
            },
            {
                materials = {
                    { id = "afs_kevlar", coverage = 80, thickness = 2 },
                    { id = "nylon", coverage = 100, thickness = 1 },
                },
                covers = {
                    "head",
                    "mouth",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                    "leg_l",
                    "leg_r",
                    "foot_l",
                    "foot_r",
                },
                coverage = 100,
            },
        },
        warmth = 10,
    },
    artifact = { enchantments = { "afs_ench_climate_control_warm", "afs_ench_cryo_ui" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "afs_exo_combat_underlayer_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "afs_exo_combat_underlayer_on",
    copy_from = "afs_exo_combat_underlayer",
    repair_like = "afs_exo_combat_underlayer",
    name = ccb.content.plural_text("exosuit combat underlayer (on)", "exosuit combat underlayers (on)"),
    description = ccb.content.text("A form-fitting suit meant to be worn by an exosuit pilot.  Although not a requirement for the operation of an exosuit, it features haptic feedback systems that offer improved performance and comfort while doing so.  The suit is not designed for use outside of armor.  This model includes tough Kevlar to protect from spalling.\n\nIts temperature control unit is active and drawing power from its own battery port."),
    revert_to = "afs_exo_combat_underlayer",
    inheritance = { add = { flags = { "ACTIVE_CRYOSUIT", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "12626 mW" },
    armor = { warmth = 150 },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "afs_exo_combat_underlayer",
        },
    },
}

ccb.content.define_item {
    id = "afs_exo_eva_underlayer",
    copy_from = "jumpsuit",
    looks_like = "robofac_enviro_suit",
    name = ccb.content.plural_text("exosuit EVA underlayer", "exosuit EVA underlayers"),
    description = ccb.content.text("A form-fitting suit meant to be worn by an exosuit pilot.  Although not a requirement for the operation of an exosuit, it features haptic feedback systems that offer improved performance and comfort while doing so.  This model is designed for EVA operation, offering protection against breaches.\n\nIts temperature control unit can either draw power from an active frame or be powered by its own battery port."),
    mass = "610 g",
    volume = "3500 ml",
    color = "brown",
    materials = { "nomex", "nanoprinted_alloy" },
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "afs_heavy_suit_battery_cell",
        },
    },
    flags = {
        "EXO_UNDERLAYER", "SKINTIGHT", "WATERPROOF", "POWERARMOR_COMPATIBLE", "SOFT", "GAS_PROOF",
        "RAD_RESIST", "RAINPROOF", "FRAGILE",
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        environmental_protection = 100,
        portions = {
            {
                materials = { { id = "lvl4ballisticglass", coverage = 100, thickness = 3 } },
                covers = { "eyes" },
                coverage = 100,
            },
            {
                materials = {
                    { id = "carbide_thermal_weave", coverage = 80, thickness = 1 },
                    { id = "nylon", coverage = 100, thickness = 1 },
                },
                covers = {
                    "head",
                    "mouth",
                    "torso",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                    "leg_l",
                    "leg_r",
                    "foot_l",
                    "foot_r",
                },
                coverage = 100,
            },
        },
        warmth = 10,
    },
    artifact = { enchantments = { "afs_ench_climate_control_warm", "afs_ench_cryo_ui" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "afs_exo_eva_underlayer_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "afs_exo_eva_underlayer_on",
    copy_from = "afs_exo_eva_underlayer",
    repair_like = "afs_exo_eva_underlayer",
    name = ccb.content.plural_text("exosuit EVA underlayer (on)", "exosuit EVA underlayers (on)"),
    description = ccb.content.text("A form-fitting suit meant to be worn by an exosuit pilot.  Although not a requirement for the operation of an exosuit, it features haptic feedback systems that offer improved performance and comfort while doing so.  This model is designed for EVA operation, offering protection against breaches.\n\nIts temperature control unit is active and drawing power from its own battery port."),
    revert_to = "afs_exo_eva_underlayer",
    inheritance = { add = { flags = { "ACTIVE_CRYOSUIT", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "15432 mW" },
    armor = { warmth = 150 },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "afs_exo_eva_underlayer",
        },
    },
}

ccb.content.define_item {
    id = "afs_exo_hazard_underlayer",
    copy_from = "jumpsuit",
    looks_like = "robofac_enviro_suit",
    name = ccb.content.plural_text("exosuit utility underlayer", "exosuit utility underlayers"),
    description = ccb.content.text("A form-fitting suit meant to be worn by an exosuit pilot.  Although not a requirement for the operation of an exosuit, it features haptic feedback systems that offer improved performance and comfort while doing so.  This model is designed for hazardous environments and sacrifices mobility for extra protection.\n\nIts temperature control unit can either draw power from an active frame or be powered by its own battery port."),
    mass = "610 g",
    volume = "3500 ml",
    color = "brown",
    materials = { "nomex", "kevlar_rigid" },
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "afs_heavy_suit_battery_cell",
        },
    },
    flags = {
        "EXO_UNDERLAYER", "SKINTIGHT", "WATERPROOF", "POWERARMOR_COMPATIBLE", "SOFT", "GAS_PROOF",
        "RAD_PROOF", "RAINPROOF",
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        environmental_protection = 16,
        portions = {
            {
                materials = { { id = "lvl4ballisticglass", coverage = 100, thickness = 3 } },
                covers = { "eyes" },
                coverage = 100,
            },
            {
                materials = {
                    { id = "afs_kevlar", coverage = 80, thickness = 2 },
                    { id = "nylon", coverage = 100, thickness = 0.8 },
                },
                covers = { "torso" },
                encumbrance = 6,
                coverage = 100,
            },
            {
                materials = {
                    { id = "kevlar_rigid", coverage = 80, thickness = 2 },
                    { id = "nylon", coverage = 100, thickness = 0.8 },
                },
                covers = {
                    "head",
                    "mouth",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                    "leg_l",
                    "leg_r",
                    "foot_l",
                    "foot_r",
                },
                encumbrance = 6,
                coverage = 100,
            },
        },
        warmth = 10,
    },
    artifact = { enchantments = { "afs_ench_climate_control_warm", "afs_ench_cryo_ui" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "afs_exo_hazard_underlayer_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "afs_exo_hazard_underlayer_on",
    copy_from = "afs_exo_hazard_underlayer",
    repair_like = "afs_exo_hazard_underlayer",
    name = ccb.content.plural_text("exosuit utility underlayer (on)", "exosuit utility underlayers (on)"),
    description = ccb.content.text("A form-fitting suit meant to be worn by an exosuit pilot.  Although not a requirement for the operation of an exosuit, it features haptic feedback systems that offer improved performance and comfort while doing so.  This model is designed for hazardous environments and sacrifices mobility for extra protection.\n\nIts temperature control unit is active and drawing power from its own battery port."),
    revert_to = "afs_exo_hazard_underlayer",
    inheritance = { add = { flags = { "ACTIVE_CRYOSUIT", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "13227 mW" },
    armor = { warmth = 150 },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "afs_exo_hazard_underlayer",
        },
    },
}
