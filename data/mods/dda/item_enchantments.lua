local ccb = require("ccb")
local content = ccb.content

local function item_enchantment(options)
    options.item_instance = true
    options.native_modifier_order = true
    return content.Enchantment(options)
end

-- data/json/artifact/premade_artifacts.json

content.add(item_enchantment {
    id = "ITEM_ENCH_dda_architect_cube_0",
}
    :mutation("DEBUG_CLAIRVOYANCE"))

content.add(item_enchantment {
    id = "ITEM_ENCH_dda_DEBUG_stabbing_0", has = "WIELD", condition = "ALWAYS",
}
    :skill("stabbing", { add = 10 }))

-- data/json/items/armor/bespoke_armor/custom_bodysuits.json

content.add(item_enchantment {
    id = "ITEM_ENCH_dda_armor_nomad_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("well_distributed"))

content.add(item_enchantment {
    id = "ITEM_ENCH_dda_armor_nomad_advanced_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("well_distributed"))

-- data/json/items/armor/suits_protection.json

content.add(item_enchantment {
    id = "ITEM_ENCH_dda_armor_nomad_plate_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("well_distributed"))

content.add(item_enchantment {
    id = "ITEM_ENCH_dda_armor_nomad_lightplate_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("well_distributed"))

content.add(item_enchantment {
    id = "ITEM_ENCH_dda_armor_nomad_heavyplate_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("well_distributed"))

content.add(item_enchantment {
    id = "ITEM_ENCH_dda_armor_nomad_chainmail_0", has = "WORN", condition = "ALWAYS",
}
    :mutation("well_distributed"))

-- data/json/items/melee/swords_and_blades.json

content.add(item_enchantment {
    id = "ITEM_ENCH_dda_jade_nagamaki_0", has = "WIELD",
}
    :value("MELEE_STAMINA_CONSUMPTION", { multiply = -0.67 }))

-- data/json/items/relics/extradimensional_artifacts.json

content.add(item_enchantment {
    id = "ITEM_ENCH_dda_string_dimension_hypercube_0", has = "HELD", condition = "ALWAYS",
}
    :value("ARTIFACT_RESONANCE", { add = 2000 }))

-- data/json/items/relics/highland_artifacts.json

content.add(item_enchantment {
    id = "ITEM_ENCH_dda_coin_highlands_0", condition = "ALWAYS",
}
    :value("ARTIFACT_RESONANCE", { add = 5 }))

-- data/json/items/relics/highland_censer.json

content.add(item_enchantment {
    id = "ITEM_ENCH_dda_highland_censer_0", condition = "ALWAYS",
}
    :value("ARTIFACT_RESONANCE", { add = 200 }))

-- data/json/items/tool_armor.json

content.add(item_enchantment {
    id = "ITEM_ENCH_dda_utility_exoskeleton_off_0", condition = "ACTIVE",
}
    :value("CARRY_WEIGHT", { add = 215000 }))

content.add(item_enchantment {
    id = "ITEM_ENCH_dda_ice_utility_exoskeleton_off_0", condition = "ACTIVE",
}
    :value("CARRY_WEIGHT", { add = 190000 }))
