local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_holo_transposition_caster",
    name = ccb.content.plural_text("hologram transposition caster", "hologram transposition casters"),
    copy_from = "afs_caster",
    description = ccb.content.text("A small metallic sphere with a recessed bottom up top.  When activated it will allow you to swap positions with an existing hologram."),
    pockets = { { kind = "MAGAZINE", ammunition = { battery = 15 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { regenerate_ammo = true, recharge_type = "periodic", interval = "1 h" } },
    use_actions = { { kind = "cast_spell", spell = "afs_holo_transposition", no_fail = true, level = 1 } },
}

ccb.content.define_item {
    id = "afs_holo_flare_caster",
    copy_from = "afs_caster",
    name = ccb.content.plural_text("hologram flare caster", "hologram flare casters"),
    description = ccb.content.text("A small metallic sphere with a recessed bottom up top.  When activated it will allow you to select a hologram, which will explode in a blinding flash, stunning anything nearby."),
    pockets = { { kind = "MAGAZINE", ammunition = { battery = 15 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { regenerate_ammo = true, recharge_type = "periodic", interval = "1 h" } },
    use_actions = { { kind = "cast_spell", spell = "afs_holo_flare", no_fail = true, level = 1 } },
}

ccb.content.define_item {
    id = "afs_holo_decoy_caster",
    copy_from = "afs_caster",
    name = ccb.content.plural_text("decoy caster", "decoy casters"),
    description = ccb.content.text("A small metallic sphere with a recessed bottom up top.  When activated it will a holographic decoy in a location of your choosing."),
    pockets = { { kind = "MAGAZINE", ammunition = { battery = 2 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { regenerate_ammo = true, recharge_type = "periodic", interval = "1 h" } },
    use_actions = { { kind = "cast_spell", spell = "afs_holo_decoy", no_fail = true, level = 1 } },
}

ccb.content.define_item {
    id = "afs_holo_field_caster",
    copy_from = "afs_caster",
    name = ccb.content.plural_text("decoy field caster", "decoy field casters"),
    description = ccb.content.text("A small metallic sphere with a recessed bottom up top.  When activated it will create several holographic decoys around you."),
    pockets = { { kind = "MAGAZINE", ammunition = { battery = 1 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { regenerate_ammo = true, recharge_type = "periodic", interval = "1 h" } },
    use_actions = { { kind = "cast_spell", spell = "afs_holo_field", no_fail = true, level = 1 } },
}
