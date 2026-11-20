local ccb = require("ccb")

return ccb.ModDefinition {
    id = "Rummaging",
    name = ccb.content.text("Rummaging"),
    authors = { "Aunt_Su | 苏大妈#7831" },
    description = ccb.content.text("Some furniture containers need to open the door to scavenge, to enhance the thrill of scavenging."),
    category = "misc_additions",
    obsolete = true,
    dependencies = { "ccb" },
    ordered_data_files = true,
}
