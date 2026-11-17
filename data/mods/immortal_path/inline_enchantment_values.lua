local ccb = require("ccb")
local content = ccb.content

-- mutations/cultivation_traits.json
ccb.runtime.handler("inline_value_inline_ench_immortal_path_qi_cultivator_0_custom_0_add", function(ctx)
    return (math.max(0, ctx.spell_levels["realm_qi_refining"]) * 20)
end)

ccb.runtime.handler("inline_value_inline_ench_immortal_path_qi_cultivator_0_custom_1_add", function(ctx)
    return (math.max(0, ctx.spell_levels["realm_qi_refining"]) * 8)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_immortal_path_qi_cultivator_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :custom("qi_max", { add_handler = "inline_value_inline_ench_immortal_path_qi_cultivator_0_custom_0_add", load_skills = {  }, load_spell_levels = { "realm_qi_refining" } })
    :custom("qi_power", { add_handler = "inline_value_inline_ench_immortal_path_qi_cultivator_0_custom_1_add", load_skills = {  }, load_spell_levels = { "realm_qi_refining" } }))
