local ccb = require("ccb")

ccb.content.define_item {
    id = "fermentable_fish_mixture_active",
    name = ccb.content.plural_text("fermentable fish mixture", "fermentable fish mixture"),
    description = ccb.content.text("A mixture of fish, sugars, and water.  Wait about two months for them to be fermented in an open tank."),
    copy_from = "fermentable_liquid_mixture",
    revert_to = "fermented_fertilizer_liquid",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "comestible", "tool" },
    comestible = {},
    tool = {},
    countdown_interval = "50 days",
}
