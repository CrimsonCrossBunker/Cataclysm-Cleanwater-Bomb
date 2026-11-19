local ccb = require("ccb")

-- 88.9mm + 58mm max OAL for 500mag. Revolvers just built different.
ccb.content.define_item {
    id = "sw_500",
    copy_from = "gun_base_handgun_manual",
    looks_like = "sw_619",
    name = ccb.content.text(".500 Magnum revolver"),
    description = ccb.content.text("The definition of 'overkill', this behemoth handgun puts large .44 caliber revolvers to shame with its sheer size, power, and immense chambering.  Firing the appropriately named .500 Magnum cartridge, the most powerful handgun round in the world, the weapon has seen work in both sport shooting and hunting roles.  A pistol for those of the 'bigger is better' mentality, a high recoil junky's personal dream, and an all-around useless military sidearm, should the urge to assault the Cataclysm in fine style grip you, this giant provides you with 5 rounds with which to reduce a zombie into an afterthought."),
    variant_kind = "gun",
    variants = {
        {
            id = "sw_500",
            name = ccb.content.text("S&W 500 revolver"),
            description = ccb.content.text("The 5-shot Smith and Wesson 500 revolver fires the comparably-named .500 S&W Magnum.  It's an impressive weapon."),
        },
    },
    mass = "1960 g",
    volume = "1307 ml",
    price = "900 USD",
    survival_price = "35 USD",
    length = "407 mm",
    materials = { "steel", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ["500"] = 5 },
            allowed_speedloaders = { "500_speedloader5" },
        },
    },
    gun = {
        barrel_length = "147 mm",
        ammunition = { "500" },
        dispersion = 280,
        clip_size = 5,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}
