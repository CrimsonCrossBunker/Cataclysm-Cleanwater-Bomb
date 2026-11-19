local ccb = require("ccb")

ccb.content.define_start_location {
    id = "sloc_magic_basement",
    name = ccb.content.text("Wizard's Secret Basement Study"),
    targets = { "magic_basement" },
}

ccb.content.define_start_location {
    id = "sloc_lake_retreat",
    name = ccb.content.text("Wizard's lake retreat"),
    targets = { "lake_retreat_ground" },
}

ccb.content.define_start_location {
    id = "sloc_last_mage_on_earth",
    name = ccb.content.text("Last Mage on Earth Shelter"),
    targets = { "last_mage_on_earth_shelter" },
}
