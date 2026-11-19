local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "blank_body_avatar_copy_polymorph",
    name = ccb.content.text_without_extraction("Blank Body Player Copy"),
    description = ccb.content.text_without_extraction("Blank body copies the player"),
    message = ccb.content.text("The blank body's flesh suddenly begins to flow like wax, warping and changing, and when it's done it's…you."),
    flags = { "NO_PROJECTILE", "SILENT", "NO_EXPLOSION_SFX", "HIDDEN_SPELL" },
    effect = "targeted_polymorph",
    effect_data = "mon_blank_avatar_copy",
    valid_targets = { "self" },
    min_damage = 10000,
    max_damage = 10000,
    base_casting_time = 200,
    shape = "blast",
}
