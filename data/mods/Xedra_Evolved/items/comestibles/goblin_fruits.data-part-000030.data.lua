local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_adrenaline",
    name = ccb.content.plural_text("pulsating goblin fruit", "pulsating goblin fruits"),
    description = ccb.content.text("This fruit pulses at regular intervals like a beating heart.  As you hold it its rhythm changes, mimicking your own heart."),
    copy_from = "goblin_fruit_abstract",
    color = "green",
    mass = "324 g",
    volume = "395 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_adrenaline" },
}
