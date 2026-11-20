local ccb = require("ccb")

ccb.content.define_field_type {
    id = "fd_migo_atmosphere",
    levels = {
        {
            name = ccb.content.text("foul-smelling air"),
            symbol = "8",
            dangerous = true,
            effects = {
                {
                    effect = "migo_atmosphere",
                    body_part = "mouth",
                    intensity = 1,
                    min_duration = "5 seconds",
                    max_duration = "10 seconds",
                    immune_inside_vehicle = true,
                },
            },
        },
        {
            name = ccb.content.text("foul-smelling air"),
            translucency = 1,
            effects = {
                {
                    effect = "migo_atmosphere",
                    body_part = "mouth",
                    intensity = 2,
                    min_duration = "10 seconds",
                    max_duration = "25 seconds",
                },
            },
        },
        {
            name = ccb.content.text("foul-smelling air"),
            effects = {
                {
                    effect = "migo_atmosphere",
                    body_part = "mouth",
                    intensity = 4,
                    min_duration = "15 seconds",
                    max_duration = "25 seconds",
                },
            },
        },
    },
    decay_amount_factor = 5,
    gas_absorption_factor = 15,
    percent_spread = 30,
    outdoor_age_speedup = "3 minutes",
    dirty_transparency_cache = true,
    has_fume = true,
    immunity = { resistances = { { part = "mouth", minimum = 15 } }, flags = { "MIGO_IMMUNE" } },
    priority = 8,
    half_life = "10 minutes",
    phase = "gas",
}
