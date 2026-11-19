local ccb = require("ccb")

-- 212.852 + 58.4mm max OAL for 454. Revolvers just built different.
ccb.content.define_item {
    id = "460_xvr",
    copy_from = "gun_base_handgun_manual",
    looks_like = "sw_619",
    name = ccb.content.text(".460 S&W Magnum revolver"),
    description = ccb.content.text("A behemoth of a revolver, with an 8.38\" barrel, weighing over 2 kilograms, and sporting an impressive muzzle break.  With how powerful the .460 S&W Magnum round is, those features won't be taken for granted.  Often used as a hunting handgun, or as a bush gun, this large revolver is a formidable threat."),
    mass = "2041 g",
    volume = "1167 ml",
    variant_kind = "gun",
    variants = {
        {
            id = "460_xvr",
            name = ccb.content.plural_text("S&W 460XVR revolver", "S&W 460XVR revolver"),
            description = ccb.content.text("The S&W 460XVR is a behemoth of a revolver, with an 8.38\" barrel, weighing over 2 kilograms, and sporting an impressive muzzle break.  With how powerful the .460 S&W Magnum round is, those features won't be taken for granted.  Often used as a hunting handgun, or as a bush gun, this large revolver is a formidable threat."),
        },
    },
    length = "332 mm",
    price = "1639 USD",
    survival_price = "30 USD",
    materials = { "steel", "plastic" },
    pockets = { { kind = "MAGAZINE", ammunition = { ["460sw"] = 5 } } },
    gun = {
        barrel_length = "271 mm",
        ammunition = { "460sw" },
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
