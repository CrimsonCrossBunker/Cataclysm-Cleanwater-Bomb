local ccb = require("ccb")

ccb.content.define_item {
    id = "item_ewwww_de_zombie",
    name = ccb.content.plural_text("dose of ewwww de zombie", "doses of ewwww de zombie"),
    description = ccb.content.text("Zombie blood and guts all mixed together.  Coating yourself in this would have been unimaginable before the Cataclysm, but the prospect of being ripped apart otherwise is a powerful motivator."),
    copy_from = "blood_tainted",
    inheritance = { add = { flags = { "NO_AUTO_CONSUME", "NO_INGEST" } }, remove = { flags = { "RAW" } } },
    comestible = {
        calories = 0,
        kind = "MED",
        shelf_life = "12 days",
        vitamins = {},
        on_consume = "consume_item_ewwww_de_zombie",
    },
    use_actions = {},
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "TRAIT_EWWWW_DE_ZOMBIE",
    name = ccb.content.text_without_extraction("Zombie Ignoring"),
    points = 0,
    description = ccb.content.text_without_extraction("Need this trait for anger relations."),
    valid = false,
    purifiable = false,
    player_display = false,
    ignored_by = { "ZOMBIE" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "TRAIT_EWWWW_DE_ZOMBIE_SCENT",
    name = ccb.content.text_without_extraction("Fetid scent"),
    points = 0,
    description = ccb.content.text_without_extraction("Need this trait for scent."),
    valid = false,
    purifiable = false,
    player_display = false,
    scent_type = "sc_fetid",
}
