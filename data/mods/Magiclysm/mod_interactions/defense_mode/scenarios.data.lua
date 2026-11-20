local ccb = require("ccb")

ccb.content.define_scenario {
    copy_from = "defense_mode_fortified",
    extend = { locations = { "sloc_lake_retreat" } },
    id = "defense_mode_fortified",
}
