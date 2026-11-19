local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_launcher_salvaged",
    copy_from = "m320",
    looks_like = "m79",
    name = ccb.content.text("vatforged grenade launcher"),
    description = ccb.content.text("A crude grenade launcher that's been either ripped from a broken robot or built using a hacked template.  The remnants of a loading rack allow it to hold three 40mm grenades at once."),
    price = "300 USD",
    survival_price = "300 USD",
    variants = {},
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["40x46mm"] = 3 } } },
    melee_damage = { bash = 6 },
    inheritance = { add = { flags = { "RELOAD_ONE" } } },
    gun = { clip_size = 3, reload_time = 200 },
}
