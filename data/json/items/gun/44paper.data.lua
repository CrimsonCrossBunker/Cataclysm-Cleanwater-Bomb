local ccb = require("ccb")

ccb.content.define_item {
    id = "colt_army",
    copy_from = "gun_base_handgun_manual",
    looks_like = "sw_619",
    name = ccb.content.text("civil war revolver"),
    description = ccb.content.text("The Colt Army Model 1860 is a cap & ball .44-caliber revolver.  It was used during the American Civil War, and made by Colt's Manufacturing Company."),
    variant_kind = "gun",
    variants = {
        {
            id = "colt_army",
            name = ccb.content.plural_text("Colt M1860 Army", "Colt M1860 Armies"),
            description = ccb.content.text("The Colt M1860 is a black powder, cap & ball revolver dating back to the Civil War.  While reloading it takes quite a while due to having to put a primer on each chamber manually, instead of having the primer in one unit with the casing, like metallic cartridges.  However, for the time 6 shots in quick succession was a great thing for cavalry and officers to have on the field.  Nowadays, this firearm is completely outdated, and only sees use in collections, reenactment, or special shooting competitions.  However, black powder guns such as this are less regulated than more modern firearms, so it is sometimes the first gun a youth may buy.  This one is chambered in .44, and while the number may remind some of .44 Magnum, it has nowhere near the ballistic effectiveness of .44 Magnum."),
        },
    },
    mass = "1188 g",
    volume = "486 ml",
    length = "373 mm",
    price = "430 USD",
    survival_price = "30 USD",
    materials = { "steel", "wood" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["44paper"] = 6 } } },
    inheritance = {
        add = {
            flags = {
                "NO_UNLOAD",
                "ALLOWS_BODY_BLOCK",
                "RELOAD_ONE",
                "NO_TURRET",
                "EASY_CLEAN",
                "SINGLE_ACTION",
            },
        },
    },
    gun = {
        ammunition = { "44paper" },
        dispersion = 400,
        mod_locations = { { id = "barrel", count = 1 }, { id = "stock mount", count = 1 } },
        durability = 7,
        blackpowder_tolerance = 96,
        clip_size = 6,
    },
}
