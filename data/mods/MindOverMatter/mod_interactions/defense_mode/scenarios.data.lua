local ccb = require("ccb")

ccb.content.define_start_location {
    id = "sloc_phavian_office",
    name = ccb.content.text("Office?"),
    targets = { "office_cubical_phavian" },
}
