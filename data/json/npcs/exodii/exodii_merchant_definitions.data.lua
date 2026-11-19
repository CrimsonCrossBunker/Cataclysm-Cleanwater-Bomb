local ccb = require("ccb")

ccb.content.define_item {
    id = "pamd68rubik",
    copy_from = "pamd68",
    name = ccb.content.text("Rubik's Exodii battle rifle"),
    description = ccb.content.text("The most popular gun to use the 12.3ln cartridge was, of course, the PA md. 71.  Its predecessor, the md. 68, was viewed by many as a sort of failure: although it was reliable and powerful, it was too heavy to be used as a good infantry weapon, and not really heavy enough to be a good support gun.  Enough were made, though, that during the zombie apocalypse, it gained a great deal of resurgent popularity as a light emplacement gun that used readily available ammunition.  It perfectly served the purposes of the Exodii, who had far less concern about its unwieldiness.\n\nThis particular rifle has been painted a dusty pink color and has a picture of a smiling eel twisting along the barrel."),
    variant_kind = "gun",
    variants = {
        {
            id = "pamd68",
            name = ccb.content.text("Rubik's PA md. 68 battle rifle"),
            description = ccb.content.text("The most popular gun to use the 12.3ln cartridge was, of course, the PA md. 71.  Its predecessor, the md. 68, was viewed by many as a sort of failure: although it was reliable and powerful, it was too heavy to be used as a good infantry weapon, and not really heavy enough to be a good support gun.  Enough were made, though, that during the zombie apocalypse, it gained a great deal of resurgent popularity as a light emplacement gun that used readily available ammunition.  It perfectly served the purposes of the Exodii, who had far less concern about its unwieldiness.\n\nThis particular rifle has been painted a dusty pink color and has a picture of a smiling eel twisting along the barrel."),
        },
    },
    inheritance = { add = { flags = { "TRADER_KEEP_EQUIPPED", "NO_TURRET" } } },
    gun = {},
}
