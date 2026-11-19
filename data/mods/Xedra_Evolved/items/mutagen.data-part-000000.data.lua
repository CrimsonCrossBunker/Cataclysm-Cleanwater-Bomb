local ccb = require("ccb")

ccb.content.define_item {
    id = "mutagen_earthkin",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("Ierde destiny draught", "Ierde destiny draughts"),
    description = ccb.content.text("This magical potion will further your transformation from newly sentient creature to elemental powerhouse."),
    price = "5 kUSD",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_earthkin", minimum = 550 }, { id = "mutagen", minimum = 550 } },
        },
    },
}
