local ccb = require("ccb")
local content = ccb.content

-- Definition IDs keep bionic enchantments independent of the display language.

-- data/mods/MindOverMatter/bionics.json

content.add(content.Enchantment {
    id = "BIONIC_ENCH_bio_cameleoflage_fifth_sun_0", condition = "ACTIVE",
    native_modifier_order = true,
}
    :value("STEALTH_MODIFIER", { add = 50 }))
