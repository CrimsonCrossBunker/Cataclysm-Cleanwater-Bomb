local ccb = require("ccb")
local content = ccb.content

-- Hidden, but provides flags for powers using SUBTLE_SPELL
content.add(content.EffectType {
    id = "effect_subtle_spell_flag",
    name = "",
    description = "",
}
    :flag("SUBTLE_SPELL"))

-- Hidden, but provides the STEADY flag
content.add(content.EffectType {
    id = "effect_steady_flag",
    name = "",
    description = "",
}
    :flag("STEADY"))

-- Hidden, but provides the NO_SCENT flag
content.add(content.EffectType {
    id = "effect_no_scent_flag",
    name = "",
    description = "",
}
    :flag("NO_SCENT"))

-- Hidden, but provides the ENHANCED_VISION flag
content.add(content.EffectType {
    id = "effect_enhanced_vision_flag",
    name = "",
    description = "",
}
    :flag("ENHANCED_VISION"))

-- Hidden, but provides the GLARE_RESIST flag
content.add(content.EffectType {
    id = "effect_glare_resist_flag",
    name = "",
    description = "",
}
    :flag("GLARE_RESIST"))

-- Hidden, but provides the SLUDGE_IMMUNE flag
content.add(content.EffectType {
    id = "effect_sludge_immune_flag",
    name = "",
    description = "",
}
    :flag("SLUDGE_IMMUNE"))

-- Hidden, but provides flags for Sensing the Sun
content.add(content.EffectType {
    id = "effect_arvore_sense_sun",
    name = "",
    description = "",
}
    :flag("WATCH")
    :flag("ALARMCLOCK"))

-- Hidden, but provides effect limiting bezoar consumption
content.add(content.EffectType {
    id = "effect_consumed_bezoar",
    name = "",
    description = "",
})

-- Hidden effect, used for a conditional bonus
content.add(content.EffectType {
    id = "effect_xe_blocking_huge_attacks",
    name = "",
    description = "",
    rating = "good",
}
    :flag("BLOCK_HUGE_ATTACKS"))

-- Hidden effect, used to hide hunger
content.add(content.EffectType {
    id = "effect_xe_hidden_hunger",
    name = "",
    description = "",
    rating = "good",
}
    :flag("HUNGER_DISRUPTION"))

-- Hidden effect, used to allow easier infection recovery
content.add(content.EffectType {
    id = "effect_xe_hidden_infection_recovery",
    name = "",
    description = "",
    rating = "good",
}
    :flag("INFECTION_RECOVERY"))

-- Hidden effect, makes full vampires and shapeshifters unable to use serums
content.add(content.EffectType {
    id = "effect_xe_nonhuman_super_soldier_serum_immune",
    name = "",
    description = "",
}
    :removes_effect("resilience_serum_main")
    :removes_effect("resilience_serum_crash")
    :removes_effect("speed_serum_main")
    :removes_effect("speed_serum_crash")
    :removes_effect("super_soldier_serum_main")
    :removes_effect("super_soldier_serum_crash")
    :removes_effect("learning_serum_main")
    :removes_effect("learning_serum_crash")
    :removes_effect("regen_serum_main")
    :removes_effect("regen_serum_crash_cardio")
    :removes_effect("regen_serum_crash_fatigue")
    :removes_effect("night_ops_serum_main")
    :removes_effect("night_ops_serum_crash"))
