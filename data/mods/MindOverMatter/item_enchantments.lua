local ccb = require("ccb")
local content = ccb.content

local function item_enchantment(options)
    options.item_instance = true
    options.native_modifier_order = true
    return content.Enchantment(options)
end

-- data/mods/MindOverMatter/items/armor/belt.json

content.add(item_enchantment {
    id = "ITEM_ENCH_MindOverMatter_psionic_shield_belt_0",
    has = "WORN",
    condition = "ACTIVE",
    name = content.text("Active Shield Belt"),
    description = content.text("The air around you has a faint shimmer."),
}
    :incoming_damage("bash", { add = -8 })
    :incoming_damage("stab", { add = -20 })
    :incoming_damage("cut", { add = -15 })
    :incoming_damage("bullet", { add = -40 })
    :effect("effect_shield_belt_telekin_protection", 1))

content.add(item_enchantment {
    id = "ITEM_ENCH_MindOverMatter_psionic_fire_shield_belt_0",
    has = "WORN",
    condition = "ACTIVE",
    name = content.text("Active Suppression Belt"),
    description = content.text("The air around you feels cool."),
}
    :value("CLIMATE_CONTROL_CHILL", { add = 1000 })
    :incoming_damage("heat", { multiply = -1 })
    :effect("effect_suppression_belt_fire_protection", 1))

-- data/mods/MindOverMatter/items/armor/head.json

content.add(item_enchantment {
    id = "ITEM_ENCH_MindOverMatter_psionic_anchoring_crown_0", has = "WORN", condition = "ALWAYS",
}
    :effect("effect_psi_dimensionally_anchored", 1))

content.add(item_enchantment {
    id = "ITEM_ENCH_MindOverMatter_psionic_telepathic_dampener_0", has = "WORN", condition = "ALWAYS",
}
    :incoming_damage("psi_telepathic_damage", { multiply = -1 })
    :effect("effect_psi_dimensionally_anchored", 1))

ccb.runtime.handler("item_ench_mindovermatter_psionic_mindsight_glasses_0_vision_0_detect", function(ctx)
    return (((not (ctx.target_inputs.species["PSI_NULL"]) and
        ctx.target_inputs.flags["HAS_MIND"]) or
        (not (ctx.target_inputs.species["PSI_NULL"]) and
        not (ctx.target_inputs.species["ZOMBIE"]) and
        ctx.target_inputs.flags["HUMAN"]) or
        ctx.target_inputs.npc) and
        not (ctx.target_inputs.effects["eff_monster_immune_to_telepathy"]) and
        not (ctx.target_inputs.flags["TEEP_IMMUNE"]))
end)

content.add(item_enchantment {
    id = "ITEM_ENCH_MindOverMatter_psionic_mindsight_glasses_0", has = "WORN", condition = "ACTIVE",
}
    :vision({
        condition_handler = "item_ench_mindovermatter_psionic_mindsight_glasses_0_vision_0_detect",
        target_inputs = {
            effects = { "eff_monster_immune_to_telepathy" },
            flags = { "HAS_MIND", "HUMAN", "TEEP_IMMUNE" },
            npc = true,
            species = { "PSI_NULL", "ZOMBIE" }
        },
        distance = 20,
        descriptions = {
            {
                id = "sense_minds",
                color = "c_white",
                symbol = "?",
                text = content.text("You sense a sapient mind here.")
            }
        }
    }))

-- data/mods/MindOverMatter/items/armor/overrides.json

content.add(item_enchantment {
    id = "ITEM_ENCH_MindOverMatter_dimensional_anchor_0", has = "WORN", condition = "ACTIVE",
}
    :effect("effect_psi_dimensionally_anchored", 1))

content.add(item_enchantment {
    id = "ITEM_ENCH_MindOverMatter_dimensional_anchor_on_0", has = "WORN", condition = "ACTIVE",
}
    :effect("effect_psi_dimensionally_anchored", 1))

content.add(item_enchantment {
    id = "ITEM_ENCH_MindOverMatter_robofac_armor_anchor_0", has = "WORN", condition = "ACTIVE",
}
    :effect("effect_psi_dimensionally_anchored", 1))

content.add(item_enchantment {
    id = "ITEM_ENCH_MindOverMatter_robofac_armor_anchor_on_0", has = "WORN", condition = "ACTIVE",
}
    :effect("effect_psi_dimensionally_anchored", 1))

-- data/mods/MindOverMatter/items/teleporter_start_items.json

content.add(item_enchantment {
    id = "ITEM_ENCH_MindOverMatter_mom_fifth_sun_eagle_tac_helmet_3", condition = "ACTIVE",
}
    :incoming_damage("psi_telepathic_damage", { multiply = -0.33 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_MindOverMatter_mom_fifth_sun_standard_body_armor_0",
    has = "WORN",
    condition = "ACTIVE",
    name = content.text("Ehēcatepantli Barrier"),
    description = content.text("The air around you has a faint shimmer."),
}
    :incoming_damage("bash", { add = -8 })
    :incoming_damage("stab", { add = -20 })
    :incoming_damage("cut", { add = -15 })
    :incoming_damage("bullet", { add = -40 })
    :incoming_damage("electric", { add = -4 })
    :effect("effect_shield_belt_telekin_protection", 1)
    :effect("effect_mom_fall_one_story", 1))

content.add(item_enchantment {
    id = "ITEM_ENCH_MindOverMatter_mom_fifth_sun_standard_body_armor_non_fifth_sun_0",
    has = "WORN",
    condition = "ACTIVE",
    name = content.text("Shimmering air"),
    description = content.text("The air around you has a faint shimmer."),
}
    :incoming_damage("bash", { add = -8 })
    :incoming_damage("stab", { add = -20 })
    :incoming_damage("cut", { add = -15 })
    :incoming_damage("bullet", { add = -40 })
    :effect("effect_shield_belt_telekin_protection", 1)
    :effect("effect_mom_fall_one_story", 1))
