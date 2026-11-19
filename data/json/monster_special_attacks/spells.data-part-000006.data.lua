local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
-- Duration is 3-5 hours, can't seem to write it in hours, had to write it in moves which is terrible
ccb.content.define_spell {
    id = "skunk_squirt",
    name = ccb.content.text_without_extraction("Skunk Spray"),
    description = ccb.content.text_without_extraction("Skunk spray defense mechanism."),
    valid_targets = { "hostile" },
    effect = "attack",
    shape = "cone",
    min_range = 4,
    max_range = 4,
    min_duration = 1080000,
    max_duration = 1800000,
    flags = { "RANDOM_DURATION" },
    effect_data = "skunk_spray",
}

-- exist because zed try to use boomer_claymore on max range except trying to minimize the distance (ty venera for idea)
-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "boomer_claymore_initial",
    name = ccb.content.text_without_extraction("Initial Boomer Claymore Attack"),
    description = ccb.content.text_without_extraction("Nothing to see here."),
    valid_targets = { "hostile" },
    flags = { "NO_EXPLOSION_SFX" },
    effect = "attack",
    shape = "blast",
    min_damage = 0,
    max_damage = 0,
    min_range = 3,
    max_range = 3,
    extra_spells = { { spell = "boomer_claymore" } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "boomer_claymore",
    name = ccb.content.text_without_extraction("Boomer Claymore Attack"),
    description = ccb.content.text_without_extraction("Nothing to see here."),
    valid_targets = { "hostile", "ally", "ground" },
    flags = { "SPLIT_DAMAGE" },
    effect = "attack",
    shape = "cone",
    min_damage = 30,
    max_damage = 30,
    damage_type = "cut",
    min_range = 6,
    max_range = 6,
    min_aoe = 120,
    max_aoe = 120,
    extra_spells = { { spell = "boomer_claymore_suicide", self = true } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "create_noise",
    name = ccb.content.text_without_extraction("Do noise"),
    description = ccb.content.text_without_extraction("Causes some noise"),
    flags = { "NO_EXPLOSION_SFX" },
    message = ccb.content.text("The %s makes a deafening screech"),
    sound_description = ccb.content.text("a deafening screech"),
    sound_type = "combat",
    sound_ambient = true,
    sound_id = "misc",
    sound_variant = "shockwave",
    min_damage = 50,
    max_damage = 50,
    valid_targets = { "self" },
    shape = "blast",
    effect = "noise",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "boomer_claymore_suicide",
    name = ccb.content.text_without_extraction("Boomer Suicide Spell"),
    description = ccb.content.text_without_extraction("Nothing to see here."),
    valid_targets = { "hostile", "ally", "self" },
    effect = "attack",
    shape = "blast",
    damage_type = "biological",
    flags = { "NO_EXPLOSION_SFX" },
    min_damage = 9999,
    max_damage = 9999,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mon_twisting_blade_attack",
    name = ccb.content.text_without_extraction("Twisting Blade Attack"),
    description = ccb.content.text_without_extraction("Hurts you mentally."),
    copy_from = "base_portal",
    effect_data = "EOC_mon_twisting_blade_attack",
}
