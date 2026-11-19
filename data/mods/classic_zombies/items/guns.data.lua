local ccb = require("ccb")

-- The C7A1 is semi or full-auto with a 20 in. barrel, which it shares with the M16A3 it overrides.
ccb.content.define_item {
    id = "modular_m16_auto_rifle",
    copy_from = "modular_m16_auto_rifle",
    name = ccb.content.text("C7 assault rifle"),
    description = ccb.content.text("The C7A1 is the standard issue rifle for the Canadian military manufactured by Diemaco.  It is a gas-operated, rotating bolt rifle known for its accuracy and controllable recoil."),
    variant_kind = "gun",
    variants = {
        {
            id = "modular_m16a3",
            name = ccb.content.text("C7"),
            description = ccb.content.text("The standard issue rifle for the Canadian armed forces, featuring a 20 in. long barrel and full auto capabilities when fed from STANAG magazines."),
            weight = 100,
        },
        {
            id = "c7a1",
            name = ccb.content.text("C7A1"),
            description = ccb.content.text("This is the updated model of the C7 carbine, using a modified Weaver rail instead of a carrying handle/iron sight assembly to assist in mounting optics."),
            weight = 5,
        },
    },
    gun = {},
}

ccb.content.define_item {
    id = "modular_m4_carbine",
    copy_from = "modular_m4_carbine",
    looks_like = "modular_ar15",
    name = ccb.content.text("C8 carbine"),
    description = ccb.content.text("A carbine variant of the C7A1, recently introduced by the Canadian armed forces.  Though accurate, small, and lightweight, it is infamous for its unreliability when not properly maintained.  It is chambered in 5.56x45mm and accepts STANAG magazines."),
    variants = {
        {
            id = "modular_m4a1",
            name = ccb.content.text("C8"),
            description = ccb.content.text("The standard issue carbine for the Canadian armed forces, featuring a 14.5 in. long barrel and full auto capabilities when fed from STANAG magazines."),
            ascii_picture = "modular_m4a1",
            weight = 1,
        },
        {
            id = "m4_cqbr",
            name = ccb.content.text("C8CQB"),
            description = ccb.content.text("This is the updated model of the C7 carbine, using a modified Weaver rail instead of a carrying handle/iron sight assembly to assist in mounting optics."),
        },
    },
    gun = {},
}

ccb.content.define_item {
    id = "hi_power_9mm",
    name = ccb.content.text("Browning Hi-Power"),
    copy_from = "hi_power_9mm",
    description = ccb.content.text("A licensed copy of the Browning Hi-Power, made by John Inglis and Company.  Issued to officers and infantry in need of a weapon for confined spaces, this is chambered in 9x19 Parabellum."),
    gun = {},
}

-- Simply renaming the pistol like the Hi-Power above doesn't work because of the variants, which the M45A1 is too modern to exist in DDotD
-- You can get 'em for over US$1K if you want.  This is a fairly cheap remake.
ccb.content.define_item {
    id = "m1911a1",
    copy_from = "m1911",
    looks_like = "glock_17",
    name = ccb.content.text("M1911A1"),
    description = ccb.content.text("This is a semi-automatic pistol, chambered in .45 ACP and accepting M1911 magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "m1911",
            name = ccb.content.text("M1911"),
            description = ccb.content.text("The M1911 was the US Military standard-issue sidearm for most of the 20th Century.  It remains one of the most popular .45 pistols today."),
            weight = 1,
        },
        {
            id = "m1911_MEU",
            name = ccb.content.text("M1911A1"),
            description = ccb.content.text("An update to the original M1911, featuring an extended tang on the grip safety to prevent hammer bite as well as a shorter trigger for smaller hands."),
        },
    },
    ascii_picture = "m1911",
    gun = {},
}

ccb.content.define_item {
    id = "m249",
    name = ccb.content.text("C9"),
    copy_from = "m249",
    description = ccb.content.text("A mountable machine gun used by Canadian infantry, feeding from a belt or STANAG magazines in a pinch.  Quite inaccurate and difficult to control, the C9 is designed to fire many rounds very quickly."),
    gun = {},
}

ccb.content.define_item {
    id = "m60",
    name = ccb.content.text("C6"),
    copy_from = "m60",
    description = ccb.content.text("The Colt Canada C6 is a general-purpose machine gun developed to replace the .30-caliber C5 GPMG.  Heavy and difficult to handle fired from the shoulder, as most people aren't action-movie heroes."),
    gun = {},
}

ccb.content.define_item {
    id = "rossi_gallery",
    name = ccb.content.text("pump action varmint rifle"),
    copy_from = "rossi_gallery",
    variant_kind = "gun",
    variants = {
        {
            id = "rossi_gallery",
            name = ccb.content.text("Winchester 1890"),
            description = ccb.content.text("The Winchester 1890 is a pump action rifle, chambered in .22 LR.  Holds 15 rounds of ammo, so go get plinking!"),
        },
    },
    gun = {},
}
