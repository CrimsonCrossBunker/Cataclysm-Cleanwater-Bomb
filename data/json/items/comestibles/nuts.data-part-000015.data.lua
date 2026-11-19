local ccb = require("ccb")

ccb.content.define_item {
    id = "acorns_blanched",
    name = ccb.content.plural_text("Handful of blanched acorns", "of blanched acorns"),
    display_type = "BY_WEIGHT",
    copy_from = "acorns",
    description = ccb.content.text("A handful of mushy blanched acorns.  No longer bitter, but not pleasant to eat in this state."),
    price = "90 cent",
    survival_price = "2 USD",
    flags = { "EDIBLE_FROZEN" },
    subtype_order = { "milling", "comestible" },
    milling = { result = "paste_nut", recipe = "paste_nut_mill_10_1" },
    comestible = { shelf_life = "5 days", smoking_result = "acorns_cooked", fun = -1 },
}

ccb.content.define_item {
    id = "acorns_blanching_active",
    name = ccb.content.plural_text("Blanching acorns", "of blanching acorns"),
    display_type = "BY_WEIGHT",
    copy_from = "acorns",
    description = ccb.content.text("A mix of water and hulled acorns, slowly leaching the tannins.  It'll take about a week before they're palatable."),
    symbol = "~",
    survival_price = "50 cent",
    mass = "512 g",
    volume = "500 ml",
    phase = "liquid",
    looks_like = "coffee",
    revert_to = "acorns_blanched",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } }, remove = { flags = { "EDIBLE_FROZEN" } } },
    comestible = { kind = "DRINK", quench = 25, servings = 1 },
    countdown_interval = "6 days",
}
