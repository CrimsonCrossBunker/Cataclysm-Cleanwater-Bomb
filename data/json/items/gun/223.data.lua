local ccb = require("ccb")

-- This is assumed to be the standard model matching the M16. Tileset whitelist for rifles
-- Numbers for weight, volume, and length calculations are based upon an AR-15's complete lower receiver. The difference will be made up for with integrated stats from the installable modular upper receivers.
ccb.content.define_item {
    id = "modular_ar15",
    name = ccb.content.text("AR-15"),
    copy_from = "gun_base_rifle_semi",
    description = ccb.content.text("This ubiquitous rifle is the forefather of the M16 rifle series.  It is lightweight and accurate, but will malfunction if not properly maintained.  This one is a semi-automatic civilian version."),
    mass = "902 g",
    volume = "1550 ml",
    length = "520 mm",
    price = "1 kUSD 250 USD",
    survival_price = "40 USD",
    materials = { "aluminum", "steel", "plastic" },
    flags = { "NO_TURRET" },
    gun = {
        ammunition = { "NULL" },
        dispersion = 150,
        min_cycle_recoil = 1350,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bore", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock", count = 1 },
        },
    },
}

-- Based on https://www.aeroprecisionusa.com/m4e1-carbine-complete-lower-a2-grip-no-stock-anodized
ccb.content.define_item {
    id = "modular_ar_pistol",
    copy_from = "gun_base_rifle_semi",
    looks_like = "modular_ar15",
    name = ccb.content.plural_text("AR \"pistol\"", "AR \"pistols\""),
    description = ccb.content.text("The common AR-15 platform, with its stock removed and buffer tube covered by a thick, padded sleeve that allows the user to brace it like a rifle.  AR pistols lack stocks, or have arm braces due to restrictions on short barreled rifles, and so without a stock, they're legally classified as a pistol."),
    mass = "735 g",
    volume = "748 ml",
    length = "373 mm",
    price = "245 USD",
    survival_price = "35 USD",
    materials = { "steel", "aluminum" },
    flags = { "NO_TURRET" },
    melee_damage = { bash = 9 },
    gun = {
        ammunition = { "NULL" },
        dispersion = 150,
        min_cycle_recoil = 1350,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bore", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock", count = 1 },
        },
    },
}

