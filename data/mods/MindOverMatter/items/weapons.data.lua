local ccb = require("ccb")

ccb.content.define_item {
    id = "mom_exodii_stungun_pistol",
    looks_like = "v29",
    name = ccb.content.text("Onšut §A"),
    description = ccb.content.text("The world where this crowd-control weapon came from made great use of psionic technology, but it wasn't enough to save them from their own Cataclysm.  The Exodii left most devices they found in the ruins, assuming that they would be too difficult to maintain, but took some of the simpler weapons with them.  The Onšut §A overloads the target's mind, trapping them in a hallucinatory waking dream.  This renders them almost completely harmless while in effect, with the unfortunate disadvantage of not affecting zombies."),
    melee_damage = { bash = 5 },
    mass = "566 g",
    volume = "79 ml",
    length = "158 mm",
    symbol = "(",
    color = "cyan",
    materials = { "nether_crystal", "steel", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            magazine_well = "25 ml",
            allowed_items = { "exodii_exodii_stungun_mag" },
        },
    },
    flags = { "NEVER_JAMS", "NON_FOULING", "NEEDS_NO_LUBE", "NO_REPAIR" },
    gun = {
        reload_noise_volume = 5,
        skill = "pistol",
        damage = { type = "psi_telepathic_damage", amount = 3 },
        dispersion = 180,
        durability = 8,
        loudness = 7,
        reload_time = 200,
        range = 20,
        effects = { "EXODII_NEURAL_STUNGUN" },
        ammunition = { "psionic_charge_power" },
    },
}
