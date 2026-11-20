local ccb = require("ccb")
local content = ccb.content

-- Native jmath functions
do
local definition = content.MathFunction {
    id = "scaling_factor",
    arguments = 1,
    expression = "( ( _0 + 10) / 20 )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "time_since_cata_start",
    arguments = 1,
    expression = "time_since('cataclysm', 'unit':'days') < _0 ? 0 : 1",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "time_since_cata_end",
    arguments = 1,
    expression = "time_since('cataclysm', 'unit':'days') < _0 ? 1 : 0",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "time_since_cata_linear_pos",
    arguments = 1,
    expression = "time_since('cataclysm', 'unit':'days') < _0 ? time_since('cataclysm', 'unit':'days') / _0 : 1",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "time_since_cata_linear_neg",
    arguments = 1,
    expression = "time_since('cataclysm', 'unit':'days') < _0 ? 1 - ( time_since('cataclysm', 'unit':'days') / _0 ) : 0",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "time_since_cata_quadratic_pos",
    arguments = 1,
    expression = "time_since('cataclysm', 'unit':'days') < _0 ? ( time_since('cataclysm', 'unit':'days') / _0 ) ^ 2 : 1",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "time_since_cata_quadratic_neg",
    arguments = 1,
    expression = "time_since('cataclysm', 'unit':'days') < _0 ? 1 - ( ( time_since('cataclysm', 'unit':'days') / _0 ) ^ 2 ) : 0",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "time_since_cata_quadratic_u_pos",
    arguments = 1,
    expression = "time_since('cataclysm', 'unit':'days') < ( _0 * 2 ) ? ( 1 / ( _0 ^ 2 ) ) * ( ( time_since('cataclysm', 'unit':'days') - _0 ) ^ 2 ) : 1",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "time_since_cata_quadratic_u_neg",
    arguments = 1,
    expression = "time_since('cataclysm', 'unit':'days') < ( _0 * 2 ) ? 1 - ( ( 1 / ( _0 ^ 2 ) ) * ( ( time_since('cataclysm', 'unit':'days') - _0 ) ^ 2 ) ) : 0",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "alpha_stat_bonus",
    arguments = 1,
    expression = "_0 < 18 ? 13 - (_0 / 2) : 4",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "temperature_speed_mod",
    arguments = 2,
    expression = "min((fahrenheit(weather('temperature')) - _0 + u_climate_control_str_heat()) * _1, 0)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "temperature_speed_mod_bipolar",
    arguments = 2,
    expression = "(fahrenheit(weather('temperature')) - _0 + u_climate_control_str_heat()) * _1",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "spent_to_ingested_ratio",
    arguments = 0,
    expression = "max( get_calories_daily('type':'spent', 'day':1), 1 ) / max( get_calories_daily('type':'ingested', 'day':1), 1 )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "addiction_rational",
    arguments = 3,
    expression = "(_0 / max(1, (_0 - (_1 * _2)))) - 1",
}
content.add(definition)
end
