local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_silvergram_pistol",
    copy_from = "gun_base_handgun_semi",
    looks_like = "glock_17",
    name = ccb.content.plural_text("W1011 Silvergram", "W1011 Silvergrams"),
    description = ccb.content.text("A finely sculpted white and silver pistol entrusted to Wraitheon's corporate elite.  It employs advanced targeting and precision guiding capabilities to deliver devastating bursts of guided 10mm microjet darts.  Firing is as expensive as it looks."),
    mass = "780 g",
    volume = "480 ml",
    length = "205 mm",
    price = "750 kUSD",
    materials = { "plastic", "superalloy" },
    variants = {
        {
            id = "silverhawk",
            name = ccb.content.plural_text("W1011 Silverhawk", "W1011 Silverhawks"),
            description = ccb.content.text("A Silvergram smart pistol given a far less conspicuous \"military carbon\" black finish.  Its performance and smart targeting capacities are otherwise identical."),
        },
        {
            id = "lx",
            name = ccb.content.plural_text("W1011 Silvergram", "W1011 Silvergrams"),
            description = ccb.content.text("A finely sculpted white and silver pistol entrusted to Wraitheon's corporate elite.  It employs advanced targeting and precision guiding capabilities to deliver devastating bursts of guided 10mm microjet darts.  Firing is as expensive as it looks."),
        },
    },
    pockets = {
        {
            magazine_well = "103 ml",
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "afs_silvergram_22mag" },
        },
    },
    flags = { "NEVER_JAMS", "MUNDANE", "WONT_TRAIN_MARKSMANSHIP" },
    subtype_order = { "artifact", "gun" },
    artifact = { enchantments = { "ench_smart_gun" } },
    gun = {
        built_in_mods = { "afs_smart_scope" },
        skill = ccb.content.text("smartgun", "gun_type_type"),
        ammunition = { "afs_10mm_smart" },
        dispersion = 0,
        durability = 9,
        blackpowder_tolerance = 0,
        min_cycle_recoil = 570,
        modes = { { id = "DEFAULT", label = ccb.content.text("2 rd."), quantity = 2 } },
        mod_locations = {},
    },
}
