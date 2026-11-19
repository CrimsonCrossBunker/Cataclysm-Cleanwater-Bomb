local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "generic_folded_vehicle",
    name = ccb.content.text_without_extraction("seeing this is a bug", "seeing this is a bug"),
    description = ccb.content.text_without_extraction("seeing this is a bug"),
    volume = "0 ml",
    price = "0 cent",
    survival_price = "0 cent",
    symbol = "/",
    color = "light_gray",
    flags = { "ZERO_WEIGHT" },
    tool = {},
    use_actions = { "UNFOLD_GENERIC" },
}
