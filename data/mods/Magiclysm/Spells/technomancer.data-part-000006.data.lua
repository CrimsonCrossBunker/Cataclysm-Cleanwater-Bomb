local ccb = require("ccb")

ccb.content.define_spell {
    id = "technomancer_conjure_radio",
    name = ccb.content.text("Speak through the Aether"),
    description = ccb.content.text("One of the most widely-known pre-modern technomantic spells, this allows technomancers to communicate at a distance.  Its use declined rapidly after Guglielmo Marconi invented the radio and suddenly everyone could listen in to their conversations."),
    valid_targets = { "self" },
    flags = { "CONJURATION_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC" },
    extra_spells = { { spell = "eoc_summon_setup", self = true } },
    effect = "spawn_item",
    effect_data = "technomancer_summoned_radio",
    shape = "blast",
    spell_class = "TECHNOMANCER",
    difficulty = 4,
    max_level = 15,
    min_duration = 30000,
    max_duration = 180000,
    duration_increment = 15000,
    magic_type = "magiclysm_conjuration_magic",
    base_casting_time = 6000,
    base_energy_cost = 300,
}
