local ccb = require("ccb")
local content = ccb.content

local function item_enchantment(options)
    options.item_instance = true
    options.native_modifier_order = true
    return content.Enchantment(options)
end

-- data/mods/aftershock_exoplanet/items/armor.json

content.add(item_enchantment {
    id = "ITEM_ENCH_aftershock_exoplanet_afs_sentinel_cloak_0",
    has = "WORN",
    condition = "ALWAYS",
    name = content.text("Living Shadow"),
    description = content.text("You are wearing equipment that gives 1 bonus dodge."),
}
    :value("BONUS_DODGE", { add = 1 }))

-- data/mods/aftershock_exoplanet/items/armor/exosuit/exosuit_frame.json

content.add(item_enchantment {
    id = "ITEM_ENCH_aftershock_exoplanet_modular_exosuit_0", condition = "ACTIVE",
}
    :value("STRENGTH", { add = 10 })
    :value("CARRY_WEIGHT", { add = 20000 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_aftershock_exoplanet_modular_exosuit_light_on_0", condition = "ACTIVE",
}
    :value("STRENGTH", { add = 5 }))

-- data/mods/aftershock_exoplanet/items/armor/exosuit/exosuit_modules.json

content.add(item_enchantment {
    id = "ITEM_ENCH_aftershock_exoplanet_exo_climb_0",
    has = "WORN",
    condition = "ALWAYS",
    name = content.text("Climbing Assist"),
    description = content.text("Additional climbing gear allows you to scale walls."),
}
    :mutation("exo_climb_mutation"))

-- data/mods/aftershock_exoplanet/items/tools.json

content.add(item_enchantment {
    id = "ITEM_ENCH_aftershock_exoplanet_afs_motion_sensor_1",
    has = "HELD",
    condition = "ALWAYS",
    name = content.text("Passive Motion Detection"),
    description = content.text("Passively detects movement at 10 second intervals."),
}
    :every(10, { id = "afs_motion_sensor_spell" }))

content.add(item_enchantment {
    id = "ITEM_ENCH_aftershock_exoplanet_vr_laptop_holosuite_0",
    has = "WORN",
    condition = "ALWAYS",
    name = content.text("Augmented Reality"),
    description = content.text("You are wearing equipment that gives 1 additional perception but causes you to see strange things."),
}
    :value("PERCEPTION", { add = 1 })
    :mutation("PSYCHOPATH")
    :mutation("SCHIZOPHRENIC"))

-- data/mods/aftershock_exoplanet/items/weapons.json

content.add(item_enchantment {
    id = "ITEM_ENCH_aftershock_exoplanet_afs_freeze_gauntlet_0",
    has = "WORN",
    condition = "ALWAYS",
    name = content.text("Ice Fists"),
    description = content.text("Strikes from this weapon can freeze targets solid."),
}
    :melee_damage("cold", { add = 17 }))