-- Groups all 'H&K416' related rifles together. Used M27 due to it being the most popular of the three in the US.
-- Numbers for weight, volume, and length calculations are based upon an AR-15's complete lower receiver. The difference will be made up for with integrated stats from the installable modular upper receivers.
ccb.content.define_item {
    id = "modular_m27_assault_rifle",
    looks_like = "modular_ar15",
    copy_from = "gun_base_rifle_semi",
    name = ccb.content.text("M27 assault rifle"),
    description = ccb.content.text("Designed to replace the M4 Carbine, the M27 assault rifle features most of the former's strengths, while being considerably more durable.  It is chambered in 5.56x45mm NATO and accepts STANAG magazines."),
    mass = "1222 g",
    volume = "3407 ml",
    length = "388 mm",
    price = "5 kUSD 400 USD",
    survival_price = "50 USD",
    variant_kind = "gun",
    variants = {
        {
            id = "modular_h&k416a5",
            name = ccb.content.text("H&K HK416 A5 rifle"),
            description = ccb.content.text("Designed to replace the M4A1, the Heckler and Koch 416 A5 features most of the former's strengths, while being considerably more durable."),
        },
        {
            id = "modular_m27iar",
            name = ccb.content.text("M27 IAR carbine"),
            description = ccb.content.text("A HK416 carbine outfitted with a heavier barrel to enable higher amounts of suppressive fire while retaining a good degree of mobility."),
            ascii_picture = "m27_iar",
        },
        {
            id = "modular_m38dmr",
            name = ccb.content.text("M38 DMR rifle"),
            description = ccb.content.text("The M38 Designated Marksman Rifle is an M27 IAR, itself derived from a HK416, selected for accuracy, and outfitted with a variable power scope and a QDSS suppressor."),
        },
    },
    accuracy = -1,
    materials = { "aluminum", "steel", "plastic" },
    flags = { "NO_TURRET" },
    gun = {
        ammunition = { "NULL" },
        dispersion = 180,
        min_cycle_recoil = 1350,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 850 },
        },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bore", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "scar_l",
    copy_from = "gun_base_223_semi_rifle",
    name = ccb.content.text("FN SCAR-L"),
    description = ccb.content.text("A highly accurate and modular assault rifle specially designed for the United States Special Operations Command.  The 'L' in its name stands for light, as it uses the lightweight 5.56 NATO round."),
    ascii_picture = "scar-L",
    mass = "3490 g",
    volume = "4957 ml",
    length = "798 mm",
    price = "5 kUSD 400 USD",
    materials = { "steel", "aluminum", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "stanag30", "stanag5", "stanag5ranger", "stanag10", "stanag10ranger", "stanag20",
                "stanag20ranger", "stanag30ranger", "stanag40", "stanag40ranger", "stanag50", "stanag60",
                "stanag60drum", "stanag90", "stanag100", "stanag100drum", "stanag150", "survivor223mag",
            },
        },
    },
    gun = {
        barrel_length = "355 mm",
        dispersion = 180,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 600 },
        },
        default_mods = { "high_end_folding_stock" },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock", count = 1 },
            { id = "underbarrel", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "scar_16s",
    copy_from = "scar_l",
    name = ccb.content.text("civilian FN SCAR-L rifle"),
    description = ccb.content.text("A highly accurate and modular rifle specially designed for the United States Special Operations Command, in semi-auto only to be sold on the civilian market."),
    variant_kind = "gun",
    variants = {
        {
            id = "scar_16s",
            name = ccb.content.text("FN SCAR 16S"),
            description = ccb.content.text("The SCAR 16S is the civilian-legal version of the SCAR-L rifle.  It is still very expensive, not like that matters now anymore."),
        },
    },
    ascii_picture = "scar-L",
    mass = "3289 g",
    price = "3 kUSD 839 USD",
    survival_price = "20 USD",
    gun = {
        barrel_length = "413 mm",
        modes = { { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 } },
    },
}

ccb.content.define_item {
    id = "sl8",
    copy_from = "gun_base_223_semi_rifle",
    looks_like = "modular_ar15",
    name = ccb.content.text("SL8 civilian rifle"),
    description = ccb.content.text("A semi-automatic clone of an older German assault rifle.  Due to importation bans, it is semi-auto and can only feed from 10 round magazines."),
    mass = "3901 g",
    volume = "3919 ml",
    length = "987 mm",
    price = "1 kUSD 789 USD",
    survival_price = "5 USD",
    variant_kind = "gun",
    variants = {
        {
            id = "sl8",
            name = ccb.content.text("SL8-6"),
            description = ccb.content.text("The SL8 is an importation-legal gun similar to the German G36, made to be semi-auto only, and to only feed from 10 round single stack magazines.  It also features a distinctive thumbhole stock, a polymer handguard, and a top rail for mounting optics."),
        },
    },
    materials = { "steel", "plastic" },
    pockets = { { magazine_well = "60 ml", kind = "MAGAZINE_WELL", allowed_items = { "sl8mag" } } },
    gun = {
        barrel_length = "635 mm",
        dispersion = 150,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "m249",
    copy_from = "gun_base_223_semi_rifle",
    looks_like = "modular_ar15",
    name = ccb.content.text("M249 machine gun"),
    description = ccb.content.text("The M249 is a mountable machine gun used by the US military and SWAT teams.  While quite inaccurate and difficult to control, the M249 is designed to fire many rounds very quickly."),
    ascii_picture = "m249_saw",
    mass = "7500 g",
    volume = "10610 ml",
    length = "1035 mm",
    price = "7 kUSD 500 USD",
    survival_price = "20 USD",
    materials = { "steel", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "belt223", "stanag30", "stanag5", "stanag5ranger", "stanag10", "stanag10ranger",
                "stanag20", "stanag20ranger", "stanag30ranger", "stanag40", "stanag40ranger", "stanag50",
                "stanag60", "stanag60drum", "stanag90", "stanag100", "stanag100drum", "stanag150",
                "survivor223mag",
            },
        },
    },
    gun = {
        barrel_length = "533 mm",
        dispersion = 200,
        reload_time = 400,
        modes = { { id = "DEFAULT", label = ccb.content.text("auto-rpm"), rpm = 850 } },
        built_in_mods = { "bipod" },
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
        },
    },
}

