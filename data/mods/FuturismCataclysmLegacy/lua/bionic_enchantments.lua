local ccb = require("ccb")
local content = ccb.content

-- Definition IDs keep bionic enchantments independent of the display language.

-- data/mods/FuturismCataclysmLegacy/bionics.json

content.add(content.Enchantment {
    id = "BIONIC_ENCH_fcl_bio_linguistic_coprocessor_0", condition = "ALWAYS",
    native_modifier_order = true,
}
    :value("READING_SPEED_MULTIPLIER", { multiply = -0.15 }))

content.add(content.Enchantment {
    id = "BIONIC_ENCH_fcl_bio_blood_brain_0",
    native_modifier_order = true,
}
    :value("INTELLIGENCE", { add = 4 })
    :value("PERCEPTION", { add = 4 })
    :value("DEXTERITY", { add = 4 })
    :value("PAIN", { multiply = -0.33 })
    :value("PAIN_PENALTY_MOD_INT", { add = -4 }))
