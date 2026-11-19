local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "librarian_blinding",
    name = ccb.content.text_without_extraction("Soul Pressure"),
    description = ccb.content.text_without_extraction("This is a spell that represents the Soulfire putting a burning pressure on nearby opponents.  If you are seeing this spell, you have debugged it in."),
    valid_targets = { "hostile" },
    flags = { "SILENT", "NO_PROJECTILE" },
    effect = "attack",
    effect_data = "blind",
    extra_spells = { { spell = "fireball", self = true } },
    shape = "blast",
    min_damage = 20,
    max_damage = 20,
    min_range = 6,
    max_range = 6,
    min_duration = 200,
    max_duration = 200,
    damage_type = "pure",
}
