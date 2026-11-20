local ccb = require("ccb")
local content = ccb.content

-- Native jmath functions
do
local definition = content.MathFunction {
    id = "int_to_level",
    arguments = 1,
    expression = "(u_val('intelligence') * 1.5) * (_0)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "scaling_factor",
    arguments = 1,
    expression = "( ( _0 + 10) / 20 )",
}
content.replace(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_experience_formula_channeling",
    arguments = 0,
    expression = "(u_val('focus_effective') / 100 ) * 80 * ( ( u_val('intelligence') + 10) / 20 ) * min( ( 0.5 + ( u_skill('metaphysics') / 20) ), 1) * esper_potential_trait_handling()",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_experience_formula_maintenance",
    arguments = 0,
    expression = "(u_val('focus_effective') / 100) * 80 * ( ( u_val('intelligence') + 10) / 20 ) * min( ( 0.5 + ( u_skill('metaphysics') / 20) ), 1) * esper_potential_trait_handling()",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "esper_potential_trait_handling",
    arguments = 0,
    expression = "u_has_trait('ESPER_ADVANCEMENT_OKAY') ? 1 : u_has_trait('ESPER_STARTER_ADVANCEMENT_OKAY') ? 1 : 0",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionics_weariness_calculations",
    arguments = 1,
    expression = "(12 * _0) * rng( 0.3, 1.6)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_success_formula",
    arguments = 0,
    expression = "psionic_power_success_formula_convert_to_decimal()",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_success_formula_convert_to_decimal",
    arguments = 0,
    expression = "( (psionic_power_success_formula_prevent_out_of_bounds() - 40 ) / 40) ^ 2",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_success_formula_prevent_out_of_bounds",
    arguments = 0,
    expression = "clamp( psionic_power_success_formula_proficiency_handling(), 0, 40 )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_success_formula_proficiency_handling",
    arguments = 0,
    expression = " u_has_proficiency('prof_concentration_basic') ? ( u_has_proficiency('prof_concentration_intermediate') ? ( u_has_proficiency('prof_concentration_master') ? min( ( psionic_power_success_formula_base_calc() ), 40 ) : min( ( psionic_power_success_formula_base_calc() ), (37 + (u_has_trait('PSI_EXTENDED_CHANNELING_active') * 3) ) ) ) : min( ( psionic_power_success_formula_base_calc() ), 31 + (u_has_trait('PSI_EXTENDED_CHANNELING_active') * 3) ) ) : min( ( psionic_power_success_formula_base_calc() ), 24 + (u_has_trait('PSI_EXTENDED_CHANNELING_active') * 7) )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_success_formula_base_calc",
    arguments = 0,
    expression = "(2 * ( ( u_skill('metaphysics') * 2 ) - u_spell_difficulty(_spell_id) ) + ( u_val('intelligence') * 1.5 ) + (u_spell_level(_spell_id) * 0.6666666666) ) + psionic_power_success_formula_channeling_concentration_modifiers() + psionic_power_success_formula_weariness_modifiers() + psionic_power_success_formula_repeated_channeling_modifiers()",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_success_formula_channeling_concentration_modifiers",
    arguments = 0,
    expression = "u_vitamin('vitamin_afs_maintained_powers') > 0 ? ( ( (u_vitamin('vitamin_afs_maintained_powers') > concentration_calculations() ) ? ( ( u_vitamin('vitamin_afs_maintained_powers') - concentration_calculations() ) * 3 ): 0 ) * -1) : 0",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_success_formula_weariness_modifiers",
    arguments = 0,
    expression = "3 + (u_effect_intensity('weary_1') > -1 ? -3 : 0) + (u_effect_intensity('weary_2') > -1 ? -7 : 0) + (u_effect_intensity('weary_3') > -1 ? -11 : 0) + (u_effect_intensity('weary_4') > -1 ? -16 : 0) + (u_effect_intensity('weary_5') > -1 ? -22 : 0) + (u_effect_intensity('weary_6') > -1 ? -30 : 0)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_success_formula_repeated_channeling_modifiers",
    arguments = 0,
    expression = "(u_afs_psi_repeated_channeling_value / -2)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "concentration_trait_bonuses",
    arguments = 0,
    expression = "(u_has_trait('INT_ALPHA')) + (u_has_trait('NOMAD2') ? -1 : 0) + (u_has_trait('NOMAD3') ? -1 : 0) + (u_has_trait('PER_SLIME') ? -15 : 0) + (u_has_proficiency('prof_concentration_basic')) + (u_has_proficiency('prof_concentration_intermediate')) + (u_has_proficiency('prof_concentration_master') * 2) + (u_effect_intensity('hallu') > 0 ? -1 : 0) + (u_effect_intensity('winded') > 0 ? -2 : 0) + (u_effect_intensity('nausea') > 0 ? -1 : 0) + (u_effect_intensity('nausea') > 3 ? -1 : 0) +  (u_effect_intensity('cold') > 1 ? -1 : 0) + (u_effect_intensity('hot') > 1 ? -1 : 0) + (u_effect_intensity('asthma') > 0 ? -3 : 0) + (u_effect_intensity('datura') > 0 ? -3 : 0) + (u_effect_intensity('dazed') > 0 ? -2 : 0) + (u_effect_intensity('psi_dazed') > 0 ? -2 : 0) + (u_effect_intensity('psi_dazed_zap') > 0 ? -1 : 0) + (u_effect_intensity('downed') > 0 ? -2 : 0) + (u_effect_intensity('boomered') > 0 ? -1 : 0) + (u_effect_intensity('conjunctivitis') > 0 ? -1 : 0) + (u_effect_intensity('teargas') > 0 ? -3 : 0) + (u_effect_intensity('smoke_eyes') > 0 ? -1 : 0) + (u_effect_intensity('smoke_lungs') > 0 ? -2 : 0)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "concentration_calculations",
    arguments = 0,
    expression = "(u_val('intelligence') / 4) + u_bonus_concentration_powers + concentration_trait_bonuses()",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "afs_hack_skill",
    arguments = 1,
    expression = "(u_skill('computer') + u_val('intelligence')/3 + u_hack_bonus) * (_0)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "afs_hack_time_adjust",
    arguments = 3,
    expression = "_0 - _1 * afs_hack_skill(1) < _2 ? _2 : _0 - _1* afs_hack_skill(1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "afs_hack_bonus",
    arguments = 2,
    expression = "_0 + trunc( 4 * ( ( _1 - 100 ) / 100 ) )",
}
content.add(definition)
end