ccb.content.define_item {
    id = "m249_semi",
    copy_from = "m249",
    name = ccb.content.text("M249S machine gun"),
    description = ccb.content.text("This is a semi-automatic civilian variant of the M249 machine gun, manufactured for sport shooting and collectors market.  Notably, it retains the ability to be belt fed, an uncommon feature in civilian firearms."),
    gun = { modes = { { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 } } },
}

-- The volume, weight, and overall length of an average AR-15's complete upper receiver module have been deducted and will be made up for by the installable upper assemblies.
-- This should be removed once vehicle turrets are capable of mounting guns with mods attached. As it stands, trying to mount this style of weapon would require the player to remove the conversion kit, thus rendering it unusable anyhow.
ccb.content.define_item {
    id = "modular_m4_carbine",
    looks_like = "modular_ar15",
    copy_from = "gun_base_rifle_semi",
    name = ccb.content.text("M4 carbine"),
    description = ccb.content.text("A popular carbine, long used by the US military.  Although accurate, small and lightweight, it is infamous for its unreliability when not properly maintained.  It is chambered in 5.56x45mm NATO and accepts STANAG magazines."),
    ascii_picture = "modular_m4a1",
    mass = "880 g",
    volume = "1760 ml",
    length = "470 mm",
    price = "2 kUSD 400 USD",
    survival_price = "50 USD",
    variant_kind = "gun",
    variants = {
        {
            id = "modular_m4a1",
            name = ccb.content.text("M4A1 carbine"),
            description = ccb.content.text("A popular carbine, long used by the US military.  Although accurate, small and lightweight, it is infamous for its unreliability when not properly maintained."),
            ascii_picture = "modular_m4a1",
        },
        {
            id = "m4_cqbr",
            name = ccb.content.text("Mk 18 CQBR carbine"),
            description = ccb.content.text("This is a shorter M4 carbine with a 10.3 inch barrel, intended for confined spaces and close quarters battle situations."),
            weight = 0,
        },
    },
    materials = { "aluminum", "steel", "plastic" },
    flags = { "NO_TURRET" },
    gun = {
        ammunition = { "NULL" },
        dispersion = 180,
        min_cycle_recoil = 1350,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 750 },
        },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bore", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock", count = 1 },
        },
    },
}

