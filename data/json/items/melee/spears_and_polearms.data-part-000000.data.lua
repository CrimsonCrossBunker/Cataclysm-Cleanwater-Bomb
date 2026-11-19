local ccb = require("ccb")

ccb.content.define_item {
    id = "spear_knife",
    name = ccb.content.plural_text("simple knife spear", "simple knife spears"),
    copy_from = "spear_knife_superior",
    description = ccb.content.text("A flimsy pole made of wood with a knife bound to the end.  It's long enough to slice from a distance, but the knife isn't that well attached.  You could take a bit more time to carefully split the shaft and attach the knife blade more permanently."),
    price = "7 USD",
    survival_price = "1 USD 50 cent",
    qualities = { { id = "CUT", level = 1 }, { id = "COOK", level = 1 }, { id = "BUTCHER", level = -42 } },
    inheritance = { add = { flags = { "FRAGILE_MELEE" } } },
    tool = {},
    use_actions = { "HEAT_SOLID_ITEMS" },
}
