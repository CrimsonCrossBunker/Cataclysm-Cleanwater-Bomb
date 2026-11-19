local ccb = require("ccb")

ccb.content.define_item {
    id = "mutagen_flamekin",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("Salamander destiny draught", "Salamander destiny draughts"),
    description = ccb.content.text("This magical potion will further your transformation from newly sentient creature to elemental powerhouse."),
    price = "5 kUSD",
    comestible = { on_consume = "drink_salamander_destiny_draught" },
}
