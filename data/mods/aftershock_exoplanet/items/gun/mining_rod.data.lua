local ccb = require("ccb")

ccb.content.define_item {
    id = "exo_rod_launcher",
    name = ccb.content.text("mining rod launcher"),
    symbol = "=",
    color = "yellow",
    description = ccb.content.text("Based on an old TsKBEM design, this is a rail launcher used in mining exploration.  The rod is fired into a rock face and a seismic mapper on the launcher displays ore veins.  Not being designed for combat, it is difficult to use without the augmented strength of an exosuit and the reloading process is quite slow.  The barrel is covered in warning labels indemnifying the manufacturer of any injuries caused by misuse."),
    mass = "7500 g",
    volume = "5 L",
    length = "1500 mm",
    accuracy = -1,
    materials = { "copper", "qt_steel", "superalloy" },
    min_strength = 18,
    pockets = {
        { id = "ammo", kind = "MAGAZINE", rigid = true, ammunition = { metal_rail = 1 } },
        {
            id = "power",
            kind = "MAGAZINE_WELL",
            capacity = "20 L",
            mass_limit = "20 kg",
            magazine_well = "75 ml",
            allowed_items = { "afs_cartridge" },
        },
    },
    melee_damage = { bash = 12 },
    gun = {
        ammunition = { "metal_rail" },
        skill = "rifle",
        range = 60,
        dispersion = 45,
        durability = 8,
        reload_time = 2000,
        clip_size = 1,
        firing_requirements = { DEFAULT = { { pocket = "ammo", count = 1 }, { pocket = "power", count = 100 } } },
    },
}
