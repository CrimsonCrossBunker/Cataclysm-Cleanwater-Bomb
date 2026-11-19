local ccb = require("ccb")

ccb.content.define_item {
    id = "iv_mutagen_tyrant",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("tyrant mutagenic primer", "tyrant mutagenic primer"),
    description = ccb.content.text("A super-concentrated mutagenic primer strongly resembling children's toy slime."),
    price = "10 kUSD",
    color = "light_green",
    comestible = { healthy = -4 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_tyrant", minimum = 500 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_tyrant",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("tyrant mutagen", "tyrant mutagen"),
    description = ccb.content.text("An extremely rare mutagen cocktail, it smells like blood and is a green goop with blood-red streaks."),
    color = "light_green",
    price = "5 kUSD",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_tyrant", minimum = 175 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_stego",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("stego mutagenic primer", "stego mutagenic primer"),
    description = ccb.content.text("A super-concentrated mutagenic primer not for those frightened of this thing they have become."),
    price = "10 kUSD",
    color = "light_green",
    comestible = { healthy = -4 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_stego", minimum = 500 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_stego",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("stego mutagen", "stego mutagen"),
    description = ccb.content.text("An extremely rare mutagen cocktail, it seeks to cure what's deep inside."),
    color = "light_green",
    price = "5 kUSD",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_stego", minimum = 175 }, { id = "mutagen", minimum = 125 } },
        },
    },
}

ccb.content.define_item {
    id = "iv_mutagen_horns",
    copy_from = "iv_mutagen_flavor",
    name = ccb.content.plural_text("horns mutagenic primer", "horns mutagenic primer"),
    description = ccb.content.text("A super-concentrated mutagenic primer containing refined and purified biological samples, spiked with rum."),
    price = "10 kUSD",
    color = "light_green",
    comestible = { healthy = -4 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            vitamins = { { id = "mutagen_horns", minimum = 500 } },
        },
    },
}

ccb.content.define_item {
    id = "mutagen_horns",
    copy_from = "mutagen_flavor",
    name = ccb.content.plural_text("horns mutagen", "horns mutagen"),
    description = ccb.content.text("An extremely rare mutagen cocktail containing a mix of biological samples, spiked with rum."),
    color = "light_green",
    price = "5 kUSD",
    comestible = {},
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink the %s."),
            vitamins = { { id = "mutagen_horns", minimum = 175 }, { id = "mutagen", minimum = 125 } },
        },
    },
}
