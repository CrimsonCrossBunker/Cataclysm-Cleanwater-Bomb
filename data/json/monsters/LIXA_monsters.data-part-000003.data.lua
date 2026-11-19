local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "LIXA_vector_volley",
    copy_from = "fake_item",
    name = ccb.content.text_without_extraction("coordinate rotation volley"),
    description = ccb.content.text_without_extraction("Fake gun that fires, uh.  Coordinate transform matrices?"),
    flags = { "NEVER_JAMS", "NO_TURRET" },
    gun = {
        modes = { { id = "DEFAULT", label = ccb.content.text("auto"), quantity = 3 } },
        effects = { "BLINDS_EYES", "NO_PENETRATE_OBSTACLES", "NO_DAMAGE_SCALING" },
        skill = "rifle",
        durability = 10,
        range = 100,
        dispersion = 5000,
        damage = { { type = "pure", amount = 8 } },
    },
}
