local ccb = require("ccb")

ccb.content.define_item {
    id = "matrix_crystal_pyrokinesis",
    name = ccb.content.plural_text("strange crystal, red", "strange crystal, red"),
    copy_from = "matrix_crystal_biokinesis",
    description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing red light in its depths.  Holding it, you feel hot."),
    color = "red",
    flags = { "MATRIX_CRYSTAL_PYROKINESIS", "RELIC_PINK" },
    tool = {},
}
