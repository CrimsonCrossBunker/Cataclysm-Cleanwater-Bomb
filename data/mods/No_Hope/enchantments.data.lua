local ccb = require("ccb")

ccb.content.define_spell {
    id = "destruction_ray",
    name = ccb.content.text("Destruction Ray"),
    description = ccb.content.text("Pre-nerf flaming eye's destruction ray."),
    valid_targets = { "hostile", "ground" },
    effect = "bash",
    extra_spells = { { spell = "flaming_eye_damage" } },
    flags = { "NO_PROJECTILE", "IGNORE_WALLS" },
    shape = "line",
    min_damage = 999,
    max_damage = 999,
    min_aoe = 1,
    max_aoe = 1,
    min_range = 20,
    max_range = 20,
}

ccb.content.define_spell {
    id = "flaming_eye_damage",
    name = ccb.content.text("Flaming Eye Damage"),
    description = ccb.content.text("Damage with the destruction ray."),
    valid_targets = { "hostile" },
    effect = "attack",
    damage_type = "bash",
    flags = { "NO_PROJECTILE", "IGNORE_WALLS" },
    shape = "blast",
    min_damage = 20,
    max_damage = 50,
    min_range = 20,
    max_range = 20,
}

ccb.content.define_spell {
    id = "flaming_eye_warming_up",
    name = ccb.content.text("Flaming Eye Notify"),
    description = ccb.content.text("Flaming Eye warms up before activating its destruction ray."),
    valid_targets = { "hostile", "ground", "ally" },
    effect = "attack",
    shape = "blast",
    effect_data = "flaming_eye_warming_up",
    flags = { "NO_PROJECTILE", "IGNORE_WALLS", "SILENT" },
    min_range = 20,
    max_range = 20,
}
