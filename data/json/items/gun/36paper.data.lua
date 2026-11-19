local ccb = require("ccb")

ccb.content.define_item {
    id = "colt_navy",
    copy_from = "gun_base_handgun_manual",
    looks_like = "sw_619",
    name = ccb.content.text("civil war six-shooter"),
    description = ccb.content.text("The Colt Model 1861 Navy cap & ball .36-caliber revolver was a six-shot, single-action percussion weapon produced by Colt's Manufacturing Company from 1861 until 1873."),
    variant_kind = "gun",
    variants = {
        {
            id = "colt_navy",
            name = ccb.content.plural_text("Colt M1861 Navy", "Colt M1861 Navies"),
            description = ccb.content.text("The Colt M1861 is a black powder, cap & ball revolver dating back to the Civil War.  While reloading it takes quite a while due to having to put a primer on each chamber manually, instead of having the primer in one unit with the casing, like metallic cartridges.  However, for the time 6 shots in quick succession was a great thing for cavalry and officers to have on the field, though this version was much rarer than the more popular Colt M1860.  Nowadays, this firearm is completely outdated, and only sees use in collections, reenactment, or special shooting competitions.  However, black powder guns such as this are less regulated than more modern firearms, so it is sometimes the first gun a youth may buy.  This one is chambered in .36, weaker than the M1860's .44."),
        },
    },
    mass = "1184 g",
    volume = "540 ml",
    length = "351 mm",
    price = "300 USD",
    survival_price = "30 USD",
    materials = { "steel", "wood" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["36paper"] = 6 } } },
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
        ammunition = { "36paper" },
        dispersion = 450,
        mod_locations = { { id = "barrel", count = 1 }, { id = "stock mount", count = 1 } },
        durability = 7,
        blackpowder_tolerance = 96,
        clip_size = 6,
        reload_time = 500,
    },
}
