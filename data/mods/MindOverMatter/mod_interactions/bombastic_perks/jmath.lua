local ccb = require("ccb")
local content = ccb.content

-- Native jmath functions
do
local definition = content.MathFunction {
    id = "psionic_power_success_formula_perks",
    arguments = 0,
    expression = "u_has_trait('perk_clear_minded_channeling') ? min( ( u_vitamin('vitamin_maintained_powers') <= 0 ? 6 : 0 ) + ( u_pain() <= 0 ? 6 : 0 ), 6) : 0",
}
content.replace(definition)
end
