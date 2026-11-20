local ccb = require("ccb")
local content = ccb.content

-- Native jmath functions
do
local definition = content.MathFunction {
    id = "speedball_counter",
    arguments = 0,
    expression = "(u_effect_intensity('jetinjector') > 0 ? 3 : 0) + (u_effect_intensity('stimpack') > 0 ? 3 : 0) + (u_effect_intensity('adrenaline') > 0 ? 3 : 0) + (u_effect_intensity('meth') > 0 ? 3 : 0) +  (u_effect_intensity('cig') > 0 ? 3 : 0) + (u_effect_intensity('high') > 0 ? 3 : 0) + (u_effect_intensity('weed_high') > 0 ? 3 : 0) + (u_effect_intensity('drunk') > 0 ? 3 : 0) + (u_effect_intensity('betablock') > 0 ? 3 : 0) + (u_effect_intensity('stim') > 0 ? 3 : 0) + (u_effect_intensity('stim_overdose') > 0 ? 3 : 0) + (u_effect_intensity('datura') > 0 ? 3 : 0)",
}
content.add(definition)
end
