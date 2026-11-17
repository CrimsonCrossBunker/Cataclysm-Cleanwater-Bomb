local ccb = require("ccb")
local content = ccb.content

local function item_enchantment(options)
    options.item_instance = true
    options.native_modifier_order = true
    return content.Enchantment(options)
end

-- data/mods/Isolation-Protocol/items/unique_items.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Isolation_Protocol_iso_lewis_gun_0", has = "WIELD",
}
    :value("ATTACK_SPEED", { multiply = -0.67 })
    :value("MELEE_STAMINA_CONSUMPTION", { multiply = -0.8 }))
