local ccb = require("ccb")
local content = ccb.content

-- effects/effects_monster.json
ccb.runtime.handler("body_enchantment_inline_ench_effect_whispering_amalgamation_whispers_0_skill_0_add", function(ctx)
    local known = ctx.character_inputs.known_proficiencies
    return -3 + (known.prof_concentration_basic and 1 or 0)
        + (known.prof_concentration_intermediate and 1 or 0)
        + (known.prof_concentration_master and 1 or 0)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_effect_whispering_amalgamation_whispers_0",
    load_character_inputs = {
        known_proficiencies = {
            "prof_concentration_basic",
            "prof_concentration_intermediate",
            "prof_concentration_master"
        }
    },
    native_modifier_order = true,
}
    :skill("metaphysics", {
        add_handler = "body_enchantment_inline_ench_effect_whispering_amalgamation_whispers_0_skill_0_add",
        load_skills = {}
    }))
