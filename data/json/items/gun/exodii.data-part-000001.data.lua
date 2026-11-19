local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_corrosive_spray",
    name = ccb.content.text_without_extraction("corrosive spray"),
    description = ccb.content.text_without_extraction("Your weapon coats its target in highly corrosive chemicals"),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile", "ally", "ground" },
    effect_data = "corroding",
    min_duration = 1300,
    max_duration = 1300,
    min_aoe = 6,
    max_aoe = 6,
    difficulty = 1,
    min_range = 10,
    max_range = 10,
    field = "fd_acid",
    min_field_intensity = 3,
    max_field_intensity = 3,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_adhesive_spray",
    name = ccb.content.text_without_extraction("adhesive spray"),
    description = ccb.content.text_without_extraction("Your weapon coats its target in quickly hardening resin"),
    effect = "ter_transform",
    effect_data = "exodii_foam",
    shape = "blast",
    valid_targets = { "ground" },
    min_aoe = 5,
    max_aoe = 5,
    difficulty = 1,
    min_range = 10,
    max_range = 10,
}
