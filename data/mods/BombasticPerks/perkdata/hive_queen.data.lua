local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "TRAIT_HIVE_QUEEN",
    name = ccb.content.text_without_extraction("Insect Ignoring"),
    points = 0,
    description = ccb.content.text_without_extraction("Need this trait for anger relations."),
    valid = false,
    purifiable = false,
    player_display = false,
    ignored_by = { "INSECT", "INSECT_FLYING" },
}
