local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_atlas_pavement_white",
    copy_from = "t_pavement",
    name = ccb.content.text("lane marking"),
    description = ccb.content.text("A white lane marking painted on asphalt."),
    symbol = ".",
    color = "white",
    looks_like = "t_pavement",
}
