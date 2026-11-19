local ccb = require("ccb")

ccb.content.define_item {
    id = "mirror_march_estoc",
    symbol = "/",
    color = "light_gray",
    name = ccb.content.plural_text("mirrored estoc", "mirrored estocs"),
    description = ccb.content.text("A thin piercing sword no wider than two fingers side by side, it's mirrored surface reflects the world back at it's wielders opponents and is difficult to see to parry.  You've never felt a sword like this before."),
    price = "1 kUSD 350 USD",
    survival_price = "500 USD",
    materials = { "moon_tears" },
    techniques = { "WBLOCK_2", "PRECISE" },
    flags = { "DURABLE_MELEE", "SHEATH_SWORD" },
    weapon_categories = { "LONG_SWORDS", "FENCING_WEAPONRY" },
    mass = "1214 g",
    volume = "2750 ml",
    length = "130 cm",
    accuracy = { grip = "weapon", length = "long", surface = "line", balance = "good" },
    category = "weapons",
    qualities = { { id = "CUT", level = 1 }, { id = "BUTCHER", level = 8 } },
    melee_damage = { bash = 8, stab = 42 },
}
