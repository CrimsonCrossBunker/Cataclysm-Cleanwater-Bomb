local ccb = require("ccb")

ccb.content.define_item {
    id = "dry_veggy_tainted",
    category = "other",
    name = ccb.content.plural_text("dehydrated alien fungus chunk", "dehydrated alien fungus chunks"),
    copy_from = "dry_veggy",
    looks_like = "dry_mushroom",
    description = ccb.content.text("Pieces of alien mushroom that have been dried to prevent them from rotting away.  They will still poison you if you eat them."),
    display_type = "BY_WEIGHT",
    price = "0 cent",
    survival_price = "0 cent",
    flags = { "EDIBLE_FROZEN", "FUNGAL_VECTOR" },
    comestible = {},
    use_actions = { "POISON" },
}
