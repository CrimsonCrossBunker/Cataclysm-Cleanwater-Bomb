local ccb = require("ccb")

ccb.content.define_item {
    id = "abyssal_coffee",
    looks_like = "coffee",
    copy_from = "coffee",
    name = ccb.content.plural_text("abyssal coffee", "abyssal coffee"),
    description = ccb.content.text("The morning ritual of the pre-apocalyptic world, created from coffee cherries through a complex process of seed removal, roasting, grinding, and brewing.  Well, that's true for regular coffee, but this doesn't look regular.  It's so coffee is so dark it seems to dim the light around it and its aroma fills the entire room."),
    price = "100 USD",
    survival_price = "3 USD50 cent",
    comestible = { fun = 0, on_consume = "consume_abyssal_coffee" },
}

ccb.content.define_item {
    id = "truckers_stamina_pills",
    name = "alchemically altered trucker pill",
    description = "When you began the sinister path into occultism, you never imagined you'd be alchemically altering truckstop Viagra into combat drugs.  But here you are, no sleep til Boston.",
    symbol = "!",
    color = "light_cyan",
    default_container = "bag_zipper",
    mass = "1 g",
    volume = "2 ml",
    price = "150 cent",
    survival_price = "50 cent",
    flags = { "NO_INGEST", "WATER_DISSOLVE", "EDIBLE_FROZEN" },
    materials = { "powder" },
    use_actions = {
        {
            kind = "consume_drug",
            message = "You swallow a couple of the large green pills.",
            vitamins = {
                { id = "cheval", minimum = 1000 },
            },
        },
    },
    comestible = {
        kind = "MED",
        fun = 30,
        quench = -2,
        healthy = -7,
        stimulation = 20,
        addiction_potential = 15,
        addictions = {
            "amphetamine",
            { id = "opiate", potential = 10 },
        },
        vitamins = {
            { id = "vit_mme", amount = 200 },
        },
    },
}
