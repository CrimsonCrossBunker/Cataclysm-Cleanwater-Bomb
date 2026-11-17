local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("inline_enchantment_effect_ewwww_de_zombie_0", function(ctx)
    local inputs = ctx.character_inputs
    return not ((inputs.effects["effect_ewwww_de_zombie_canceller"] or
        inputs.body_part_effects["head"]["bleed"] or
        inputs.body_part_effects["torso"]["bleed"] or
        inputs.body_part_effects["arm_r"]["bleed"] or
        inputs.body_part_effects["arm_l"]["bleed"] or
        inputs.body_part_effects["leg_r"]["bleed"] or
        inputs.body_part_effects["leg_l"]["bleed"]))
end)

ccb.runtime.handler("inline_enchantment_not_effects_effect_perk_situational_uncanny_dodge_remover", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.effects["effect_perk_situational_uncanny_dodge_remover"])
end)

ccb.runtime.handler("inline_enchantment_worn_flags_high_heels", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.worn_flags["HIGH_HEELS"]
end)

ccb.runtime.handler("inline_enchantment_not_armed", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.armed)
end)

ccb.runtime.handler("inline_enchantment_perk_fish_in_water_0", function(ctx)
    local inputs = ctx.character_inputs
    return (inputs.environment.terrain_flags["SWIMMABLE"] and
        inputs.environment.terrain_flags["DEEP_WATER"])
end)

ccb.runtime.handler("inline_enchantment_effects_effect_perk_firstest_aid", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.effects["effect_perk_firstest_aid"]
end)

ccb.runtime.handler("inline_enchantment_effects_cig", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.effects["cig"]
end)

ccb.runtime.handler("inline_enchantment_wielded_flags_messy", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.wielded_flags["MESSY"]
end)

ccb.runtime.handler("inline_enchantment_wielded_flags_old_gun", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.wielded_flags["OLD_GUN"]
end)

ccb.runtime.handler("inline_enchantment_not_daylight", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.environment.daylight)
end)

ccb.runtime.handler("inline_enchantment_daylight", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.environment.daylight
end)

ccb.runtime.handler("inline_enchantment_perk_nocturnal_2", function(ctx)
    local inputs = ctx.character_inputs
    return (inputs.environment.daylight and
        inputs.environment.outside)
end)

ccb.runtime.handler("inline_enchantment_effects_hunger_very_hungry", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.effects["hunger_very_hungry"]
end)

ccb.runtime.handler("inline_enchantment_effects_hunger_near_starving", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.effects["hunger_near_starving"]
end)

ccb.runtime.handler("inline_enchantment_effects_hunger_starving", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.effects["hunger_starving"]
end)

ccb.runtime.handler("inline_enchantment_effects_hunger_famished", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.effects["hunger_famished"]
end)

ccb.runtime.handler("inline_enchantment_effects_sleep", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.effects["sleep"]
end)

ccb.runtime.handler("inline_enchantment_perk_poison_painkill_0", function(ctx)
    local inputs = ctx.character_inputs
    return (inputs.effects["poison"] or
        inputs.effects["venom_dmg"] or
        inputs.effects["venom_weaken"] or
        inputs.effects["badpoison"] or
        inputs.effects["foodpoison"] or
        inputs.effects["paralyzepoison"])
end)

ccb.runtime.handler("inline_enchantment_wielded_flags_sheath_bow", function(ctx)
    local inputs = ctx.character_inputs
    return inputs.wielded_flags["SHEATH_BOW"]
end)

ccb.runtime.handler("inline_enchantment_not_effects_effect_hive_queen_canceller", function(ctx)
    local inputs = ctx.character_inputs
    return not (inputs.effects["effect_hive_queen_canceller"])
end)

-- perkdata/ewww_de_zombie.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_ewwww_de_zombie_0",
    condition_handler = "inline_enchantment_effect_ewwww_de_zombie_0",
    load_character_inputs = { body_part_effects = { arm_l = { "bleed" }, arm_r = { "bleed" }, head = { "bleed" }, leg_l = { "bleed" }, leg_r = { "bleed" }, torso = { "bleed" } }, effects = { "effect_ewwww_de_zombie_canceller" } },
}
    :mutation("TRAIT_EWWWW_DE_ZOMBIE"))

