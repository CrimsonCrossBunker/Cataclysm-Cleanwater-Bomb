local ccb = require("ccb")

ccb.content.define_field_type {
    id = "fd_blood",
    legacy_enum_id = 1,
    levels = {
        { name = ccb.content.text("blood splatter"), color = "red" },
        { name = ccb.content.text("blood stain") },
        { name = ccb.content.text("puddle of blood") },
    },
    description_affix = "covered_in",
    underwater_age_speedup = "25 minutes",
    decay_amount_factor = 2,
    splattering = true,
    half_life = "2 days",
    phase = "liquid",
    accelerated_decay = true,
    display_field = true,
}

ccb.content.define_field_type {
    id = "fd_bile",
    legacy_enum_id = 2,
    levels = {
        { name = ccb.content.text("bile splatter"), color = "pink" },
        { name = ccb.content.text("bile stain") },
        { name = ccb.content.text("puddle of bile") },
    },
    description_affix = "covered_in",
    underwater_age_speedup = "25 minutes",
    decay_amount_factor = 2,
    splattering = true,
    half_life = "1 days",
    phase = "liquid",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_acid",
}

ccb.content.define_field_type {
    id = "fd_gibs_flesh",
    legacy_enum_id = 3,
    levels = {
        { name = ccb.content.text("scraps of flesh"), symbol = "~", color = "brown" },
        { name = ccb.content.text("bloody meat chunks"), color = "light_red" },
        { name = ccb.content.text("heap of gore"), color = "red" },
    },
    description_affix = "covered_in",
    underwater_age_speedup = "25 minutes",
    decay_amount_factor = 2,
    splattering = true,
    half_life = "2 days",
    phase = "liquid",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_blood",
}

ccb.content.define_field_type {
    id = "fd_gibs_veggy",
    legacy_enum_id = 4,
    levels = {
        { name = ccb.content.text("shredded leaves and twigs"), symbol = "~", color = "light_green" },
        { name = ccb.content.text("shattered branches and leaves") },
        { name = ccb.content.text("broken vegetation tangle"), color = "green" },
    },
    description_affix = "covered_in",
    underwater_age_speedup = "25 minutes",
    decay_amount_factor = 2,
    splattering = true,
    half_life = "2 days",
    phase = "liquid",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_blood_veggy",
}

ccb.content.define_field_type {
    id = "fd_web",
    legacy_enum_id = 5,
    levels = {
        {
            name = ccb.content.text("cobwebs"),
            symbol = "}",
            effects = {
                {
                    effect = "webbed",
                    intensity = 1,
                    min_duration = "1 m",
                    immune_in_vehicle = true,
                    environmental = false,
                },
            },
        },
        {
            name = ccb.content.text("webs"),
            effects = {
                {
                    effect = "webbed",
                    intensity = 2,
                    min_duration = "1 m",
                    immune_in_vehicle = true,
                    environmental = false,
                },
            },
        },
        {
            name = ccb.content.text("thick webs"),
            transparent = false,
            effects = {
                {
                    effect = "webbed",
                    intensity = 3,
                    min_duration = "1 m",
                    immune_in_vehicle = true,
                    environmental = false,
                },
            },
        },
    },
    description_affix = "covered_in",
    immunity = { flags = { "WEBWALK" } },
    immune_monsters = { "mon_spider_web", "mon_spider_web_s", "mon_mutant_arthropod" },
    decrease_intensity_on_contact = true,
    priority = 2,
    phase = "solid",
    display_items = false,
    bash = {
        minimum_strength = 1,
        maximum_strength = 3,
        volume = 2,
        failure_volume = 2,
        sound = ccb.content.text_without_extraction("hsh!"),
        success_message = ccb.content.text("You brush aside some webs."),
    },
    display_field = true,
}

ccb.content.define_field_type {
    id = "fd_web_nostick",
    looks_like = "fd_web",
    levels = {
        { name = ccb.content.text("thin cobwebs"), symbol = "}", color = "white" },
        { name = ccb.content.text("thin webs"), transparent = false },
    },
    description_affix = "covered_in",
    decrease_intensity_on_contact = true,
    priority = 2,
    phase = "solid",
    display_items = true,
    bash = {
        minimum_strength = 1,
        maximum_strength = 3,
        volume = 2,
        failure_volume = 2,
        sound = ccb.content.text_without_extraction("hsh!"),
        success_message = ccb.content.text("You brush aside some webs."),
    },
    display_field = true,
}

ccb.content.define_field_type {
    id = "fd_void_web",
    looks_like = "fd_web",
    levels = {
        {
            name = ccb.content.text("starlit webs"),
            symbol = "}",
            color = "white",
            transparent = true,
            effects = {
                {
                    effect = "webbed",
                    intensity = 1,
                    min_duration = "1 m",
                    immune_in_vehicle = true,
                    environmental = false,
                },
            },
        },
        {
            name = ccb.content.text("starlit webs"),
            transparent = true,
            effects = {
                {
                    effect = "webbed",
                    intensity = 2,
                    min_duration = "1 m",
                    immune_in_vehicle = true,
                    environmental = false,
                },
            },
        },
        {
            name = ccb.content.text("starlit webs"),
            transparent = false,
            effects = {
                {
                    effect = "webbed",
                    intensity = 3,
                    min_duration = "1 m",
                    immune_in_vehicle = true,
                    environmental = false,
                },
            },
        },
    },
    description_affix = "covered_in",
    immune_monsters = {
        "mon_void_spider",
        "mon_void_spider_spiderling",
        "mon_void_spider_maw",
        "mon_void_spider_limb",
    },
    decrease_intensity_on_contact = true,
    priority = 2,
    phase = "solid",
    display_items = false,
    display_field = true,
}

ccb.content.define_field_type {
    id = "fd_slime",
    legacy_enum_id = 6,
    levels = {
        { name = ccb.content.text("slime trail"), color = "light_green" },
        { name = ccb.content.text("slime stain") },
        { name = ccb.content.text("puddle of slime"), color = "green" },
    },
    description_affix = "covered_in",
    decay_amount_factor = 2,
    apply_slime_factor = 10,
    splattering = true,
    half_life = "1 days",
    phase = "liquid",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_blood_veggy",
}

ccb.content.define_field_type {
    id = "fd_acid",
    legacy_enum_id = 7,
    levels = {
        { name = ccb.content.text("acid splatter"), symbol = "5", color = "light_green", dangerous = true },
        { name = ccb.content.text("acid streak") },
        { name = ccb.content.text("pool of acid"), color = "green" },
    },
    description_affix = "covered_in",
    immunity = { flags = { "ACID_IMMUNE" } },
    underwater_age_speedup = "2 minutes",
    has_acid = true,
    priority = 2,
    half_life = "2 minutes",
    phase = "liquid",
    display_field = true,
    looks_like = "fd_bile",
}

ccb.content.define_field_type {
    id = "fd_sap",
    legacy_enum_id = 8,
    levels = {
        {
            name = ccb.content.text("sap splatter"),
            symbol = "5",
            color = "yellow",
            dangerous = true,
            effects = {
                {
                    effect = "sap",
                    intensity = 1,
                    min_duration = "2 seconds",
                    max_duration = "2 seconds",
                    immune_in_vehicle = true,
                    environmental = false,
                    message = ccb.content.text("The sap sticks to you!"),
                    npc_message = ccb.content.text("The sap sticks to <npcname>!"),
                    message_type = "bad",
                },
            },
        },
        {
            name = ccb.content.text("glob of sap"),
            effects = {
                {
                    effect = "sap",
                    intensity = 1,
                    min_duration = "4 seconds",
                    max_duration = "4 seconds",
                    immune_in_vehicle = true,
                    environmental = false,
                    message = ccb.content.text("The sap sticks to you!"),
                    npc_message = ccb.content.text("The sap sticks to <npcname>!"),
                    message_type = "bad",
                },
            },
        },
        {
            name = ccb.content.text("pool of sap"),
            color = "brown",
            effects = {
                {
                    effect = "sap",
                    intensity = 1,
                    min_duration = "6 seconds",
                    max_duration = "6 seconds",
                    immune_in_vehicle = true,
                    environmental = false,
                    message = ccb.content.text("The sap sticks to you!"),
                    npc_message = ccb.content.text("The sap sticks to <npcname>!"),
                    message_type = "bad",
                },
            },
        },
    },
    description_affix = "covered_in",
    splattering = true,
    priority = 2,
    half_life = "2 minutes",
    phase = "liquid",
    display_field = true,
    looks_like = "fd_blood_veggy",
}

