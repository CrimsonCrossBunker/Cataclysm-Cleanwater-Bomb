local ccb = require("ccb")
local content = ccb.content

local function item_enchantment(options)
    options.item_instance = true
    options.native_modifier_order = true
    return content.Enchantment(options)
end

-- data/mods/XedraWood/items/ethereal_items.json

content.add(item_enchantment {
    id = "ITEM_ENCH_XedraWood_druid_bramble_spear_item_0", has = "WIELD",
}
    :hit_you({ id = "bramble_spear_slow", self = false }))
