local ccb = require("ccb")

ccb.content.define_item {
    id = "caff_gum",
    name = ccb.content.plural_text("caffeinated chewing gum", "caffeinated chewing gums"),
    description = ccb.content.text("Sugar-free chewing gum with added caffeine.  It's a nice pick-me-up, one stick is equivalent to a strong cup of tea."),
    materials = { "drug_filler" },
    category = "drugs",
    mass = "2100 mg",
    volume = "2 ml",
    price = "1 cent",
    survival_price = "12 cent",
    symbol = "*",
    color = "white",
    flags = { "NO_INGEST" },
    stackable = true,
    comestible = {
        kind = "MED",
        addiction = "caffeine",
        fun = 1,
        vitamins = { { id = "caffeine", amount = 90 } },
    },
    use_actions = { "CHEW" },
}

ccb.content.define_item {
    id = "caffeine",
    name = ccb.content.plural_text("caffeine pill", "caffeine pills"),
    description = ccb.content.text("A No-doz brand caffeine pill, maximum strength.  Useful in pulling an all-nighter, one pill is equivalent to a strong cup of coffee."),
    mass = "100 mg",
    volume = "1 ml",
    price = "5 cent",
    survival_price = "7 cent",
    materials = { "drug_filler" },
    symbol = "!",
    color = "cyan",
    default_container = "bottle_plastic_pill_supplement",
    flags = { "WATER_DISSOLVE", "NO_TEMP" },
    stackable = true,
    comestible = { kind = "MED", addiction_potential = 3, addiction = "caffeine" },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You take a %s."),
            vitamins = { { id = "caffeine", minimum = 100 } },
        },
    },
}

ccb.content.define_item {
    id = "chaw",
    name = ccb.content.plural_text("chewing tobacco", "chewing tobacco"),
    description = ccb.content.text("Mint-flavored chewing tobacco.  While absolutely terrible for your health, it was once a favorite amongst baseball players, cowboys, and other macho types."),
    display_type = "BY_WEIGHT",
    mass = "4 g",
    volume = "4 ml",
    price = "33 cent",
    survival_price = "25 cent",
    symbol = "*",
    color = "green",
    default_container = "wrapper",
    flags = { "NO_INGEST" },
    stackable = true,
    comestible = {
        kind = "MED",
        quench = 1,
        healthy = -1,
        fun = 4,
        addiction_potential = 40,
        addiction = "nicotine",
        vitamins = { { id = "nicotine_slow", amount = 4 } },
    },
    use_actions = { "CHEW" },
}
