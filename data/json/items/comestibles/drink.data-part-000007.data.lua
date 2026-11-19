local ccb = require("ccb")

ccb.content.define_item {
    id = "tea_willowbark",
    copy_from = "tea",
    name = ccb.content.plural_text("willowbark tea", "willowbark tea"),
    conditional_names = {
        {
            kind = "FLAG",
            key = "COLD",
            name = ccb.content.plural_text("iced willowbark tea", "iced willowbark tea"),
        },
    },
    description = ccb.content.text("A bitter tea made by boiling willow bark in water, used since ancient times as a mild painkiller."),
    display_type = "BY_VOLUME",
    flags = { "NO_AUTO_CONSUME" },
    comestible = { kind = "MED", healthy = -1, sleepiness = 0, stimulation = 0, calories = 0, fun = -2 },
    use_actions = {
        {
            kind = "consume_drug",
            effects = { { id = "pkill1_nsaid", duration = 90 }, { id = "nausea", duration = "5 m" } },
        },
    },
}

ccb.content.define_item {
    id = "tea_bark",
    looks_like = "tea",
    name = ccb.content.plural_text("bark tea", "bark tea"),
    conditional_names = {
        {
            kind = "FLAG",
            key = "COLD",
            name = ccb.content.plural_text("iced bark tea", "iced bark tea"),
        },
    },
    mass = "500 g",
    color = "brown",
    default_container = "bottle_plastic",
    symbol = "~",
    description = ccb.content.text("Often regarded as folk medicine in some countries, bark tea tastes awful and tends to dry you out, but can help flush out stomach or other gut bugs."),
    display_type = "BY_VOLUME",
    price = "12 USD 50 cent",
    survival_price = "25 cent",
    volume = "500 ml",
    materials = { "water" },
    phase = "liquid",
    flags = { "EATEN_HOT", "NO_AUTO_CONSUME" },
    comestible = { kind = "MED", quench = -35, servings = 1, fun = -5 },
    use_actions = { "ANTIPARASITIC" },
}
