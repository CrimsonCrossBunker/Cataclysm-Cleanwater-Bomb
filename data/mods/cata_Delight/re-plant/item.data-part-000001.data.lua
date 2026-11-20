local ccb = require("ccb")

ccb.content.define_item {
    id = "tsow_compost_bin_fermenting",
    category = "other",
    name = ccb.content.plural_text("Compost Bin Fermenting", "Compost Bin Fermentings"),
    description = ccb.content.text("A compost bin filled with humus while its organic matter ferments inside.  In about seven days, the humus will become fertile soil, and the bin can be reused."),
    mass = "7000 g",
    volume = "12000 ml",
    length = "30 cm",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "wood", "soil" },
    symbol = ")",
    color = "yellow_green",
    flags = { "SPAWN_ACTIVE", "TRADER_AVOID" },
    countdown_interval = "7 days",
    transform_into = { target = "tsow_fertile_soil", container = "tsow_compost_bin_empty", target_charges = 20 },
}
