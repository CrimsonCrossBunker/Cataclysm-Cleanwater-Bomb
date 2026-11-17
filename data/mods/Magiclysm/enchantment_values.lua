local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("enchantment_enchant_stormshaper_heart_of_hurricane_knockback_resist_add", function(ctx)
    return (ctx.spell_levels["stormshaper_heart_of_hurricane"] * 0.02) + 0.3
end)

ccb.runtime.handler("enchantment_ench_longsword_holy_lumination_add", function(ctx)
    return ((ctx.stats["intelligence"] * 2) + (ctx.spell_levels["magus_mage_conjured_blade"] * 1.5)) * 3
end)

ccb.runtime.handler("enchantment_ench_longsword_holy_light_add", function(ctx)
    return math.min(((ctx.stats["intelligence"] * 2) + (ctx.spell_levels["magus_mage_conjured_blade"] * 1.5)), 40)
end)

ccb.runtime.handler("enchantment_ench_armor_spirit_lumination_add", function(ctx)
    return ((ctx.stats["intelligence"] * 1.5) + ((ctx.spell_levels["magus_mage_conjured_armor"] + ctx.spell_levels["magus_mage_conjured_armor_plus"]) * 0.5)) * 3
end)

ccb.runtime.handler("enchantment_ench_armor_spirit_bash_add", function(ctx)
    return math.max((((ctx.stats["intelligence"] * 1.5) + ((ctx.spell_levels["magus_mage_conjured_armor"] + ctx.spell_levels["magus_mage_conjured_armor_plus"]) * 0.5)) * (-1)), (-45))
end)

ccb.runtime.handler("enchantment_ench_storm_hammer_electric_add", function(ctx)
    return (5 + (1 * ctx.spell_levels["storm_hammer"])) + (1 * ctx.spell_levels["storm_hammer_plus"])
end)

ccb.runtime.handler("enchantment_ench_aura_caustic_melee_damage_acid_add", function(ctx)
    return (1 + (0.25 * ctx.spell_levels["biomancer_caustic_aura"])) + (0.25 * ctx.spell_levels["biomancer_caustic_aura_plus"])
end)

ccb.runtime.handler("enchantment_ench_aura_caustic_incoming_damage_acid_add", function(ctx)
    return ((-2) - (0.5 * ctx.spell_levels["biomancer_caustic_aura"])) - (0.5 * ctx.spell_levels["biomancer_caustic_aura_plus"])
end)

ccb.runtime.handler("enchantment_ench_subzero_talons_cold_add", function(ctx)
    return 3 + (0.5 * ctx.spell_levels["summon_subzero_talons"])
end)

ccb.runtime.handler("enchantment_ench_aura_feral_strength_add", function(ctx)
    return 1 + (ctx.spell_levels["druid_feralform"] / 5)
end)

ccb.runtime.handler("enchantment_ench_aura_feral_intelligence_add", function(ctx)
    return (-3) + (ctx.spell_levels["druid_feralform"] / 7)
end)

ccb.runtime.handler("enchantment_ench_aura_feral_plus_strength_add", function(ctx)
    return 3 + (ctx.spell_levels["druid_feralform_plus"] / 5)
end)

ccb.runtime.handler("enchantment_ench_aura_feral_plus_perception_add", function(ctx)
    return 0 + (ctx.spell_levels["druid_feralform"] / 7)
end)

ccb.runtime.handler("enchantment_ench_technomancer_far_sight_lens_overmap_sight_add", function(ctx)
    return (30 + (2 * ctx.spell_levels["technomancer_far_sight"])) + (3 * ctx.spell_levels["technomancer_far_sight_plus"])
end)

content.add(content.Enchantment {
    id = "enchant_stormshaper_heart_of_hurricane",
    has = "HELD",
    condition = "ALWAYS",
}
    :value("FOOTSTEP_NOISE", { multiply = 1 })
    :value("KNOCKBACK_RESIST", {
        add_handler = "enchantment_enchant_stormshaper_heart_of_hurricane_knockback_resist_add",
        load_spell_levels = { "stormshaper_heart_of_hurricane" },
    })
    :value("KNOCKDOWN_RESIST", {
        add_handler = "enchantment_enchant_stormshaper_heart_of_hurricane_knockback_resist_add",
        load_spell_levels = { "stormshaper_heart_of_hurricane" },
    })
    :hit_me({ id = "stormshaper_heart_of_hurricane_throw", self = false, trigger_once_in = 3 }))

