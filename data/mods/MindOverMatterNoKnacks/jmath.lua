local ccb = require("ccb")
local content = ccb.content

-- Native jmath functions
do
local definition = content.MathFunction {
    id = "scaling_factor",
    arguments = 1,
    expression = "min( ( ( _0 + 10) / 20 ), 1.25)",
}
content.replace(definition)
end
do
local definition = content.MathFunction {
    id = "int_to_level",
    arguments = 1,
    expression = "min( ( (u_val('intelligence') * 1.5) * (_0) ), 20)",
}
content.add(definition)
end
