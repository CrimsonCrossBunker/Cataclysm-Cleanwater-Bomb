local ccb = require("ccb")

ccb.content.define_spell {
    id = "iso_robolove_charm_1",
    name = ccb.content.text("Its a teapot!"),
    description = ccb.content.text("Makes a robot friendly for a very long time."),
    valid_targets = { "self" },
    flags = { "NO_EXPLOSION_SFX", "SILENT" },
    effect = "attack",
    damage_type = "pure",
    shape = "blast",
    min_aoe = 15,
    max_aoe = 15,
    min_range = 10,
    max_range = 10,
    extra_spells = { { spell = "iso_robolove_charm_2" } },
}

ccb.content.define_spell {
    id = "iso_robolove_charm_2",
    name = ccb.content.text("robot charm"),
    description = ccb.content.text("!"),
    valid_targets = { "hostile" },
    flags = { "NO_LEGS", "SILENT", "RANDOM_TARGET", "NO_PROJECTILE" },
    targeted_species = { "ROBOT", "CYBORG" },
    min_duration = 1080000,
    max_duration = 1080000,
    effect = "charm_monster",
    min_damage = 360000,
    max_damage = 360000,
    min_range = 10,
    max_range = 10,
    difficulty = 1,
    shape = "blast",
}
