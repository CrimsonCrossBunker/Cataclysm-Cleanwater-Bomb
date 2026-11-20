local ccb = require("ccb")

ccb.content.define_item {
    id = "oxygen_cylinder",
    name = ccb.content.text("oxygen tank"),
    description = ccb.content.text("A large steel cylinder used for storing pressurized gas.  It is marked with a faded, but legible O2 symbol."),
    category = "container",
    mass = "19050 g",
    volume = "28000 ml",
    length = "92 cm",
    price = "134 USD",
    survival_price = "5 USD",
    accuracy = { grip = "bad", length = "long", surface = "any", balance = "clumsy" },
    materials = { "steel", "plastic" },
    symbol = ";",
    color = "blue",
    pockets = {
        {
            kind = "MAGAZINE",
            airtight = true,
            watertight = true,
            rigid = true,
            ammunition = { oxygen = 300 },
        },
    },
    flags = { "NO_UNLOAD" },
    melee_damage = { bash = 10 },
    magazine = { ammunition = { "oxygen" }, capacity = 300, count = 300 },
}
