local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_marsec_t72_shotgun",
    copy_from = "underbarrel_base",
    name = ccb.content.plural_text("MarSec. T72 shotgun", "MarSec. T72 shotguns"),
    description = ccb.content.text("The single round 00 bore barrel built at the center of the T72 revolver.  Can function as a backup in case the power pack of the main weapon is depleted."),
    volume = "250 ml",
    integral_volume = "0 ml",
    materials = { "steel" },
    symbol = ":",
    color = "light_red",
    flags = { "RELOAD_ONE", "NO_UNLOAD", "IRREMOVABLE" },
    pockets = { { kind = "MAGAZINE", ammunition = { shot = 1 } } },
    subtype_order = { "gun", "gunmod" },
    gun = {
        ammunition = { "shot" },
        skill = ccb.content.text("shotgun", "gun_type_type"),
        range = -6,
        dispersion = 600,
        durability = 10,
        reload_time = 150,
        clip_size = 1,
    },
    gunmod = {
        install_time = "0 s",
        location = ccb.content.text("underbarrel"),
        targets = { ccb.content.text("pistol", "gun_type_type") },
    },
}
