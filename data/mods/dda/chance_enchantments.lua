local ccb = require("ccb")
local content = ccb.content

local random = ccb.services.random

-- data/json/mutations/mutations.json
ccb.runtime.handler("chance_enchantment_inline_ench_mucus_secretion2_0_melee_damage_0_add", function(ctx)
    return random.native_float(2, ((ctx.character_inputs.skills["unarmed"] / 2) + 6))
end)

ccb.runtime.handler("chance_enchantment_active_inline_ench_mucus_secretion2_0", function(ctx)
    return (not (ctx.character_inputs.armed) and
        not (ctx.character_inputs.traits["BIONIC_ARM_BASIC_BOTH"]) and
        random.native_probability(1, math.max(((23 - ctx.character_inputs.skills["unarmed"]) - (ctx.character_inputs.stats.dexterity / 2)), 2)))
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_MUCUS_SECRETION2_0",
    condition_handler = "chance_enchantment_active_inline_ench_mucus_secretion2_0",
    load_character_inputs = {
        armed = true,
        skills = { "unarmed" },
        stats = true,
        traits = { "BIONIC_ARM_BASIC_BOTH" }
    },
    native_modifier_order = true,
}
    :melee_damage("acid", {
        add_handler = "chance_enchantment_inline_ench_mucus_secretion2_0_melee_damage_0_add",
        load_skills = {}
    }))
