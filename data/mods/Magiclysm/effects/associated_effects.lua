local ccb = require("ccb")
local content = ccb.content

-- This is a dummy effect because EoCs can't tell what you're wearing
content.add(content.EffectType {
    id = "effect_elven_cloak_effect",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_petrified",
    name = ccb.content.text("Petrified"),
    description = ccb.content.text("You skin feels like stone.  You can't move."),
    apply_message = ccb.content.text("Your whole body goes rigid and you can't move a muscle!"),
    remove_message = ccb.content.text("The rigidity fades and you can move again."),
    rating = "bad",
    maximum_intensity = 1000,
}
    :flag("EFFECT_IMPEDING")
    :removes_effect("haste")
    :removes_effect("enchant_windrun")
    :removes_effect("flask_speed_eff"))

-- Remove after 0.J
content.add(content.EffectType {
    id = "effect_feral_technomancer_mage_blade",
    name = "Wielding Mage Blade",
    description = "You are a monster wielding a mage blade, as this effect indicates.",
    show_in_info = true,
})

-- Longer internal cooldown for feral mage blade
content.add(content.EffectType {
    id = "effect_feral_technomancer_mage_blade_cooldown",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_feral_technomancer_mage_armor",
    name = ccb.content.text("Mage Armor"),
    description = "You are a monster wearing conjured armor, as this effect indicates.",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_feral_technomancer_mage_armor_0"))

-- Longer internal cooldown for feral mage armor
content.add(content.EffectType {
    id = "effect_feral_technomancer_mage_armor_cooldown",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "burn_scar",
    description = ccb.content.text("This burn really hurts!"),
    maximum_duration_turns = 10,
    rating = "bad",
}
    :modifier("pain", "amount", { base = 20 }))

content.add(content.EffectType {
    id = "effect_dragon_deep_breath",
    name = "Deep Breath",
    description = "You are ready to use your breath weapon.",
})

content.add(content.EffectType {
    id = "soul_burn",
    name = ccb.content.text("Soul Burn"),
    description = ccb.content.text("A little of your soul has been burned away, leaving you in a weakened state.  The soul heals quickly, but your body regenerates more slowly while the soul is weak."),
    rating = "bad",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_soul_burn_0"))

content.add(content.EffectType {
    id = "eff_storm_elemental_electric_melee",
    name = ccb.content.text("Galvanic"),
    description = ccb.content.text("You deal additional electric damage in melee."),
    apply_message = ccb.content.text("Electric energy is concentrated in your hands, and it's ready to go."),
    remove_message = ccb.content.text("Your hands turn back to normal condition."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_eff_storm_elemental_electric_melee_0")
    :enchantment("INLINE_ENCH_eff_storm_elemental_electric_melee_1"))

content.add(content.EffectType {
    id = "gravity_mage_melee",
    name = ccb.content.text("Gravity Control"),
    description = ccb.content.text("Decreases mass of weapon on swing, increases the gravity on attack."),
    remove_message = ccb.content.text("You cease your control over gravity."),
    rating = "good",
    show_intensity = false,
}
    :enchantment("INLINE_ENCH_gravity_mage_melee_0"))

content.add(content.EffectType {
    id = "effect_terra_armor",
    name = ccb.content.text("Terra Armor"),
    description = ccb.content.text("Your body is covered in dense, ethereal shell, that protect you."),
    remove_message = ccb.content.text("Your lost your terra shell."),
}
    :enchantment("INLINE_ENCH_effect_terra_armor_0"))
