local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "assassin_teleport",
    name = ccb.content.text_without_extraction("Assassin Teleport"),
    description = ccb.content.text_without_extraction("This is a sub-spell for Assassin Strike.  It teleports you."),
    effect = "short_range_teleport",
    shape = "blast",
    valid_targets = { "none" },
    flags = { "CONVEYANCE_SPELL", "SILENT" },
    min_range = 8,
    max_range = 8,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "assassin_toxic_smoke",
    name = ccb.content.text_without_extraction("Assassin Toxic Smoke"),
    description = ccb.content.text_without_extraction("This is a sub-spell for Assassin Strike.  It generates toxic smoke in an area."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "ground", "hostile" },
    field = "fd_toxic_gas",
    min_field_intensity = 2,
    max_field_intensity = 3,
    min_aoe = 4,
    max_aoe = 4,
}
