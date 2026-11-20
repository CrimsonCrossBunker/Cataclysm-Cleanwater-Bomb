local ccb = require("ccb")

ccb.content.define_item {
    id = "feeding_kit",
    name = ccb.content.plural_text("feeding kit", "feeding kits"),
    description = ccb.content.text("This is a collection of syringes with nozzles, an aerosol sprayer, and a few other attachments.  It seems designed for looking after some kind of creature that wants to stay wet."),
    mass = "85 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "plastic", "steel" },
    symbol = ",",
    color = "red",
    pockets = { { kind = "MAGAZINE", ammunition = { water = 5 }, watertight = true } },
    flags = { "ALLOWS_REMOTE_USE" },
    tool = { charges_per_use = 1 },
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_metal",
            materials = { "alien_liquid" },
            skill = "survival",
            tool_quality = 0,
            cost_scaling = 0.1,
            move_cost = 100,
        },
    },
}
