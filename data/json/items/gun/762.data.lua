local ccb = require("ccb")

ccb.content.define_item {
    id = "ak47",
    copy_from = "gun_base_762_semi_rifle",
    looks_like = "modular_ar15",
    name = ccb.content.text("AKM rifle"),
    description = ccb.content.text("One of the most recognizable assault rifles ever made, the AKM is renowned for its durability even under the worst conditions."),
    variant_kind = "gun",
    variants = {
        {
            id = "ak47",
            name = ccb.content.text("AKM"),
            description = ccb.content.text("First produced in 1959, the AKM has cemented itself in history as the popular successor to its older brother, the AK-47, making improvements such as reduced weight and increased reliability.  Despite its age, it still sees plenty of use in conflicts including the post-Cataclysm."),
        },
    },
    mass = "3402 g",
    volume = "2167 ml",
    length = "87 cm",
    price = "2 kUSD 900 USD",
    materials = { "steel", "wood" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "akmag30", "akmag10", "akmag20", "akmag40", "akdrum75" },
        },
    },
    gun = {
        barrel_length = "415 mm",
        dispersion = 180,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 600 },
        },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "sks",
    copy_from = "gun_base_762_semi_rifle",
    looks_like = "modular_ar15",
    name = ccb.content.text("SKS rifle"),
    description = ccb.content.text("First produced by the Soviets in 1945, this rifle was quickly replaced by the full-auto AK-47.  However, due to its superb accuracy, low recoil, and deployable integrated bayonet, this gun maintains immense popularity."),
    variant_kind = "gun",
    variants = {
        {
            id = "sks",
            name = ccb.content.text("SKS"),
            description = ccb.content.text("A very common 7.62x39 rifle, the SKS was designed to replace the Mosin Nagant bolt action rifle, while the AK-47 was meant to replace the PPSh-41.  Mechanically, it resembles a much scaled down version of USSR's PTRS-41 semi automatic anti-tank rifle.  However, due to the success of the AK-47, the SKS was replaced by it in the USSR's Red Army.  It still saw service in other militaries, mainly other socialist states that got a surplus of SKS carbines from the USSR.  Due to the amount produced, it is a commonplace rifle in many gun owning American households."),
        },
    },
    ascii_picture = "sks",
    mass = "3850 g",
    volume = "2838 ml",
    length = "103 cm",
    price = "380 USD",
    materials = { "steel", "wood" },
    flags = { "RELOAD_ONE" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ["762"] = 10 },
            allowed_speedloaders = { "762x39_clip" },
        },
    },
    gun = {
        barrel_length = "520 mm",
        dispersion = 90,
        clip_size = 10,
        barrel_volume = "500 ml",
        built_in_mods = { "inter_bayonet" },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "aksemi",
    copy_from = "gun_base_762_semi_rifle",
    looks_like = "modular_ar15",
    name = ccb.content.text("AK-47 rifle"),
    description = ccb.content.text("A Civilian-legal clone of the AK-47 with no ability to fire full-auto.  Despite it lacking that ability, it is still a reliable and useful rifle even if it has much rarer ammo than the more common AR-15 platform."),
    variant_kind = "gun",
    variants = {
        {
            id = "aksemi_vska",
            name = ccb.content.text("Century Arms VSKA"),
            description = ccb.content.text("This specific model is a VSKA, manufactured in the USA by Century Arms."),
            weight = 16,
            append = true,
        },
        {
            id = "aksemi_wasr",
            name = ccb.content.text("Century Arms WASR-10"),
            description = ccb.content.text("This specific model is a WASR-10, imported by Century Arms."),
            weight = 8,
            append = true,
        },
        {
            id = "aksemi_zpap",
            name = ccb.content.text("Zastava ZPAP M70"),
            description = ccb.content.text("This specific model is a ZPAP M70, imported by Zastava."),
            weight = 5,
            append = true,
        },
    },
    mass = "3402 g",
    volume = "2167 ml",
    length = "87 cm",
    price = "795 USD",
    materials = { "steel", "wood" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "akmag30", "akmag10", "akmag20", "akmag40", "akdrum75" },
        },
    },
    gun = {
        barrel_length = "415 mm",
        dispersion = 180,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "mk47",
    copy_from = "gun_base_762_semi_rifle",
    name = ccb.content.text("American AK rifle"),
    description = ccb.content.text("This American AK Rifle is natively chambered for 7.62x39mm ammo.  It features a characteristic free-floating handguard, with a similar action mechanism to the AR-15, repurposed for the larger, more potent ammo."),
    variant_kind = "gun",
    variants = {
        {
            id = "mk47",
            name = ccb.content.text("Mk47 Mutant rifle"),
            description = ccb.content.text("The CMMG Mk47 Mutant is an American rifle, natively chambered for 7.62x39mm ammo.  It features a characteristic free-floating handguard, with a similar action mechanism to the AR-15, repurposed for the larger, more potent ammo."),
        },
    },
    mass = "2540 g",
    volume = "2300 ml",
    length = "930 mm",
    price = "1 kUSD 700 USD",
    materials = { "plastic", "steel" },
    looks_like = "modular_ar15",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "akmag10", "akmag20", "akmag30", "akmag40", "akdrum75" },
        },
    },
    gun = {
        barrel_length = "409 mm",
        dispersion = 150,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel", count = 1 },
        },
    },
}
