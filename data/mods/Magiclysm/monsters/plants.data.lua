local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_tanglevine_triffid",
    copy_from = "mon_tanglevine",
    species = { "PLANT", "SUMMONED_CREATURE" },
    default_faction = "triffid",
}
