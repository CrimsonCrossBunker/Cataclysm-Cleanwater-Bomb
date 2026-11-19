local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "LIXA_spit_light",
    copy_from = "fake_item",
    name = ccb.content.text_without_extraction("photonic gun"),
    description = ccb.content.text_without_extraction("Horks up a glob of congealed light."),
    flags = { "NEVER_JAMS", "NO_TURRET" },
    gun = {
        effects = { "BLINDS_EYES", "NO_DAMAGE_SCALING", "NO_PENETRATE_OBSTACLES" },
        skill = "rifle",
        durability = 10,
        range = 100,
        dispersion = 1000,
        damage = { type = "pure", amount = 4 },
    },
}
