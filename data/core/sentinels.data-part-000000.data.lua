local ccb = require("ccb")

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
