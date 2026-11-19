local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_RESONANCE_BARRIER",
    name = ccb.content.text_without_extraction("Artifact resonance barrier"),
    description = ccb.content.text_without_extraction("Creates a low hp energy shield around you."),
    message = ccb.content.text("Your surroundings start shimmering."),
    valid_targets = { "self" },
    effect = "spawn_item",
    effect_data = "artifact_energy_shield",
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
    min_duration = 1200,
    max_duration = 1200,
}
