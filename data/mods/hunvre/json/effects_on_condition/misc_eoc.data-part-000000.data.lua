local ccb = require("ccb")

-- This needs to be above the ter_furn_transform definitions down there.
ccb.content.define_furniture {
    id = "f_bed_retractable",
    copy_from = "f_bed",
    name = ccb.content.text("Bed"),
    description = ccb.content.text("Bed"),
    examine_handler = "examine_retractable_furniture",
}

-- This needs to be above the ter_furn_transform definitions down there.
ccb.content.define_furniture {
    id = "f_shower_retractable",
    copy_from = "f_shower",
    name = ccb.content.text("Shower"),
    description = ccb.content.text("Shower"),
    examine_handler = "examine_retractable_furniture",
}
