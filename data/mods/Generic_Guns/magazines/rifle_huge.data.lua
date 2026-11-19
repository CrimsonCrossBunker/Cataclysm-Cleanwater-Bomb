local ccb = require("ccb")

ccb.content.define_item {
    id = "rifle_huge_belt",
    copy_from = "magazine_belt",
    name = ccb.content.text("heavy machine gun belt"),
    description = ccb.content.text("An ammo belt consisting of metal linkages which separate from the belt upon firing.  Holds huge rifle ammunition."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_rifle_huge = 100 }, rigid = false } },
    magazine = {
        ammunition = { "ammo_rifle_huge" },
        linkage = "ammolinkrifle_huge",
        capacity = 100,
        count = 100,
    },
}

ccb.content.define_item {
    id = "rifle_huge_amr_mag",
    copy_from = "m107a1mag",
    name = ccb.content.text("anti-materiel rifle magazine"),
    description = ccb.content.text("A huge 10 round magazine for anti-materiel rifles."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_rifle_huge = 10 }, rigid = true } },
    magazine = { ammunition = { "ammo_rifle_huge" } },
}
