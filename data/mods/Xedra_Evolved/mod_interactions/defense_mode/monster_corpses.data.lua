local ccb = require("ccb")

ccb.content.define_item {
    id = "broken_dm_exodii_worker",
    name = ccb.content.plural_text("broken Exodii worker", "broken Exodii workers"),
    copy_from = "broken_exodii_worker",
}

ccb.content.define_item {
    id = "broken_dm_exodii_quad",
    name = ccb.content.plural_text("broken Exodii quadruped", "broken Exodii quadrupeds"),
    copy_from = "broken_exodii_quad",
}

ccb.content.define_item {
    id = "broken_dm_exodii_quad_jotunn",
    name = ccb.content.plural_text("broken Exodii Jotunn", "broken Exodii Jotunns"),
    copy_from = "broken_exodii_quad_jotunn",
}
