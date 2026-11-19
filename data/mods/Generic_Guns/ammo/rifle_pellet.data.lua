local ccb = require("ccb")

ccb.content.define_item {
    id = "rifle_pellet_target",
    copy_from = "airgun_pellet_target",
    name = ccb.content.text("air rifle target pellet"),
    description = ccb.content.text("A tin of small cone-shaped pellets meant to be used in an air rifle.  Suitable for plinking."),
    ammunition = {},
}

ccb.content.define_item {
    id = "rifle_pellet_hunting",
    copy_from = "airgun_pellet_hunting",
    name = ccb.content.text("air rifle hunting pellet"),
    description = ccb.content.text("A tin of small cone-shaped pellets meant to be used in an air rifle.  Suitable for hunting small game."),
    ammunition = {},
}
