local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_bulletin_evac",
    copy_from = "f_bulletin_evac",
    examine_handler = "examine_f_bulletin_evac_classic",
}
