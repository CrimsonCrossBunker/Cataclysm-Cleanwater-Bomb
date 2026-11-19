local ccb = require("ccb")

ccb.content.define_item {
    id = "laser_rifle",
    copy_from = "laser_rifle",
    name = ccb.content.text("A7 laser rifle"),
    gun = { damage = { type = "psi_photokinetic_damage", amount = 25, penetration = 4 } },
}

ccb.content.define_item {
    id = "bio_laser_gun",
    copy_from = "bio_laser_gun",
    name = ccb.content.text("laser finger"),
    gun = { damage = { type = "psi_photokinetic_damage", amount = 10, penetration = 4 } },
}

ccb.content.define_item {
    id = "v29",
    copy_from = "v29",
    name = ccb.content.text("V29 laser pistol"),
    gun = { damage = { type = "psi_photokinetic_damage", amount = 10, penetration = 4 } },
}

ccb.content.define_item {
    id = "v29_turret",
    copy_from = "v29_turret",
    name = ccb.content.text("mounted laser"),
    gun = { damage = { type = "psi_photokinetic_damage", amount = 10, penetration = 4 } },
}

ccb.content.define_item {
    id = "recon_mech_laser_single",
    copy_from = "recon_mech_laser_single",
    name = ccb.content.text("salvaged RMES marksman laser"),
    gun = { damage = { type = "psi_photokinetic_damage", amount = 30, penetration = 4 } },
}

ccb.content.define_item {
    id = "recon_mech_laser",
    copy_from = "recon_mech_laser",
    name = ccb.content.text("RMES marksman system"),
    gun = { damage = { type = "psi_photokinetic_damage", amount = 30, penetration = 4 } },
}

ccb.content.define_item {
    id = "gatling_mech_laser_single",
    copy_from = "gatling_mech_laser_single",
    name = ccb.content.text("salvaged CMES laser cannon"),
    gun = { damage = { type = "psi_photokinetic_damage", amount = 20, penetration = 4 } },
}

ccb.content.define_item {
    id = "gatling_mech_laser",
    copy_from = "gatling_mech_laser",
    name = ccb.content.text("CMES laser cannon"),
    gun = { damage = { type = "psi_photokinetic_damage", amount = 20, penetration = 4 } },
}
