local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_broken_cyborg",
    copy_from = "mon_broken_cyborg",
    inheritance = { add = { armor = { poison = 20, necrotic = 8, psionic = 8 } } },
}

ccb.content.define_monster {
    id = "mon_prototype_cyborg",
    copy_from = "mon_prototype_cyborg",
    inheritance = { add = { armor = { poison = 15, necrotic = 6, psionic = 10 } } },
}

ccb.content.define_monster {
    id = "mon_exodii_worker",
    copy_from = "mon_exodii_worker",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_exodii_quad",
    copy_from = "mon_exodii_quad",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}
