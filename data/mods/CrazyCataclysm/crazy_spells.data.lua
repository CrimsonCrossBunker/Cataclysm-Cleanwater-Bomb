local ccb = require("ccb")

ccb.content.define_spell {
    id = "remove_controlled_jackson",
    name = ccb.content.text("Uncontrol Dancers"),
    valid_targets = { "self", "ally" },
    description = ccb.content.text("Removes control effect from polymorphed dancers."),
    targeted_monsters = { "mon_zombie_hulk" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    min_aoe = 48,
    max_aoe = 48,
    shape = "blast",
    effect_data = "controlled",
    effect = "remove_effect",
}

ccb.content.define_spell {
    id = "death_jackson",
    name = ccb.content.text("Jackson Death"),
    description = ccb.content.text("Hee Hee!  WOO!"),
    valid_targets = { "self", "ally" },
    effect = "targeted_polymorph",
    min_aoe = 48,
    max_aoe = 48,
    min_damage = 400,
    max_damage = 400,
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect_data = "mon_zombie_hulk",
    targeted_monsters = { "mon_zombie_dancer" },
    extra_spells = { { spell = "remove_controlled_jackson", self = true } },
}

-- NO_I18N
ccb.content.define_spell {
    id = "spell_clean_dust",
    name = ccb.content.text("Clean Dust"),
    description = ccb.content.text_without_extraction("Cleans Dust."),
    message = "",
    min_aoe = 3,
    max_aoe = 3,
    valid_targets = { "ground", "field" },
    flags = { "IGNORE_WALLS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "remove_field",
    effect_data = "fd_dust",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_clean_splinters",
    name = ccb.content.text_without_extraction("Clean Splinters"),
    description = ccb.content.text_without_extraction("Clean splinters."),
    message = "",
    min_aoe = 3,
    max_aoe = 3,
    valid_targets = { "ground", "field" },
    flags = { "IGNORE_WALLS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "remove_field",
    effect_data = "fd_splinters",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_clean_blood",
    name = ccb.content.text_without_extraction("Clean Blood"),
    description = ccb.content.text_without_extraction("Cleans blood."),
    message = "",
    min_aoe = 3,
    max_aoe = 3,
    valid_targets = { "ground", "field" },
    flags = { "IGNORE_WALLS", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "remove_field",
    effect_data = "fd_blood",
}
