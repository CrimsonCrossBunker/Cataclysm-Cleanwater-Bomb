local ccb = require("ccb")

ccb.content.define_item {
    id = "item_hedge_nether_eye_paste",
    name = ccb.content.plural_text("Blood-and-Ash Paste", "Blood-and-Ash Paste"),
    description = ccb.content.text("A disgusting mixture of blood, ashes, and certain herbs.  Using it will allow you to see otherworldly creatures even through walls or in darkness."),
    mass = "265 g",
    volume = "250 ml",
    price = "2 USD",
    survival_price = "1 USD",
    symbol = "q",
    color = "blue",
    flags = { "EATEN_COLD", "HEDGE_ENCHANTED" },
    phase = "solid",
    comestible = {
        kind = "MED",
        shelf_life = "10 days",
        fun = -5,
        on_consume = "consume_item_hedge_nether_eye_paste",
    },
}

ccb.content.define_item {
    id = "item_hedge_changeling_snare",
    name = "betweener's maze",
    description = "A yarn contraption similar to a cat's cradle that looks like a three dimensional maze.  When placed properly, it can fascinate the changeling blooded.",
    symbol = "*",
    color = "green_green",
    category = "traps",
    mass = "20 g",
    volume = "100 ml",
    length = "20 cm",
    price = "250 USD",
    survival_price = "5 USD",
    flags = { "SINGLE_USE", "HEDGE_ENCHANTED" },
    materials = { "wool" },
    properties = { capture_species = "CHANGELING" },
    use_actions = {
        {
            kind = "place_trap",
            trap = "tr_fae_snare",
            moves = 150,
            practice = 2,
            done_message = "You place the betweener's maze.",
        },
    },
    tool = {},
}
