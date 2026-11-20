local ccb = require("ccb")

ccb.content.define_item {
    id = "stick",
    symbol = "/",
    color = "brown",
    name = ccb.content.plural_text("straight stick", "straight sticks"),
    description = ccb.content.text("A respectable length of wood, just big enough to wrap your hand around.  Relatively straight and makes a decent melee weapon."),
    materials = { "wood" },
    techniques = { "WBLOCK_1", "MOUNTED_CHARGE" },
    flags = { "TRADER_AVOID", "FIREWOOD" },
    weapon_categories = { "BATONS" },
    mass = "1500 g",
    volume = "2500 ml",
    length = "130 cm",
    accuracy = { grip = "solid", length = "long", surface = "any", balance = "neutral" },
    category = "spare_parts",
    melee_damage = { bash = 14 },
    stackable = true,
    mounted_charge = { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 },
}
