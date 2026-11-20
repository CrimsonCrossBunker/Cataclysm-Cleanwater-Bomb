local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "horse_armor",
    abstract = true,
    name = ccb.content.text_without_extraction("horse armor"),
    symbol = "[",
    length = "60 cm",
    flags = { "IS_PET_ARMOR" },
    subtype_order = { "pet_armor", "pet_equipment" },
    pet_armor = { min_pet_volume = "380 L", max_pet_volume = "1000 L", body_type = "horse" },
    pet_equipment = { slots = { "armor" }, passive_effects = { "monster_armor" } },
}
