local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_FRIENDLY_VORTEX",
    name = ccb.content.text_without_extraction("Artifact Vortex"),
    description = ccb.content.text_without_extraction("Summon vortexes."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_vortex",
    shape = "blast",
    base_casting_time = 100,
    message = ccb.content.text("Space twists and deforms around you."),
    min_damage = 1,
    max_damage = 3,
    min_aoe = 5,
    max_aoe = 5,
    flags = { "RANDOM_DAMAGE", "HOSTILE_50", "NO_EXPLOSION_SFX" },
    min_duration = 40000,
    max_duration = 40000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_CALL_OF_TINDALOS",
    name = ccb.content.text_without_extraction("Artifact Call of Tindalos"),
    description = ccb.content.text_without_extraction("Summon hostile hounds of Tindalos."),
    valid_targets = { "ground" },
    effect = "summon",
    effect_data = "mon_hound_tindalos",
    shape = "blast",
    base_casting_time = 100,
    message = ccb.content.text("The world unravels into geometric shapes, and between the chaos you spot a horrid prowling beast."),
    min_damage = 1,
    max_damage = 1,
    min_aoe = 15,
    max_aoe = 15,
    min_duration = 40000,
    max_duration = 40000,
    flags = { "HOSTILE_SUMMON", "NO_EXPLOSION_SFX" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_FORCE_PULL",
    name = ccb.content.text_without_extraction("Artifact Force Pull"),
    description = ccb.content.text_without_extraction("Pull objects."),
    effect = "area_pull",
    shape = "blast",
    valid_targets = { "self", "ally", "hostile", "ground", "item", "field" },
    message = ccb.content.text("An unnatural implosion sends objects flying."),
    flags = { "NO_EXPLOSION_SFX" },
    min_range = 15,
    max_range = 15,
    min_aoe = 7,
    max_aoe = 7,
    base_casting_time = 100,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_TELEPORTITIS",
    name = ccb.content.text_without_extraction("Artifact Teleportitis"),
    description = ccb.content.text_without_extraction("Causes you to teleport uncontrollably."),
    message = ccb.content.text("The world loses coherence, with images of nearby places forming and disappearing around you."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "artifact_teleportitis_aura",
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
    min_duration = 4000,
    max_duration = 4000,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_SLOW",
    name = ccb.content.text_without_extraction("Artifact Slow"),
    description = ccb.content.text_without_extraction("Slows you for a few turns."),
    message = ccb.content.text("The world shifts blue, and reality accelerates around you."),
    valid_targets = { "self" },
    effect = "attack",
    effect_data = "artifact_slow_aura",
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
    min_duration = 900,
    max_duration = 900,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_TIME_STOP",
    name = ccb.content.text_without_extraction("Artifact Time Stop"),
    description = ccb.content.text_without_extraction("Grants you a few turns of super speed."),
    message = ccb.content.text("Stale golden light floods the world, and reality stands still."),
    valid_targets = { "self" },
    effect = "mod_moves",
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    min_damage = 500,
    max_damage = 500,
    base_casting_time = 100,
}
