local ccb = require("ccb")

ccb.content.define_item {
    id = "fcl_atomic_coffeemaker",
    name = ccb.content.plural_text("atomic coffeemaker", "atomic coffeemakers"),
    description = ccb.content.text("This is a Curie-G coffeemaker, by CuppaTech.  It famously uses a radioactive generator to heat water for coffee, reducing the amount of total electricity it consumes.  Consumer safety concerns led to it being banned in the EU as well as many other countries, but don't let that stop you from brewing your morning Joe with the power of the atom™!"),
    mass = "6102 g",
    volume = "1500 ml",
    length = "20 cm",
    price = "300 USD",
    survival_price = "50 USD",
    accuracy = { grip = "bad", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "steel", "plastic" },
    symbol = ";",
    color = "light_gray",
    flags = { "LEAK_DAM", "RADIOACTIVE", "DURABLE_MELEE", "WATER_BREAK", "ALLOWS_REMOTE_USE" },
    qualities = { { id = "BOIL", level = 1 }, { id = "HOTPLATE", level = 1 } },
    pockets = { { capacity = "1 L", mass_limit = "2400 g", watertight = true, rigid = true } },
    melee_damage = { bash = 2 },
    tool = {},
    use_actions = { "HEAT_LIQUID_ITEMS", { kind = "link_up", cable_length = 2, charge_rate = "0 W" } },
}
