local ccb = require("ccb")
local content = ccb.content

-- Native jmath functions
do
local definition = content.MathFunction {
    id = "magiclysm_standard_spell_failure_equation",
    arguments = 0,
    expression = "0.6 + (u_effect_intensity('effect_magiclysm_spellcasting_aid_item_wielded') > 0 ? -0.3 : 0) + (u_val('intelligence') * -0.03) + (u_spell_level(_spell_id) * -0.02) + clamp( ( (u_pain('type': 'perceived') / 100) + ( (u_pain('type': 'perceived') > 4) ? (u_spell_level(_spell_id) * -0.04) : 0) ), 0, 1) + magiclysm_spell_failure_spellcraft_adjustments()",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_spellcraft_adjustments",
    arguments = 0,
    expression = "(u_spell_difficulty(_spell_id) * 0.04) + (u_skill('spellcraft') * -0.08) + (u_spell_difficulty(_spell_id) > u_skill('spellcraft') ) ? ( (u_spell_difficulty(_spell_id) - u_skill('spellcraft') ) * 0.12 ) : 0",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_evocation_formula",
    arguments = 0,
    expression = "clamp( (magiclysm_standard_spell_failure_equation() + magiclysm_spell_failure_evocation_proficiency_adjustments() ), 0, 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_evocation_proficiency_adjustments",
    arguments = 0,
    expression = "(u_has_proficiency('prof_magic_evocation_beginner') ? -0.1 : 0) + (u_has_proficiency('prof_magic_evocation_apprentice') ? -0.15 : 0) + (u_has_proficiency('prof_magic_evocation_master') ? -0.2 : 0)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_channeling_formula",
    arguments = 0,
    expression = "clamp( (magiclysm_standard_spell_failure_equation() + magiclysm_spell_failure_channeling_proficiency_adjustments() ), 0, 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_channeling_proficiency_adjustments",
    arguments = 0,
    expression = "(u_has_proficiency('prof_magic_channel_beginner') ? -0.1 : 0) + (u_has_proficiency('prof_magic_channel_apprentice') ? -0.15 : 0) + (u_has_proficiency('prof_magic_channel_master') ? -0.2 : 0)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_summoning_formula",
    arguments = 0,
    expression = "clamp( (magiclysm_standard_spell_failure_equation() + magiclysm_spell_failure_summoning_proficiency_adjustments() ), 0, 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_summoning_proficiency_adjustments",
    arguments = 0,
    expression = "(u_has_proficiency('prof_magic_summon_beginner') ? -0.1 : 0) + (u_has_proficiency('prof_magic_summon_apprentice') ? -0.15 : 0) + (u_has_proficiency('prof_magic_summon_master') ? -0.2 : 0)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_enhancement_formula",
    arguments = 0,
    expression = "clamp( (magiclysm_standard_spell_failure_equation() + magiclysm_spell_failure_enhancement_proficiency_adjustments() ), 0, 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_enhancement_proficiency_adjustments",
    arguments = 0,
    expression = "(u_has_proficiency('prof_magic_enhancement_beginner') ? -0.1 : 0) + (u_has_proficiency('prof_magic_enhancement_apprentice') ? -0.15 : 0) + (u_has_proficiency('prof_magic_enhancement_master') ? -0.2 : 0)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_enervation_formula",
    arguments = 0,
    expression = "clamp( (magiclysm_standard_spell_failure_equation() + magiclysm_spell_failure_enervation_proficiency_adjustments() ), 0, 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_enervation_proficiency_adjustments",
    arguments = 0,
    expression = "(u_has_proficiency('prof_magic_enervation_beginner') ? -0.1 : 0) + (u_has_proficiency('prof_magic_enervation_apprentice') ? -0.15 : 0) + (u_has_proficiency('prof_magic_enervation_master') ? -0.2 : 0)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_conveyance_formula",
    arguments = 0,
    expression = "clamp( (magiclysm_standard_spell_failure_equation() + magiclysm_spell_failure_conveyance_proficiency_adjustments() ), 0, 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_conveyance_proficiency_adjustments",
    arguments = 0,
    expression = "(u_has_proficiency('prof_magic_conveyance_beginner') ? -0.1 : 0) + (u_has_proficiency('prof_magic_conveyance_apprentice') ? -0.15 : 0) + (u_has_proficiency('prof_magic_conveyance_master') ? -0.2 : 0)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_restoration_formula",
    arguments = 0,
    expression = "clamp( (magiclysm_standard_spell_failure_equation() + magiclysm_spell_failure_restoration_proficiency_adjustments() ), 0, 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_restoration_proficiency_adjustments",
    arguments = 0,
    expression = "(u_has_proficiency('prof_magic_restoration_beginner') ? -0.1 : 0) + (u_has_proficiency('prof_magic_restoration_apprentice') ? -0.15 : 0) + (u_has_proficiency('prof_magic_restoration_master') ? -0.2 : 0)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_transformation_formula",
    arguments = 0,
    expression = "clamp( (magiclysm_standard_spell_failure_equation() + magiclysm_spell_failure_transformation_proficiency_adjustments() ), 0, 1)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_transformation_proficiency_adjustments",
    arguments = 0,
    expression = "(u_has_proficiency('prof_magic_transformation_beginner') ? -0.1 : 0) + (u_has_proficiency('prof_magic_transformation_apprentice') ? -0.15 : 0) + (u_has_proficiency('prof_magic_transformation_master') ? -0.2 : 0)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_transformation_proficiency_adjustments_damage",
    arguments = 0,
    expression = "1 + (u_has_proficiency('prof_magic_transformation_beginner') ? 0.1 : 0) + (u_has_proficiency('prof_magic_transformation_apprentice') ? 0.15 : 0) + (u_has_proficiency('prof_magic_transformation_master') ? 0.2 : 0)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "magiclysm_spell_failure_transformation_proficiency_adjustments_damage_npc",
    arguments = 0,
    expression = "1 + (n_has_proficiency('prof_magic_transformation_beginner') ? 0.1 : 0) + (n_has_proficiency('prof_magic_transformation_apprentice') ? 0.15 : 0) + (n_has_proficiency('prof_magic_transformation_master') ? 0.2 : 0)",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "evocation_proficiency_modifier",
    arguments = 0,
    expression = "1 + ( (u_proficiency('prof_magic_evocation_beginner', 'format': 'percent') / 1000) + (u_proficiency('prof_magic_evocation_apprentice', 'format': 'percent') / 1000) + (u_proficiency('prof_magic_evocation_master', 'format': 'percent') / 1000) )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "channeling_proficiency_modifier",
    arguments = 0,
    expression = "1 + ( (u_proficiency('prof_magic_channel_beginner', 'format': 'percent') / 1000) + (u_proficiency('prof_magic_channel_apprentice', 'format': 'percent') / 1000) + (u_proficiency('prof_magic_channel_master', 'format': 'percent') / 1000) )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "summoning_proficiency_modifier",
    arguments = 0,
    expression = "1 + ( (u_proficiency('prof_magic_summon_beginner', 'format': 'percent') / 1000) + (u_proficiency('prof_magic_summon_apprentice', 'format': 'percent') / 1000) + (u_proficiency('prof_magic_summon_master', 'format': 'percent') / 1000) )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "enhancement_proficiency_modifier",
    arguments = 0,
    expression = "1 + ( (u_proficiency('prof_magic_enhancement_beginner', 'format': 'percent') / 1000) + (u_proficiency('prof_magic_enhancement_apprentice', 'format': 'percent') / 1000) + (u_proficiency('prof_magic_enhancement_master', 'format': 'percent') / 1000) )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "restoration_proficiency_modifier",
    arguments = 0,
    expression = "1 + ( (u_proficiency('prof_magic_restoration_beginner', 'format': 'percent') / 1000) + (u_proficiency('prof_magic_restoration_apprentice', 'format': 'percent') / 1000) + (u_proficiency('prof_magic_restoration_master', 'format': 'percent') / 1000) )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "conveyance_proficiency_modifier",
    arguments = 0,
    expression = "1 + ( (u_proficiency('prof_magic_conveyance_beginner', 'format': 'percent') / 1000) + (u_proficiency('prof_magic_conveyance_apprentice', 'format': 'percent') / 1000) + (u_proficiency('prof_magic_conveyance_master', 'format': 'percent') / 1000) )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "transformation_proficiency_modifier",
    arguments = 0,
    expression = "1 + ( (u_proficiency('prof_magic_transformation_beginner', 'format': 'percent') / 1000) + (u_proficiency('prof_magic_transformation_apprentice', 'format': 'percent') / 1000) + (u_proficiency('prof_magic_transformation_master', 'format': 'percent') / 1000) )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "limit_caster_level_boost",
    arguments = 2,
    expression = "floor( min(_0, ( 1 + ( _1 / 5 ) ) ) )",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "mc_spell_train_focus_factor",
    arguments = 2,
    expression = "_1 > 15 ? (max(20, _0) - 50) / 100 + 0.5 : 1",
}
content.add(definition)
end
do
local definition = content.MathFunction {
    id = "mc_spell_cost_train_factor",
    arguments = 3,
    expression = "max(_1, min(_2, (_2 - (_1 * max(0, _0) / u_val('mana_max') * _2 / _1 ))))",
}
content.add(definition)
end
