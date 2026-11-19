local ccb = require("ccb")

ccb.content.define_item {
    id = "coin_silver",
    category = "currency",
    name = ccb.content.plural_text("Silver Eagle coin", "Silver Eagle coins"),
    description = ccb.content.text("The official silver bullion coin of the United States, it has a nominal face value of one dollar and is guaranteed to contain one troy ounce of 99.9% pure silver."),
    mass = "10 g",
    volume = "1 ml",
    price = "23 USD",
    survival_price = "3 USD 10 cent",
    materials = { "silver" },
    symbol = "o",
    color = "light_gray",
    flags = { "COIN_SHAPED" },
    use_actions = { "COIN_FLIP" },
}
