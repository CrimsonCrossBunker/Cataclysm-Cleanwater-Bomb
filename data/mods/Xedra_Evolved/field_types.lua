local ccb = require("ccb")
local content = ccb.content

-- Native field-type definitions
do
local definition = content.FieldType {
    id = "fd_dream_wound_shadow",
    priority = 8,
    description_affix = "under",
    looks_like = "fd_smoke",
    display_items = true,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("oily sheen"),
    symbol = "*",
    color = "light_gray",
    dangerous = true,
    upgrade_chance = 10,
    upgrade_duration_turns = 21600,
}
definition:intensity {
    name = ccb.content.text("deep shadows"),
    symbol = "*",
    color = "dark_gray",
    dangerous = true,
    upgrade_chance = 10,
    upgrade_duration_turns = 21600,
}
definition:intensity {
    name = ccb.content.text("roiling shadows"),
    symbol = "*",
    color = "black_green",
    dangerous = true,
    transparent = false,
    upgrade_chance = 10,
    upgrade_duration_turns = 21600,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_blood_karma",
    underwater_age_speedup_turns = 1500,
    decay_amount_factor = 2,
    half_life_turns = 172800,
    phase = "liquid",
    description_affix = "covered_in",
    splattering = true,
    accelerated_decay = true,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("karma splatter"),
    color = "cyan",
}
definition:intensity {
    name = ccb.content.text("karma stain"),
    color = "cyan",
}
definition:intensity {
    name = ccb.content.text("puddle of karma"),
    color = "cyan",
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_salamander_heat",
    outdoor_age_speedup_turns = 2400,
    decay_amount_factor = 5,
    percent_spread = 10,
    priority = -1,
    half_life_turns = 1200,
    phase = "gas",
}
definition:intensity {
    name = ccb.content.text("heated air"),
    symbol = "&",
    convection_temperature_modifier = 12,
}
definition:intensity {
    name = ccb.content.text("heated air"),
    symbol = "&",
    color = "yellow",
    convection_temperature_modifier = 22,
}
definition:intensity {
    name = ccb.content.text("heated air"),
    symbol = "&",
    color = "red",
    convection_temperature_modifier = 45,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_sylph_solid_fog",
    percent_spread = 0,
    half_life_turns = 999999999999,
    phase = "gas",
    looks_like = "fd_fog",
    display_items = false,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("solid fog"),
    symbol = "*",
    transparent = false,
    move_cost = -1,
    local_light_override = 0.0,
    translucency = 99.0,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_xedra_dreamer_accelerated_time",
    priority = 50,
    half_life_turns = 2,
    description_affix = "in",
    display_items = true,
}
definition:intensity {
    name = ccb.content.text("accelerated time"),
    symbol = "o",
    color = "light_gray",
}
definition:effect(1, {
    effect = "effect_xedra_dreamer_accelerated_time",
    duration_min_turns = 2,
})
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_shoggoth_dissolution",
    underwater_age_speedup_turns = 1500,
    decay_amount_factor = 2,
    half_life_turns = 86400,
    phase = "liquid",
    description_affix = "covered_in",
    looks_like = "fd_bile",
    splattering = true,
    moppable = true,
    accelerated_decay = true,
    display_field = true,
    mopsafe = true,
}
definition:intensity {
    name = ccb.content.text("spilled protoplasm"),
    color = "yellow",
}
definition:intensity {
    name = ccb.content.text("puddle of protoplasm"),
    color = "yellow",
    light_emitted = 1.0,
}
definition:intensity {
    name = ccb.content.text("deep puddle of protoplasm"),
    color = "yellow",
    light_emitted = 3.0,
}
content.add(definition)
end
