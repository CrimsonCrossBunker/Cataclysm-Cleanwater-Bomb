local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "effect_xe_ma_arvore_beneath_falling_tree_weakpoints_bonus",
    name = ccb.content.text("Falling Tree"),
    description = ccb.content.text("Your armor has been reduced."),
    rating = "bad",
}
    :enchantment("INLINE_ENCH_effect_xe_ma_arvore_beneath_falling_tree_weakpoints_bonus_0"))
