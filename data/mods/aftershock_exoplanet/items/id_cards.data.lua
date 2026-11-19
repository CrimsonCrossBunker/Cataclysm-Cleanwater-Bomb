local ccb = require("ccb")

ccb.content.define_item {
    id = "STEED_registry",
    name = ccb.content.plural_text("STEED registry key", "STEED registry keys"),
    description = ccb.content.text("A slim card that is used to initialize a STEED, which will then imprint the rider's biometric data and follow them unerringly."),
    price = "5000 USD",
    mass = "6 g",
    volume = "5 ml",
    symbol = ",",
    color = "green",
    comestible = { kind = "INVALID", pet_food = { "STEED_registry" } },
    use_actions = { "PETFOOD" },
}
