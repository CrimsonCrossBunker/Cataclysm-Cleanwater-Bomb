local ccb = require("ccb")
local content = ccb.content

-- effect_potion_fruit.json
content.add(content.Enchantment { id = "enchant_pfruit_thorns", has = "HELD", condition = "ALWAYS" }
    :hit_me({ id = "pfruit_aura_thorns", self = false }))

-- Spells.json
content.add(content.Enchantment { id = "enchant_stormshaper_electric_waves", has = "HELD", condition = "ALWAYS" }
    :hit_me({ id = "electric_waves_damage", self = false, trigger_once_in = 3 })
    :hit_you({ id = "electric_waves_damage", self = false, trigger_once_in = 3 }))

content.add(content.Enchantment { id = "enchant_stormshaper_cloak_of_fog", has = "HELD", emitter = "emit_obscuring_fog", condition = "ALWAYS" })

content.add(content.Enchantment { id = "ench_shape_of_dust", has = "HELD", emitter = "emit_eshaper_dust", condition = "ALWAYS" }
    :value("BONUS_DODGE", { add = 2 }))

-- mutation_enchantments.json
content.add(content.Enchantment { id = "dragon_leg_strength", condition = "ALWAYS" }
    :value("MOVE_COST", { multiply = 0.05 })
    :value("CARRY_WEIGHT", { multiply = 1.1 })
    :value("FOOTSTEP_NOISE", { add = 5 })
    :value("REGEN_STAMINA", { multiply = 1.05 }))

-- bionics.json
content.add(content.Enchantment { id = "ench_bio_sneeze_beam" }
    :value("MAX_MANA", { add = 500 }))

-- enchanted_cloaks.json
content.add(content.Enchantment { id = "ench_fishform", has = "WORN", condition = "ALWAYS" }
    :mutation("WILDSHAPE:FISH")
    :mutation("WAYFARER")
    :mutation("DRUID_SHIFTER_FISH_FORM_TRAITS")
    :mutation("BESTIAL_MIND"))

content.add(content.Enchantment { id = "ench_bearform", has = "WORN", condition = "ALWAYS" }
    :mutation("WILDSHAPE:BEAR")
    :mutation("DRUID_SHIFTER_BEAR_FORM_TRAITS")
    :mutation("BESTIAL_MIND")
    :mutation("BESTIAL_MIND_COMBAT"))

content.add(content.Enchantment { id = "ench_deerform", has = "WORN", condition = "ALWAYS" }
    :mutation("WILDSHAPE:DEER")
    :mutation("DRUID_SHIFTER_DEER_FORM_TRAITS")
    :mutation("BESTIAL_MIND"))

-- enchanted_clothes.json
content.add(content.Enchantment { id = "ench_parabolan_blouse", has = "WORN", condition = "ALWAYS" }
    :value("DEXTERITY", { add = 2 })
    :value("BONUS_DODGE", { add = 3 })
    :value("SOCIAL_LIE", { add = 3 })
    :mutation("MIRROR_DISPLACEMENT"))

-- ethereal_items.json
content.add(content.Enchantment { id = "ench_overcharge_burn_scar" }
    :effect("burn_scar", 1))

-- manatouched.json
content.add(content.Enchantment { id = "ench_mana_siphon_1" }
    :hit_you({ id = "sp_mana_siphon", self = true, trigger_once_in = 5, trigger_message = content.text("You recover some mana.") }))

content.add(content.Enchantment { id = "ench_mana_siphon_2" }
    :hit_you({ id = "sp_mana_siphon", self = true, level = 3, trigger_once_in = 5, trigger_message = content.text("You recover some mana.") }))

content.add(content.Enchantment { id = "ench_mana_siphon_3" }
    :hit_you({ id = "sp_mana_siphon", self = true, level = 6, trigger_once_in = 5, trigger_message = content.text("You recover some mana.") }))

ccb.runtime.handler("enchantment_wizards_eye_detects_target", function(ctx)
    local target = ctx.target_inputs
    return target.flags.MAGIC_USER or (target.character and target.spell_count >= 6)
end)

content.add(content.Enchantment {
    id = "ench_bio_see_wizards_eye", has = "WORN", condition = "ACTIVE",
}:vision {
    distance = 22,
    condition_handler = "enchantment_wizards_eye_detects_target",
    target_inputs = { flags = { "MAGIC_USER" }, character = true, spell_count = true },
    descriptions = { {
        id = "fae_sense", symbol = "?", color = "cyan",
        text = content.text("You see the ley lines of a wielder of magic."),
    } },
})
