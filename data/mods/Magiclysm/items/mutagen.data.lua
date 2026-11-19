local ccb = require("ccb")

ccb.content.define_item {
    id = "manatouched_serum",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("concentrated mana mutagenic primer", "concentrated mana mutagenic primer"),
    color = "light_blue",
    description = ccb.content.text("A very concentrated form of mana potion."),
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_manatouched", minimum = 500 } },
        },
    },
}

ccb.content.define_item {
    id = "manatouched_mutagen",
    copy_from = "mutagen_flavor",
    color = "light_blue",
    description = ccb.content.text("A mana potion mixed with mutagen.  It might help you connect with magic."),
    name = ccb.content.plural_text("mana mutagen", "mana mutagen"),
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_manatouched", minimum = 175 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_black_dragon",
    copy_from = "mutagen_flavor",
    color = "dark_gray",
    description = ccb.content.text("An alchemic concoction made from the remains of a slain black dragon and a bit of potion base.  Ancient and Academic texts talk of profound changes from consuming this."),
    name = ccb.content.plural_text("black dragon mutagen", "black dragon mutagen"),
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_black_dragon", minimum = 175 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_black_dragon",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("black dragon mutagenic primer", "black dragon mutagenic primer"),
    description = ccb.content.text("A super-concentrated mutagen that seems to swirl with the anger of a black dragon.  Do you dare leave your humanity behind and inject it?"),
    color = "dark_gray",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_black_dragon", minimum = 500 } },
        },
    },
}
