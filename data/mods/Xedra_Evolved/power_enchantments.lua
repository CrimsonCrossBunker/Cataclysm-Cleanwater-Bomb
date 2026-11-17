local ccb = require("ccb")
local content = ccb.content

local progression = require("enchantment_progression")

-- mutations/mutations.json
ccb.runtime.handler("power_enchantment_inline_ench_vampire_weakness_cold_blooded_0_value_0_add", function(ctx)
    return math.min((ctx.character_inputs.environment.temperature_fahrenheit - 65) * 2, 0)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_VAMPIRE_WEAKNESS_COLD_BLOODED_0",
    load_character_inputs = { environment = { temperature_fahrenheit = true } },
    native_modifier_order = true,
}
    :value("SPEED", {
        add_handler = "power_enchantment_inline_ench_vampire_weakness_cold_blooded_0_value_0_add",
        load_skills = {}
    }))

-- mutations/werewolf_traits.json
ccb.runtime.handler("power_enchantment_inline_ench_werewolf_mana_trait_0_value_0_add", function(ctx)
    return (((-200) + (ctx.character_inputs.stats.intelligence * (-100))) + math.min((((((((ctx.character_inputs.stats.strength * 30) + (ctx.character_inputs.stats.dexterity * 15)) + (progression.werewolf_tier_one(ctx) * 10)) + (progression.werewolf_tier_two(ctx) * 20)) + (progression.werewolf_tier_three(ctx) * 30)) + (progression.werewolf_tier_four(ctx) * 40)) + (progression.werewolf_tier_five(ctx) * 50)), 3000))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_WEREWOLF_MANA_TRAIT_0",
    load_character_inputs = {
        stats = true,
        traits = {
            "WEREWOLF_BATTLE_FURY",
            "WEREWOLF_CAMOUFLAGE_COAT",
            "WEREWOLF_CLIMB_IN_WOLF_FORM",
            "WEREWOLF_CLOSE_TEAR_IN_REALITY",
            "WEREWOLF_EXTRA_WEAKPOINT_HITS",
            "WEREWOLF_FAR_JUMP",
            "WEREWOLF_FRIEND_TO_ANIMALS",
            "WEREWOLF_ILLUMINATE_TARGET",
            "WEREWOLF_MANA_BONUS_AFTER_KILL",
            "WEREWOLF_MOON_ARMOR",
            "WEREWOLF_NO_SCENT",
            "WEREWOLF_PARTIAL_SHIFT",
            "WEREWOLF_SENSE_SPIRITS_AND_ALIENS",
            "WEREWOLF_SILVER_CLAWS",
            "WEREWOLF_SMASH_TERRAIN",
            "WEREWOLF_SMELL_NEARBY_ENEMIES",
            "WEREWOLF_STRENGTH_BONUS",
            "WEREWOLF_STUN_MACHINE",
            "WEREWOLF_SUMMON_FOG",
            "WEREWOLF_SUMMON_SHADOW_PACK",
            "WEREWOLF_SUPER_FAST_REGENERATION",
            "WEREWOLF_TRANSFORM_INTO_PRIMAL_FORM",
            "WEREWOLF_WALK_THROUGH_WALLS"
        }
    },
    native_modifier_order = true,
}
    :value("MAX_MANA", {
        add_handler = "power_enchantment_inline_ench_werewolf_mana_trait_0_value_0_add",
        load_skills = {}
    }))