-- perks.json
content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_situational_uncanny_dodge_0",
    condition_handler = "inline_enchantment_not_effects_effect_perk_situational_uncanny_dodge_remover",
    load_character_inputs = { effects = { "effect_perk_situational_uncanny_dodge_remover" } },
}
    :effect("effect_perk_situational_uncanny_dodge", 1))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_running_in_heels_0",
    condition_handler = "inline_enchantment_worn_flags_high_heels",
    load_character_inputs = { worn_flags = { "HIGH_HEELS" } },
}
    :encumbrance("foot_l", { add = -35 })
    :encumbrance("foot_r", { add = -35 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_non_combatant_0",
    condition_handler = "inline_enchantment_not_armed",
    load_character_inputs = { armed = true },
}
    :value("ARMOR_ALL", { multiply = -0.25 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_fish_in_water_0",
    condition_handler = "inline_enchantment_perk_fish_in_water_0",
    load_character_inputs = { environment = { terrain_flags = { "DEEP_WATER", "SWIMMABLE" } } },
}
    :value("REGEN_STAMINA", { multiply = 1 })
    :value("MOVECOST_SWIM_MOD", { multiply = -0.25 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_firstest_aid_0",
    condition_handler = "inline_enchantment_effects_effect_perk_firstest_aid",
    load_character_inputs = { effects = { "effect_perk_firstest_aid" } },
}
    :value("BLEED_STOP_BONUS", { multiply = 0.5 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_chainsmoker_0",
    condition_handler = "inline_enchantment_effects_cig",
    load_character_inputs = { effects = { "cig" } },
}
    :melee_damage("bash", { multiply = 0.25 })
    :melee_damage("stab", { multiply = 0.25 })
    :melee_damage("cut", { multiply = 0.25 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_chainsmoker_1",
    condition_handler = "inline_enchantment_effects_cig",
    load_character_inputs = { effects = { "cig" } },
}
    :value("WEAPON_DISPERSION", { multiply = -0.25 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_chainsaw_0",
    condition_handler = "inline_enchantment_wielded_flags_messy",
    load_character_inputs = { wielded_flags = { "MESSY" } },
}
    :value("ATTACK_SPEED", { multiply = -0.2 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_olde_guns_0",
    condition_handler = "inline_enchantment_wielded_flags_old_gun",
    load_character_inputs = { wielded_flags = { "OLD_GUN" } },
}
    :value("RANGED_DAMAGE", { multiply = 0.25 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_nocturnal_0",
    condition_handler = "inline_enchantment_not_daylight",
    load_character_inputs = { environment = { daylight = true } },
}
    :value("PERCEPTION", { add = 2 })
    :value("INTELLIGENCE", { add = 1 })
    :value("SLEEPY", { add = -30 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_nocturnal_1",
    condition_handler = "inline_enchantment_daylight",
    load_character_inputs = { environment = { daylight = true } },
}
    :value("SLEEPY", { add = 50 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_nocturnal_2",
    condition_handler = "inline_enchantment_perk_nocturnal_2",
    load_character_inputs = { environment = { daylight = true, outside = true } },
}
    :value("PERCEPTION", { add = -2 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_ascetic_empowerment_1",
    condition_handler = "inline_enchantment_effects_hunger_very_hungry",
    load_character_inputs = { effects = { "hunger_very_hungry" } },
}
    :value("STRENGTH", { add = 1 })
    :value("DEXTERITY", { add = 1 })
    :value("INTELLIGENCE", { add = 1 })
    :value("PERCEPTION", { add = 1 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_ascetic_empowerment_2",
    condition_handler = "inline_enchantment_effects_hunger_near_starving",
    load_character_inputs = { effects = { "hunger_near_starving" } },
}
    :value("STRENGTH", { add = 2 })
    :value("DEXTERITY", { add = 2 })
    :value("INTELLIGENCE", { add = 2 })
    :value("PERCEPTION", { add = 2 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_ascetic_empowerment_3",
    condition_handler = "inline_enchantment_effects_hunger_starving",
    load_character_inputs = { effects = { "hunger_starving" } },
}
    :value("STRENGTH", { add = 3 })
    :value("DEXTERITY", { add = 3 })
    :value("INTELLIGENCE", { add = 3 })
    :value("PERCEPTION", { add = 3 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_ascetic_empowerment_4",
    condition_handler = "inline_enchantment_effects_hunger_famished",
    load_character_inputs = { effects = { "hunger_famished" } },
}
    :value("STRENGTH", { add = 4 })
    :value("DEXTERITY", { add = 4 })
    :value("INTELLIGENCE", { add = 4 })
    :value("PERCEPTION", { add = 4 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_dream_armor_0",
    condition_handler = "inline_enchantment_effects_sleep",
    load_character_inputs = { effects = { "sleep" } },
}
    :value("ARMOR_ALL", { add = -100 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_poison_painkill_0",
    condition_handler = "inline_enchantment_perk_poison_painkill_0",
    load_character_inputs = { effects = { "badpoison", "foodpoison", "paralyzepoison", "poison", "venom_dmg", "venom_weaken" } },
}
    :value("PAIN", { multiply = -0.8 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_yeoman_0",
    condition_handler = "inline_enchantment_wielded_flags_sheath_bow",
    load_character_inputs = { wielded_flags = { "SHEATH_BOW" } },
}
    :value("RANGED_ARMOR_PENETRATION", { add = 4 })
    :value("WEAKPOINT_ACCURACY", { multiply = 1 })
    :value("WEAPON_DISPERSION", { multiply = -0.25 })
    :value("RANGED_DAMAGE", { multiply = 0.25 })
    :value("RANGE", { add = 6 }))

content.add(content.Enchantment {
    id = "INLINE_ENCH_perk_hive_queen_0",
    condition_handler = "inline_enchantment_not_effects_effect_hive_queen_canceller",
    load_character_inputs = { effects = { "effect_hive_queen_canceller" } },
}
    :mutation("TRAIT_HIVE_QUEEN"))
