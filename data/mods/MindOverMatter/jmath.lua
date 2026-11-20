local ccb = require("ccb")
local content = ccb.content

-- Native jmath functions
do
local definition = content.MathFunction {
    id = "mom_int_to_level",
    arguments = 0,
    expression = "(u_val('intelligence') * 1.5)",
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
    id = "mom_biokinesis_max_power_formula",
    arguments = 0,
    expression = "mom_int_to_level() + ( u_has_wielded_with_flag('MATRIX_CRYSTAL_BIOKINESIS') ? 6 : 0 )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "mom_clairsentience_max_power_formula",
    arguments = 0,
    expression = "mom_int_to_level() + ( u_has_wielded_with_flag('MATRIX_CRYSTAL_CLAIRSENTIENCE') ? 6 : 0 )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "mom_electrokinesis_max_power_formula",
    arguments = 0,
    expression = "mom_int_to_level() + ( u_has_wielded_with_flag('MATRIX_CRYSTAL_ELECTROKINESIS') ? 6 : 0 )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "mom_photokinesis_max_power_formula",
    arguments = 0,
    expression = "mom_int_to_level() + ( u_has_wielded_with_flag('MATRIX_CRYSTAL_PHOTOKINESIS') ? 6 : 0 )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "mom_pyrokinesis_max_power_formula",
    arguments = 0,
    expression = "mom_int_to_level() + ( u_has_wielded_with_flag('MATRIX_CRYSTAL_PYROKINESIS') ? 6 : 0 )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "mom_telekinesis_max_power_formula",
    arguments = 0,
    expression = "mom_int_to_level() + ( u_has_wielded_with_flag('MATRIX_CRYSTAL_TELEKINESIS') ? 6 : 0 )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "mom_telepathy_max_power_formula",
    arguments = 0,
    expression = "mom_int_to_level() + ( u_has_wielded_with_flag('MATRIX_CRYSTAL_TELEPATHY') ? 6 : 0 )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "mom_teleportation_max_power_formula",
    arguments = 0,
    expression = "mom_int_to_level() + ( u_has_wielded_with_flag('MATRIX_CRYSTAL_TELEPORTATION') ? 6 : 0 )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "mom_vitakinesis_max_power_formula",
    arguments = 0,
    expression = "mom_int_to_level() + ( u_has_wielded_with_flag('MATRIX_CRYSTAL_VITAKINESIS') ? 6 : 0 )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_modifiers",
    arguments = 0,
    expression = "scaling_factor(u_val('intelligence') ) * u_nether_attunement_power_scaling * weariness_power_scaling()",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "weariness_power_scaling",
    arguments = 0,
    expression = "(u_effect_intensity('weary_1') > -1 ? 0.9 : 1) * (u_effect_intensity('weary_2') > -1 ? 0.75 : 1) * (u_effect_intensity('weary_3') > -1 ? 0.6 : 1) * (u_effect_intensity('weary_4') > -1 ? 0.45 : 1) * (u_effect_intensity('weary_5') > -1 ? 0.25 : 1) * (u_effect_intensity('weary_6') > -1 ? 0.25 : 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_experience_formula_channeling",
    arguments = 0,
    expression = "(u_val('focus_effective') / 100 ) * 80 * ( ( u_val('intelligence') + 10) / 20 ) * min( ( 0.5 + ( u_skill('metaphysics') / 20) ), 1) * u_nether_attunement_power_scaling * game_option('SKILL_TRAINING_SPEED')",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_experience_formula",
    arguments = 0,
    expression = "(u_val('focus_effective') / 100) * 80 * ( ( u_val('intelligence') + 10) / 20 ) * min( ( 0.5 + ( u_skill('metaphysics') / 20) ), 1) * u_nether_attunement_power_scaling * game_option('SKILL_TRAINING_SPEED')",
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
    expression = "u_has_proficiency('prof_concentration_basic') ? ( u_has_proficiency('prof_concentration_intermediate') ? ( u_has_proficiency('prof_concentration_master') ? min( ( psionic_power_success_formula_base_calc() ), 40 ) : min( ( psionic_power_success_formula_base_calc() ), (37 + (u_has_trait('PSI_EXTENDED_CHANNELING_active') * 3) ) ) ) : min( ( psionic_power_success_formula_base_calc() ), 31 + (u_has_trait('PSI_EXTENDED_CHANNELING_active') * 3) ) ) : min( ( psionic_power_success_formula_base_calc() ), 24 + (u_has_trait('PSI_EXTENDED_CHANNELING_active') * 7) )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_success_formula_base_calc",
    arguments = 0,
    expression = "(2 * ( ( u_skill('metaphysics') * 2 ) - u_spell_difficulty(_spell_id) ) + ( u_val('intelligence') * 1.5 ) + (u_spell_level(_spell_id) * 0.6666666666) ) + psionic_power_success_formula_channeling_concentration_modifiers() + psionic_power_success_formula_weariness_modifiers() + psionic_power_success_formula_repeated_channeling_modifiers() + psionic_power_success_formula_modifiers() + psionic_power_success_formula_perks()",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_success_formula_channeling_concentration_modifiers",
    arguments = 0,
    expression = "u_vitamin('vitamin_maintained_powers') > 0 ? ( ( (u_vitamin('vitamin_maintained_powers') > concentration_calculations() ) ? ( ( u_vitamin('vitamin_maintained_powers') - concentration_calculations() ) * 3 ): 0 ) * -1) : 0",
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
    expression = "(u_nether_conduit_repeated_channeling_value / -2) * (1 + (u_has_trait('PSI_TORRENTIAL_CHANNELING_active') + 0.6) )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_success_formula_modifiers",
    arguments = 0,
    expression = "psionic_power_success_formula_torrential_channeling() + u_has_trait('PSI_EXTENDED_CHANNELING_active') ? (8 + u_skill('metaphysics') ) ) : 0",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_success_formula_torrential_channeling",
    arguments = 0,
    expression = "u_has_trait('PSI_TORRENTIAL_CHANNELING_active') ? max( (psionic_power_success_formula_nether_attunement_calculations() * -2), -35) : (psionic_power_success_formula_nether_attunement_calculations() * -1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_success_formula_nether_attunement_calculations",
    arguments = 0,
    expression = "u_has_proficiency('prof_concentration_basic') ? ( u_has_proficiency('prof_concentration_intermediate') ? ( u_has_proficiency('prof_concentration_master') ? ( u_vitamin('vitamin_psionic_drain') / 40 ) : ( u_vitamin('vitamin_psionic_drain') / 25 ) ) : ( u_vitamin('vitamin_psionic_drain') / 15 ) ) : ( u_vitamin('vitamin_psionic_drain') / 10 )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionic_power_success_formula_perks",
    arguments = 0,
    expression = "0",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "nether_attune_difficulty_scaler",
    arguments = 1,
    expression = "_0 * _0",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "nether_attune_torrential_channeling_influence",
    arguments = 0,
    expression = "u_has_trait('PSI_TORRENTIAL_CHANNELING_active') * ( clamp( (u_vitamin('vitamin_psionic_drain') / 2), 0,50) + clamp( (u_vitamin('vitamin_psionic_drain') - 100), 0,100) + clamp( ( (u_vitamin('vitamin_psionic_drain') - 200) * 2), 0,100) )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "psionics_kcal_cost",
    arguments = 1,
    expression = "(4 * _0) * rng( 0.3, 1.7) * u_nether_attunement_power_scaling * (u_effect_intensity('effect_nether_attunement_extra_kcal') > 0 ? 3 : 1) + (1 * u_has_trait('SCEN_HEART_OF_FIRE') * 0.5)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "concentration_trait_bonuses",
    arguments = 0,
    expression = "(u_has_trait('CONCENTRATION_GOOD')) + (u_has_trait('CONCENTRATION_BAD') ? -1 : 0) + (u_has_trait('INT_ALPHA')) + (u_has_trait('NOMAD2') ? -1 : 0) + (u_has_trait('NOMAD3') ? -1 : 0) + (u_has_trait('PER_SLIME') ? -15 : 0) + (u_has_trait('PER_INTERSTICE') ? 2 : 0) + (u_has_trait('CONCENTRATION_DEBUG') ? 50 : 0) + (u_has_proficiency('prof_concentration_basic')) + (u_has_proficiency('prof_concentration_intermediate')) + (u_has_proficiency('prof_concentration_master') * 2) + (u_effect_intensity('effect_disease_psionic_drain') > 4 ? -1 : 0) + (u_effect_intensity('effect_disease_psionic_drain') > 10 ? -1 : 0) + (u_effect_intensity('effect_psi_studying_power') > 0 ? -2 : 0) + (u_effect_intensity('effect_psi_learning_new_power') > 0 ? -3 : 0) + (u_effect_intensity('hallu') > 0 ? -1 : 0) + (u_effect_intensity('winded') > 0 ? -2 : 0) + (u_effect_intensity('nausea') > 0 ? -1 : 0) + (u_effect_intensity('nausea') > 3 ? -1 : 0) +  (u_effect_intensity('cold') > 1 ? -1 : 0) + (u_effect_intensity('hot') > 1 ? -1 : 0) + (u_effect_intensity('asthma') > 0 ? -3 : 0) + (u_effect_intensity('datura') > 0 ? -3 : 0) + (u_effect_intensity('dazed') > 0 ? -2 : 0) + (u_effect_intensity('psi_dazed') > 0 ? -2 : 0) + (u_effect_intensity('psi_dazed_zap') > 0 ? -1 : 0) + (u_effect_intensity('downed') > 0 ? -2 : 0) + (u_effect_intensity('boomered') > 0 ? -1 : 0) + (u_effect_intensity('conjunctivitis') > 0 ? -1 : 0) + (u_effect_intensity('teargas') > 0 ? -3 : 0) + (u_effect_intensity('smoke_eyes') > 0 ? -1 : 0) + (u_effect_intensity('smoke_lungs') > 0 ? -2 : 0) + (u_effect_intensity('effect_whispering_amalgamation_whispers') > 0 ? -2 : 0)",
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
    id = "concentration_nether_attunement_influences",
    arguments = 0,
    expression = "(concentration_calculations() > 1 ? concentration_calculations(): 1) * (u_has_proficiency('prof_concentration_basic') ? 0.9: 1) + (u_has_proficiency('prof_concentration_intermediate') ? 0.9: 1) + (u_has_proficiency('prof_concentration_master') ? 0.8: 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "jmath_psi_learning_counter_time_low",
    arguments = 1,
    expression = "_0 * max(( 1 - ( ( ( u_val('intelligence') + 23.33) / 33.33 ) ) + 1 ),0.4) * clamp( ( 1 - ( ( (u_skill('metaphysics') - 4) + 20 ) / 21) + 1),0.75,1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "jmath_psi_learning_counter_time_high",
    arguments = 1,
    expression = "_0 * max(( 1 - ( ( ( u_val('intelligence') + 23.33) / 33.33 ) ) + 1 ),0.4) * clamp(( 1 - (((u_skill('metaphysics') - 4) + 20 ) / 21) + 1),0.75,1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "jmath_biokinesis_learning_eocs_modifiers",
    arguments = 1,
    expression = "_0 * max(( 1 - ( ( ( u_val('intelligence') + 23.33) / 33.33 ) ) + 1 ),0.4) * (1 - (0.2 * u_has_proficiency('prof_contemplation_biokinesis')))",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "jmath_clairsentience_learning_eocs_modifiers",
    arguments = 1,
    expression = "_0 * max(( 1 - ( ( ( u_val('intelligence') + 23.33) / 33.33 ) ) + 1 ),0.4) * (1 - (0.2 * u_has_proficiency('prof_contemplation_clairsentience')))",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "jmath_electrokinesis_learning_eocs_modifiers",
    arguments = 1,
    expression = "_0 * max(( 1 - ( ( ( u_val('intelligence') + 23.33) / 33.33 ) ) + 1 ),0.4) * (1 - (0.2 * u_has_proficiency('prof_contemplation_electrokinesis')))",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "jmath_photokinesis_learning_eocs_modifiers",
    arguments = 1,
    expression = "_0 * max(( 1 - ( ( ( u_val('intelligence') + 23.33) / 33.33 ) ) + 1 ),0.4) * (1 - (0.2 * u_has_proficiency('prof_contemplation_photokinesis')))",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "jmath_pyrokinesis_learning_eocs_modifiers",
    arguments = 1,
    expression = "_0 * max(( 1 - ( ( ( u_val('intelligence') + 23.33) / 33.33 ) ) + 1 ),0.4) * (1 - (0.2 * u_has_proficiency('prof_contemplation_pyrokinesis')))",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "jmath_telekinesis_learning_eocs_modifiers",
    arguments = 1,
    expression = "_0 * max(( 1 - ( ( ( u_val('intelligence') + 23.33) / 33.33 ) ) + 1 ),0.4) * (1 - (0.2 * u_has_proficiency('prof_contemplation_telekinesis')))",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "jmath_telepathy_learning_eocs_modifiers",
    arguments = 1,
    expression = "_0 * max(( 1 - ( ( ( u_val('intelligence') + 23.33) / 33.33 ) ) + 1 ),0.4) * (1 - (0.2 * u_has_proficiency('prof_contemplation_telepathy')))",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "jmath_teleportation_learning_eocs_modifiers",
    arguments = 1,
    expression = "_0 * max(( 1 - ( ( ( u_val('intelligence') + 23.33) / 33.33 ) ) + 1 ),0.4) * (1 - (0.2 * u_has_proficiency('prof_contemplation_teleportation')))",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "jmath_vitakinesis_learning_eocs_modifiers",
    arguments = 1,
    expression = "_0 * max(( 1 - ( ( ( u_val('intelligence') + 23.33) / 33.33 ) ) + 1 ),0.4) * (1 - (0.2 * u_has_proficiency('prof_contemplation_vitakinesis')))",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "jmath_telepathy_knacks_combined_level",
    arguments = 0,
    expression = "u_spell_level('telepathic_shield_knack') + u_spell_level('telepathic_mind_sense_knack') + u_spell_level('telepathic_morale_knack') + u_spell_level('telepathic_blast_knack') + u_spell_level('telepathic_mesmerize_knack') + u_spell_level('telepathic_animal_mind_control_knack') + u_spell_level('telepathic_invisibility_knack') + u_spell_level('telepathic_blast_radius_knack')",
}
content.add(definition)
end
