local ccb = require("ccb")

ccb.content.define_item {
    id = "battletorch",
    category = "weapons",
    name = ccb.content.plural_text("Louisville Slaughterer", "Louisville Slaughterers"),
    description = ccb.content.text("This is sturdy wood bat, wrapped in gasoline-soaked rags and flame-resistant Nomex fabric.  Light it, and the ball game will REALLY heat up.  You'll need a lighter or matches to light it."),
    mass = "1485 g",
    volume = "2 L",
    price = "160 USD",
    accuracy = { grip = "weapon", length = "long", surface = "any", balance = "good" },
    materials = { "wood", "nomex" },
    symbol = "/",
    color = "brown",
    techniques = { "WBLOCK_1" },
    flags = { "DURABLE_MELEE" },
    melee_damage = { bash = 18 },
    tool = { initial_charges = 25, max_charges = 25, charges_per_use = 1 },
    use_actions = {
        {
            kind = "transform",
            target = "battletorch_lit",
            message = ccb.content.text("You light the Louisville Slaughterer."),
            need_fire = 1,
            menu_text = ccb.content.text("Light", "verb"),
        },
    },
}
