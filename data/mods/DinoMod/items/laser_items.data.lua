local ccb = require("ccb")

ccb.content.define_item {
    id = "laser_rifle_dino2",
    symbol = "(",
    color = "yellow",
    looks_like = "modular_ar15",
    name = ccb.content.text("2-DINO-A7 laser rifle"),
    description = ccb.content.text("A state-of-the-art laser rifle developed by the R&D outfit \"Aerial Labs\".  Initial performance rivaled Rivtech's finest, with rumors flying about corporate skulduggery.  Fitted with a large internal plutonium cell for CyberDinos."),
    flags = {
        "NEVER_JAMS", "NON_FOULING", "NEEDS_NO_LUBE", "UNRECOVERABLE", "TRADER_AVOID", "WATERPROOF_GUN",
        "NO_SALVAGE",
    },
    mass = "540 g",
    volume = "2500 ml",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "1 L",
            mass_limit = "1 kg",
            allowed_items = { "light_minus_battery_cell" },
        },
    },
    melee_damage = { bash = 12 },
    gun = {
        skill = "rifle",
        reload_noise_volume = 3,
        loudness = 6,
        damage = { type = "bullet", amount = 24, penetration = 6 },
        range = 30,
        clip_size = 1,
        dispersion = 1200,
        durability = 6,
        effects = { "LASER" },
        ammunition = { "battery" },
        ammo_per_shot = 0,
        energy_drain = "1 kJ",
    },
}
