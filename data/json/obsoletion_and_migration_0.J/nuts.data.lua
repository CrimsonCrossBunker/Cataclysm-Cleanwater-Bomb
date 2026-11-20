local ccb = require("ccb")

ccb.content.define_item {
    id = "acorns_blanching",
    name = ccb.content.plural_text("blanching acorns (obsolete)", "blanching acorns (obsolete)"),
    copy_from = "acorns",
    description = ccb.content.text("A mix of water and hulled acorns, slowly leaching the tannins.  It'll take about a week before they're palatable."),
    symbol = "~",
    survival_price = "50 cent",
    mass = "512 g",
    volume = "500 ml",
    phase = "liquid",
    looks_like = "coffee",
    inheritance = { remove = { flags = { "EDIBLE_FROZEN" } } },
    comestible = { kind = "DRINK", quench = 25, servings = 1 },
    use_actions = {
        {
            kind = "delayed_transform",
            target = "acorns_blanched",
            message = ccb.content.text("After a week of changing water and taste-testing, the acorns are no longer bitter and ready to decant."),
            moves = 50,
            age = 518400,
            not_ready_message = ccb.content.text("The acorns are still bitter."),
        },
    },
}
