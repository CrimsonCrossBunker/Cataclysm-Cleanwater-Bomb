local ccb = require("ccb")
local content = ccb.content

-- Native field-type definitions
do
local definition = content.FieldType {
    id = "afs_heat_drain_field",
    underwater_age_speedup_turns = 10,
    decay_amount_factor = 2,
    half_life_turns = 15,
    phase = "gas",
    description_affix = "covered_in",
    accelerated_decay = true,
    display_field = false,
}
definition:intensity {
    name = ccb.content.text("cold air"),
    symbol = "&",
    convection_temperature_modifier = -350,
}
definition:intensity {
    name = ccb.content.text("frozen air"),
    symbol = "&",
    color = "blue",
    convection_temperature_modifier = -300,
}
definition:intensity {
    name = ccb.content.text("frozen air"),
    symbol = "&",
    color = "cyan",
    convection_temperature_modifier = -400,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_deco_mist",
    percent_spread = 30,
    priority = 2,
    half_life_turns = 5,
    phase = "gas",
    looks_like = "fd_fog",
    accelerated_decay = true,
    display_items = false,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("mist"),
    symbol = "~",
    transparent = false,
    translucency = 5.0,
}
definition:intensity {
    name = ccb.content.text("mist"),
    symbol = "~",
    transparent = false,
    translucency = 5.0,
}
definition:intensity {
    name = ccb.content.text("mist"),
    symbol = "~",
    transparent = false,
    translucency = 5.0,
}
definition:intensity {
    name = ccb.content.text("mist"),
    symbol = "~",
    transparent = false,
    translucency = 5.0,
}
definition:intensity {
    name = ccb.content.text("mist"),
    symbol = "~",
    transparent = false,
    translucency = 5.0,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_deco_mist_e",
    percent_spread = 30,
    priority = 2,
    half_life_turns = 5,
    phase = "gas",
    wandering_field = "fd_deco_mist",
    looks_like = "fd_fog",
    accelerated_decay = true,
    display_items = false,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("mist"),
    symbol = "~",
    transparent = false,
    translucency = 5.0,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_hot_airAC",
    priority = -1,
    phase = "gas",
    display_field = false,
}
definition:intensity {
    name = ccb.content.text("air conditioner"),
    symbol = "&",
    convection_temperature_modifier = 115,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_hot_airAC_temporary",
    percent_spread = 100,
    priority = -1,
    half_life_turns = 120,
    phase = "gas",
    display_field = false,
}
definition:intensity {
    name = ccb.content.text("air conditioner"),
    symbol = "&",
    convection_temperature_modifier = 115,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_elect_anomaly",
    priority = -1,
    half_life_turns = 20,
    phase = "plasma",
    description_affix = "illuminated_by",
    wandering_field = "fd_electricity",
    looks_like = "fd_electricity",
    has_electricity = true,
    display_items = false,
    display_field = true,
}
definition:intensity {
    name = ccb.content.text("electrical anomaly"),
    symbol = "&",
}
definition:intensity {
    name = ccb.content.text("electrical anomaly"),
    symbol = "&",
}
definition:intensity {
    name = ccb.content.text("electrical anomaly"),
    symbol = "&",
}
definition:intensity {
    name = ccb.content.text("electrical anomaly"),
    symbol = "&",
}
definition:intensity {
    name = ccb.content.text("electrical anomaly"),
    symbol = "&",
}
definition:intensity {
    name = ccb.content.text("electrical anomaly"),
    symbol = "&",
}
definition:intensity {
    name = ccb.content.text("electrical anomaly"),
    symbol = "&",
}
definition:intensity {
    name = ccb.content.text("electrical anomaly"),
    symbol = "&",
}
definition:intensity {
    name = ccb.content.text("electrical anomaly"),
    symbol = "&",
}
definition:intensity {
    name = ccb.content.text("electrical anomaly"),
    symbol = "&",
}
content.add(definition)
end
