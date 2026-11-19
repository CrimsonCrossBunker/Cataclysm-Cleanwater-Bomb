local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_giant_growth",
    name = ccb.content.plural_text("shiny goblin fruit", "shiny goblin fruits"),
    description = ccb.content.text("This round blue goblin fruit glows bright enough to read by.  The light flickers like firelight, even when the fruit is simply placed on the table.  It smells like pine needles soaked in strong alcohol."),
    copy_from = "goblin_fruit_abstract",
    color = "yellow_cyan",
    mass = "199 g",
    volume = "228 ml",
    light = 10,
    flags = { "FREEZERBURN", "NO_AUTO_CONSUME" },
    comestible = { kind = "FOOD", on_consume = "eat_giant_growth_goblin_fruit" },
}

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
