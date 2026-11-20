local ccb = require("ccb")

return ccb.ModDefinition {
    id = "standard_combat_test",
    name = ccb.content.text("Standard combat test suite"),
    authors = { "Venera3" },
    maintainers = { "Venera3" },
    conflicts = { "hunvre" },
    description = ccb.content.text("A set of standard character loadouts to facilitate objective monster testing.  Disables all but the test scenarios."),
    dependencies = { "ccb" },
    ordered_data_files = true,
}
