local ccb = require("ccb")

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
