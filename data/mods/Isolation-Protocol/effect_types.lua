local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "iso_eff_backup",
    rating = "good",
    intensity_duration_turns = 1,
    maximum_duration_turns = 1,
    show_in_info = false,
})

content.add(content.EffectType {
    id = "iso_eff_hypo_o",
    rating = "good",
    intensity_duration_turns = 1,
    maximum_duration_turns = 6,
    show_in_info = false,
})

content.add(content.EffectType {
    id = "iso_heal",
    name = ccb.content.text("Rapid Healing"),
    rating = "good",
    intensity_duration_turns = 1,
    maximum_duration_turns = 6,
}
    :modifier("hurt", "amount", { base = -10 }))

content.add(content.EffectType {
    id = "iso_eff_geas_buff",
    rating = "good",
    intensity_duration_turns = 1,
    maximum_duration_turns = 6,
    show_in_info = false,
})

content.add(content.EffectType {
    id = "effect_iso_eldritch_damage_shield",
    name = ccb.content.text("Coruscating Scales"),
    description = ccb.content.text("You are invincible."),
    remove_message = ccb.content.text("The glowing scales protecting you collapse."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_iso_eldritch_damage_shield_0"))

content.add(content.EffectType {
    id = "effect_iso_eldritch_cold_damage_blast",
    name = ccb.content.text("Void-chilled"),
    description = ccb.content.text("You are frozen to the bone."),
    remove_message = ccb.content.text("The chill fades away."),
    rating = "bad",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_iso_eldritch_cold_damage_blast_0"))

content.add(content.EffectType {
    id = "effect_iso_eldritch_invisibile_and_intangible",
    name = ccb.content.text("The Umbral Transfiguration"),
    description = ccb.content.text("You are an animate shadow."),
    rating = "good",
}
    :flag("ETHEREAL")
    :flag("INVISIBLE")
    :enchantment("INLINE_ENCH_effect_iso_eldritch_invisibile_and_intangible_0")
    :enchantment("INLINE_ENCH_effect_iso_eldritch_invisibile_and_intangible_1"))

content.add(content.EffectType {
    id = "effect_iso_eldritch_cure_poison_disease_gas",
    name = ccb.content.text("To Walk Amidst the Fens"),
    description = ccb.content.text("Your flesh is so full of venins that you are immune to any external miasmas."),
    rating = "good",
}
    :flag("INHALED_TOXIN_IMMUNE")
    :removes_effect("poison")
    :removes_effect("badpoison")
    :removes_effect("tpollen")
    :removes_effect("venom_dmg")
    :removes_effect("venom_weaken")
    :removes_effect("venom_blind")
    :removes_effect("venom_pain")
    :removes_effect("paralyzepoison")
    :removes_effect("nausea")
    :removes_effect("smoke_eyes")
    :removes_effect("teargas")
    :removes_effect("boomered")
    :removes_effect("fetid_goop")
    :removes_effect("spores")
    :removes_effect("dermatik")
    :enchantment("INLINE_ENCH_effect_iso_eldritch_cure_poison_disease_gas_0"))

content.add(content.EffectType {
    id = "effect_iso_eldritch_imprisonment",
    name = ccb.content.text("The Adamantine Gaol of Emthys"),
    description = ccb.content.text("You are totally immobile and invulnerable."),
    remove_message = ccb.content.text("You can move again."),
    rating = "bad",
    show_in_info = true,
}
    :flag("CANNOT_ATTACK")
    :flag("CANNOT_MOVE")
    :flag("CANNOT_TAKE_DAMAGE"))

-- Hidden effects, blocks The Most Excellent Obliteration of Blasphemies from being instantly dispelled
content.add(content.EffectType {
    id = "effect_iso_eldritch_mass_aoe_zombie_destruction_preventer",
    name = "",
    description = "",
})
