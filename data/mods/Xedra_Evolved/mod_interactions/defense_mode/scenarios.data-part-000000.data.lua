local ccb = require("ccb")

ccb.content.define_scenario {
    copy_from = "defense_mode_fortified",
    extend = { locations = { "sloc_defense_mode_border_office" } },
    id = "defense_mode_fortified",
}
