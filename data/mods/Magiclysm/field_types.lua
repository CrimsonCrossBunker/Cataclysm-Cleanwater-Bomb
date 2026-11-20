local ccb = require("ccb")
local content = ccb.content

-- Native field-type definitions
do
local definition = content.FieldType {
    id = "fd_kelvinist_warmth",
    outdoor_age_speedup_turns = 900,
    decay_amount_factor = 5,
    percent_spread = 50,
    priority = 7,
    half_life_turns = 1800,
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
    convection_temperature_modifier = 15,
}
definition:intensity {
    name = ccb.content.text("heated air"),
    symbol = "&",
    color = "red",
    convection_temperature_modifier = 30,
}
content.add(definition)
end
do
local definition = content.FieldType {
    id = "fd_kelvinist_cold",
    outdoor_age_speedup_turns = 900,
    decay_amount_factor = 5,
    percent_spread = 50,
    priority = 7,
    half_life_turns = 1800,
    phase = "gas",
}
definition:intensity {
    name = ccb.content.text("chill air"),
    symbol = "&",
    convection_temperature_modifier = -7,
}
definition:intensity {
    name = ccb.content.text("chill air"),
    symbol = "&",
    color = "blue",
    convection_temperature_modifier = -15,
}
definition:intensity {
    name = ccb.content.text("chill air"),
    symbol = "&",
    color = "cyan",
    convection_temperature_modifier = -30,
}
content.add(definition)
end
