local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_mana_restore",
    name = ccb.content.plural_text("fizzy goblin fruit", "fizzy goblin fruits"),
    description = ccb.content.text("This small brown goblin fruit constantly forms bubbles that erupt from its skin.  Despite that, its surface remains smooth at all times.  It has a subtle, sugary smell."),
    copy_from = "goblin_fruit_abstract",
    color = "brown",
    mass = "134 g",
    volume = "122 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_mana_restore" },
}
