local ccb = require("ccb")
local content = ccb.content

local function item_enchantment(options)
    options.item_instance = true
    options.native_modifier_order = true
    return content.Enchantment(options)
end

-- data/mods/MindOverMatter/mod_interactions/magiclysm/item_overrides.json

content.add(item_enchantment {
    id = "ITEM_ENCH_MindOverMatter_thought_shield_item_0", has = "WORN", condition = "ALWAYS",
}
    :effect("effect_item_mind_protection", 1))

content.add(item_enchantment {
    id = "ITEM_ENCH_MindOverMatter_thought_shield_plus_item_0", has = "WORN", condition = "ALWAYS",
}
    :effect("effect_item_mind_protection", 1))
