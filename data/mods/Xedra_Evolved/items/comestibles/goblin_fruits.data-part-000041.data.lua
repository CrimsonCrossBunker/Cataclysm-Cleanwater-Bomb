local ccb = require("ccb")

ccb.content.define_item {
    id = "goblin_fruit_heat_blast",
    name = ccb.content.plural_text("urchin goblin fruit", "urchin goblin fruits"),
    description = ccb.content.text("This spherical fruit bears many spines, yet all of of them are dulled.  It smells faintly of cinnamon and aftershave."),
    copy_from = "goblin_fruit_abstract",
    color = "red",
    mass = "331 g",
    volume = "341 ml",
    comestible = { kind = "FOOD", on_consume = "consume_goblin_fruit_heat_blast" },
}
