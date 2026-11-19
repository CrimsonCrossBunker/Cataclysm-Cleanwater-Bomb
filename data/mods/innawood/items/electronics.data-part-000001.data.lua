local ccb = require("ccb")

ccb.content.define_item {
    id = "magazine_battery_mod",
    copy_from = "mod_battery",
    category = "spare_parts",
    name = ccb.content.plural_text("battery compartment mod", "battery compartment mods"),
    description = ccb.content.text("A battery compartment mod that allows using vehicle batteries and small storage batteries in regular tools."),
    color = "light_green",
    toolmod = {
        compatible_ammo = { "battery" },
        added_pockets = {
            {
                kind = "MAGAZINE_WELL",
                allowed_items = { "small_storage_battery", "battery_car", "battery_motorbike", "battery_car_clay" },
            },
        },
        magazine_adapters = {
            {
                ammo_type = "battery",
                magazines = { "small_storage_battery", "battery_car", "battery_motorbike", "battery_car_clay" },
            },
        },
    },
}
