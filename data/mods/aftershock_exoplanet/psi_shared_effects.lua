local ccb = require("ccb")
local content = ccb.content

-- Separate ID to allow telepaths and telepathy-immune monsters to defend against it.
content.upsert_effect_type(content.EffectType {
    id = "psi_stunned",
    name = ccb.content.text("Stunned"),
    description = ccb.content.text("Your mind is reeling."),
    apply_message = ccb.content.text("You're stunned!"),
    rating = "bad",
    show_in_info = true,
}
    :flag("DISABLE_FLIGHT")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("NO_SPELLCASTING")
    :flag("NO_PSIONICS")
    :immune_character_flag("TEEPSHIELD")
    :immune_character_flag("TEEP_IMMUNE")
    :limb_score("balance", { multiplier = 0.2 })
    :limb_score("reaction", { multiplier = 0.0 }))

content.upsert_effect_type(content.EffectType {
    id = "effect_telepath_sense_minds",
    name = ccb.content.text("Sensing Minds"),
    description = ccb.content.text("You are looking out for other minds."),
    apply_message = "",
    remove_message = ccb.content.text("Your awareness of other minds fades away."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 50,
})

content.upsert_effect_type(content.EffectType {
    id = "effect_telepathic_psi_armor",
    name = ccb.content.text("Telepathic Shield"),
    description = ccb.content.text("Your mind is warded against telepathic attack or detection."),
    apply_message = "",
    remove_message = ccb.content.text("Your thoughts are once again unguarded."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 17,
})