ccb.content.define_field_type {
    id = "fd_sludge",
    legacy_enum_id = 9,
    mopsafe = true,
    levels = {
        {
            name = ccb.content.text("thin sludge trail"),
            symbol = "5",
            color = "light_gray",
            dangerous = true,
            effects = {
                { effect = "sludged", intensity = 1, immune_in_vehicle = true, environmental = false },
            },
        },
        {
            name = ccb.content.text("sludge trail"),
            color = "dark_gray",
            effects = {
                { effect = "sludged", intensity = 2, immune_in_vehicle = true, environmental = false },
            },
        },
        {
            name = ccb.content.text("thick sludge trail"),
            effects = {
                { effect = "sludged", intensity = 3, immune_in_vehicle = true, environmental = false },
            },
        },
    },
    description_affix = "covered_in",
    splattering = true,
    priority = 2,
    half_life = "30 minutes",
    phase = "liquid",
    display_field = true,
    immunity = { flags = { "SLUDGE_IMMUNE" } },
    looks_like = "fd_sap",
}

ccb.content.define_field_type {
    id = "fd_fire",
    legacy_enum_id = 10,
    levels = {
        {
            name = ccb.content.text("small fire"),
            symbol = "4",
            color = "yellow",
            dangerous = true,
            light_emitted = 20,
            light_color = { 255, 120, 40 },
            translucency = 0.7,
            convection_temperature_mod = 300,
        },
        {
            name = ccb.content.text("fire", "noun"),
            color = "light_red",
            light_emitted = 60,
            light_color = { 255, 180, 80 },
            translucency = 0.4,
        },
        {
            name = ccb.content.text("raging fire"),
            color = "red",
            light_emitted = 160,
            light_color = { 255, 255, 210 },
            translucency = 0.1,
        },
    },
    description_affix = "on",
    decay_amount_factor = 3,
    has_fire = true,
    priority = 4,
    half_life = "30 minutes",
    phase = "plasma",
    display_items = false,
    display_field = true,
}

-- won't be applied outside of vehicles, so it could apply harsher effect
-- won't be applied inside of vehicles, so it could apply lesser effect
ccb.content.define_field_type {
    id = "fd_extinguisher",
    levels = {
        {
            name = ccb.content.text("extinguisher mist"),
            symbol = "%",
            color = "white",
            dangerous = true,
            translucency = 0.1,
            concentration = 1,
            convection_temperature_mod = -10,
            effects = {
                {
                    effect = "poison",
                    body_part = "mouth",
                    intensity = 2,
                    min_duration = "2 minutes",
                    max_duration = "2 minutes",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("You feel sick from inhaling the extinguisher mist."),
                    message_type = "bad",
                },
            },
        },
        {
            name = ccb.content.text("extinguisher cloud"),
            color = "white",
            convection_temperature_mod = -20,
            translucency = 0.4,
            concentration = 2,
            effects = {
                {
                    effect = "poison",
                    body_part = "mouth",
                    intensity = 2,
                    min_duration = "2 minutes",
                    max_duration = "2 minutes",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("You feel sick from inhaling the extinguisher cloud."),
                    message_type = "bad",
                },
            },
        },
        {
            name = ccb.content.text("thick extinguisher cloud"),
            color = "white",
            convection_temperature_mod = -30,
            translucency = 0.7,
            concentration = 4,
            effects = {
                {
                    effect = "poison",
                    body_part = "mouth",
                    intensity = 5,
                    min_duration = "3 minutes",
                    max_duration = "3 minutes",
                    immune_outside_vehicle = true,
                    message = ccb.content.text("You feel sick from inhaling the thick extinguisher cloud."),
                    message_type = "bad",
                },
                {
                    effect = "badpoison",
                    body_part = "mouth",
                    intensity = 5,
                    min_duration = "3 minutes",
                    max_duration = "3 minutes",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("You feel sick from inhaling the thick extinguisher cloud."),
                    message_type = "bad",
                },
            },
        },
    },
    description_affix = "on",
    decay_amount_factor = 3,
    priority = 4,
    half_life = "10 seconds",
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_fog",
    gas_absorption_factor = "20h",
    has_fume = true,
    percent_spread = 90,
    dirty_transparency_cache = true,
    immunity = { resistances = { { part = "mouth", minimum = 15 } }, flags = { "INHALED_TOXIN_IMMUNE" } },
}

ccb.content.define_field_type {
    id = "fd_rubble",
    legacy_enum_id = 11,
    levels = { { name = ccb.content.text("legacy rubble"), symbol = "#", color = "dark_gray" } },
    description_affix = "covered_in",
    half_life = "1 turns",
    phase = "solid",
    display_items = false,
    display_field = true,
    looks_like = "f_rubble",
    legacy_make_rubble = true,
}

ccb.content.define_field_type {
    id = "fd_smoke",
    legacy_enum_id = 12,
    levels = {
        {
            name = ccb.content.text("thin smoke"),
            symbol = "8",
            dangerous = true,
            translucency = 1,
            concentration = 1,
            effects = {
                {
                    effect = "smoke_eyes",
                    body_part = "eyes",
                    intensity = 1,
                    min_duration = "2 seconds",
                    max_duration = "2 seconds",
                    immunity = { resistances = { { part = "sensor", minimum = 3 } } },
                    immune_inside_vehicle = true,
                },
                {
                    effect = "smoke_lungs",
                    body_part = "mouth",
                    intensity = 1,
                    min_duration = "2 seconds",
                    max_duration = "2 seconds",
                    immunity = {
                        resistances = { { part = "mouth", minimum = 3 } },
                        flags = { "INHALED_TOXIN_IMMUNE" },
                    },
                    immune_inside_vehicle = true,
                },
            },
        },
        {
            name = ccb.content.text("smoke"),
            color = "light_gray",
            transparent = false,
            translucency = 10,
            concentration = 2,
            effects = {
                {
                    effect = "smoke_eyes",
                    body_part = "eyes",
                    intensity = 2,
                    min_duration = "7 seconds",
                    max_duration = "7 seconds",
                    immunity = { resistances = { { part = "sensor", minimum = 5 } } },
                    immune_inside_vehicle = true,
                },
                {
                    effect = "smoke_lungs",
                    body_part = "mouth",
                    intensity = 2,
                    min_duration = "7 seconds",
                    max_duration = "7 seconds",
                    immunity = {
                        resistances = { { part = "mouth", minimum = 5 } },
                        flags = { "INHALED_TOXIN_IMMUNE" },
                    },
                    immune_inside_vehicle = true,
                },
            },
            scent_neutralization = 1,
        },
        {
            name = ccb.content.text("thick smoke"),
            color = "dark_gray",
            translucency = 0,
            concentration = 4,
            effects = {
                {
                    effect = "smoke_eyes",
                    body_part = "eyes",
                    intensity = 4,
                    min_duration = "15 seconds",
                    max_duration = "15 seconds",
                    immunity = { resistances = { { part = "sensor", minimum = 7 } } },
                    immune_inside_vehicle = true,
                },
                {
                    effect = "smoke_lungs",
                    body_part = "mouth",
                    intensity = 4,
                    min_duration = "15 seconds",
                    max_duration = "15 seconds",
                    immunity = {
                        resistances = { { part = "mouth", minimum = 7 } },
                        flags = { "INHALED_TOXIN_IMMUNE" },
                    },
                    immune_inside_vehicle = true,
                },
            },
            scent_neutralization = 5,
        },
    },
    decay_amount_factor = 5,
    gas_absorption_factor = "100m",
    dirty_transparency_cache = true,
    percent_spread = 10,
    outdoor_age_speedup = "0 turns",
    priority = 8,
    half_life = "2 minutes",
    phase = "gas",
    has_fume = true,
    accelerated_decay = true,
    display_items = false,
    display_field = true,
    looks_like = "fd_fog",
}

