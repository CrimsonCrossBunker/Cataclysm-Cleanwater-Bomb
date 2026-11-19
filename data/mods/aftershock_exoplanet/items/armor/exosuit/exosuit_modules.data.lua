local ccb = require("ccb")

ccb.content.define_item {
    id = "exo_AR_module",
    name = ccb.content.plural_text("exosuit AR research module", "exosuit AR research modules"),
    description = ccb.content.text("An augmented reality module interfaces with the exosuit's HUD, assisting you with research and study."),
    mass = "500 g",
    volume = "250 ml",
    price = "10 kUSD",
    materials = { "lvl4ballisticglass", "qt_steel" },
    symbol = "(",
    color = "yellow",
    flags = { "CANT_WEAR", "EXO_HELMET_GADGET" },
    subtype_order = { "tool", "artifact" },
    tool = {},
    artifact = { enchantments = { "afs_ench_exo_AR_module" } },
    use_actions = {
        {
            kind = "transform",
            target = "exo_AR_module_on",
            message = ccb.content.text("The %s engages."),
            menu_text = ccb.content.text("Turn on module"),
            need_charges = 5,
            need_charges_message = ccb.content.text("There is not enough charge to activate the module."),
        },
    },
}
