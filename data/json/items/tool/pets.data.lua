local ccb = require("ccb")

ccb.content.define_item {
    id = "livestock_scale",
    name = "livestock scale",
    description = "A giant electronic scale with a rubber mat meant for weighing a single horse, cow, or other large animal.  You could also weigh yourself with it.",
    symbol = "_",
    color = "light_gray",
    looks_like = "tr_rollmat",
    mass = "52800 g",
    volume = "40 L",
    length = "196 cm",
    price = "12 kUSD",
    survival_price = "50 cent",
    flags = { "ALLOWS_REMOTE_USE" },
    materials = { "steel", "rubber" },
    melee_damage = { bash = 16 },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            default_magazine = "medium_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
        },
    },
    accuracy = { grip = "bad", length = "long", surface = "any", balance = "clumsy" },
    use_actions = {
        { kind = "weigh_self", max_weight = "2300 kg" },
    },
    tool = {
        charges_per_use = 1,
        ammo_types = { "battery" },
    },
}
