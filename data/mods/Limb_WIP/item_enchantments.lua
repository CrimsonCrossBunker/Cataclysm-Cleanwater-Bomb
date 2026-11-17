local ccb = require("ccb")
local content = ccb.content

local function item_enchantment(options)
    options.item_instance = true
    options.native_modifier_order = true
    return content.Enchantment(options)
end

-- data/mods/Limb_WIP/armor/arm_prosthetics.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Limb_WIP_right_arm_prosthetic_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("RIGHT_PROSTHETIC_ARM"))

content.add(item_enchantment {
    id = "ITEM_ENCH_Limb_WIP_left_arm_prosthetic_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("LEFT_PROSTHETIC_ARM"))

content.add(item_enchantment {
    id = "ITEM_ENCH_Limb_WIP_right_arm_neuroprosthetic_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("RIGHT_NEUROPROSTHETIC_ARM"))

content.add(item_enchantment {
    id = "ITEM_ENCH_Limb_WIP_left_arm_neuroprosthetic_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("LEFT_NEUROPROSTHETIC_ARM"))

content.add(item_enchantment {
    id = "ITEM_ENCH_Limb_WIP_right_arm_prosthetic_wood_old_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("RIGHT_COSMETIC_PROSTHETIC_ARM"))

content.add(item_enchantment {
    id = "ITEM_ENCH_Limb_WIP_left_arm_prosthetic_wood_old_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("LEFT_COSMETIC_PROSTHETIC_ARM"))

content.add(item_enchantment {
    id = "ITEM_ENCH_Limb_WIP_right_arm_prosthetic_steel_old_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("RIGHT_PROSTHETIC_ARM"))

content.add(item_enchantment {
    id = "ITEM_ENCH_Limb_WIP_left_arm_prosthetic_steel_old_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("LEFT_PROSTHETIC_ARM"))

-- data/mods/Limb_WIP/armor/legs_prosthetics.json

content.add(item_enchantment {
    id = "ITEM_ENCH_Limb_WIP_right_leg_prosthetic_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("RIGHT_PROSTHETIC_LEG"))

content.add(item_enchantment {
    id = "ITEM_ENCH_Limb_WIP_left_leg_prosthetic_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("LEFT_PROSTHETIC_LEG"))

content.add(item_enchantment {
    id = "ITEM_ENCH_Limb_WIP_right_peg_leg_old_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("RIGHT_PEG_LEG"))

content.add(item_enchantment {
    id = "ITEM_ENCH_Limb_WIP_left_peg_leg_old_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("LEFT_PEG_LEG"))

content.add(item_enchantment {
    id = "ITEM_ENCH_Limb_WIP_right_leg_prosthetic_steel_old_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("RIGHT_PROSTHETIC_LEG"))

content.add(item_enchantment {
    id = "ITEM_ENCH_Limb_WIP_left_leg_prosthetic_steel_old_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("LEFT_PROSTHETIC_LEG"))
