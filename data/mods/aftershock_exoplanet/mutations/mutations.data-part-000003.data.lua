local ccb = require("ccb")

ccb.content.define_mutation {
    id = "MIGO_RAD_ADAPTION",
    name = ccb.content.text("Radioactive Environment Adaptation"),
    points = 2,
    description = ccb.content.text("You think you know how to instruct your body to process radioactive particles out of itself faster than normal."),
    categories = { "MIGO" },
    active = true,
    on_activate = "activate_migo_rad_adaption",
}

ccb.content.define_mutation {
    id = "MIGO_THRESH_RAD_FLUSH",
    name = ccb.content.text("Radiation Flush"),
    points = 5,
    description = ccb.content.text("You can instruct your immune system to flush out radioactive particles at an enviable speed."),
    prerequisites = { "MIGO_RAD_ADAPTION" },
    categories = { "MIGO" },
    threshold_requirements = { "THRESH_YUGGOTH" },
    active = true,
    on_activate = "activate_migo_thresh_rad_flush",
}
