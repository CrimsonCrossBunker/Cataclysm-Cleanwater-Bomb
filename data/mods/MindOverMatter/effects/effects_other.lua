local ccb = require("ccb")
local content = ccb.content

-- Hidden effect, used as a tracker
content.add(content.EffectType {
    id = "effect_no_nether_attunement_from_channel",
    name = "",
    description = "",
    rating = "good",
})

-- Hidden effect, used as a tracker
content.add(content.EffectType {
    id = "effect_vitakin_wakeful_resting",
    name = "",
    description = "",
    rating = "good",
})

-- Hidden effect, used for a conditional bonus
content.add(content.EffectType {
    id = "effect_psi_blocking_huge_attacks",
    name = "",
    description = "",
    rating = "good",
}
    :flag("BLOCK_HUGE_ATTACKS"))

-- Hidden effect, used as a limiter
content.add(content.EffectType {
    id = "effect_premonition_quiet_farm_limiter",
    name = "",
    description = "",
})

-- Hidden effect, used as part of the SHADOW URGE process
content.add(content.EffectType {
    id = "effect_mom_shadow_urge_process_operation",
    name = "",
    description = "",
    apply_message = ccb.content.text("You slip into unconsciousness."),
    rating = "mixed",
}
    :flag("BLIND")
    :flag("DEAF"))
