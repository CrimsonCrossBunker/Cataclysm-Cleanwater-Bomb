local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
-- volume is damage/3, so 20
ccb.content.define_spell {
    id = "cause_loud_moaning",
    name = ccb.content.text_without_extraction("cause loud moaning"),
    description = ccb.content.text_without_extraction("You should not see this.  Causes loud noise."),
    valid_targets = { "ground", "ally" },
    max_level = 1,
    shape = "blast",
    effect = "noise",
    flags = { "NO_EXPLOSION_SFX" },
    sound_type = "combat",
    sound_id = "melee_attack",
    sound_variant = "monster_melee_hit",
    sound_description = ccb.content.text("a zombie moaning!"),
    min_damage = 60,
    max_damage = 60,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "wake_up_dormant",
    name = ccb.content.text_without_extraction("dormant corpse waking up"),
    description = ccb.content.text_without_extraction("You should not see this.  Causes all dormant corpses in the tile to revive."),
    valid_targets = { "ground" },
    max_level = 1,
    flags = { "NO_EXPLOSION_SFX" },
    base_casting_time = 1,
    shape = "blast",
    min_aoe = 1,
    max_aoe = 1,
    effect = "revive_dormant",
    effect_data = "ZOMBIE",
    extra_spells = { { spell = "cause_loud_moaning" } },
}
