local ccb = require("ccb")
local content = ccb.content

-- Native jmath functions
do
local definition = content.MathFunction {
    id = "iso_eldritch_sorcery_formula_get_level",
    arguments = 1,
    expression = "_0 / 1",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "iso_eldritch_sorcery_formula_exp_for_level",
    arguments = 1,
    expression = "1 * _0",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "iso_eldritch_sorcery_formula_exp_per_cast",
    arguments = 1,
    expression = "0 * _0",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "iso_eldritch_sorcery_failure_chance",
    arguments = 0,
    expression = "u_pain() / 200",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "iso_balthazar_aid",
    arguments = 1,
    expression = "min(40, iso_balthazar_aid_value + _0)",
}
content.add(definition)
end
