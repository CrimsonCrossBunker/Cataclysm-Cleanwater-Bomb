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
