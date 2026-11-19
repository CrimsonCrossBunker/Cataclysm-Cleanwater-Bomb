local ccb = require("ccb")

ccb.content.define_item {
    id = "iv_mutagen_migo",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("mi-go mutagenic primer", "mi-go mutagenic primer"),
    description = ccb.content.text("A super-concentrated mutagen strongly resembling a lava lamp."),
    price = "10 kUSD",
    color = "red",
    comestible = { healthy = -4 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_migo", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_migo",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("mi-go mutagen", "mi-go mutagen"),
    description = ccb.content.text("An extremely rare mutagen cocktail, it smells of sulfur and glows orange."),
    price = "5 kUSD",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_migo", minimum = 175 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_mastodon",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("mastodon mutagenic primer", "mastodon mutagenic primer"),
    description = ccb.content.text("A processed mutagenic primer not for those frightened of this thing they have become."),
    price = "10 kUSD",
    color = "red",
    comestible = { healthy = -4 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_mastodon", minimum = 450, maximum = 550 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_mastodon",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("mastodon mutagen", "mastodon mutagen"),
    description = ccb.content.text("An extremely rare mutagen cocktail, it seeks to cure what's deep inside."),
    price = "5 kUSD",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_mastodon", minimum = 175 }, { id = "mutagen", minimum = 125 } },
        },
    },
}
