local ccb = require("ccb")

ccb.content.define_item {
    id = "migo_bio_tech",
    name = ccb.content.plural_text("Mi-go Biotech", "Mi-go Biotech"),
    description = "A piece of mi-go biotechnology.",
    symbol = "!",
    color = "light_red",
    mass = "250 g",
    volume = "250 ml",
    price = "30 USD",
    survival_price = "100 USD",
    materials = { "alien_resin" },
    conditional_names = {
        {
            kind = "VAR",
            key = "mbt_f_function",
            value = "morale",
            name = ccb.content.plural_text("%s (happy)", "%s (happy)"),
        },
        {
            kind = "VAR",
            key = "mbt_f_function",
            value = "focus",
            name = ccb.content.plural_text("%s (focus)", "%s (focus)"),
        },
        {
            kind = "VAR",
            key = "mbt_f_function",
            value = "pain",
            name = ccb.content.plural_text("%s (pain relief)", "%s (pain relief)"),
        },
        {
            kind = "VAR",
            key = "mbt_f_function",
            value = "sleepiness",
            name = ccb.content.plural_text("%s (wake up)", "%s (wake up)"),
        },
    },
    tool = {},
}
