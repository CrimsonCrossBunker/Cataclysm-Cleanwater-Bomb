local ccb = require("ccb")

ccb.content.define_item {
    id = "iso_old_cloak",
    copy_from = "cape_sci_fi",
    name = ccb.content.text("tattered cloak"),
    description = ccb.content.text("The cloak of an imperial envoy, depicting a star chart in gold thread.  It's terribly worn and frayed."),
    materials = { "wool" },
    armor = {},
}
