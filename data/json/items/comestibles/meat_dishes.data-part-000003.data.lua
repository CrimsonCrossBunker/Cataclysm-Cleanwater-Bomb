local ccb = require("ccb")

ccb.content.define_item {
    id = "dry_meat_tainted",
    name = ccb.content.plural_text("dehydrated tainted meat", "dehydrated tainted meat"),
    copy_from = "meat_tainted",
    mass = "85 g",
    color = "red",
    description = ccb.content.text("Pieces of poisonous meat that have been dried to prevent them from rotting away.  They're still unsafe to eat."),
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "flesh" },
    volume = "125 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "360 days",
        quench = -3,
        fun = -7,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
    use_actions = { "POISON" },
}
