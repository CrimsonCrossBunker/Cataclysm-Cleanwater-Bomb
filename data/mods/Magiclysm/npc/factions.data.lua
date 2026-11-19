local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "MARK_FOR_DEATH_VALZAIN",
    player_display = false,
    name = ccb.content.text_without_extraction("Forge Lord Wrath"),
    points = 0,
    description = ccb.content.text_without_extraction("Makes sure all the Forge Lord mobs shoot you on sight."),
    valid = false,
    purifiable = false,
    species_anger = { FORGE_LORD = 95 },
}
