local ccb = require("ccb")
local content = ccb.content

-- Definition IDs keep bionic enchantments independent of the display language.

-- data/mods/aftershock_exoplanet/player/bionics.json

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_microgen_0",
    native_modifier_order = true,
}
    :value("POWER_TRICKLE", { add = 8000 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_afs_bio_linguistic_coprocessor_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :value("READING_SPEED_MULTIPLIER", { multiply = -0.15 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_afs_bio_blood_plus_0",
    native_modifier_order = true,
}
    :value("CARDIO_MULTIPLIER", { multiply = 1.2 })
    :effect("synth_blood_permanent", 2))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_afs_bio_blood_brain_0",
    native_modifier_order = true,
}
    :value("INTELLIGENCE", { add = 4 })
    :value("PERCEPTION", { add = 4 })
    :value("DEXTERITY", { add = 4 })
    :value("PAIN", { multiply = -0.33 })
    :value("PAIN_PENALTY_MOD_INT", { add = -4 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_afs_speed_injection_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("HUNGER", { multiply = 2 })
    :value("SPEED", { multiply = 1.75 })
    :value("MAX_STAMINA", { multiply = 1.35 })
    :value("THIRST", { multiply = 2.5 })
    :value("METABOLISM", { multiply = 2.5 })
    :value("REGEN_STAMINA", { multiply = 1.15 })
    :value("BONUS_DODGE", { add = 2 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_afs_healing_injection_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("PAIN_REMOVE", { add = 45 })
    :value("METABOLISM", { multiply = 1.5 })
    :value("REGEN_HP", { multiply = 2 })
    :incoming_damage("biological", { add = -7 })
    :incoming_damage("cold", { add = -5 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_afs_strength_injection_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("STRENGTH", { add = 3 })
    :value("MAX_HP", { add = 17 })
    :value("BONUS_BLOCK", { add = 3 })
    :value("MAX_STAMINA", { multiply = 1.25 })
    :value("THIRST", { multiply = 2.5 })
    :value("METABOLISM", { multiply = 2.5 })
    :value("REGEN_STAMINA", { multiply = 1.05 })
    :value("FOOTSTEP_NOISE", { add = 4 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_shield_heavy_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :mutation("DEAF"))

ccb.runtime.handler("bionic_ench_afs_bio_blade_fire_0_active", function(ctx)
    return (("yes" == ctx.character_inputs.character_strings["bio_superheater_on"]) and
        ctx.character_inputs.wielded_flags["BIONIC_WEAPON_MELEE"])
end)

content.add(content.Enchantment {
    id = "BIONIC_ENCH_afs_bio_blade_fire_0", name = content.text("Super Heated Bionic Weapon"), description = content.text("The superheated bionic weapon cuts and burns with ease."),
    condition_handler = "bionic_ench_afs_bio_blade_fire_0_active",
    load_character_inputs = {
        character_strings = { "bio_superheater_on" },
        wielded_flags = { "BIONIC_WEAPON_MELEE" }
    },
    native_modifier_order = true,
}
    :melee_damage("heat", { add = 35 }))

ccb.runtime.handler("bionic_ench_afs_bio_blade_electric_0_active", function(ctx)
    return (("yes" == ctx.character_inputs.character_strings["bio_blade_electric_on"]) and
        ctx.character_inputs.wielded_flags["BIONIC_WEAPON_MELEE"])
end)

content.add(content.Enchantment {
    id = "BIONIC_ENCH_afs_bio_blade_electric_0", name = content.text("Charged Bionic Weapon"), description = content.text("Your bionic weapon sparks under constant electrical charge."),
    condition_handler = "bionic_ench_afs_bio_blade_electric_0_active",
    load_character_inputs = {
        character_strings = { "bio_blade_electric_on" },
        wielded_flags = { "BIONIC_WEAPON_MELEE" }
    },
    native_modifier_order = true,
}
    :melee_damage("electric", { add = 10 })
    :hit_you({ id = "bio_blade_electric_arc" }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_afs_bio_skullgun_0",
    native_modifier_order = true,
}
    :value("INTELLIGENCE", { add = -4 })
    :value("PERCEPTION", { add = -2 }))