-- The volume, weight, and overall length of an average AR-15's complete upper receiver module with a 20-inch barrel have been deducted and will be made up for by the installable upper assemblies.
-- This should be removed once vehicle turrets are capable of mounting guns with mods attached. As it stands, trying to mount this style of weapon would require the player to remove the conversion kit, thus rendering it unusable anyhow.
ccb.content.define_item {
    id = "modular_m16a4",
    looks_like = "modular_ar15",
    copy_from = "modular_m4_carbine",
    name = ccb.content.text("M16 burst rifle"),
    description = ccb.content.text("The M16 is a common assault rifle descended from the AR-15, used by militaries across the world for over 50 years.  It fires in three round bursts, ensuring the rifle is more accurate, but at the cost of being slower than other assault rifles.  It is chambered in 5.56x45mm NATO rounds, and accepts STANAG magazines."),
    mass = "992 g",
    volume = "3480 ml",
    length = "495 mm",
    variant_kind = "gun",
    variants = {
        {
            id = "modular_m16a4",
            name = ccb.content.text("M16A4 rifle"),
            description = ccb.content.text("The M16 is a very common assault rifle descended from the AR-15, used by militaries across the world for over 50 years.  It is a gas-operated, rotating bolt rifle known for its accuracy and controllable recoil.  This model is a M16A4, which shoots in semiautomatic and burst fire, and a Picatinny rail."),
        },
    },
    materials = { "aluminum", "steel", "plastic" },
    gun = {
        default_mods = { "adjustable_stock", "retool_ar15_223rem_extended" },
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { rpm = 800, quantity = 3 },
        },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bore", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock", count = 1 },
        },
    },
}

-- Figured having 'm16' in the name would make it more understandable, seeing as I named 2 of the .223 rifle groups/names after it.
-- This should be removed once vehicle turrets are capable of mounting guns with mods attached. As it stands, trying to mount this style of weapon would require the player to remove the conversion kit, thus rendering it unusable anyhow.
ccb.content.define_item {
    id = "modular_m16_auto_rifle",
    copy_from = "modular_m16a4",
    name = ccb.content.text("M16 auto rifle"),
    description = ccb.content.text("The M16 is a very common assault rifle descended from the AR-15, used by militaries across the world for over 50 years.  Unlike its more common brother, the M16 burst rifle, this one has full-auto capabilities.  It is chambered in 5.56x45mm NATO and accepts STANAG magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "modular_m16a3",
            name = ccb.content.text("M16A3 rifle"),
            description = ccb.content.text("The M16 is a very common assault rifle descended from the AR-15, used by militaries across the world for over 50 years.  It is a gas-operated, rotating bolt rifle known for its accuracy and controllable recoil.  This model is a relatively rare M16A3, with full auto capability."),
        },
    },
    flags = { "NO_TURRET" },
    gun = {
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 750 },
        },
    },
}

ccb.content.define_item {
    id = "ruger_mini",
    copy_from = "gun_base_223_semi_rifle",
    looks_like = "modular_ar15",
    name = ccb.content.text("Ruger Mini-14 carbine"),
    description = ccb.content.text("A small, lightweight semi-auto carbine designed for civilian and police use.  Its superb accuracy and low recoil makes it more suitable than full-auto rifles for some situations."),
    ascii_picture = "mini-14",
    mass = "3180 g",
    volume = "2900 ml",
    length = "977 mm",
    price = "921 USD",
    materials = { "steel", "wood" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "ruger20",
                "ruger5",
                "ruger10",
                "ruger30",
                "ruger90",
                "ruger100",
                "ruger_makeshiftmag",
            },
        },
    },
    gun = {
        barrel_length = "406 mm",
        dispersion = 100,
        barrel_volume = "500 ml",
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bore", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock", count = 1 },
        },
    },
}

-- Changed from SG 553, which itself was originally the Sig 550, to the civilian legal copy
ccb.content.define_item {
    id = "sig_assault_rifle",
    copy_from = "gun_base_223_semi_rifle",
    looks_like = "modular_ar15",
    name = ccb.content.text("SIG civilian rifle"),
    description = ccb.content.text("A civilian variant of an automatic Swiss rifle for military service.  Accepts 5.56x45mm NATO STANAG magazines."),
    mass = "4100 g",
    volume = "3146 ml",
    length = "1020 mm",
    price = "3 kUSD 200 USD",
    variant_kind = "gun",
    variants = {
        {
            id = "sig553",
            name = ccb.content.text("SIG SG 556"),
            description = ccb.content.text("The SG 556 is a civilian model of the Swiss SIG SG 550 series, manufactured in New Hampshire.  It lacks any automatic fire capability and has a 16 inch barrel, but still retains a folding stock, with the feature of feeding from STANAG magazines instead of the SG 550 series magazines."),
        },
    },
    materials = { "steel", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "stanag30", "stanag5", "stanag5ranger", "stanag10", "stanag10ranger", "stanag20",
                "stanag20ranger", "stanag30ranger", "stanag40", "stanag40ranger", "stanag50", "stanag60",
                "stanag60drum", "stanag90", "stanag100", "stanag100drum", "stanag150", "survivor223mag",
            },
        },
    },
    gun = {
        barrel_length = "406 mm",
        dispersion = 180,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
        built_in_mods = { "folding_stock" },
    },
}

