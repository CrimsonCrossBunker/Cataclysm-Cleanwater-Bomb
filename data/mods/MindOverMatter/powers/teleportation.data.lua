local ccb = require("ccb")

ccb.content.define_spell {
    id = "teleport_reality_tear_temporary",
    copy_from = "teleport_reality_tear",
    magic_type = "mom_psionics",
    valid_targets = { "ground" },
    effect = "attack",
    shape = "blast",
    min_range = { handler = "scale_teleport_reality_tear_temporary_min_range", fallback = 0.0 },
    max_range = 80,
    field = "fd_tear_in_reality_temporary",
    field_chance = 1,
    min_field_intensity = 2,
    max_field_intensity = 2,
}

ccb.content.define_spell {
    id = "teleport_reality_tear_permanent",
    copy_from = "teleport_reality_tear",
    magic_type = "mom_psionics",
    valid_targets = { "ground" },
    effect = "attack",
    shape = "blast",
    min_range = { handler = "scale_teleport_reality_tear_temporary_min_range", fallback = 0.0 },
    max_range = 80,
    field = "fd_fatigue",
    field_chance = 1,
    min_field_intensity = 3,
    max_field_intensity = 3,
}