-- won't be applied outside of vehicles, so it could apply harsher effect
-- won't be applied inside of vehicles, so it could apply lesser effect
-- won't be applied outside of vehicles, so it could apply harsher effect
-- won't be applied inside of vehicles, so it could apply lesser effect
ccb.content.define_field_type {
    id = "fd_toxic_gas",
    legacy_enum_id = 13,
    levels = {
        {
            name = ccb.content.text("hazy cloud"),
            symbol = "8",
            dangerous = true,
            translucency = 1,
            concentration = 1,
            effects = {
                {
                    effect = "poison",
                    body_part = "eyes",
                    intensity = 2,
                    min_duration = "2 minutes",
                    max_duration = "2 minutes",
                    immune_inside_vehicle = true,
                    immunity = { resistances = { { part = "sensor", minimum = 15 } } },
                    message = ccb.content.text("The hazy cloud makes your eyes itch."),
                    message_type = "bad",
                },
                {
                    effect = "poison",
                    body_part = "mouth",
                    intensity = 2,
                    min_duration = "2 minutes",
                    max_duration = "2 minutes",
                    immune_inside_vehicle = true,
                    immunity = {
                        resistances = { { part = "mouth", minimum = 15 } },
                        flags = { "INHALED_TOXIN_IMMUNE" },
                    },
                    message = ccb.content.text("You feel sick from inhaling the hazy cloud."),
                    message_type = "bad",
                },
            },
        },
        {
            name = ccb.content.text("toxic gas"),
            color = "light_green",
            transparent = false,
            translucency = 10,
            concentration = 2,
            effects = {
                {
                    effect = "poison",
                    body_part = "eyes",
                    intensity = 5,
                    min_duration = "3 minutes",
                    max_duration = "3 minutes",
                    immune_inside_vehicle = true,
                    immunity = { resistances = { { part = "sensor", minimum = 15 } } },
                    message = ccb.content.text("The toxic gas makes your eyes burn."),
                    message_type = "bad",
                },
                {
                    effect = "poison",
                    body_part = "mouth",
                    intensity = 5,
                    min_duration = "3 minutes",
                    max_duration = "3 minutes",
                    immune_inside_vehicle = true,
                    immunity = {
                        resistances = { { part = "mouth", minimum = 15 } },
                        flags = { "INHALED_TOXIN_IMMUNE" },
                    },
                    message = ccb.content.text("You feel sick from inhaling the toxic gas."),
                    message_type = "bad",
                },
            },
        },
        {
            name = ccb.content.text("thick toxic gas"),
            color = "green",
            translucency = 0,
            concentration = 4,
            effects = {
                {
                    effect = "poison",
                    body_part = "eyes",
                    intensity = 5,
                    min_duration = "3 minutes",
                    max_duration = "3 minutes",
                    immune_outside_vehicle = true,
                    immunity = { resistances = { { part = "sensor", minimum = 15 } } },
                    message = ccb.content.text("You eyes burn from the thick toxic gas."),
                    message_type = "bad",
                },
                {
                    effect = "badpoison",
                    body_part = "eyes",
                    intensity = 5,
                    min_duration = "3 minutes",
                    max_duration = "3 minutes",
                    immune_inside_vehicle = true,
                    immunity = { resistances = { { part = "sensor", minimum = 15 } } },
                    message = ccb.content.text("You eyes burn from the thick toxic gas."),
                    message_type = "bad",
                },
                {
                    effect = "poison",
                    body_part = "mouth",
                    intensity = 5,
                    min_duration = "3 minutes",
                    max_duration = "3 minutes",
                    immune_outside_vehicle = true,
                    immunity = {
                        resistances = { { part = "mouth", minimum = 15 } },
                        flags = { "INHALED_TOXIN_IMMUNE" },
                    },
                    message = ccb.content.text("You feel sick from inhaling the thick toxic gas."),
                    message_type = "bad",
                },
                {
                    effect = "badpoison",
                    body_part = "mouth",
                    intensity = 5,
                    min_duration = "3 minutes",
                    max_duration = "3 minutes",
                    immune_inside_vehicle = true,
                    immunity = {
                        resistances = { { part = "mouth", minimum = 15 } },
                        flags = { "INHALED_TOXIN_IMMUNE" },
                    },
                    message = ccb.content.text("You feel sick from inhaling the thick toxic gas."),
                    message_type = "bad",
                },
            },
        },
    },
    decay_amount_factor = 5,
    gas_absorption_factor = "80m",
    percent_spread = 30,
    outdoor_age_speedup = "3 minutes",
    dirty_transparency_cache = true,
    has_fume = true,
    priority = 8,
    half_life = "10 minutes",
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_nuke_gas",
}

ccb.content.define_field_type {
    id = "fd_pollen_triffid",
    legacy_enum_id = 51,
    levels = {
        {
            name = ccb.content.text("hazy cloud"),
            symbol = "8",
            dangerous = true,
            translucency = 1,
            concentration = 1,
            effects = {
                {
                    effect = "tpollen",
                    body_part = "mouth",
                    intensity = 2,
                    min_duration = "2 minutes",
                    max_duration = "2 minutes",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("You feel sick from inhaling the hazy cloud."),
                    message_type = "bad",
                },
            },
        },
        {
            name = ccb.content.text("triffid pollen"),
            color = "light_green",
            transparent = false,
            translucency = 10,
            concentration = 2,
            effects = {
                {
                    effect = "tpollen",
                    body_part = "mouth",
                    intensity = 5,
                    min_duration = "3 minutes",
                    max_duration = "3 minutes",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("You feel sick from inhaling the triffid pollen."),
                    message_type = "bad",
                },
            },
        },
    },
    decay_amount_factor = 5,
    gas_absorption_factor = "80m",
    percent_spread = 30,
    outdoor_age_speedup = "3 minutes",
    dirty_transparency_cache = true,
    has_fume = true,
    immunity = { resistances = { { part = "mouth", minimum = 15 } }, flags = { "INHALED_TOXIN_IMMUNE" } },
    priority = 8,
    half_life = "10 minutes",
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_nuke_gas",
}

ccb.content.define_field_type {
    id = "fd_tear_gas",
    legacy_enum_id = 14,
    levels = {
        {
            name = ccb.content.text("hazy cloud"),
            symbol = "8",
            dangerous = true,
            translucency = 1,
            concentration = 1,
            effects = {
                {
                    effect = "teargas",
                    body_part = "eyes",
                    immunity = { resistances = { { part = "sensor", minimum = 15 } } },
                    intensity = 1,
                    min_duration = "2 minutes",
                    max_duration = "5 minutes",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("Hazy cloud got into your eyes."),
                    message_type = "bad",
                },
                {
                    effect = "teargas",
                    body_part = "mouth",
                    immunity = {
                        resistances = { { part = "mouth", minimum = 15 } },
                        flags = { "INHALED_TOXIN_IMMUNE" },
                    },
                    intensity = 1,
                    min_duration = "2 minutes",
                    max_duration = "5 minutes",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("You feel sick from inhaling the hazy cloud."),
                    message_type = "bad",
                },
            },
        },
        {
            name = ccb.content.text("tear gas"),
            color = "light_green",
            transparent = false,
            translucency = 10,
            concentration = 2,
            scent_neutralization = 1,
            effects = {
                {
                    effect = "teargas",
                    body_part = "eyes",
                    immunity = { resistances = { { part = "sensor", minimum = 15 } } },
                    intensity = 1,
                    min_duration = "5 minutes",
                    max_duration = "15 minutes",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("Tear gas got into your eyes."),
                    message_type = "bad",
                },
                {
                    effect = "teargas",
                    body_part = "mouth",
                    immunity = {
                        resistances = { { part = "mouth", minimum = 15 } },
                        flags = { "INHALED_TOXIN_IMMUNE" },
                    },
                    intensity = 1,
                    min_duration = "5 minutes",
                    max_duration = "15 minutes",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("You feel sick from inhaling the tear gas."),
                    message_type = "bad",
                },
            },
        },
        {
            name = ccb.content.text("thick tear gas"),
            color = "green",
            translucency = 0,
            concentration = 4,
            scent_neutralization = 5,
            effects = {
                {
                    effect = "teargas",
                    body_part = "eyes",
                    immunity = { resistances = { { part = "sensor", minimum = 15 } } },
                    intensity = 1,
                    min_duration = "15 minutes",
                    max_duration = "20 minutes",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("Thick tear gas got into your eyes."),
                    message_type = "bad",
                },
                {
                    effect = "teargas",
                    body_part = "mouth",
                    immunity = {
                        resistances = { { part = "mouth", minimum = 15 } },
                        flags = { "INHALED_TOXIN_IMMUNE" },
                    },
                    intensity = 1,
                    min_duration = "15 minutes",
                    max_duration = "20 minutes",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("You feel sick from inhaling the thick tear gas."),
                    message_type = "bad",
                },
            },
        },
    },
    decay_amount_factor = 5,
    gas_absorption_factor = "80m",
    percent_spread = 10,
    outdoor_age_speedup = "0 turns",
    dirty_transparency_cache = true,
    has_fume = true,
    priority = 8,
    half_life = "5 minutes",
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_smoke",
}

