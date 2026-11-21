local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_soothing_the_savage_beast",
    name = ccb.content.text("Soothing the Savage Beast"),
    description = ccb.content.text("Disney princesses stand back!  You have learned the secret tongues of bird and beast, or at least, you can howl or chirp in such a way that they consider it an offer of friendship.  Activate this perk to charm any nearby mammals, birds, amphibians, reptiles, or fish (not insects or spiders)."),
    points = 0,
    purifiable = false,
    valid = false,
    active = true,
    on_activate = "soothing_the_savage_beast",
    flags = { "PERK" },
}
