local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_awake",
    name = ccb.content.plural_text("minty goblin fruit", "minty goblin fruits"),
    description = ccb.content.text("This dark purple goblin fruit has an overpowering minty smell.  The smell even escapes sealed containers."),
    copy_from = "goblin_fruit_abstract",
    color = "magenta",
    mass = "150 g",
    volume = "191 ml",
    comestible = { kind = "FOOD", fun = 0, on_consume = "consume_goblin_fruit_awake" },
}
