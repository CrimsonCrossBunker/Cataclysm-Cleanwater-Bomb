local ccb = require("ccb")
local content = ccb.content

-- Native jmath functions
do
local definition = content.MathFunction {
    id = "xedrawood_weariness_sorcery_effects",
    arguments = 0,
    expression = "-0.25 + (u_effect_intensity('weary_1') > -1 ? 0.1 : 0) + (u_effect_intensity('weary_2') > -1 ? 0.25 : 0) + (u_effect_intensity('weary_3') > -1 ? 0.35 : 0) + (u_effect_intensity('weary_4') > -1 ? 0.5 : 0) + (u_effect_intensity('weary_5') > -1 ? 0.65 : 0) + (u_effect_intensity('weary_6') > -1 ? 0.9 : 0)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "xedrawood_spell_failure_chance_forest",
    arguments = 0,
    expression = "clamp( ( ( (u_pain('type': 'perceived') / 200 ) + ( u_spell_difficulty(_spell_id) / 8.2 ) + ( ( u_spell_level(_spell_id) / 30 ) * -1) ) + ( ( u_skill('deduction') / 25 ) * -1) + xedrawood_weariness_sorcery_effects() ), 0.005, 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "xedrawood_forest_magic_modifiers",
    arguments = 0,
    expression = "1",
}
content.add(definition)
end