ccb.content.define_item {
    id = "steyr_aug",
    copy_from = "gun_base_223_semi_rifle",
    looks_like = "modular_ar15",
    name = ccb.content.text("AUG assault rifle"),
    description = ccb.content.text("An assault rifle chambered in 5.56x45mm NATO and accepting AUG magazines"),
    mass = "3500 g",
    volume = "3520 ml",
    length = "715 mm",
    price = "4 kUSD 900 USD",
    variant_kind = "gun",
    variants = {
        {
            id = "steyr_aug",
            name = ccb.content.text("Steyr AUG"),
            description = ccb.content.text("The Steyr AUG is an Austrian assault rifle that uses a bullpup design.  It is used in the armed forces and police forces of many nations, and enjoys low recoil and high accuracy."),
        },
    },
    materials = { "steel", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "augmag_30rd", "augmag_10rd", "augmag_42rd", "augmag_100rd" },
        },
    },
    gun = {
        barrel_length = "508 mm",
        dispersion = 140,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 700 },
        },
        built_in_mods = { "grip" },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "ak556",
    copy_from = "gun_base_223_semi_rifle",
    looks_like = "modular_ar15",
    name = ccb.content.text("ZPAP AK-style rifle"),
    description = ccb.content.text("A civilian AK pattern rifle, chambered in 5.56x45 NATO."),
    variant_kind = "gun",
    variants = {
        {
            id = "zpapm90",
            name = ccb.content.text("Zastava ZPAP M90"),
            description = ccb.content.text("A Serbian-made AK pattern rifle made by Zastava in 5.56x45mm NATO.  To avoid import restrictions, Zastava USA has added a number of American-made parts."),
        },
    },
    mass = "3402 g",
    volume = "2167 ml",
    length = "99 cm",
    price = "795 USD",
    materials = { "steel", "wood" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "zpap85mag", "zpap85mag_10rd" } } },
    gun = {
        barrel_length = "465 mm",
        dispersion = 180,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

-- The length, weight, and volume numbers are assigned to, roughly, represent an MDRX without a protruding barrel. the difference will be made up for with the installable conversion kits.
-- This should be removed once vehicle turrets are capable of mounting guns with mods attached. As it stands, trying to mount this style of weapon would require the player to remove the conversion kit, thus rendering it unusable anyhow.
ccb.content.define_item {
    id = "mdrx",
    copy_from = "gun_base_rifle_semi",
    looks_like = "modular_ar15",
    name = ccb.content.text("Desert Tech bullpup carbine"),
    description = ccb.content.text("Produced by the Desert Tech gun company, this is a highly modular, semi-automatic rifle of remarkably modest dimensions.  The weapon is notable for the simplicity of converting it to fire a wide number of different cartridges, with retool kits for .223 Remington, .308 Winchester, and .300 AAC Blackout being available."),
    variant_kind = "gun",
    variants = {
        {
            id = "mdrx",
            name = ccb.content.text("Desert Tech MDRX carbine"),
            description = ccb.content.text("Bringing a compact, highly modular, and soft-recoiling weapon system to the table, the Desert Tech Micro Dynamic Rifle Extreme (MDRX) is a gas-operated bullpup carbine originally unveiled in 2014, with this updated model of the weapon having been released in 2019.  One of the rifle's most notable features is the utter simplicity of swapping the carbine's chambering, with an easy change of the barrel, bolt, and a handful of other components being all the steps required to chamber the MDRX for either .223 Remington, .308 Winchester, or .300 AAC Blackout."),
        },
    },
    mass = "3080 g",
    volume = "3121 ml",
    length = "402 mm",
    price = "1 kUSD 739 USD",
    survival_price = "40 USD",
    materials = { "aluminum", "steel", "plastic" },
    flags = { "NO_TURRET" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "stanag30", "stanag5", "stanag5ranger", "stanag10", "stanag10ranger", "stanag20",
                "stanag20ranger", "stanag30ranger", "stanag40", "stanag40ranger", "stanag50", "stanag60",
                "stanag60drum", "stanag90", "stanag100", "stanag100drum", "stanag150", "ar10mag_20rd",
                "ar10mag_10rd", "ar10mag_25rd", "ar10mag_50rd", "ar10_makeshiftmag", "survivor223mag",
            },
        },
    },
    gun = {
        ammunition = { "NULL" },
        dispersion = 150,
        min_cycle_recoil = 1250,
        mod_locations = {
            { id = "bore", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 2 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 2 },
            { id = "underbarrel", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "bren2_556",
    copy_from = "gun_base_223_semi_rifle",
    looks_like = "modular_ar15",
    name = ccb.content.text("Bren 5.56x45mm carbine"),
    description = ccb.content.text("A semi-automatic clone of the Czech Republic's standard infantry carbine, sold for civilian sport shooting and recreational use, this modular rifle makes use of the standard magazines of the AR-15 platform and a 5.56x45mm NATO cartridge."),
    variant_kind = "gun",
    variants = {
        {
            id = "bren2_556",
            name = ccb.content.text("CZ Bren 2 carbine"),
            description = ccb.content.text("Hailing from the Czech Republic, this modular carbine supplanted the older CZ 805 rifle within Czech military use, improving upon the former's features and bringing fully ambidextrous controls, a streamlined design, and an easily adjustable gas system to the table.  Chambered for the 5.56x45mm NATO cartridge, this particular weapon possesses a 16.5-inch barrel and is a civilian MS, 'modular semi-automatic,' model.  Incorporating a number of US-made parts, the weapon features a removable muzzle break rather than the flash hider that comes standard with military rifles."),
        },
    },
    mass = "3450 g",
    volume = "4200 ml",
    length = "91 cm",
    price = "2 kUSD 259 USD",
    materials = { "steel", "aluminum", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "stanag30", "stanag5", "stanag5ranger", "stanag10", "stanag10ranger", "stanag20",
                "stanag20ranger", "stanag30ranger", "stanag40", "stanag40ranger", "stanag50", "stanag60",
                "stanag60drum", "stanag90", "stanag100", "stanag100drum", "stanag150", "survivor223mag",
            },
        },
    },
    gun = {
        barrel_length = "419 mm",
        dispersion = 140,
        default_mods = { "folding_stock", "muzzle_brake" },
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

ccb.content.define_item {
    id = "rdb_223",
    copy_from = "gun_base_223_semi_rifle",
    looks_like = "modular_ar15",
    name = ccb.content.text("5.56x45mm bullpup rifle"),
    description = ccb.content.text("This is a semi-automatic bullpup rifle with a lightened body due to the use of polymers and aluminum, using standard magazines of the AR-15 platform and a 5.56x45mm NATO cartridge."),
    variant_kind = "gun",
    variants = {
        {
            id = "rdb_223",
            name = ccb.content.text("Kel-Tec RDB rifle"),
            description = ccb.content.text("This is a semi-automatic bullpup rifle with a lightened body due to the use of polymers and aluminum, using standard magazines from the AR-15 platform and the 5.56x45mm NATO cartridge.  The name stands for rifle, downward-ejection, bullpup, and its design was intended to incorporate some technical solutions, such as downward case ejection and convenience for left-handers, to solve some problems with bullpup guns.  However, the good idea's execution is not as perfect as the manufacturer (and user) would like.  No good idea from Kel-Tec is immune to Kel-Tec manufacturing issues, sadly."),
        },
    },
    mass = "3200 g",
    volume = "3421 ml",
    length = "693 mm",
    price = "1 kUSD",
    survival_price = "40 USD",
    materials = { "steel", "aluminum", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "stanag30", "stanag5", "stanag5ranger", "stanag10", "stanag10ranger", "stanag20",
                "stanag20ranger", "stanag30ranger", "stanag40", "stanag40ranger", "stanag50", "stanag60",
                "stanag60drum", "stanag90", "stanag100", "stanag100drum", "stanag150", "survivor223mag",
            },
        },
    },
    gun = {
        barrel_length = "439 mm",
        dispersion = 180,
        sight_dispersion = 500,
        durability = 6,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "underbarrel", count = 1 },
        },
    },
}

