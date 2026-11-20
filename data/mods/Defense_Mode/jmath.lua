local ccb = require("ccb")
local content = ccb.content

-- Native jmath functions
do
local definition = content.MathFunction {
    id = "wave_spawn_number",
    arguments = 0,
    expression = "max( 1, wave_number * diffulty_modifier )",
}
content.add(definition)
end
