local ccb = require("ccb")

-- repeat last entry
-- repeat last entry
ccb.content.define_field_type {
    id = "fd_vault_atmosphere",
    levels = {
        {
            name = ccb.content.text("crisp air"),
            effects = {
                {
                    effect = "vault_atmosphere",
                    body_part = "mouth",
                    intensity = 1,
                    min_duration = "250 seconds",
                    max_duration = "750 seconds",
                    immune_inside_vehicle = false,
                },
            },
        },
        {},
        {},
    },
    decay_amount_factor = 5,
    gas_absorption_factor = 15,
    percent_spread = 30,
    outdoor_age_speedup = "3 minutes",
    priority = 8,
    half_life = "10 minutes",
    phase = "gas",
}

-- repeat last entry
-- repeat last entry
ccb.content.define_field_type {
    id = "fd_safe_shoppers",
    levels = {
        {
            -- TRANSLATORS: context: `hair on your neck`, according to maleclypse, `I've always heard that when you suspect you are being watched it feels like the hair on your neck is lifting away from your body`. the effect of field is delete the invisibility effect from the character
            name = ccb.content.text("hair on your neck"),
            effects = {
                {
                    effect = "safe_shoppers",
                    body_part = "mouth",
                    intensity = 1,
                    min_duration = "100 seconds",
                    max_duration = "950 seconds",
                    immune_inside_vehicle = false,
                },
            },
        },
        {},
        {},
    },
    decay_amount_factor = 5,
    gas_absorption_factor = 15,
    percent_spread = 70,
    outdoor_age_speedup = "9 minutes",
    priority = 8,
    half_life = "30 minutes",
    phase = "gas",
}

ccb.content.define_field_type {
    id = "fd_alkahest",
    levels = {
        {
            name = ccb.content.text("alkahest splatter"),
            symbol = "5",
            color = "light_green",
            dangerous = false,
            effects = {
                { effect = "alkahest", intensity = 1, immune_in_vehicle = true, environmental = false },
            },
        },
    },
    description_affix = "covered_in",
    immunity = { flags = { "ALKAHEST_IMMUNE" } },
    underwater_age_speedup = "8 h",
    priority = 2,
    half_life = "8 h",
    phase = "liquid",
    display_field = true,
    looks_like = "fd_sludge",
}

ccb.content.define_field_type {
    id = "fd_eshaper_dust",
    levels = {
        {
            name = ccb.content.text("dust"),
            symbol = "~",
            dangerous = false,
            transparent = false,
            translucency = 14,
        },
    },
    decay_amount_factor = 15,
    gas_absorption_factor = 5,
    percent_spread = 30,
    dirty_transparency_cache = true,
    has_fume = true,
    priority = 8,
    half_life = "20 seconds",
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_tear_gas",
}

ccb.content.define_field_type {
    id = "fd_cold_energy",
    display_field = true,
    phase = "gas",
    levels = {
        {
            name = ccb.content.text("Ice haze"),
            symbol = "S",
            color = "blue",
            dangerous = false,
            effects = {
                { effect = "ice_energy", intensity = 1, immune_in_vehicle = true, environmental = false },
            },
        },
        {
            name = ccb.content.text("Ice mist"),
            symbol = "S",
            color = "blue",
            dangerous = false,
            effects = {
                { effect = "ice_energy", intensity = 2, immune_in_vehicle = true, environmental = false },
            },
        },
        {
            name = ccb.content.text("Ice fog"),
            symbol = "S",
            color = "blue",
            dangerous = false,
            effects = {
                { effect = "ice_energy", intensity = 3, immune_in_vehicle = true, environmental = false },
            },
        },
    },
    immunity = { flags = { "COLD_ENERGY_IMMUNE" } },
    half_life = "3 seconds",
}

ccb.content.define_field_type {
    id = "fd_fog_permanent",
    copy_from = "fd_fog",
    half_life = "999999999 minutes",
    looks_like = "fd_fog",
}

ccb.content.define_field_type {
    id = "fd_rad_mage_aura",
    levels = {
        {
            name = ccb.content.text("hazy cloud"),
            symbol = "8",
            dangerous = true,
            translucency = 10,
            extra_radiation_max = 10,
        },
        {
            name = ccb.content.text("radioactive gas"),
            color = "light_green",
            extra_radiation_max = 15,
            radiation_hurt_damage_min = 1,
            radiation_hurt_damage_max = 2,
            radiation_hurt_message = ccb.content.text_without_extraction("This radioactive gas burns!"),
        },
        {
            name = ccb.content.text("thick radioactive gas"),
            color = "green",
            transparent = false,
            extra_radiation_max = 20,
            radiation_hurt_damage_min = 1,
            radiation_hurt_damage_max = 3,
            radiation_hurt_message = ccb.content.text_without_extraction("This radioactive gas burns!"),
        },
    },
    decay_amount_factor = 5,
    percent_spread = 15,
    outdoor_age_speedup = "1 minutes",
    dirty_transparency_cache = true,
    has_fume = true,
    priority = 8,
    half_life = "100 minutes",
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_nuke_gas",
}