content.add(content.Enchantment {
    id = "ench_longsword_holy",
    has = "WIELD",
    condition = "ALWAYS",
    name = content.text("Force blade"),
    description = content.text("The damage done and light emitted by this sword increase with intelligence and spell level."),
}
    :value("LUMINATION", {
        add_handler = "enchantment_ench_longsword_holy_lumination_add",
        load_spell_levels = { "magus_mage_conjured_blade" },
    })
    :melee_damage("light", {
        add_handler = "enchantment_ench_longsword_holy_light_add",
        load_spell_levels = { "magus_mage_conjured_blade" },
    }))

content.add(content.Enchantment {
    id = "ench_armor_spirit",
    has = "WORN",
    condition = "ALWAYS",
    name = content.text("Magic armor"),
    description = content.text("This magical armor improves with your intelligence and the spell's level."),
}
    :value("LUMINATION", {
        add_handler = "enchantment_ench_armor_spirit_lumination_add",
        load_spell_levels = { "magus_mage_conjured_armor", "magus_mage_conjured_armor_plus" },
    })
    :incoming_damage("bash", {
        add_handler = "enchantment_ench_armor_spirit_bash_add",
        load_spell_levels = { "magus_mage_conjured_armor", "magus_mage_conjured_armor_plus" },
    })
    :incoming_damage("stab", {
        add_handler = "enchantment_ench_armor_spirit_bash_add",
        load_spell_levels = { "magus_mage_conjured_armor", "magus_mage_conjured_armor_plus" },
    })
    :incoming_damage("cut", {
        add_handler = "enchantment_ench_armor_spirit_bash_add",
        load_spell_levels = { "magus_mage_conjured_armor", "magus_mage_conjured_armor_plus" },
    })
    :incoming_damage("bullet", {
        add_handler = "enchantment_ench_armor_spirit_bash_add",
        load_spell_levels = { "magus_mage_conjured_armor", "magus_mage_conjured_armor_plus" },
    }))

content.add(content.Enchantment {
    id = "ench_storm_hammer",
    has = "WIELD",
    condition = "ALWAYS",
    name = content.text("Storm hammer"),
    description = content.text("A magical hammer whose damage increases with the spell."),
}
    :melee_damage("electric", {
        add_handler = "enchantment_ench_storm_hammer_electric_add",
        load_spell_levels = { "storm_hammer", "storm_hammer_plus" },
    }))

content.add(content.Enchantment {
    id = "ench_aura_caustic",
    has = "WORN",
    condition = "ALWAYS",
}
    :melee_damage("acid", {
        add_handler = "enchantment_ench_aura_caustic_melee_damage_acid_add",
        load_spell_levels = { "biomancer_caustic_aura", "biomancer_caustic_aura_plus" },
    })
    :incoming_damage("acid", {
        add_handler = "enchantment_ench_aura_caustic_incoming_damage_acid_add",
        load_spell_levels = { "biomancer_caustic_aura", "biomancer_caustic_aura_plus" },
    })
    :hit_me({ id = "corrosive_aura_spell" }))

content.add(content.Enchantment {
    id = "ench_subzero_talons",
    has = "WORN",
    condition = "ALWAYS",
    name = content.text("Subzero Talons"),
    description = content.text("Icy talons to freeze your enemies."),
}
    :melee_damage("cold", {
        add_handler = "enchantment_ench_subzero_talons_cold_add",
        load_spell_levels = { "summon_subzero_talons" },
    }))

content.add(content.Enchantment {
    id = "ench_aura_feral",
    has = "HELD",
    condition = "ALWAYS",
    name = content.text("Feral Aura"),
    description = content.text("Unleashing the rage within."),
}
    :value("STRENGTH", {
        add_handler = "enchantment_ench_aura_feral_strength_add",
        load_spell_levels = { "druid_feralform" },
    })
    :value("DEXTERITY", {
        add_handler = "enchantment_ench_aura_feral_strength_add",
        load_spell_levels = { "druid_feralform" },
    })
    :value("INTELLIGENCE", {
        add_handler = "enchantment_ench_aura_feral_intelligence_add",
        load_spell_levels = { "druid_feralform" },
    })
    :value("PERCEPTION", {
        add_handler = "enchantment_ench_aura_feral_intelligence_add",
        load_spell_levels = { "druid_feralform" },
    })
    :mutation("LIGHTFUR")
    :mutation("CLAWS")
    :mutation("ADRENALINE")
    :mutation("CANINE_EARS")
    :mutation("PERSISTENCE_HUNTER")
    :mutation("SNARL")
    :mutation("CARNIVORE")
    :mutation("SMELLY2")
    :mutation("DEFORMED2"))

