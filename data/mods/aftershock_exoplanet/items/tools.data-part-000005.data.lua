local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_bionic_power_mod",
    copy_from = "mod_battery",
    category = "spare_parts",
    name = ccb.content.plural_text("cybernetic power port mod", "cybernetic power port mods"),
    description = ccb.content.text("This device replaces standard power connections and battery ports for electronic devices with a carefully-shaped port that hooks into bionic implants.  When applied, it will convert an item to run directly off of bionic power."),
    flags = { "USES_BIONIC_POWER", "NO_UNLOAD", "NO_RELOAD" },
    toolmod = { ammo_types = { "battery" } },
}
