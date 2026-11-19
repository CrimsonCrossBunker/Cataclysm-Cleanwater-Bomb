local ccb = require("ccb")

ccb.content.define_item {
    id = "exo_small_carry",
    category = "exosuit",
    name = ccb.content.plural_text("exosuit small load support module (off)", "exosuit small load support modules (off)"),
    description = ccb.content.text("This module increases the exosuit's weight bearing at the cost of increased power consumption."),
    mass = "500 g",
    volume = "500 ml",
    materials = { "plastic", "qt_steel" },
    symbol = "=",
    looks_like = "storage_battery",
    color = "light_gray",
    flags = { "FRAGILE", "CANT_WEAR", "WATERPROOF", "USE_UPS", "EXO_SMALL_GADGET" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = { "battery" } },
    armor = {},
    artifact = { enchantments = { "afs_ench_exo_small_carry" } },
    use_actions = {
        {
            kind = "transform",
            target = "exo_small_carry_on",
            message = ccb.content.text("The %s engages."),
            menu_text = ccb.content.text("Turn on module"),
            need_charges = 5,
            need_charges_message = ccb.content.text("There is not enough charge to activate the module."),
        },
    },
}
