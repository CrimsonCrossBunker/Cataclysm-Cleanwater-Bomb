local ccb = require("ccb")
local content = ccb.content

-- Native jmath functions
do
local definition = content.MathFunction {
    id = "immortal_path_qi_max",
    arguments = 0,
    expression = "u_enchant_val('qi_max', 100)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "immortal_path_qi_power",
    arguments = 0,
    expression = "u_enchant_val('qi_power', 100)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "immortal_path_polarization_fire",
    arguments = 0,
    expression = "u_enchant_val('polarization_fire', 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "immortal_path_polarization_metal",
    arguments = 0,
    expression = "u_enchant_val('polarization_metal', 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "immortal_path_polarization_wood",
    arguments = 0,
    expression = "u_enchant_val('polarization_wood', 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "immortal_path_polarization_water",
    arguments = 0,
    expression = "u_enchant_val('polarization_water', 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "immortal_path_polarization_earth",
    arguments = 0,
    expression = "u_enchant_val('polarization_earth', 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "immortal_path_polarization_ice",
    arguments = 0,
    expression = "u_enchant_val('polarization_ice', 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "immortal_path_polarization_wind",
    arguments = 0,
    expression = "u_enchant_val('polarization_wind', 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "immortal_path_polarization_lightning",
    arguments = 0,
    expression = "u_enchant_val('polarization_lightning', 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "immortal_path_realm_exp_for_level",
    arguments = 1,
    expression = "86 * _0 * ( _0 + 1 )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "immortal_path_realm_get_level",
    arguments = 1,
    expression = "floor( ( -86 + sqrt( 7396 + 344 * _0 ) ) / 172 )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "immortal_path_fatigue_mult",
    arguments = 1,
    expression = "max( 0, 1 - _0 / 80 )",
}
content.add(definition)
end