ccb.content.define_field_type {
    id = "fd_obscuring_fog",
    levels = {
        {
            name = ccb.content.text("thick fog"),
            symbol = "~",
            dangerous = false,
            transparent = false,
            translucency = 8,
            color = "light_gray",
            scent_neutralization = 3,
        },
        {
            name = ccb.content.text("very thick fog"),
            translucency = 12,
            color = "light_gray",
            scent_neutralization = 6,
        },
        {
            name = ccb.content.text("impenetrable fog"),
            translucency = 0,
            color = "dark_gray",
            scent_neutralization = 9,
        },
    },
    decay_amount_factor = 15,
    gas_absorption_factor = 5,
    percent_spread = 35,
    dirty_transparency_cache = true,
    has_fume = true,
    priority = 8,
    half_life = "7 minutes",
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_smoke",
}

-- Like fd_dazzling, but thaumic zombies are immune to it
-- repeat last entry
-- repeat last entry
ccb.content.define_field_type {
    id = "fd_dazzling_thaumic",
    immune_monsters = {
        "mon_zombie_thaumic",
        "mon_zombie_leyspark",
        "mon_zombie_levinbolt",
        "mon_zombie_manastorm",
        "mon_zombie_queller",
        "mon_zombie_disruptor",
        "mon_zombie_magebreaker",
    },
    levels = {
        {
            name = ccb.content.text("dazzling"),
            color = "light_red_yellow",
            symbol = "#",
            light_emitted = 5,
            effects = {
                {
                    effect = "blind",
                    body_part = "eyes",
                    intensity = 2,
                    min_duration = "2 seconds",
                    max_duration = "2 seconds",
                    chance_in_vehicle = 1,
                    chance_inside_vehicle = 1,
                    chance_outside_vehicle = 1,
                },
                {
                    effect = "blind",
                    body_part = "eyes",
                    intensity = 10,
                    min_duration = "10 seconds",
                    max_duration = "10 seconds",
                    chance_in_vehicle = 5,
                    chance_inside_vehicle = 5,
                    chance_outside_vehicle = 5,
                },
            },
        },
        {
            effects = {
                {
                    effect = "blind",
                    body_part = "eyes",
                    intensity = 10,
                    min_duration = "10 seconds",
                    max_duration = "10 seconds",
                    chance_in_vehicle = 1,
                    chance_inside_vehicle = 1,
                    chance_outside_vehicle = 1,
                },
            },
        },
        {},
    },
    description_affix = "illuminated_by",
    immunity = {
        any_worn_flags = {
            { part = "sensor", flag = "FLASH_PROTECTION" },
            { part = "sensor", flag = "BLIND" },
        },
        flags = { "BLIND" },
    },
    priority = 4,
    half_life = "1 turns",
    phase = "plasma",
    display_items = false,
    display_field = true,
    looks_like = "fd_laser",
}

ccb.content.define_field_type {
    id = "fd_nullifying_field",
    levels = {
        {
            name = ccb.content.text("emptiness"),
            effects = {
                {
                    effect = "effect_disjunction",
                    intensity = 1,
                    min_duration = "1 seconds",
                    max_duration = "2 seconds",
                    immune_inside_vehicle = false,
                },
            },
        },
    },
    decay_amount_factor = 5,
    gas_absorption_factor = 15,
    percent_spread = 5,
    priority = 8,
    half_life = "10 seconds",
    phase = "gas",
}

ccb.content.define_field_type {
    id = "fd_mana_overload",
    display_field = true,
    phase = "gas",
    percent_spread = 5,
    half_life = "10 seconds",
    levels = {
        {
            name = ccb.content.text("shimmering air"),
            symbol = "~",
            color = "blue",
            dangerous = true,
            effects = {
                {
                    effect = "effect_mana_overload",
                    min_duration = "15 minutes",
                    max_duration = "45 minutes",
                    intensity = 1,
                    immune_in_vehicle = true,
                    environmental = false,
                },
            },
        },
        {
            name = ccb.content.text("glittering air"),
            symbol = "~",
            color = "blue",
            dangerous = false,
            light_emitted = 1,
            effects = {
                {
                    effect = "effect_mana_overload",
                    intensity = 2,
                    min_duration = "2 hours",
                    max_duration = "4 hours",
                    immune_in_vehicle = true,
                    environmental = false,
                },
            },
        },
        {
            name = ccb.content.text("glowing air"),
            symbol = "~",
            color = "blue",
            dangerous = true,
            light_emitted = 10,
            effects = {
                {
                    effect = "effect_mana_overload",
                    intensity = 3,
                    min_duration = "12 hours",
                    max_duration = "24 hours",
                    immune_in_vehicle = true,
                    environmental = false,
                },
            },
        },
    },
}