-- Yes the ID says 300blk.  The old .300 version didn't meet the inclusion criteria, but the 556 one did so it was changed to 556.  Since it feeds from the same magazines, a migration wasn't need and the old ID was kept.
ccb.content.define_item {
    id = "iwi_tavor_x95_300blk",
    copy_from = "gun_base_223_semi_rifle",
    looks_like = "modular_ar15",
    name = ccb.content.text("IWI Tavor X95"),
    description = ccb.content.text("The Tavor is an Israeli series of bullpup rifles designed and produced by Israel Weapon Industries.  This is the Tavor X95, a civilian-legal rifle lacking any full-auto capability, and sporting a 16.5\" barrel.  Chambered in 5.56x45mm NATO, this rifle feeds from STANAG magazines."),
    mass = "3583 g",
    volume = "2400 ml",
    length = "665 mm",
    price = "4 kUSD 900 USD",
    materials = { "steel", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "stanag30", "stanag5", "stanag5ranger", "stanag10", "stanag10ranger", "stanag20",
                "stanag20ranger", "stanag30ranger", "stanag40", "stanag50", "stanag60", "stanag60drum",
                "stanag90", "stanag100", "stanag100drum", "stanag150", "survivor223mag",
            },
        },
    },
    melee_damage = { bash = 12 },
    gun = {
        barrel_length = "419 mm",
        dispersion = 140,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

-- Based on https://www.smith-wesson.com/product/mp15-sport-iii-10rd-fixed-stock-compliant
ccb.content.define_item {
    id = "mp_15",
    copy_from = "gun_base_223_semi_rifle",
    looks_like = "modular_ar15",
    name = ccb.content.text("sporter AR rifle"),
    description = ccb.content.text("A lightweight AR-15 platform rifle, capable of feeding standard AR magazines.  Unlike the military versions, it has no threaded barrel or collapsing stock."),
    variant_kind = "gun",
    variants = {
        {
            id = "mp_15",
            name = ccb.content.text("M&P 15"),
            description = ccb.content.text("S&Ws version of the AR-15, the M&P-15 is a very common rifle.  Despite being very similar to an AR-15 in both form and function, the receivers and uppers are incompatible."),
        },
    },
    mass = "2903 g",
    volume = "3677 ml",
    length = "876 mm",
    price = "799 USD",
    materials = { "steel", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "stanag30", "stanag5", "stanag5ranger", "stanag10", "stanag10ranger", "stanag20",
                "stanag20ranger", "stanag30ranger", "stanag40", "stanag50", "stanag60", "stanag60drum",
                "stanag90", "stanag100", "stanag100drum", "stanag150", "survivor223mag",
            },
        },
    },
    gun = {
        barrel_length = "406 mm",
        dispersion = 150,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}
