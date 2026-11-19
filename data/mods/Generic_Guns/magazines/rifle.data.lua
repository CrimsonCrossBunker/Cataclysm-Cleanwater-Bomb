local ccb = require("ccb")

ccb.content.define_item {
    id = "rifle_belt",
    copy_from = "magazine_belt",
    name = ccb.content.text("ammo belt"),
    description = ccb.content.text("An ammo belt consisting of metal linkages which separate from the belt upon firing.  Holds rifle ammunition."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_rifle = 500 }, rigid = false } },
    magazine = {
        ammunition = { "ammo_rifle" },
        capacity = 500,
        count = 100,
        default_ammo = "rifle_ball",
        linkage = "ammolinkrifle",
    },
}

ccb.content.define_item {
    id = "rifle_mag",
    copy_from = "falbigmag",
    materials = { "aluminum" },
    name = ccb.content.text("standard rifle magazine"),
    description = ccb.content.text("A 30 round standard capacity magazine for service rifles, cheaper than the cost of a meal due to its adoption by nearly every other common rifle.  They're made of aluminum and were originally meant to be disposable, so they're not the most durable; don't let them get damaged."),
    volume = "500 ml",
    pockets = {
        {
            kind = "MAGAZINE",
            ammunition = { ammo_rifle = 30 },
            allowed_speedloaders = { "rifle_clip" },
            rigid = true,
        },
    },
    magazine = { ammunition = { "ammo_rifle" } },
}

ccb.content.define_item {
    id = "rifle_sniper_mag",
    copy_from = "m2010mag",
    name = ccb.content.text("compact rifle magazine"),
    description = ccb.content.text("A short 5 round steel magazine compatible with nearly every common rifle.  Although it has a low capacity it is easy to store and quick to reload."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_rifle = 5 }, rigid = true } },
    magazine = { ammunition = { "ammo_rifle" } },
}

ccb.content.define_item {
    id = "rifle_mag_foreign",
    copy_from = "exodiiBRmag",
    name = ccb.content.text("foreign rifle magazine"),
    description = ccb.content.text("An unreasonably large magazine for the unusual Exodii rifles, custom designed and manufactured by the Exodii."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ammo_rifle_foreign = 60 } } },
    magazine = { ammunition = { "ammo_rifle_foreign" } },
}

ccb.content.define_item {
    id = "rifle_sniper_mag_foreign",
    copy_from = "exodiiminimag",
    name = ccb.content.text("foreign sniper rifle magazine"),
    description = ccb.content.text("A small, sleek magazine for the unusual Exodii sniper rifles."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ammo_rifle_foreign = 10 } } },
    magazine = { ammunition = { "ammo_rifle_foreign" } },
}

ccb.content.define_item {
    id = "rifle_mag_cannon",
    copy_from = "ree_33_4_mag",
    name = ccb.content.text("cannon rifle magazine"),
    description = ccb.content.text("Small magazine for exodii cannon rifle."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ammo_rifle_cannon = 4 } } },
    magazine = { ammunition = { "ammo_rifle_cannon" } },
}

ccb.content.define_item {
    id = "rifle_mag_cannon_big",
    copy_from = "ree_33_53_mag",
    name = ccb.content.text("cannon rifle box magazine"),
    description = ccb.content.text("Bulky box magazine for exodii cannon rifle."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ammo_rifle_cannon = 53 } } },
    magazine = { ammunition = { "ammo_rifle_cannon" } },
}

ccb.content.define_item {
    id = "rifle_rail_mag",
    copy_from = "hk_g80mag",
    name = ccb.content.text("railgun rifle magazine"),
    description = ccb.content.text("A railgun rifle magazine which can hold up to 20 ferromagnetic projectiles."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ammo_railgun = 20 } } },
    magazine = { ammunition = { "ammo_railgun" } },
}

ccb.content.define_item {
    id = "rifle_clip",
    copy_from = "clip223_10rd",
    name = ccb.content.text("rifle clip"),
    description = ccb.content.text("A tiny piece of grooved metal designed to allow a shooter to quickly load ten rifle rounds into a magazine."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ammo_rifle = 10 } } },
    magazine = { ammunition = { "ammo_rifle" } },
}
