local ccb = require("ccb")

ccb.content.define_field_type {
    id = "fd_fright",
    levels = {
        {
            name = ccb.content.text("dreadful presence"),
            symbol = "8",
            dangerous = true,
            effects = {
                {
                    effect = "eff_frightful_presence",
                    body_part = "torso",
                    intensity = 1,
                    min_duration = "2 seconds",
                    max_duration = "2 seconds",
                    environmental = false,
                },
            },
        },
        {
            name = ccb.content.text("frightful presence"),
            color = "light_gray",
            effects = {
                {
                    effect = "eff_frightful_presence",
                    body_part = "torso",
                    intensity = 2,
                    min_duration = "2 seconds",
                    max_duration = "2 seconds",
                    environmental = false,
                },
            },
        },
        {
            name = ccb.content.text("terrifying presence"),
            color = "dark_gray",
            effects = {
                {
                    effect = "eff_frightful_presence",
                    body_part = "torso",
                    intensity = 3,
                    min_duration = "2 seconds",
                    max_duration = "2 seconds",
                    environmental = false,
                },
            },
        },
    },
    decay_amount_factor = 5,
    gas_absorption_factor = 12,
    dirty_transparency_cache = true,
    percent_spread = 40,
    outdoor_age_speedup = "0 turns",
    immunity = { resistances = { { part = "sensor", minimum = 12 } } },
    priority = 8,
    half_life = "2 minutes",
    phase = "gas",
    accelerated_decay = true,
    display_field = false,
}