ccb.content.define_field_type {
    id = "fd_nuke_gas",
    legacy_enum_id = 15,
    levels = {
        {
            name = ccb.content.text("hazy cloud"),
            symbol = "8",
            dangerous = true,
            translucency = 10,
            concentration = 1,
            extra_radiation_max = 1,
        },
        {
            name = ccb.content.text("radioactive gas"),
            color = "light_green",
            extra_radiation_max = 2,
            concentration = 2,
        },
        {
            name = ccb.content.text("thick radioactive gas"),
            color = "green",
            transparent = false,
            concentration = 4,
            extra_radiation_max = 3,
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
    looks_like = "fd_smoke",
}

-- repeat last entry
-- repeat last entry
ccb.content.define_field_type {
    id = "fd_gas_vent",
    legacy_enum_id = 16,
    levels = { { name = ccb.content.text("gas vent"), concentration = 4 }, {}, {} },
    description_affix = "under",
    wandering_field = "fd_toxic_gas",
    gas_absorption_factor = "80m",
    dirty_transparency_cache = true,
    immunity = { resistances = { { part = "mouth", minimum = 15 } }, flags = { "INHALED_TOXIN_IMMUNE" } },
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_toxic_gas",
}

ccb.content.define_field_type {
    id = "fd_tindalos_rift",
    levels = {
        {
            name = ccb.content.text("angular ripple"),
            color = "light_gray",
            symbol = "*",
            light_emitted = 160,
            concentration = 1,
        },
        { name = ccb.content.text("angular rift"), color = "dark_gray", concentration = 1 },
        {
            name = ccb.content.text("fractal fissure"),
            color = "magenta",
            transparent = false,
            concentration = 1,
            monster_spawn_chance = 15,
            monster_spawn_count = 1,
            monster_spawn_radius = 1,
            monster_spawn_group = "GROUP_TINDALOS",
            light_emitted = 160,
        },
    },
    priority = 9,
    half_life = "10 seconds",
    accelerated_decay = true,
    wandering_field = "fd_tindalos_gas",
    gas_absorption_factor = "80m",
    dirty_transparency_cache = true,
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_smoke",
}

ccb.content.define_field_type {
    id = "fd_twisting_mass_dust",
    levels = {
        {
            name = ccb.content.text("magenta sparkles"),
            color = "magenta",
            symbol = "*",
            light_emitted = 160,
            light_color = { 255, 0, 255 },
            concentration = 1,
        },
    },
    priority = 9,
    half_life = "10 seconds",
    accelerated_decay = true,
    dirty_transparency_cache = true,
    phase = "gas",
    display_items = true,
    display_field = true,
    looks_like = "fd_tindalos_rift",
}

-- repeat last entry
-- repeat last entry
ccb.content.define_field_type {
    id = "fd_fire_vent",
    legacy_enum_id = 17,
    levels = { { name = ccb.content.text("fire vent"), light_emitted = 20 }, {}, {} },
    description_affix = "under",
    has_fire = true,
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_fire",
}

-- repeat last entry
-- repeat last entry
ccb.content.define_field_type {
    id = "fd_flame_burst",
    legacy_enum_id = 18,
    levels = {
        {
            name = ccb.content.text("fire", "noun"),
            symbol = "5",
            color = "red",
            dangerous = true,
            light_emitted = 20,
        },
        {},
        {},
    },
    description_affix = "on",
    has_fire = true,
    priority = 4,
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_fire",
}

-- repeat last entry
-- repeat last entry
-- repeat last entry
-- repeat last entry
-- repeat last entry
-- repeat last entry
-- repeat last entry
ccb.content.define_field_type {
    id = "fd_electricity",
    legacy_enum_id = 19,
    levels = {
        {
            name = ccb.content.text("sparks"),
            symbol = "9",
            dangerous = true,
            light_emitted = 0.01,
            light_color = { 95, 204, 247 },
        },
        { light_emitted = 1, light_color = { 95, 204, 247 } },
        { light_emitted = 2.5, light_color = { 95, 204, 247 } },
        {
            name = ccb.content.text("electric crackle"),
            color = "cyan",
            light_emitted = 4,
            light_color = { 146, 217, 245 },
        },
        { light_emitted = 7.5, light_color = { 146, 217, 245 } },
        { light_emitted = 11, light_color = { 146, 217, 245 } },
        {
            name = ccb.content.text("electric cloud"),
            color = "blue",
            light_emitted = 14.5,
            light_color = { 146, 217, 245 },
        },
        { light_emitted = 18, light_color = { 182, 231, 250 } },
        { light_emitted = 21.5, light_color = { 182, 231, 250 } },
        { light_emitted = 25, light_color = { 182, 231, 250 } },
    },
    description_affix = "illuminated_by",
    has_elec = true,
    priority = 4,
    half_life = "4 turns",
    phase = "plasma",
    display_items = false,
    display_field = true,
}

ccb.content.define_field_type {
    id = "fd_fatigue",
    legacy_enum_id = 20,
    levels = {
        {
            name = ccb.content.text("odd ripple"),
            color = "light_gray",
            symbol = "*",
            dangerous = true,
            intensity_upgrade_chance = 10,
            intensity_upgrade_duration = "6 hours",
        },
        { name = ccb.content.text("swirling air"), color = "dark_gray" },
        {
            name = ccb.content.text("tear in reality"),
            color = "magenta",
            transparent = false,
            monster_spawn_chance = 600,
            monster_spawn_count = 1,
            monster_spawn_radius = 1,
            monster_spawn_group = "GROUP_NETHER_REALITY_TEAR_FIELD",
        },
    },
    description_affix = "under",
    priority = 8,
    display_items = true,
    display_field = true,
    looks_like = "fd_smoke",
}

ccb.content.define_field_type {
    id = "fd_push_items",
    legacy_enum_id = 21,
    levels = { { name = ccb.content.text("push items"), symbol = "&" } },
    priority = -1,
    display_items = false,
    display_field = true,
}

-- repeat last entry
-- repeat last entry
ccb.content.define_field_type {
    id = "fd_shock_vent",
    legacy_enum_id = 22,
    levels = { { name = ccb.content.text("shock vent"), symbol = "&" }, {}, {} },
    description_affix = "under",
    has_elec = true,
    priority = -1,
    phase = "plasma",
    display_items = false,
    display_field = true,
    looks_like = "fd_electricity",
}

-- repeat last entry
-- repeat last entry
ccb.content.define_field_type {
    id = "fd_acid_vent",
    legacy_enum_id = 23,
    levels = { { name = ccb.content.text("acid vent"), symbol = "&" }, {}, {} },
    description_affix = "under",
    has_acid = true,
    priority = -1,
    phase = "liquid",
    display_items = false,
    display_field = true,
    looks_like = "fd_acid",
}

ccb.content.define_field_type {
    id = "fd_plasma",
    legacy_enum_id = 24,
    levels = {
        { name = ccb.content.text("faint plasma"), color = "magenta", symbol = "9", light_emitted = 0.01 },
        { name = ccb.content.text("glowing plasma"), color = "pink", light_emitted = 4 },
        { name = ccb.content.text("glaring plasma"), color = "white", light_emitted = 20 },
    },
    priority = 4,
    half_life = "2 turns",
    dirty_transparency_cache = true,
    phase = "plasma",
    display_items = false,
    display_field = true,
    looks_like = "fd_fire",
}

ccb.content.define_field_type {
    id = "fd_laser",
    legacy_enum_id = 25,
    levels = {
        { name = ccb.content.text("faint glimmer"), color = "blue", symbol = "9" },
        { name = ccb.content.text("beam of light"), color = "light_blue" },
        { name = ccb.content.text("intense beam of light"), color = "white" },
    },
    description_affix = "illuminated_by",
    priority = 4,
    half_life = "1 turns",
    dirty_transparency_cache = true,
    phase = "plasma",
    display_items = false,
    display_field = true,
    looks_like = "fd_plasma",
}

ccb.content.define_field_type {
    id = "fd_spotlight",
    legacy_enum_id = 26,
    levels = { { name = ccb.content.text("spotlight"), symbol = "&", light_emitted = 80 } },
    description_affix = "illuminated_by",
    priority = 1,
    half_life = "1 turns",
    display_field = true,
    looks_like = "fd_laser",
}

-- repeat last entry
-- repeat last entry
ccb.content.define_field_type {
    id = "fd_dazzling",
    legacy_enum_id = 27,
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
    id = "fd_blood_veggy",
    legacy_enum_id = 28,
    levels = {
        { name = ccb.content.text("plant sap splatter"), color = "light_green" },
        { name = ccb.content.text("plant sap stain") },
        { name = ccb.content.text("puddle of resin") },
    },
    description_affix = "covered_in",
    underwater_age_speedup = "25 minutes",
    decay_amount_factor = 2,
    splattering = true,
    half_life = "2 days",
    phase = "liquid",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_blood",
}

ccb.content.define_field_type {
    id = "fd_blood_insect",
    legacy_enum_id = 29,
    levels = {
        { name = ccb.content.text("bug blood splatter"), color = "green" },
        { name = ccb.content.text("bug blood stain") },
        { name = ccb.content.text("puddle of bug blood") },
    },
    description_affix = "covered_in",
    underwater_age_speedup = "25 minutes",
    decay_amount_factor = 2,
    splattering = true,
    half_life = "2 days",
    phase = "liquid",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_blood",
}

ccb.content.define_field_type {
    id = "fd_blood_invertebrate",
    legacy_enum_id = 30,
    levels = {
        { name = ccb.content.text("hemolymph splatter"), color = "light_gray" },
        { name = ccb.content.text("hemolymph stain") },
        { name = ccb.content.text("puddle of hemolymph") },
    },
    description_affix = "covered_in",
    underwater_age_speedup = "25 minutes",
    decay_amount_factor = 2,
    splattering = true,
    half_life = "2 days",
    phase = "liquid",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_blood",
}

ccb.content.define_field_type {
    id = "fd_gibs_insect",
    legacy_enum_id = 31,
    levels = {
        { name = ccb.content.text("shards of chitin"), color = "light_green", symbol = "~" },
        { name = ccb.content.text("shattered bug leg"), color = "green" },
        { name = ccb.content.text("torn insect organs"), color = "yellow" },
    },
    description_affix = "covered_in",
    underwater_age_speedup = "25 minutes",
    decay_amount_factor = 2,
    splattering = true,
    half_life = "2 days",
    phase = "liquid",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_blood_insect",
}

ccb.content.define_field_type {
    id = "fd_gibs_invertebrate",
    legacy_enum_id = 32,
    levels = {
        { name = ccb.content.text("gooey scraps"), color = "light_gray", symbol = "~" },
        { name = ccb.content.text("icky mess") },
        { name = ccb.content.text("heap of squishy gore"), color = "dark_gray" },
    },
    description_affix = "covered_in",
    underwater_age_speedup = "25 minutes",
    decay_amount_factor = 2,
    splattering = true,
    half_life = "2 days",
    phase = "liquid",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_blood_invertebrate",
}

ccb.content.define_field_type {
    id = "fd_cigsmoke",
    legacy_enum_id = 33,
    levels = {
        { name = ccb.content.text("swirl of tobacco smoke"), translucency = 5 },
        { name = ccb.content.text("tobacco smoke"), color = "light_gray" },
        { name = ccb.content.text("thick tobacco smoke"), color = "dark_gray" },
    },
    decay_amount_factor = 5,
    percent_spread = 250,
    outdoor_age_speedup = "6 minutes",
    dirty_transparency_cache = true,
    priority = 8,
    half_life = "35 minutes",
    phase = "gas",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_smoke",
}

ccb.content.define_field_type {
    id = "fd_purple_incense",
    levels = {
        {
            name = ccb.content.text("swirl of purple incense"),
            translucency = 5,
            color = "magenta",
            effects = {
                {
                    effect = "purple_incense_effect",
                    intensity = 1,
                    min_duration = "2 minutes",
                    max_duration = "2 minutes",
                    environmental = false,
                },
            },
        },
    },
    decay_amount_factor = 5,
    percent_spread = 250,
    outdoor_age_speedup = "6 minutes",
    dirty_transparency_cache = true,
    priority = 8,
    half_life = "35 minutes",
    phase = "gas",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_tindalos_gas",
}

ccb.content.define_field_type {
    id = "fd_red_incense",
    levels = {
        {
            name = ccb.content.text("swirl of red incense"),
            translucency = 5,
            color = "red",
            effects = {
                {
                    effect = "red_incense_effect",
                    intensity = 1,
                    min_duration = "24 hours",
                    max_duration = "24 hours",
                    environmental = false,
                },
            },
        },
    },
    decay_amount_factor = 5,
    percent_spread = 250,
    outdoor_age_speedup = "6 minutes",
    dirty_transparency_cache = true,
    priority = 8,
    half_life = "35 minutes",
    phase = "gas",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_cigsmoke",
}

ccb.content.define_field_type {
    id = "fd_yellow_incense",
    levels = { { name = ccb.content.text("swirl of yellow incense"), translucency = 5, color = "yellow" } },
    decay_amount_factor = 5,
    percent_spread = 250,
    outdoor_age_speedup = "6 minutes",
    dirty_transparency_cache = true,
    priority = 8,
    half_life = "35 minutes",
    phase = "gas",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_cigsmoke",
}

ccb.content.define_field_type {
    id = "fd_green_incense",
    levels = {
        {
            name = ccb.content.text("swirl of green incense"),
            translucency = 5,
            color = "green",
            effects = {
                {
                    effect = "green_incense_effect",
                    intensity = 1,
                    min_duration = "30 seconds",
                    max_duration = "30 seconds",
                    environmental = false,
                },
            },
        },
    },
    decay_amount_factor = 5,
    percent_spread = 250,
    outdoor_age_speedup = "6 minutes",
    dirty_transparency_cache = true,
    priority = 8,
    half_life = "35 minutes",
    phase = "gas",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_cigsmoke",
}

ccb.content.define_field_type {
    id = "fd_incense",
    levels = { { name = ccb.content.text("swirl of incense"), translucency = 5, color = "yellow" } },
    decay_amount_factor = 5,
    percent_spread = 250,
    outdoor_age_speedup = "6 minutes",
    dirty_transparency_cache = true,
    priority = 8,
    half_life = "35 minutes",
    phase = "gas",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_cigsmoke",
}

ccb.content.define_field_type {
    id = "fd_blue_incense",
    levels = {
        {
            name = ccb.content.text("swirl of blue incense"),
            translucency = 5,
            color = "blue",
            effects = {
                {
                    effect = "invisibility",
                    intensity = 1,
                    min_duration = "30 seconds",
                    max_duration = "30 seconds",
                    environmental = false,
                },
            },
        },
    },
    decay_amount_factor = 5,
    percent_spread = 250,
    outdoor_age_speedup = "6 minutes",
    dirty_transparency_cache = true,
    priority = 8,
    half_life = "35 minutes",
    phase = "gas",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_cigsmoke",
}

ccb.content.define_field_type {
    id = "fd_black_incense",
    levels = {
        {
            name = ccb.content.text("dense caustic gas"),
            color = "dark_gray",
            translucency = 20,
            transparent = false,
            dangerous = true,
            effects = {
                {
                    effect = "black_incense_effect",
                    body_part = "torso",
                    intensity = 1,
                    min_duration = "10 seconds",
                    max_duration = "10 seconds",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("You feel the caustic gas burn through your skin."),
                    message_type = "bad",
                },
            },
        },
    },
    looks_like = "fd_smoke",
    dirty_transparency_cache = true,
    immunity = {
        resistances = {
            { part = "torso", minimum = 15 },
            { part = "mouth", minimum = 15 },
            { part = "sensor", minimum = 15 },
        },
    },
    priority = 2,
    half_life = "5 minutes",
    phase = "solid",
    display_field = true,
}

ccb.content.define_field_type {
    id = "fd_weedsmoke",
    legacy_enum_id = 34,
    levels = {
        { name = ccb.content.text("swirl of pot smoke"), translucency = 5 },
        { name = ccb.content.text("pot smoke"), color = "light_gray" },
        { name = ccb.content.text("thick pot smoke"), color = "dark_gray" },
    },
    complaint = { chance = 20, issue = "weed_smoke", duration = "10 minutes", speech = "<weed_smoke>" },
    decay_amount_factor = 5,
    percent_spread = 200,
    outdoor_age_speedup = "6 minutes",
    dirty_transparency_cache = true,
    priority = 8,
    half_life = "325 turns",
    phase = "gas",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_cigsmoke",
}

ccb.content.define_field_type {
    id = "fd_cracksmoke",
    legacy_enum_id = 35,
    levels = {
        { name = ccb.content.text("swirl of crack smoke"), translucency = 5 },
        { name = ccb.content.text("crack smoke"), color = "light_gray" },
        { name = ccb.content.text("thick crack smoke"), color = "dark_gray" },
    },
    complaint = { chance = 20, issue = "crack_smoke", duration = "30 minutes", speech = "<crack_smoke>" },
    decay_amount_factor = 5,
    percent_spread = 175,
    outdoor_age_speedup = "8 minutes",
    dirty_transparency_cache = true,
    priority = 8,
    half_life = "225 turns",
    phase = "gas",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_cigsmoke",
}

ccb.content.define_field_type {
    id = "fd_methsmoke",
    legacy_enum_id = 36,
    levels = {
        { name = ccb.content.text("swirl of meth smoke"), translucency = 5 },
        { name = ccb.content.text("meth smoke"), color = "light_gray" },
        { name = ccb.content.text("thick meth smoke"), color = "dark_gray" },
    },
    complaint = { chance = 20, issue = "meth_smoke", duration = "30 minutes", speech = "<meth_smoke>" },
    decay_amount_factor = 5,
    percent_spread = 175,
    outdoor_age_speedup = "7 minutes",
    dirty_transparency_cache = true,
    priority = 8,
    half_life = "275 turns",
    phase = "gas",
    accelerated_decay = true,
    display_field = true,
    looks_like = "fd_smoke",
}

ccb.content.define_field_type {
    id = "fd_tindalos_gas",
    levels = {
        { name = ccb.content.text("swirl of fog"), translucency = 5, light_emitted = 20 },
        { name = ccb.content.text("foul fog"), color = "cyan" },
        { name = ccb.content.text("thick foul fog"), color = "pink" },
    },
    decay_amount_factor = 5,
    percent_spread = 150,
    outdoor_age_speedup = "6 minutes",
    dirty_transparency_cache = true,
    priority = 8,
    half_life = "35 minutes",
    phase = "gas",
    display_field = true,
    looks_like = "fd_smoke",
}

ccb.content.define_field_type {
    id = "fd_incendiary",
    legacy_enum_id = 38,
    levels = {
        {
            name = ccb.content.text("smoke"),
            symbol = "8",
            color = "light_red",
            dangerous = true,
            light_emitted = 20,
            translucency = 1,
        },
        {
            name = ccb.content.text("airborne incendiary"),
            color = "light_red",
            light_emitted = 60,
            translucency = 10,
        },
        {
            name = ccb.content.text("airborne incendiary"),
            color = "light_red_red",
            transparent = false,
            light_emitted = 160,
            translucency = 0,
        },
    },
    percent_spread = 66,
    outdoor_age_speedup = "4 minutes",
    dirty_transparency_cache = true,
    has_fire = true,
    priority = 8,
    half_life = "50 minutes",
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_laser",
}

ccb.content.define_field_type {
    id = "fd_relax_gas",
    legacy_enum_id = 39,
    levels = {
        {
            name = ccb.content.text("hazy cloud"),
            symbol = ".",
            dangerous = true,
            translucency = 5,
            concentration = 1,
            effects = {
                {
                    effect = "relax_gas",
                    body_part = "mouth",
                    intensity = 2,
                    min_duration = "3 seconds",
                    max_duration = "3 seconds",
                    chance_outside_vehicle = 3,
                    immune_inside_vehicle = true,
                },
            },
        },
        {
            name = ccb.content.text("sedative gas"),
            color = "pink",
            concentration = 2,
            effects = {
                {
                    effect = "relax_gas",
                    body_part = "mouth",
                    intensity = 4,
                    min_duration = "3 seconds",
                    max_duration = "3 seconds",
                    chance_inside_vehicle = 3,
                },
            },
        },
        {
            name = ccb.content.text("relaxation gas"),
            color = "cyan",
            concentration = 4,
            effects = {
                {
                    effect = "relax_gas",
                    body_part = "mouth",
                    intensity = 6,
                    min_duration = "3 seconds",
                    max_duration = "3 seconds",
                    chance_inside_vehicle = 3,
                },
            },
        },
    },
    decay_amount_factor = 5,
    gas_absorption_factor = "80m",
    percent_spread = 15,
    outdoor_age_speedup = "5 minutes",
    dirty_transparency_cache = true,
    has_fume = true,
    immunity = { resistances = { { part = "mouth", minimum = 15 } }, flags = { "INHALED_TOXIN_IMMUNE" } },
    priority = 8,
    half_life = "50 minutes",
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_tear_gas",
}

-- repeat last entry
-- repeat last entry
ccb.content.define_field_type {
    id = "fd_swamp_gas",
    levels = {
        {
            name = ccb.content.text("swamp gas"),
            symbol = ".",
            dangerous = true,
            translucency = 5,
            concentration = 1,
        },
        {},
        {},
    },
    decay_amount_factor = 5,
    gas_absorption_factor = "80m",
    percent_spread = 25,
    outdoor_age_speedup = "1 minutes",
    dirty_transparency_cache = true,
    has_fume = true,
    immunity = { resistances = { { part = "mouth", minimum = 15 } }, flags = { "INHALED_TOXIN_IMMUNE" } },
    priority = 8,
    half_life = "15 minutes",
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_nuke_gas",
}

ccb.content.define_field_type {
    id = "fd_fog",
    levels = {
        {
            name = ccb.content.text("mist"),
            symbol = "~",
            dangerous = false,
            transparent = false,
            translucency = 5,
            concentration = 1,
        },
        { name = ccb.content.text("fog"), translucency = 3 },
        { name = ccb.content.text("dense fog"), translucency = 1 },
    },
    decay_amount_factor = 15,
    gas_absorption_factor = "80m",
    percent_spread = 30,
    outdoor_age_speedup = "1 minutes",
    dirty_transparency_cache = true,
    has_fume = true,
    priority = 8,
    half_life = "7 minutes",
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_smoke",
}

ccb.content.define_field_type {
    id = "fd_fungal_haze",
    legacy_enum_id = 40,
    levels = {
        { name = ccb.content.text("hazy cloud"), symbol = ".", dangerous = true, concentration = 1 },
        { name = ccb.content.text("fungal haze"), color = "cyan", concentration = 2 },
        { name = ccb.content.text("thick fungal haze"), transparent = false, concentration = 4 },
    },
    decay_amount_factor = 5,
    gas_absorption_factor = "80m",
    percent_spread = 13,
    outdoor_age_speedup = "5 turns",
    dirty_transparency_cache = true,
    has_fume = true,
    immunity = {
        flags = { "MYCUS_IMMUNE", "INHALED_TOXIN_IMMUNE" },
        resistances = { { part = "mouth", minimum = 15 }, { part = "sensor", minimum = 15 } },
    },
    priority = 8,
    half_life = "4 minutes",
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_smoke",
}

ccb.content.define_field_type {
    id = "fd_hallucinogenic_spores",
    levels = {
        {
            name = ccb.content.text("hallucinogenic cloud"),
            symbol = "8",
            dangerous = true,
            translucency = 1,
            concentration = 1,
            effects = {
                {
                    effect = "hallucinogenic_acid_light",
                    body_part = "mouth",
                    intensity = 2,
                    min_duration = "2 minutes",
                    max_duration = "2 minutes",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("You feel the ground spinning from inhaling the hallucinogenic cloud."),
                    message_type = "bad",
                },
            },
        },
        {
            name = ccb.content.text("hallucinogenic gas"),
            color = "light_green",
            transparent = false,
            translucency = 8,
            concentration = 1,
            effects = {
                {
                    effect = "hallucinogenic_acid_light",
                    body_part = "mouth",
                    intensity = 5,
                    min_duration = "4 minutes",
                    max_duration = "5 minutes",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("You feel the ground spinning from inhaling the thick hallucinogenic gas."),
                    message_type = "bad",
                },
            },
        },
        {
            name = ccb.content.text("hallucinogenic acid gas"),
            color = "green",
            translucency = 0,
            concentration = 4,
            effects = {
                {
                    effect = "hallucinogenic_acid_heavy",
                    body_part = "mouth",
                    intensity = 5,
                    min_duration = "5 minutes",
                    max_duration = "6 minutes",
                    immune_inside_vehicle = true,
                    message = ccb.content.text("You feel the ground swirling and fracturing from inhaling the thick hallucinogenic gas."),
                    message_type = "bad",
                },
            },
        },
    },
    decay_amount_factor = 3,
    gas_absorption_factor = "80m",
    percent_spread = 30,
    outdoor_age_speedup = "4 minutes",
    dirty_transparency_cache = true,
    has_fume = true,
    immunity = {
        flags = { "MYCUS_IMMUNE", "INHALED_TOXIN_IMMUNE" },
        resistances = { { part = "mouth", minimum = 15 }, { part = "sensor", minimum = 15 } },
    },
    priority = 8,
    half_life = "15 minutes",
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_nuke_gas",
}

ccb.content.define_field_type {
    id = "fd_cold_air1",
    legacy_enum_id = 41,
    levels = {
        { name = ccb.content.text("cold air 1"), symbol = "&", convection_temperature_mod = -2 },
        { color = "blue", convection_temperature_mod = -4 },
        { color = "cyan", convection_temperature_mod = -6 },
    },
    decay_amount_factor = 5,
    percent_spread = 10,
    outdoor_age_speedup = "100 minutes",
    priority = -1,
    half_life = "50 minutes",
    phase = "gas",
}

ccb.content.define_field_type {
    id = "fd_cold_air2",
    legacy_enum_id = 42,
    levels = {
        { name = ccb.content.text("cold air 2"), symbol = "&", convection_temperature_mod = -6 },
        { color = "blue", convection_temperature_mod = -16 },
        { color = "cyan", convection_temperature_mod = -20 },
    },
    decay_amount_factor = 5,
    percent_spread = 10,
    outdoor_age_speedup = "100 minutes",
    priority = -1,
    half_life = "50 minutes",
    phase = "gas",
}

ccb.content.define_field_type {
    id = "fd_cold_air3",
    legacy_enum_id = 43,
    levels = {
        { name = ccb.content.text("cold air 3"), symbol = "&", convection_temperature_mod = -16 },
        { color = "blue", convection_temperature_mod = -40 },
        { color = "cyan", convection_temperature_mod = -70 },
    },
    decay_amount_factor = 5,
    percent_spread = 10,
    outdoor_age_speedup = "100 minutes",
    priority = -1,
    half_life = "50 minutes",
    phase = "gas",
}

ccb.content.define_field_type {
    id = "fd_cold_air4",
    legacy_enum_id = 44,
    levels = {
        { name = ccb.content.text("cold air 4"), symbol = "&", convection_temperature_mod = -70 },
        { color = "blue", convection_temperature_mod = -100 },
        { color = "cyan", convection_temperature_mod = -160 },
    },
    decay_amount_factor = 5,
    percent_spread = 10,
    outdoor_age_speedup = "100 minutes",
    priority = -1,
    half_life = "50 minutes",
    phase = "gas",
}

ccb.content.define_field_type {
    id = "fd_hot_air1",
    legacy_enum_id = 45,
    levels = {
        { name = ccb.content.text("hot air 1"), symbol = "&", convection_temperature_mod = 2 },
        { color = "yellow", convection_temperature_mod = 6 },
        { color = "red", convection_temperature_mod = 10 },
    },
    decay_amount_factor = 5,
    percent_spread = 10,
    outdoor_age_speedup = "100 minutes",
    priority = -1,
    half_life = "50 minutes",
    phase = "gas",
}

ccb.content.define_field_type {
    id = "fd_hot_air2",
    legacy_enum_id = 46,
    levels = {
        { name = ccb.content.text("hot air 2"), symbol = "&", convection_temperature_mod = 6 },
        { color = "yellow", convection_temperature_mod = 16 },
        { color = "red", convection_temperature_mod = 20 },
    },
    decay_amount_factor = 5,
    percent_spread = 10,
    outdoor_age_speedup = "100 minutes",
    priority = -1,
    half_life = "50 minutes",
    phase = "gas",
}

ccb.content.define_field_type {
    id = "fd_hot_air3",
    legacy_enum_id = 47,
    levels = {
        { name = ccb.content.text("hot air 3"), symbol = "&", convection_temperature_mod = 16 },
        { color = "yellow", convection_temperature_mod = 40 },
        { color = "red", convection_temperature_mod = 70 },
    },
    decay_amount_factor = 5,
    percent_spread = 10,
    outdoor_age_speedup = "100 minutes",
    priority = -1,
    half_life = "50 minutes",
    phase = "gas",
}

ccb.content.define_field_type {
    id = "fd_hot_air4",
    legacy_enum_id = 48,
    levels = {
        { name = ccb.content.text("hot air 4"), symbol = "&", convection_temperature_mod = 70 },
        { color = "yellow", convection_temperature_mod = 100 },
        { color = "red", convection_temperature_mod = 160 },
    },
    decay_amount_factor = 5,
    percent_spread = 10,
    outdoor_age_speedup = "100 minutes",
    priority = -1,
    half_life = "50 minutes",
    phase = "gas",
}

ccb.content.define_field_type {
    id = "fd_migo_atmosphere",
    levels = {
        {
            name = ccb.content.text("foul-smelling air"),
            symbol = "8",
            dangerous = true,
            concentration = 1,
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
            concentration = 2,
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
            concentration = 4,
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
    gas_absorption_factor = "80m",
    percent_spread = 30,
    outdoor_age_speedup = "3 minutes",
    dirty_transparency_cache = true,
    has_fume = true,
    immunity = { resistances = { { part = "mouth", minimum = 15 } }, flags = { "INHALED_TOXIN_IMMUNE" } },
    priority = 8,
    half_life = "10 minutes",
    phase = "gas",
}

ccb.content.define_field_type {
    id = "fd_fungicidal_gas",
    legacy_enum_id = 49,
    levels = {
        { name = ccb.content.text("fungicidal mist"), symbol = "8", dangerous = true, concentration = 1 },
        { name = ccb.content.text("fungicidal haze"), color = "light_gray", concentration = 2 },
        {
            name = ccb.content.text("thick fungicidal haze"),
            color = "dark_gray",
            transparent = false,
            concentration = 4,
        },
    },
    decay_amount_factor = 5,
    gas_absorption_factor = "80m",
    percent_spread = 100,
    outdoor_age_speedup = "1 minutes",
    dirty_transparency_cache = true,
    has_fume = true,
    immunity = { resistances = { { part = "mouth", minimum = 15 } }, flags = { "INHALED_TOXIN_IMMUNE" } },
    priority = 8,
    half_life = "30 minutes",
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_tear_gas",
}

ccb.content.define_field_type {
    id = "fd_insecticidal_gas",
    levels = {
        { name = ccb.content.text("insecticidal mist"), symbol = "8", dangerous = true, concentration = 1 },
        { name = ccb.content.text("insecticidal haze"), color = "light_gray", concentration = 2 },
        {
            name = ccb.content.text("thick insecticidal haze"),
            color = "dark_gray",
            transparent = false,
            concentration = 4,
        },
    },
    decay_amount_factor = 5,
    gas_absorption_factor = "80m",
    percent_spread = 100,
    outdoor_age_speedup = "1 minutes",
    dirty_transparency_cache = true,
    has_fume = true,
    immunity = { resistances = { { part = "mouth", minimum = 15 } }, flags = { "INHALED_TOXIN_IMMUNE" } },
    priority = 8,
    half_life = "30 minutes",
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_tear_gas",
}

-- repeat last entry
-- repeat last entry
ccb.content.define_field_type {
    id = "fd_smoke_vent",
    legacy_enum_id = 50,
    levels = { { name = ccb.content.text("smoke vent"), dangerous = true, concentration = 4 }, {}, {} },
    description_affix = "under",
    wandering_field = "fd_smoke",
    gas_absorption_factor = "80m",
    dirty_transparency_cache = true,
    has_fume = true,
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_smoke",
}

ccb.content.define_field_type {
    id = "fd_clairvoyant",
    levels = {
        { name = ccb.content.text("clairvoyance"), symbol = "8", dangerous = false, concentration = 1 },
    },
    decay_amount_factor = 5,
    gas_absorption_factor = "100m",
    dirty_transparency_cache = true,
    outdoor_age_speedup = "0 turns",
    priority = 8,
    half_life = "1 seconds",
    phase = "solid",
    display_field = false,
}

ccb.content.define_field_type {
    id = "fd_bee_swarm",
    levels = {
        { name = ccb.content.text("a few bees"), symbol = ".", dangerous = true, translucency = 1 },
        { name = ccb.content.text("a swarm of bees"), color = "yellow", transparent = true, translucency = 1 },
        { name = ccb.content.text("a cloud of bees"), color = "green", translucency = 0 },
    },
    decay_amount_factor = 5,
    gas_absorption_factor = "80m",
    percent_spread = 25,
    outdoor_age_speedup = "10 minutes",
    dirty_transparency_cache = true,
    has_fume = true,
    immunity = { resistances = { { part = "torso", minimum = 5 } } },
    priority = 3,
    half_life = "10 minute",
    phase = "gas",
    display_items = true,
    display_field = true,
}

-- Spores cause players to light up
-- repeat last entry
-- repeat last entry
ccb.content.define_field_type {
    id = "fd_nm_monster_gas_1",
    levels = {
        {
            name = ccb.content.text("glowing gas spores"),
            symbol = ".",
            dangerous = true,
            light_emitted = 10,
            translucency = 5,
            concentration = 1,
            effects = {
                {
                    effect = "glowing_gas_cover",
                    body_part = "torso",
                    intensity = 4,
                    min_duration = "1 minutes",
                    max_duration = "2 minutes",
                },
            },
        },
        {},
        {},
    },
    decay_amount_factor = 5,
    gas_absorption_factor = "80m",
    percent_spread = 25,
    outdoor_age_speedup = "1 minutes",
    dirty_transparency_cache = true,
    has_fume = true,
    priority = 8,
    half_life = "15 minutes",
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_tear_gas",
}

-- Spores, when inhaled, act like smoke
-- repeat last entry
-- repeat last entry
ccb.content.define_field_type {
    id = "fd_nm_monster_gas_2",
    levels = {
        {
            name = ccb.content.text("glowing gas"),
            symbol = ".",
            dangerous = true,
            light_emitted = 10,
            translucency = 5,
            concentration = 1,
            effects = {
                {
                    effect = "glowing_gas",
                    body_part = "mouth",
                    intensity = 4,
                    min_duration = "15 seconds",
                    max_duration = "25 seconds",
                },
            },
        },
        {},
        {},
    },
    decay_amount_factor = 5,
    gas_absorption_factor = "80m",
    percent_spread = 25,
    outdoor_age_speedup = "1 minutes",
    dirty_transparency_cache = true,
    immunity = { resistances = { { part = "mouth", minimum = 15 } }, flags = { "INHALED_TOXIN_IMMUNE" } },
    has_fume = true,
    priority = 8,
    half_life = "15 minutes",
    phase = "gas",
    display_items = false,
    display_field = true,
    looks_like = "fd_tear_gas",
}

ccb.content.define_field_type {
    id = "fd_congealed_light",
    mopsafe = false,
    levels = {
        {
            name = ccb.content.text("smear of congealed light"),
            symbol = "5",
            color = "magenta",
            dangerous = true,
            effects = {
                {
                    effect = "LIXA_illuminated",
                    min_duration = "2 seconds",
                    max_duration = "2 seconds",
                    intensity = 1,
                    immune_in_vehicle = true,
                    environmental = false,
                },
            },
            light_emitted = 5,
        },
        {
            name = ccb.content.text("streak of congealed light"),
            color = "pink",
            effects = {
                {
                    effect = "LIXA_illuminated",
                    min_duration = "4 seconds",
                    max_duration = "4 seconds",
                    intensity = 2,
                    immune_in_vehicle = true,
                    environmental = false,
                },
            },
            light_emitted = 15,
        },
        {
            name = ccb.content.text("pool of congealed light"),
            color = "white",
            effects = {
                {
                    effect = "LIXA_illuminated",
                    min_duration = "6 seconds",
                    max_duration = "6 seconds",
                    intensity = 3,
                    immune_in_vehicle = true,
                    environmental = false,
                },
            },
            light_emitted = 30,
        },
    },
    description_affix = "covered_in",
    splattering = true,
    priority = 2,
    half_life = "10 seconds",
    phase = "liquid",
    display_field = true,
    looks_like = "fd_bile",
}

ccb.content.define_field_type {
    id = "fd_LIXA_decompression",
    legacy_enum_id = 19,
    levels = {
        {
            name = ccb.content.text("decompressed space"),
            effects = {
                {
                    effect = "LIXA_decompressed",
                    min_duration = "2 seconds",
                    max_duration = "2 seconds",
                    intensity = 1,
                    immune_in_vehicle = true,
                    environmental = false,
                },
            },
            light_emitted = 5,
        },
        {
            name = ccb.content.text("decompressed space"),
            effects = {
                {
                    effect = "LIXA_decompressed",
                    min_duration = "4 seconds",
                    max_duration = "4 seconds",
                    intensity = 2,
                    immune_in_vehicle = true,
                    environmental = false,
                },
            },
            light_emitted = 15,
        },
        {
            name = ccb.content.text("decompressed space"),
            effects = {
                {
                    effect = "LIXA_decompressed",
                    min_duration = "6 seconds",
                    max_duration = "6 seconds",
                    intensity = 3,
                    immune_in_vehicle = true,
                    environmental = false,
                },
            },
            light_emitted = 30,
        },
    },
    priority = 2,
    half_life = "5 seconds",
    phase = "plasma",
    display_field = true,
    looks_like = "fd_fog",
}

ccb.content.define_field_type {
    id = "fd_meadow_portal",
    levels = {
        {
            name = ccb.content.text("swirling portal"),
            color = "magenta",
            symbol = "*",
            dangerous = true,
            monster_spawn_chance = 6000,
            monster_spawn_count = 1,
            monster_spawn_radius = 1,
            monster_spawn_group = "GROUP_ALIEN_MEADOW",
        },
    },
    description_affix = "under",
    priority = 8,
    display_items = true,
    display_field = true,
    looks_like = "fd_fatigue",
}

-- repeat last entry
-- repeat last entry
ccb.content.define_field_type {
    id = "fd_nauseating_smell",
    levels = {
        {
            name = ccb.content.text("nauseating stench"),
            effects = {
                {
                    effect = "nauseating_smell",
                    min_duration = "15 seconds",
                    max_duration = "45 seconds",
                    intensity = 1,
                    immune_in_vehicle = false,
                    environmental = true,
                },
            },
        },
        {},
        {},
    },
    decay_amount_factor = 5,
    gas_absorption_factor = "80m",
    percent_spread = 25,
    dirty_transparency_cache = true,
    has_fume = true,
    immunity = { resistances = { { part = "mouth", minimum = 7 } }, flags = { "INHALED_TOXIN_IMMUNE" } },
    priority = 8,
    half_life = "30 seconds",
    phase = "gas",
}

ccb.content.define_field_type {
    id = "fd_scarlet_atmosphere",
    levels = {
        {
            name = ccb.content.text("scarlet atmosphere"),
            effects = {
                {
                    effect = "effect_scarlet_atmopshere",
                    intensity = 1,
                    min_duration = "1s",
                    max_duration = "1s",
                    environmental = false,
                },
            },
        },
    },
    decrease_intensity_on_contact = false,
    indestructible = true,
    priority = -1,
    display_field = false,
    phase = "gas",
    gas_absorption_factor = "80m",
    immunity = { resistances = { { part = "mouth", minimum = 15 } } },
}

ccb.content.define_field_type {
    id = "fd_scarlet_sea_wave",
    levels = {
        {
            name = ccb.content.text("breaking ripple"),
            color = "light_red",
            symbol = "~",
            dangerous = false,
            transparent = true,
            concentration = 1,
        },
        {
            name = ccb.content.text("breaking wave"),
            color = "light_red",
            dangerous = false,
            transparent = true,
            concentration = 2,
            scent_neutralization = 1,
        },
        {
            name = ccb.content.text("breaking redcap"),
            color = "light_red",
            dangerous = false,
            transparent = true,
            concentration = 3,
            scent_neutralization = 5,
        },
    },
    decay_amount_factor = 5,
    percent_spread = 1,
    dirty_transparency_cache = true,
    outdoor_age_speedup = "0 turns",
    priority = 8,
    half_life = "1 minutes",
    phase = "gas",
    accelerated_decay = true,
    display_items = false,
    display_field = true,
}

ccb.content.define_field_type {
    id = "fd_scarlet_sea_gas",
    levels = {
        {
            name = ccb.content.text("scarlet haze"),
            color = "light_red",
            light_emitted = 160,
            light_color = { 110, 0, 0 },
            effects = {
                {
                    effect = "effect_scarlet_atmopshere",
                    intensity = 1,
                    min_duration = "1s",
                    max_duration = "1s",
                    environmental = false,
                    message = ccb.content.text("The air here irritates your lungs!"),
                    message_type = "bad",
                },
            },
        },
        {
            name = ccb.content.text("scarlet smoke"),
            color = "light_red",
            light_emitted = 160,
            light_color = { 110, 0, 0 },
            effects = {
                {
                    effect = "effect_scarlet_atmopshere",
                    intensity = 2,
                    min_duration = "1s",
                    max_duration = "1s",
                    environmental = false,
                    message = ccb.content.text("The air here irritates your lungs!"),
                    message_type = "bad",
                },
            },
        },
        {
            name = ccb.content.text("scarlet smog"),
            color = "light_red",
            light_emitted = 160,
            light_color = { 110, 0, 0 },
            effects = {
                {
                    effect = "effect_scarlet_atmopshere",
                    intensity = 3,
                    min_duration = "1s",
                    max_duration = "1s",
                    environmental = false,
                    message = ccb.content.text("The air here irritates your lungs!"),
                    message_type = "bad",
                },
            },
        },
    },
    decay_amount_factor = 5,
    percent_spread = 20,
    dirty_transparency_cache = true,
    outdoor_age_speedup = "0 turns",
    priority = 8,
    half_life = "1 minutes",
    phase = "gas",
    accelerated_decay = true,
    display_items = false,
    display_field = false,
    gas_absorption_factor = "80m",
    immunity = { resistances = { { part = "mouth", minimum = 15 } } },
}

ccb.content.define_field_type {
    id = "fd_portal_cracked_mirror",
    looks_like = "fd_fatigue",
    levels = {
        {
            name = ccb.content.text("cracked mirror"),
            color = "magenta",
            transparent = false,
            monster_spawn_chance = 60,
            monster_spawn_count = 1,
            monster_spawn_radius = 1,
            monster_spawn_group = "GROUP_PORTAL_REFLECTIONS",
        },
    },
    description_affix = "under",
    priority = 8,
    display_items = true,
    display_field = true,
}
