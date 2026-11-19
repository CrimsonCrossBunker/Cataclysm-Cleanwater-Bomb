local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_amplification_instant",
    name = ccb.content.plural_text("pressurized goblin fruit", "pressurized goblin fruits"),
    description = ccb.content.text("This capsule-shaped goblin fruit behaves as a pressurized tank when you press its surface with your finger.  Fortunately, it doesn't appear to be able to explode if pierced or bitten."),
    copy_from = "goblin_fruit_abstract",
    color = "brown",
    mass = "359 g",
    volume = "327 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_amplification_instant" },
}
