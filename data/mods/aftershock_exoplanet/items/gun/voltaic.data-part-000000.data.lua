local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_electro_anomaly_rifle",
    copy_from = "laser_rifle",
    name = ccb.content.text("R-PROTON ENR"),
    description = ccb.content.text("Within the solid barrel of the Raaz PROTON, an electrical anomaly is carefully duplicated through magnetic stimulation and projected outwards.  Freed from containment, the anomaly will temporarily settle in the physical world and quickly emit its stored electrical charge before dissipating."),
    price = "200 kUSD",
    survival_price = "200 kUSD",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            magazine_well = "75 ml",
            allowed_items = { "afs_voltaic_cartridge" },
        },
    },
    flags = { "NEVER_JAMS", "NON_FOULING", "NEEDS_NO_LUBE" },
    gun = {
        ammunition = { "battery" },
        ammo_per_shot = 0,
        energy_drain = "50 kJ",
        modes = { { id = "DEFAULT", label = ccb.content.text("pulse"), quantity = 1 } },
        damage = { { type = "electric", amount = 10 }, { type = "pure", amount = 25 } },
        effects = { "ELECTRO_ANOMALY" },
    },
}
