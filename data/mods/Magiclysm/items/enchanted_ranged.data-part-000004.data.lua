local ccb = require("ccb")

-- based on a light composite bow.  The actual enchantments are 50% increased range and higher damage and durability, the relic_data is just to make it purple.
ccb.content.define_item {
    id = "bow_of_elvenkind",
    looks_like = "longbow",
    symbol = "(",
    color = "yellow",
    name = ccb.content.plural_text("bow of elvenkind", "bows of elvenkind"),
    description = ccb.content.text("One of the traditional items of the ancient elven warrior societies, this bow is enchanted to fire further, hit harder, and last longer than any normal wooden bow of its design could.  Before the Cataclysm they were still made in small quantities for ceremonial purposes but no longer saw battlefield use, since the special forces of Tokoyo, Hy-Brasil, Alfheim, and the other elven nations long ago switched to using firearms."),
    price = "420 USD",
    materials = { "wood" },
    flags = {
        "FIRE_TWOHAND", "RELOAD_AND_SHOOT", "PRIMITIVE_RANGED_WEAPON", "BELTED", "WATER_FRIENDLY",
        "DURABLE_MELEE", "SHEATH_BOW", "WATERPROOF_GUN", "NEVER_JAMS",
    },
    min_strength = 8,
    mass = "400 g",
    volume = "1500 ml",
    length = "183 cm",
    survival_price = "300 USD",
    pockets = { { kind = "MAGAZINE", ammunition = { arrow = 1 }, open_container = true } },
    melee_damage = { bash = 12 },
    subtype_order = { "armor", "artifact", "gun" },
    armor = {
        portions = {
            {
                materials = { { id = "wood", coverage = 100, thickness = 1 } },
                encumbrance = 14,
                coverage = 10,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_bow_of_elvenkind_0" } },
    gun = {
        skill = "archery",
        ammunition = { "arrow" },
        reload_noise_volume = 3,
        loudness = 6,
        damage = { type = "stab", amount = 8 },
        range = 18,
        dispersion = 950,
        sight_dispersion = 3000,
        durability = 8,
        clip_size = 1,
        mod_locations = {
            { id = ccb.content.text("dampening"), count = 1 },
            { id = ccb.content.text("arrow rest"), count = 1 },
        },
        reload_time = 50,
    },
}
