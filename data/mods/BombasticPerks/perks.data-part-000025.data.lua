local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_ewwww_de_zombie",
    name = ccb.content.text("Ewwww de Zombie"),
    description = ccb.content.text("The zombies have some way to distinguish between the living and the dead, and you're sure that smell is a big part of it.  That's why they don't attack the ferals, because they're dirty and covered in zombie blood.  If you covered yourself in zombie blood, you bet you could sneak past them.\n\nYou can make Ewwww de Zombie from tainted blood and flesh.  Coat yourself with it and zombies will ignore you."),
    points = 0,
    purifiable = false,
    valid = false,
    flags = { "PERK" },
}
