local ccb = require("ccb")

ccb.content.define_scenario {
    copy_from = "defense_mode_fortified",
    extend = { locations = { "sloc_phavian_office" } },
    id = "defense_mode_fortified",
}

ccb.content.define_start_location {
    id = "sloc_phavian_office",
    name = ccb.content.text("Office?"),
    targets = { "office_cubical_phavian" },
}
