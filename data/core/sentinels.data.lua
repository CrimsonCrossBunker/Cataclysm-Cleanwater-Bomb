local ccb = require("ccb")

ccb.content.define_ammunition_type {
    id = "NULL",
    name = ccb.content.text("none"),
    default_item = "null",
}

ccb.content.define_map_extra {
    id = "mx_null",
    name = ccb.content.text("Nothing"),
    description = ccb.content.text("Nothing of interest is here."),
    generator = { method = "null", id = "mx_null" },
}

ccb.content.define_trap {
    id = "tr_null",
    name = ccb.content.text("none"),
    color = "white",
    symbol = "?",
    visibility = 20,
    avoidance = 0,
    difficulty = 0,
    action = "none",
    benign = true,
}

ccb.content.define_field_type {
    id = "fd_null",
    legacy_enum_id = 0,
    levels = { { name = ccb.content.text("nothing") } },
}

ccb.content.define_fault {
    id = "null",
    name = ccb.content.text("This is a bug"),
    description = ccb.content.text("This fault id is a reserved sentinel."),
}

ccb.content.define_spell {
    id = "null",
    name = ccb.content.text("none"),
    description = ccb.content.text("seeing this is a bug"),
    valid_targets = { "self" },
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    shape = "blast",
    effect = "attack",
}

ccb.content.define_vehicle_part_location {
    id = "",
    name = ccb.content.text("none"),
    z_order = 0,
    list_order = 5,
}