content.add(content.Enchantment {
    id = "ench_aura_feral_plus",
    has = "HELD",
    condition = "ALWAYS",
    name = content.text("Enhanced Feral Aura"),
    description = content.text("Unleashing the rage within."),
}
    :value("STRENGTH", {
        add_handler = "enchantment_ench_aura_feral_plus_strength_add",
        load_spell_levels = { "druid_feralform_plus" },
    })
    :value("DEXTERITY", {
        add_handler = "enchantment_ench_aura_feral_plus_strength_add",
        load_spell_levels = { "druid_feralform_plus" },
    })
    :value("PERCEPTION", {
        add_handler = "enchantment_ench_aura_feral_plus_perception_add",
        load_spell_levels = { "druid_feralform" },
    })
    :mutation("FUR")
    :mutation("CLAWS_RAT")
    :mutation("ADRENALINE")
    :mutation("FANGS")
    :mutation("CANINE_EARS")
    :mutation("PERSISTENCE_HUNTER")
    :mutation("SNARL")
    :mutation("CARNIVORE")
    :mutation("SMELLY2")
    :mutation("DEFORMED3"))

content.add(content.Enchantment {
    id = "ench_technomancer_far_sight_lens",
    has = "HELD",
    condition = "ALWAYS",
    name = content.text("Enhanced Vision"),
    description = content.text("Looking through your enchanted lens allows you to see farther than ever."),
}
    :value("OVERMAP_SIGHT", {
        add_handler = "enchantment_ench_technomancer_far_sight_lens_overmap_sight_add",
        load_spell_levels = { "technomancer_far_sight", "technomancer_far_sight_plus" },
    }))

local native_random = ccb.services.random
ccb.runtime.handler("stormglove_unarmed", function(ctx)
    return not ctx.character_inputs.armed
end)

ccb.runtime.handler("stormglove_electric_damage", function(ctx)
    local spells = ctx.spell_levels
    local limit = 5 + spells.stormfist + spells.stormfist_plus
    return native_random.native_int(math.min(0, limit), math.max(0, limit))
end)

content.add(content.Enchantment {
    id = "ench_stormglove",
    has = "WORN",
    name = content.text("Stormglove"),
    description = content.text("A coating of lighting on your hand and lower arm."),
    condition_handler = "stormglove_unarmed",
    load_character_inputs = { armed = true },
}:melee_damage("electric", {
    add_handler = "stormglove_electric_damage", load_spell_levels = { "stormfist", "stormfist_plus" },
}))

ccb.runtime.handler("luck_bone_resistance", function()
    return -native_random.native_int(0, 3)
end)
ccb.runtime.handler("luck_bone_defense", function()
    return native_random.native_int(0, 5) * 0.01
end)
ccb.runtime.handler("luck_bone_focus", function()
    return native_random.native_int(0, 5)
end)
ccb.runtime.handler("luck_bone_regeneration", function()
    return native_random.native_int(0, 10) * 0.01
end)

local luck_bone = content.Enchantment {
    id = "ench_luck_bone",
    has = "HELD",
    name = content.text("Luck Bone"),
    description = content.text("The spirits within are giving you their blessing."),
    -- The native maps determine which modifier receives each game RNG draw.
    native_modifier_order = true,
    load_character_inputs = {},
}
    :value("FORCEFIELD", { add_handler = "luck_bone_defense" })
    :value("EVASION", { add_handler = "luck_bone_defense" })
    :value("LEARNING_FOCUS", { add_handler = "luck_bone_focus" })
    :value("PAIN", { add_handler = "luck_bone_resistance" })
    :value("REGEN_HP", { multiply_handler = "luck_bone_regeneration" })
    :value("REGEN_MANA", { multiply_handler = "luck_bone_regeneration" })
    :value("REGEN_STAMINA", { multiply_handler = "luck_bone_regeneration" })
for _, damage in ipairs({ "bash", "cut", "stab", "bullet", "acid", "electric", "heat", "cold", "biological" }) do
    luck_bone:incoming_damage(damage, { add_handler = "luck_bone_resistance" })
end
content.add(luck_bone)
