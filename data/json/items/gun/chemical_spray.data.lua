local ccb = require("ccb")

ccb.content.define_item {
    id = "chemical_thrower",
    looks_like = "m79",
    name = ccb.content.text("makeshift chemical thrower"),
    description = ccb.content.text("A bulky, self-made chemical sprayer with an internal conversion mechanism that allows all sorts of chemicals to be dispersed to your surroundings."),
    mass = "4588 g",
    volume = "4250 ml",
    length = "110 cm",
    price = "100 USD",
    survival_price = "10 USD",
    accuracy = -1,
    materials = { "steel", "plastic" },
    symbol = "(",
    color = "light_gray",
    flags = { "NEVER_JAMS", "NON_FOULING" },
    pockets = {
        {
            magazine_well = "2 L",
            kind = "MAGAZINE_WELL",
            allowed_items = { "pressurized_tank_chem" },
        },
    },
    melee_damage = { bash = 9 },
    gun = {
        reload_noise = ccb.content.text("slosh."),
        reload_noise_volume = 10,
        ammo_per_shot = 50,
        skill = "launcher",
        ammunition = { "chemical_spray" },
        dispersion = 300,
        durability = 6,
        mod_locations = { { id = "sights mount", count = 1 }, { id = "sling", count = 1 } },
    },
}
