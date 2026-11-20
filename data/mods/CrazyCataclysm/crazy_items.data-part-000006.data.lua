local ccb = require("ccb")

ccb.content.define_item {
    id = "battletorch_lit",
    category = "weapons",
    name = ccb.content.plural_text("Louisville Slaughterer", "Louisville Slaughterers"),
    description = ccb.content.text("This is a sturdy wood bat, wrapped in gasoline-soaked rags and flame-resistant Nomex fabric.  It is burning brightly, and makes it much easier to see the baselines at night games (It also makes the umpire FAR more likely to call a ball instead of a strike)."),
    mass = "1485 g",
    volume = "2 L",
    price = "160 USD",
    accuracy = { grip = "weapon", length = "long", surface = "any", balance = "good" },
    materials = { "wood", "nomex" },
    symbol = "/",
    color = "red",
    revert_to = "battletorch_done",
    techniques = { "WBLOCK_1" },
    light = 310,
    flags = {
        "FIRE",
        "CHARGEDIM",
        "FLAMING",
        "DURABLE_MELEE",
        "TRADER_AVOID",
        "WATER_EXTINGUISH",
        "SPAWN_ACTIVE",
    },
    melee_damage = { bash = 18 },
    tool = { initial_charges = 25, max_charges = 25, turns_per_charge = 20 },
    use_actions = {
        { kind = "firestarter", moves = 30 },
        {
            kind = "transform",
            target = "battletorch",
            message = ccb.content.text("The Louisville Slaughterer is extinguished."),
            menu_text = ccb.content.text("Extinguish"),
        },
    },
}
