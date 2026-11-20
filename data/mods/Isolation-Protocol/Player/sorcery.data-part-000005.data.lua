local ccb = require("ccb")

ccb.content.define_spell {
    id = "iso_eldritch_cure_poison_disease_gas",
    name = ccb.content.text("To Walk Amidst the Fens"),
    description = ccb.content.text("Suffuse your body with the powers of decay, rot, and putrescent, rendering you immune to poisons, diseases, and toxin fumes of all kinds.  The enchantment will also make your flesh unpalatable to any wild creatures, should you find any."),
    valid_targets = { "self" },
    flags = { "ENHANCEMENT_SPELL", "RANDOM_DURATION", "VERBAL", "SOMATIC", "NO_LEGS" },
    spell_class = "iso_eldritch_sorcery",
    magic_type = "iso_eldritch_sorcery",
    difficulty = 4,
    max_level = 30,
    effect = "attack",
    effect_data = "effect_iso_eldritch_cure_poison_disease_gas",
    shape = "blast",
    min_duration = { handler = "scaled_iso_eldritch_cure_poison_disease_gas_min_duration", fallback = 1532.0 },
    max_duration = { handler = "scaled_iso_eldritch_cure_poison_disease_gas_max_duration", fallback = 3420.0 },
    base_energy_cost = 250,
    base_casting_time = 200,
}
