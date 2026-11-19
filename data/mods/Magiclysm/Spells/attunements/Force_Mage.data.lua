local ccb = require("ccb")

ccb.content.define_spell {
    id = "force_magical_armor",
    name = ccb.content.text("Force Shield"),
    description = ccb.content.text("Adds a shield of pure force that protects your body and your clothing from attacks."),
    valid_targets = { "none" },
    flags = { "CONJURATION_SPELL", "VERBAL", "CONCENTRATE", "MUST_HAVE_CLASS_TO_LEARN" },
    extra_spells = { { spell = "eoc_summon_setup", self = true } },
    effect = "spawn_item",
    effect_data = "force_magical_armor",
    shape = "blast",
    spell_class = "FORCE_MAGE",
    magic_type = "magiclysm_conjuration_magic",
    base_casting_time = 500,
    base_energy_cost = 500,
    max_level = 35,
    min_damage = 1,
    max_damage = 1,
    min_duration = 360000,
    max_duration = 1440000,
    duration_increment = 40115,
}
