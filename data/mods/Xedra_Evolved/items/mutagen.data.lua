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

ccb.content.define_item {
    id = "mutagen_plantkin",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("Arvore destiny draught", "Arvore destiny draughts"),
    description = ccb.content.text("This magical potion will further your transformation from newly sentient creature to elemental powerhouse."),
    price = "5 kUSD",
    comestible = { on_consume = "drink_arvore_destiny_draught" },
}

ccb.content.define_item {
    id = "mutagen_waterkin",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("Undine destiny draught", "Undine destiny draughts"),
    description = ccb.content.text("This magical potion will further your transformation from newly sentient creature to elemental powerhouse."),
    price = "5 kUSD",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_waterkin", minimum = 550 }, { id = "mutagen", minimum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_flamekin",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("Salamander destiny draught", "Salamander destiny draughts"),
    description = ccb.content.text("This magical potion will further your transformation from newly sentient creature to elemental powerhouse."),
    price = "5 kUSD",
    comestible = { on_consume = "drink_salamander_destiny_draught" },
}

ccb.content.define_item {
    id = "mutagen_dollkin",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("Homullus destiny draught", "Homullus destiny draughts"),
    description = ccb.content.text("This magical potion will further your transformation from newly sentient creature to elemental powerhouse."),
    price = "5 kUSD",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_dollkin", minimum = 550 }, { id = "mutagen", minimum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_airkin",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("Sylph destiny draught", "Sylph destiny draughts"),
    description = ccb.content.text("This magical potion will further your transformation from newly sentient creature to elemental powerhouse."),
    price = "5 kUSD",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_airkin", minimum = 550 }, { id = "mutagen", minimum = 550 } },
        },
    },
}
