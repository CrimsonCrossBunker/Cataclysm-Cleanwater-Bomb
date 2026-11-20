local ccb = require("ccb")

ccb.content.define_field_type {
    id = "fd_clairvoyant",
    levels = { { name = ccb.content.text("clairvoyance"), symbol = "8", dangerous = false } },
    decay_amount_factor = 5,
    gas_absorption_factor = 12,
    dirty_transparency_cache = true,
    outdoor_age_speedup = "0 turns",
    priority = 8,
    half_life = "1 seconds",
    phase = "solid",
    display_field = false,
}

ccb.content.define_field_type {
    id = "fd_foamcrete",
    levels = {
        { name = ccb.content.text("foamcrete"), move_cost = 1, symbol = "#", color = "light_blue" },
        { name = ccb.content.text("foamcrete lump"), move_cost = 2, color = "light_blue_white" },
        { name = ccb.content.text("foamcrete half-wall"), move_cost = 3, color = "light_blue_white" },
    },
    description_affix = "covered_in",
    priority = 2,
    phase = "solid",
    bash = {
        minimum_strength = 15,
        maximum_strength = 40,
        volume = 3,
        failure_volume = 2,
        sound = ccb.content.text_without_extraction("crash!"),
        failure_sound = ccb.content.text_without_extraction("smash!"),
        success_message = ccb.content.text("You destroy the foamcrete."),
    },
    display_items = false,
    display_field = true,
}

-- repeat last entry
-- repeat last entry
-- won't be applied inside of vehicles, so it could apply lesser effect
-- repeat last entry
-- repeat last entry
-- repeat last entry
-- repeat last entry
-- repeat last entry
ccb.content.define_field_type {
    id = "fd_toxic_foam",
    levels = {
        {
            name = ccb.content.text("toxic foam"),
            symbol = "8",
            dangerous = true,
            translucency = 1,
            effects = {
                {
                    effect = "poison",
                    body_part = "mouth",
                    intensity = 2,
                    min_duration = "2 minutes",
                    max_duration = "2 minutes",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("You feel the toxic foam burn through your skin."),
                    message_type = "bad",
                },
            },
        },
        {},
        {},
        {
            name = ccb.content.text("dense toxic foam"),
            color = "green",
            translucency = 0,
            effects = {
                {
                    effect = "afs_badpoison",
                    body_part = "mouth",
                    intensity = 5,
                    min_duration = "10 minutes",
                    max_duration = "10 minutes",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("You feel the toxic foam burn through your skin."),
                    message_type = "bad",
                },
            },
        },
        {},
        {},
        {},
        {},
        {},
    },
    decay_amount_factor = 5,
    percent_spread = 30,
    outdoor_age_speedup = "3 minutes",
    has_fume = true,
    dirty_transparency_cache = true,
    immunity = {
        resistances = {
            { part = "torso", minimum = 15 },
            { part = "leg", minimum = 15 },
            { part = "foot", minimum = 15 },
            { part = "mouth", minimum = 15 },
            { part = "sensor", minimum = 15 },
        },
    },
    priority = 2,
    half_life = "1 hours",
    phase = "solid",
    display_items = true,
    display_field = true,
    looks_like = "fd_nuke_gas",
}

ccb.content.define_field_type {
    id = "fd_rad_glimmer",
    levels = {
        {
            name = ccb.content.text("radiative glimmer"),
            color = "light_red_yellow",
            symbol = "#",
            light_emitted = 5,
            extra_radiation_max = 1,
        },
        {
            name = ccb.content.text("radiative glimmer"),
            color = "light_red_yellow",
            extra_radiation_max = 2,
            concentration = 2,
        },
        {
            name = ccb.content.text("intense radiative glimmer"),
            color = "light_red_yellow",
            light_emitted = 10,
            extra_radiation_max = 15,
            radiation_hurt_damage_min = 1,
            radiation_hurt_damage_max = 2,
            radiation_hurt_message = ccb.content.text_without_extraction("You feel a painful burning sensation."),
        },
    },
    description_affix = "illuminated_by",
    priority = 4,
    half_life = "1 turns",
    phase = "plasma",
    display_items = false,
    display_field = true,
    looks_like = "fd_laser",
}

-- repeat last entry
-- repeat last entry
ccb.content.define_field_type {
    id = "fd_toxic_dust",
    levels = {
        {
            name = ccb.content.text("toxic dust"),
            symbol = "#",
            dangerous = true,
            translucency = 1,
            effects = {
                {
                    effect = "poison",
                    body_part = "mouth",
                    intensity = 2,
                    min_duration = "2 minutes",
                    max_duration = "2 minutes",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("You feel the toxic dust burn through your skin."),
                    message_type = "bad",
                },
            },
        },
        {},
        {},
    },
    decay_amount_factor = 5,
    percent_spread = 30,
    has_fume = true,
    dirty_transparency_cache = true,
    immunity = {
        resistances = {
            { part = "torso", minimum = 15 },
            { part = "leg", minimum = 15 },
            { part = "foot", minimum = 15 },
            { part = "mouth", minimum = 15 },
            { part = "sensor", minimum = 15 },
        },
    },
    priority = 2,
    half_life = "5 seconds",
    phase = "solid",
    display_items = true,
    display_field = true,
    looks_like = "fd_fungal_haze",
}
