local ccb = require("ccb")

ccb.content.define_item {
    id = "22_blank",
    copy_from = "22_lr",
    name = ccb.content.plural_text(".22 blank", ".22 blank"),
    description = ccb.content.text("A powder load .22 blank used for powder-actuated tools."),
    ascii_picture = "22_blank",
    price = "1 USD",
    survival_price = "10 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    stack_size = 150,
    inheritance = { add = { projectile_effects = { "NOGIB" } } },
    ammunition = {
        count = 100,
        recoil = 39,
        range = 0,
        casing = "22_casing",
        damage = { type = "bash", amount = 1 },
        type = "powder_blank",
    },
}
