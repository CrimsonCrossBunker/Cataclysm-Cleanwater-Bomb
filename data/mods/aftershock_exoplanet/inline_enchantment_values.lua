local ccb = require("ccb")
local content = ccb.content

-- mutations/vanilla_overrides.json
ccb.runtime.handler("inline_value_inline_ench_afs_nightvision_0_value_0_add", function(ctx)
    return (ctx.stats.perception * 0.8)
end)

content.add(content.Enchantment {
    id = "INLINE_ENCH_AFS_NIGHTVISION_0",
    native_modifier_order = true,
}
    :value("NIGHT_VIS", { add_handler = "inline_value_inline_ench_afs_nightvision_0_value_0_add", load_skills = {  } }))
