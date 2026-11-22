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

ccb.content.define_spell {
    id = "fear_paralyze",
    shape = "blast",
    name = ccb.content.text_without_extraction("Fear Paralyze"),
    description = ccb.content.text_without_extraction("Paralyzes you when you see the creature."),
    message = "",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_range = 10,
    max_range = 10,
    impact_handler = "w16b_sp_imp_dda_ea5c7fd5f297",
}

ccb.content.define_spell {
    id = "stare",
    shape = "blast",
    name = ccb.content.text_without_extraction("Stare"),
    description = ccb.content.text_without_extraction("Applies various effects when you see the creature."),
    message = "",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_range = 150,
    max_range = 150,
    impact_handler = "w16b_sp_imp_dda_b17489876567",
}

ccb.content.define_spell {
    id = "blank_body_avatar_copy",
    shape = "blast",
    name = ccb.content.text_without_extraction("Blank Body Player Copy Check"),
    description = ccb.content.text_without_extraction("Blank body checks and might copy the player.  Needs to be the avatar to apply COPY_AVATAR_LOOK"),
    flags = { "NO_PROJECTILE", "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "self", "hostile", "ally" },
    min_aoe = 1,
    max_aoe = 1,
    base_casting_time = 200,
    impact_handler = "w16b_sp_imp_dda_5cc4b498ce51",
}
