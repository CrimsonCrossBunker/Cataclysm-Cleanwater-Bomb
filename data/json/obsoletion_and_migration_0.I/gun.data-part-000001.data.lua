local ccb = require("ccb")

ccb.content.define_item {
    id = "ksg25_aux_shotgun",
    copy_from = "underbarrel_base",
    name = ccb.content.plural_text("KSG-25 second magazine", "KSG-25 second magazines"),
    description = ccb.content.text("The integrated second tube magazine of the Kel-Tec KSG-25, which holds 12 shots.  It's irremovable."),
    mass = "1550 g",
    volume = "1750 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "steel" },
    symbol = ":",
    color = "light_red",
    flags = { "RELOAD_ONE", "IRREMOVABLE" },
    pockets = { { kind = "MAGAZINE", ammunition = { shot = 12 } } },
    subtype_order = { "gun", "gunmod" },
    gun = {
        barrel_length = "775 mm",
        ammunition = { "shot" },
        skill = ccb.content.text("shotgun", "gun_type_type"),
        damage = { type = "bullet", amount = 5 },
        dispersion = 425,
        durability = 7,
        clip_size = 12,
        reload_time = 120,
    },
    gunmod = {
        install_time = "0 s",
        location = ccb.content.text("underbarrel"),
        targets = { ccb.content.text("shotgun", "gun_type_type") },
    },
}
