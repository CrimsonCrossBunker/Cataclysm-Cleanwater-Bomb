local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_makeshift_fusion_gun",
    name = ccb.content.plural_text("direct fusion gun", "direct fusion gun"),
    copy_from = "afs_plasma_base",
    looks_like = "plasma_gun",
    description = ccb.content.text("Exhaust from a salvaged starship engine is channeled through a series of magnetic coils and focused into a searing fan of plasma, creating a crude but effective short range weapon that can easily melt through most forms of armor.  Its makeshift nature and lack of proper cooling systems make it prone to overheating and catastrophic failure."),
    mass = "8500 g",
    volume = "6 L",
    length = "45 cm",
    price = "2 kUSD",
    survival_price = "2 kUSD",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            magazine_well = "120 ml",
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "afs_40g_plasma_civ" },
        },
    },
    faults = { { fault = "fault_overheat_explosion" }, { fault = "fault_overheat_venting" } },
    inheritance = {
        add = { flags = { "OVERHEATS" }, firing_effects = { "FUSION_FAN" } },
        remove = { firing_effects = { "PLASMA", "FLAME", "EMP", "EXPLOSIVE_SMALL" } },
    },
    gun = {
        range = 10,
        damage = { { type = "afs_plasma", amount = 10 } },
        modes = {
            { id = "DEFAULT", label = ccb.content.text("standard"), quantity = 3 },
            { id = "AUTO", label = ccb.content.text("unsafe auto-rpm"), rpm = 1500 },
        },
        ammunition = { "afs_shydrogen" },
        dispersion = 200,
        ammo_per_shot = 1,
        overheat_threshold = 30,
        cooling = 5,
        heat_per_shot = 9,
        recoil = 30,
        handling = 20,
        durability = 4,
        loudness = 0,
        reload_time = 1800,
    },
}
