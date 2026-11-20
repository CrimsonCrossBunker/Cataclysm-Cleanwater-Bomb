local ccb = require("ccb")
local content = ccb.content

-- Native field-type definitions
do
local definition = content.FieldType {
    id = "fd_pyrokinetic_summon_heat_1",
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
    convection_temperature_modifier = 2,
}
definition:intensity {
    name = ccb.content.text("heated air"),
    symbol = "&",
    color = "yellow",
    convection_temperature_modifier = 3,
}
definition:intensity {
    name = ccb.content.text("heated air"),
    symbol = "&",
    color = "red",
    convection_temperature_modifier = 6,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_pyrokinetic_summon_heat_2",
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
    convection_temperature_modifier = 4,
}
definition:intensity {
    name = ccb.content.text("heated air"),
    symbol = "&",
    color = "yellow",
    convection_temperature_modifier = 8,
}
definition:intensity {
    name = ccb.content.text("heated air"),
    symbol = "&",
    color = "red",
    convection_temperature_modifier = 16,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_pyrokinetic_summon_heat_3",
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
    convection_temperature_modifier = 10,
}
definition:intensity {
    name = ccb.content.text("heated air"),
    symbol = "&",
    color = "yellow",
    convection_temperature_modifier = 20,
}
definition:intensity {
    name = ccb.content.text("heated air"),
    symbol = "&",
    color = "red",
    convection_temperature_modifier = 40,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_pyrokinetic_summon_heat_4",
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
    convection_temperature_modifier = 16,
}
definition:intensity {
    name = ccb.content.text("heated air"),
    symbol = "&",
    color = "yellow",
    convection_temperature_modifier = 38,
}
definition:intensity {
    name = ccb.content.text("heated air"),
    symbol = "&",
    color = "red",
    convection_temperature_modifier = 75,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_pyrokinetic_heat",
    outdoor_age_speedup_turns = 2400,
    decay_amount_factor = 5,
    percent_spread = 10,
    priority = -1,
    half_life_turns = 1200,
    phase = "gas",
}
definition:intensity {
    name = ccb.content.text("overheated air"),
    symbol = "&",
    convection_temperature_modifier = 12,
}
definition:intensity {
    name = ccb.content.text("overheated air"),
    symbol = "&",
    color = "yellow",
    convection_temperature_modifier = 22,
}
definition:intensity {
    name = ccb.content.text("overheated air"),
    symbol = "&",
    color = "red",
    convection_temperature_modifier = 45,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_pyrokinetic_warmth",
    outdoor_age_speedup_turns = 120,
    decay_amount_factor = 5,
    percent_spread = 10,
    priority = -1,
    half_life_turns = 60,
    phase = "gas",
}
definition:intensity {
    name = ccb.content.text("heated air"),
    symbol = "&",
    convection_temperature_modifier = 7,
}
definition:intensity {
    name = ccb.content.text("heated air"),
    symbol = "&",
    color = "yellow",
    convection_temperature_modifier = 13,
}
definition:intensity {
    name = ccb.content.text("heated air"),
    symbol = "&",
    color = "red",
    convection_temperature_modifier = 26,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_cold_air_nether_deep",
    outdoor_age_speedup_turns = 6000,
    decay_amount_factor = 5,
    percent_spread = 10,
    priority = -1,
    half_life_turns = 3000,
    phase = "gas",
}
definition:intensity {
    name = ccb.content.text("chill air"),
    symbol = "&",
    convection_temperature_modifier = -12,
}
definition:intensity {
    name = ccb.content.text("chill air"),
    symbol = "&",
    color = "blue",
    convection_temperature_modifier = -28,
}
definition:intensity {
    name = ccb.content.text("chill air"),
    symbol = "&",
    color = "cyan",
    convection_temperature_modifier = -40,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_cold_air_nether_chill",
    decay_amount_factor = 5,
    percent_spread = 10,
    priority = -1,
    half_life_turns = 3000,
    phase = "gas",
}
definition:intensity {
    name = ccb.content.text("chill air"),
    symbol = "&",
    convection_temperature_modifier = -12,
}
definition:intensity {
    name = ccb.content.text("chill air"),
    symbol = "&",
    color = "blue",
    convection_temperature_modifier = -28,
}
definition:intensity {
    name = ccb.content.text("chill air"),
    symbol = "&",
    color = "cyan",
    convection_temperature_modifier = -40,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_darkness",
    percent_spread = 50,
    half_life_turns = 300,
}
definition:intensity {
    name = ccb.content.text("darkness"),
    local_light_override = 0.0,
}
content.replace(definition)
end
do
local definition = content.FieldType {
    id = "fd_photokin_light_1",
    priority = 4,
    half_life_turns = 300,
    phase = "plasma",
    description_affix = "illuminated_by",
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("glimmer"),
    symbol = "*",
    color = "yellow",
    light_emitted = 30.0,
}
definition:intensity {
    name = ccb.content.text("glow"),
    symbol = "*",
    color = "yellow",
    light_emitted = 60.0,
}
definition:intensity {
    name = ccb.content.text("shine"),
    symbol = "*",
    color = "yellow",
    light_emitted = 90.0,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_photokin_light_2",
    priority = 4,
    half_life_turns = 900,
    phase = "plasma",
    description_affix = "illuminated_by",
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("glimmer"),
    symbol = "*",
    color = "yellow",
    light_emitted = 50.0,
}
definition:intensity {
    name = ccb.content.text("glow"),
    symbol = "*",
    color = "yellow",
    light_emitted = 100.0,
}
definition:intensity {
    name = ccb.content.text("shine"),
    symbol = "*",
    color = "yellow",
    light_emitted = 150.0,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_photokin_light_3",
    priority = 4,
    half_life_turns = 1800,
    phase = "plasma",
    description_affix = "illuminated_by",
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("glimmer"),
    symbol = "*",
    color = "yellow",
    light_emitted = 80.0,
}
definition:intensity {
    name = ccb.content.text("glow"),
    symbol = "*",
    color = "yellow",
    light_emitted = 160.0,
}
definition:intensity {
    name = ccb.content.text("shine"),
    symbol = "*",
    color = "yellow",
    light_emitted = 240.0,
}
content.add(definition)
end
