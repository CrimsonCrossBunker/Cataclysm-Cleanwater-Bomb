local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "MAGIC_CASCADE",
    name = ccb.content.text_without_extraction("Artifact magic cascade"),
    description = ccb.content.text_without_extraction("Fires bursts of low damage ranged attacks."),
    message = ccb.content.text("Burning ash whirls around you."),
    valid_targets = { "self" },
    extra_spells = {
        { spell = "MAGIC_CASCADE_MISSILE" },
        { spell = "MAGIC_CASCADE_MISSILE" },
        { spell = "MAGIC_CASCADE_MISSILE" },
    },
    effect = "attack",
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
}

ccb.content.define_spell {
    id = "AO_BOOK_BLAST_ATTACK",
    shape = "cone",
    effect = "attack",
    damage_type = "cut",
    name = ccb.content.text_without_extraction("Book blast Attack"),
    description = ccb.content.text_without_extraction("A cone AOE cut damage attack."),
    message = "Razor sharp pages shoot out from the book when you open it.",
    flags = { "SILENT", "RANDOM_TARGET", "RANDOM_CRITTER", "RANDOM_DAMAGE", "NO_PROJECTILE" },
    valid_targets = { "hostile", "ground", "ally" },
    min_damage = { handler = "wave14a_dda_stat_3", fallback = 0 },
    max_damage = { handler = "wave14a_dda_stat_4", fallback = 0 },
    min_range = 10,
    max_range = 10,
    min_aoe = 15,
    max_aoe = 15,
    base_casting_time = 100,
}

ccb.content.define_spell {
    id = "AO_BOOK_COMBUSTION",
    shape = "blast",
    name = ccb.content.text_without_extraction("Book combustion"),
    description = ccb.content.text_without_extraction("Causes other nearby books to explode."),
    message = "The pages glint slightly as you flip through them.",
    flags = { "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    base_casting_time = 100,
    impact_handler = "w16b_sp_imp_dda_b31a4fb3e1d2",
}

ccb.content.define_spell {
    id = "AO_MAGIC_CASCADE_START",
    shape = "blast",
    name = ccb.content.text_without_extraction("Artifact magic cascade"),
    description = ccb.content.text_without_extraction("Fires bursts of low damage ranged attacks."),
    message = "Burning ash whirls around you.",
    flags = { "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    base_casting_time = 100,
    impact_handler = "w16b_sp_imp_dda_0240443f212a",
}
