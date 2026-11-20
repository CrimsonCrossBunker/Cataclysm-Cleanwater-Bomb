local ccb = require("ccb")

ccb.content.define_item {
    id = "fermentable_fish_mixture",
    name = ccb.content.plural_text("fermentable fish mixture (obsolete)", "fermentable fish mixture (obsolete)"),
    description = ccb.content.text("A mixture of fish, sugars, and water.  Wait about two months for them to be fermented in an open tank."),
    copy_from = "fermentable_liquid_mixture",
    comestible = {},
    use_actions = {
        {
            kind = "delayed_transform",
            target = "fermented_fertilizer_liquid",
            age = 4320000,
            not_ready_message = ccb.content.text("The overpowering smell of the fermenting fish liquid makes it clear that it is not ready for use."),
        },
    },
}
