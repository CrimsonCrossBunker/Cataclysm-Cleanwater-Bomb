local ccb = require("ccb")

ccb.content.define_magic_type {
    id = "xe_fey_magick",
    energy_source = "MANA",
    cannot_cast_flags = { "NO_FEY_MAGIC", "NO_SPELLCASTING" },
    cannot_cast_message = ccb.content.text("You can't use your glamours now!"),
}
