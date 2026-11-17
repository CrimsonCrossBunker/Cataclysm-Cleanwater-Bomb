local ccb = require("ccb")
local content = ccb.content

local function item_enchantment(options)
    options.item_instance = true
    options.native_modifier_order = true
    return content.Enchantment(options)
end

-- data/mods/BombasticPerks/perkdata/safety_squint.json

content.add(item_enchantment {
    id = "ITEM_ENCH_BombasticPerks_perk_safety_squint_integrated_goggles_0", has = "WORN", condition = "ALWAYS",
}
    :effect("effect_perk_safety_squint_reduced_vision", 1))
