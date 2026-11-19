local ccb = require("ccb")

ccb.content.define_item {
    id = "aperture_potato",
    name = ccb.content.plural_text("companion potato", "companion potatoes"),
    description = ccb.content.text("Seems like some kind of Genetic Lifeform and Disk Operating System, attached to a potato."),
    mass = "900 g",
    volume = "500 ml",
    price = "90 USD",
    accuracy = -1,
    materials = { "plastic" },
    symbol = "%",
    color = "light_gray",
    tool = {},
    use_actions = { "DOLLCHAT" },
}
