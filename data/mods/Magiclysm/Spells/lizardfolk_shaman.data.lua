local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_summon_crocodile",
    name = ccb.content.text_without_extraction("Summon Crocodile"),
    description = ccb.content.text_without_extraction("Summons a crocodile."),
    flags = { "HOSTILE_SUMMON", "NO_PROJECTILE" },
    valid_targets = { "ground" },
    base_casting_time = 200,
    min_damage = 1,
    max_damage = 1,
    min_aoe = 2,
    max_aoe = 2,
    min_duration = 40000,
    message = ccb.content.text("The shaman summons a crocodile!"),
    shape = "blast",
    effect = "summon",
    effect_data = "mon_crocodile",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_shaman_base",
    name = ccb.content.text_without_extraction("An Ancient Reptilian Spell"),
    description = ccb.content.text_without_extraction("Causes one of the shaman spells to be cast."),
    valid_targets = { "hostile", "ground" },
    effect = "none",
    shape = "blast",
    base_casting_time = 100,
    flags = { "WONDER", "NO_PROJECTILE" },
    min_damage = 1,
    max_damage = 1,
    min_range = 10,
    max_range = 10,
    message = "",
    extra_spells = {
        { spell = "druid_veggrasp_monster" },
        { spell = "druid_veggrasp_monster" },
        { spell = "druid_veggrasp_monster" },
        { spell = "druid_veggrasp_monster" },
        { spell = "light_healing", self = true },
        { spell = "light_healing", self = true },
        { spell = "light_healing", self = true },
        { spell = "spell_summon_crocodile" },
    },
}
