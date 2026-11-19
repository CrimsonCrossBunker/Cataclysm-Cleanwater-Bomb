local ccb = require("ccb")

ccb.content.define_item {
    id = "LIXA_spit_light",
    copy_from = "LIXA_spit_light",
    gun = { damage = { type = "psi_photokinetic_damage", amount = 4 } },
}

ccb.content.define_item {
    id = "LIXA_vector_volley",
    copy_from = "LIXA_vector_volley",
    gun = {
        damage = {
            { type = "pure", amount = 8 },
            { type = "psi_teleporter_teleporting_damage", amount = 1 },
        },
    },
}
