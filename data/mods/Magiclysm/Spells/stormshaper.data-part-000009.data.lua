local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "vacuum_decompression_pull",
    name = ccb.content.text_without_extraction("Vacuum Decompression Pull"),
    description = ccb.content.text_without_extraction("Pull monsters around the target.  You can see it only in debug mode."),
    effect = "area_pull",
    shape = "blast",
    valid_targets = { "hostile", "item", "ground" },
    flags = { "EVOCATION_SPELL", "SILENT", "NO_EXPLOSION_SFX" },
    max_level = 25,
    min_aoe = 5,
    max_aoe = 16,
    aoe_increment = 0.5,
}

ccb.content.define_spell {
    id = "air_bubble",
    name = ccb.content.text("Air Bubble"),
    description = ccb.content.text("Cover your head with an air bubble, allowing you to breathe underwater or prevent breathing of toxic gases."),
    valid_targets = { "self" },
    flags = { "CONJURATION_SPELL", "CONCENTRATE", "LOUD", "VERBAL", "NO_LEGS" },
    min_damage = 1,
    max_damage = 1,
    effect = "spawn_item",
    effect_data = "flask_ethereal_rebreather",
    extra_spells = { { spell = "eoc_summon_setup", self = true } },
    shape = "blast",
    magic_type = "magiclysm_conjuration_magic",
    spell_class = "STORMSHAPER",
    difficulty = 3,
    max_level = 10,
    base_casting_time = 1000,
    base_energy_cost = 200,
    min_duration = 18000,
    max_duration = 180000,
    duration_increment = 18000,
}
