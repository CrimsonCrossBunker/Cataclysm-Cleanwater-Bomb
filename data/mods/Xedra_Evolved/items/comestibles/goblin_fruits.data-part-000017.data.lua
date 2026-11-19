local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_super_clairvoyance",
    name = ccb.content.plural_text("crumbly goblin fruit", "crumbly goblin fruits"),
    description = ccb.content.text("This large, curved goblin fruit is a dark blue color and feels like it's already on the verge of rotting.  It takes very little pressure for your fingers to bruise the skin and the flesh inside flakes off when you touch it.  It smells like sun-ripened strawberries."),
    copy_from = "goblin_fruit_abstract",
    color = "h_black",
    mass = "263 g",
    volume = "300 ml",
    comestible = { kind = "FOOD", fun = -3, on_consume = "consume_goblin_fruit_super_clairvoyance" },
}
