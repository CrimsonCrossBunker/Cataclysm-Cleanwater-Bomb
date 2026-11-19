local ccb = require("ccb")

ccb.content.define_item {
    id = "rifle_huge_amr",
    copy_from = "m107a1",
    name = ccb.content.text("anti-materiel rifle"),
    description = ccb.content.text("Large, intimidating, and overbuilt, this hefty rifle fires huge projectiles with relative precision.  Though it resembles a sniper rifle, this anti-materiel weapon is best suited for blinding tanks, shooting at aircraft, or destroying explosives.  It feeds from comically oversized magazines."),
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "rifle_huge_amr_mag" },
            rigid = true,
        },
    },
    gun = { ammunition = { "ammo_rifle_huge" } },
}

ccb.content.define_item {
    id = "rifle_huge_double",
    copy_from = "win70_458",
    name = ccb.content.text("elephant rifle"),
    description = ccb.content.text("Elegantly engraved, with deep glossy blued steel and figured wood, this break-action double rifle is almost too nice to shoot.  Your shoulder might beg you not to; the chambers are almost wide enough for two fingers and the recoil is monstrous.  You could probably kill anything with this, especially if you were to fire both barrels at once."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_rifle_huge = 2 }, rigid = true } },
    inheritance = { add = { flags = { "RELOAD_ONE" } } },
    gun = {
        ammunition = { "ammo_rifle_huge" },
        modes = {
            { id = "DEFAULT", label = ccb.content.text("single"), quantity = 1 },
            {
                id = "DOUBLE",
                label = ccb.content.text("double"),
                quantity = 2,
                flags = { "VOLLEY" },
            },
        },
        clip_size = 2,
    },
}

ccb.content.define_item {
    id = "rifle_huge_hmg",
    copy_from = "m2browning",
    name = ccb.content.text("heavy machine gun"),
    description = ccb.content.text("This large, ungainly  belt-fed machine gun fires huge projectiles, originally intended for turn of the century anti-vehicular use.  While no longer suitable for modern tanks or aircraft, thinner skinned vehicles or drones are just as susceptible, as are any other 'smaller' threats.  Slow to reload, incredibly loud, and must be mounted to be fired."),
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "rifle_huge_belt" },
            rigid = true,
        },
    },
    gun = { ammunition = { "ammo_rifle_huge" } },
}
