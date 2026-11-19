local ccb = require("ccb")

-- ["Yes, I know it's not really a glock smg.", "It takes glock magazines, and it's own special one that I am also renaming to a glock magazine", "so, I'm calling it a glock smg."]
ccb.content.define_item {
    id = "TDI",
    copy_from = "gun_base_45_semi_pistol",
    looks_like = "hk_mp5",
    name = ccb.content.text("Glock submachine gun"),
    description = ccb.content.text("A submachine gun chambered in .45 ACP, accepting Glock magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "TDI",
            name = ccb.content.text(".45 Vector submachine gun"),
            description = ccb.content.text("The Vector SMG is a delayed blowback submachine gun with a unique, in-line design that places both the shooter's hand and shoulder in line with the bore axis, reducing muzzle climb during bursts.  This one is chambered in .45 ACP."),
        },
    },
    mass = "3100 g",
    volume = "4248 ml",
    length = "611 mm",
    price = "3 kUSD 100 USD",
    survival_price = "35 USD",
    materials = { "steel", "plastic" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "glock_21mag_10", "tdi_mag", "glock_21mag", "glock_21mag26" },
        },
    },
    gun = {
        reload_noise_volume = 10,
        barrel_length = "165 mm",
        range = 1,
        skill = "smg",
        dispersion = 280,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 1200 },
        },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
            { id = "underbarrel", count = 1 },
        },
        default_mods = { "folding_stock" },
    },
}

-- Numbers for weight, volume, and length calculations are based upon weapon without caliber conversion. The difference will be made up for with integrated stats from the installable caliber conversion.
-- NO_TURRET should be removed once vehicle turrets are capable of mounting guns with mods attached. As it stands, trying to mount this style of weapon would require the player to remove the conversion kit, thus rendering it unusable anyhow.
ccb.content.define_item {
    id = "modular_ump",
    looks_like = "hk_mp5",
    name = ccb.content.text("UMP submachine gun"),
    description = ccb.content.text("A modern polymer-body sub-machine gun, once quite popular with police departments until recently.  Can be configured in 9x19mm, .40 S&W, or .45 ACP using conversion kits and the appropriate UMP magazine."),
    variant_kind = "gun",
    variants = {
        {
            id = "modular_ump",
            name = ccb.content.text("H&K UMP submachine gun"),
            description = ccb.content.text("Developed as a lower-cost successor to H&K's own MP5, the Universal Machine Pistol is a closed-bolt, simple blowback sub-machine gun constructed of lightweight polymer.  In order to make it more attractive to American police departments, it was offered in .40 S&W and .45 ACP as well as the ubiquitous 9x19mm, all using the same receiver.  This was meant to simplify manufacturing, but it also means the user can change the caliber with the right parts and magazine."),
        },
    },
    ascii_picture = "hk_ump",
    mass = "1100 g",
    volume = "4401 ml",
    length = "426 mm",
    price = "2 kUSD 900 USD",
    survival_price = "25 USD",
    materials = { "steel", "plastic" },
    symbol = "(",
    color = "dark_gray",
    flags = { "NO_TURRET" },
    faults = {
        { fault = "fault_gun_blackpowder" },
        { fault = "fault_gun_dirt" },
        { fault = "fault_gun_chamber_spent" },
        { fault = "fault_fail_to_feed" },
        { fault = "fault_stovepipe" },
        { fault = "fault_double_feed" },
    },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "ump45mag" } } },
    melee_damage = { bash = 11 },
    gun = {
        skill = "smg",
        barrel_length = "200 mm",
        range = 2,
        ammunition = { "NULL" },
        dispersion = 240,
        durability = 8,
        min_cycle_recoil = 540,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 600 },
        },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bore", count = 1 },
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
        handling = 20,
        default_mods = { "folding_stock" },
    },
}

-- You can get 'em for over US$1K if you want.  This is a fairly cheap remake.
ccb.content.define_item {
    id = "m1911",
    copy_from = "gun_base_45_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("M1911 pistol"),
    description = ccb.content.text("A semi-automatic pistol chambered in .45 ACP and accepting M1911 magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "m1911",
            name = ccb.content.text("M1911 pistol"),
            description = ccb.content.text("The M1911 was the US Military standard-issue sidearm for most of the 20th Century.  It remains one of the most popular .45 pistols today."),
        },
        {
            id = "m1911_MEU",
            name = ccb.content.text("M45A1 pistol"),
            description = ccb.content.text("The M45A1 supplanted earlier M45 MEUSOC pistols in use by Force Recon elements of Marine Expeditionary Units.  Where the original M45 pistols were gutted M1911A1s hand-fitted by USMC armorers, the updated M45A1s are hardly different from any other commercial 1911 design, save for their dual recoil springs.  Most were replaced in 2016 with Glock 19s due to logistics issues."),
        },
    },
    ascii_picture = "m1911",
    mass = "1120 g",
    volume = "454 ml",
    length = "245 mm",
    price = "784 USD",
    materials = { "steel", "plastic" },
    pockets = {
        {
            magazine_well = "250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "m1911mag", "m1911bigmag" },
        },
    },
    gun = {
        barrel_length = "127 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "mac_10",
    copy_from = "gun_base_45_semi_pistol",
    looks_like = "hk_mp5",
    name = ccb.content.text("MAC-10 submachine gun"),
    description = ccb.content.text("A submachine gun chambered in .45 ACP and accepting MAC-10 magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "mac_10",
            name = ccb.content.text("MAC-10 machine pistol"),
            description = ccb.content.text("The MAC-10 is a popular machine pistol originally designed for military use.  For many years it was the most inexpensive automatic weapon in the US, and enjoyed great popularity among criminals less concerned with quality firearms."),
        },
    },
    mass = "2810 g",
    volume = "1195 ml",
    length = "298 mm",
    price = "1 kUSD 800 USD",
    survival_price = "25 USD",
    materials = { "steel" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "mac10mag", "smg_45_mag" } } },
    gun = {
        barrel_length = "146 mm",
        skill = "smg",
        dispersion = 520,
        durability = 7,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 1100 },
        },
        built_in_mods = { "wire_stock" },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bore", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "hk_usc45",
    copy_from = "gun_base_45_semi_rifle",
    looks_like = "modular_ar15",
    name = ccb.content.text("H&K USC 45 carbine"),
    description = ccb.content.text("A compact, lightweight carbine chambering the .45 ACP pistol round.  Resembling the popular UMP submachine gun in both its blowback operating system and lightweight polymer frame construction, this civilian variant is distinguished by its skeletonized stock and 16 inch barrel, leaving it unable to accommodate standard UMP parts."),
    mass = "2781 g",
    volume = "6116 ml",
    length = "900 mm",
    price = "1 kUSD 600 USD",
    materials = { "steel", "plastic" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "usc10mag", "usc15mag", "usc20mag" } } },
    gun = {
        barrel_length = "406 mm",
        range = 6,
        dispersion = 160,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bayonet lug", count = 1 },
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

-- Crafting recipe must make use of angle grinder, bench grinder, set square and vise, which don't yet exist in game.
ccb.content.define_item {
    id = "smg_45",
    copy_from = "mac_10",
    looks_like = "hk_mp5",
    name = ccb.content.text("MAC-10 Luty submachine gun"),
    description = ccb.content.text("A Luty pattern makeshift smoothbore SMG crudely constructed out of various steel parts using advanced powered hand tools; likely one of the most complex guns that is feasible to make outside of a machine shop, but still very unreliable.  This one is chambered for .45 ACP cartridges and accepts MAC-10 compatible magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "smg_45",
            name = ccb.content.text(".45 Luty submachine gun"),
            description = ccb.content.text("A Luty pattern makeshift smoothbore SMG crudely constructed out of various steel parts using advanced powered hand tools; likely one of the most complex guns that is feasible to make outside of a machine shop, but still very unreliable.  This one is chambered for .45 ACP cartridges and accepts MAC-10 compatible magazines."),
        },
    },
    mass = "3520 g",
    volume = "1110 ml",
    length = "538 mm",
    price = "200 USD",
    survival_price = "15 USD",
    gun = {
        barrel_length = "229 mm",
        damage = { type = "bullet", amount = -4 },
        dispersion = 590,
        durability = 4,
        loudness = 25,
        barrel_volume = "250 ml",
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

-- Blish "lock" is considered to be a straight blowback in modern firearm design.
ccb.content.define_item {
    id = "tommygun",
    copy_from = "gun_base_45_semi_rifle",
    looks_like = "hk_mp5",
    name = ccb.content.text("Thompson submachine gun"),
    description = ccb.content.text("A submachine gun chambered in .45 ACP and accepting Thompson magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "tommygun",
            name = ccb.content.text("Thompson M1928A1 submachine gun"),
            description = ccb.content.text("An American-made submachine gun developed during the very end of World War I, too late to see action.  Infamous during the 1920s for its use by gangsters, and used during World War II before being mostly replaced with less-expensive alternatives."),
        },
    },
    mass = "4899 g",
    volume = "1230 ml",
    length = "832 mm",
    price = "4 kUSD 500 USD",
    materials = { "steel", "wood" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "thompson_mag", "thompson_bigmag", "thompson_drum", "thompson_makeshiftmag" },
        },
    },
    gun = {
        barrel_length = "267 mm",
        range = 4,
        skill = "smg",
        dispersion = 360,
        durability = 7,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 700 },
        },
        barrel_volume = "500 ml",
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
    id = "usp_45",
    copy_from = "gun_base_45_semi_pistol",
    name = ccb.content.text("USP .45 pistol"),
    description = ccb.content.text("A semi-automatic pistol chambered in .45 ACP and accepting USP magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "usp_45",
            name = ccb.content.text("USP .45 pistol"),
            description = ccb.content.text("A popular pistol, widely used among law enforcement.  Extensively tested for durability, it has been found to stay accurate even after being subjected to extreme abuse."),
        },
        {
            id = "mk23",
            name = ccb.content.text("MK 23 MOD 0 pistol"),
            description = ccb.content.text("Jokingly referred to as \"The World's Only Crew-Served Pistol\", this massive pistol was designed as a primary weapon for select \"special operators\".  Its cumbersome nature, the introduction of the derivative HK USP series, and the logistics of getting .45 ACP ammunition in theater doomed this behemoth to US SOCOM armories.  Like the USP, the MK 23 is a remarkably reliable gun; someone could probably take out a nuclear-equipped walking tank with this in their holster."),
        },
    },
    mass = "887 g",
    volume = "483 ml",
    length = "241 mm",
    materials = { "plastic", "steel" },
    price = "700 USD",
    survival_price = "25 USD",
    pockets = { { magazine_well = "250 ml", kind = "MAGAZINE_WELL", allowed_items = { "usp45mag" } } },
    gun = {
        barrel_length = "108 mm",
        ammunition = { "45" },
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
        built_in_mods = { "match_trigger" },
    },
}

ccb.content.define_item {
    id = "walther_ppq_45",
    copy_from = "gun_base_45_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("PPQ pistol"),
    description = ccb.content.text("A semi-automatic pistol chambered in .45 ACP and accepting PPQ magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "walther_ppq_45",
            name = ccb.content.text("Walther PPQ 45 pistol"),
            description = ccb.content.text("The Walther PPQ is a semi-automatic pistol originating from the Walther P99QA, and maintains compatibility with some of its predecessor's accessories.  This model is chambered in .45 ACP."),
        },
    },
    mass = "799 g",
    volume = "472 ml",
    length = "224 mm",
    price = "800 USD",
    materials = { "plastic", "steel" },
    pockets = { { magazine_well = "240 ml", kind = "MAGAZINE_WELL", allowed_items = { "ppq45mag" } } },
    gun = {
        barrel_length = "108 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "hptjhp",
    copy_from = "gun_base_45_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Model JHP pistol"),
    description = ccb.content.text("A semi-automatic pistol chambered in .45 ACP and accepting Hi-Point magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "hptjhp",
            name = ccb.content.text("Hi-Point Model JHP pistol"),
            description = ccb.content.text("The Hi-Point Model JHP is a blowback operated semi-automatic pistol designed by Hi-Point Firearms, which is known for making inexpensive firearms, and for making said firearms bulky and uncomfortable.  Hi-Points have slides made with a zinc pot-metal which is relatively fragile compared to steel slides."),
        },
    },
    mass = "990 g",
    volume = "538 ml",
    length = "238 mm",
    price = "75 USD",
    materials = { "plastic", "steel", "zinc" },
    pockets = { { magazine_well = "353 ml", kind = "MAGAZINE_WELL", allowed_items = { "hptjhpmag" } } },
    gun = {
        barrel_length = "114 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
        durability = 7,
    },
}

ccb.content.define_item {
    id = "glock_21",
    copy_from = "gun_base_45_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Glock pistol"),
    description = ccb.content.text("A semi-automatic pistol chambered in .45 ACP and accepting Glock magazines."),
    variant_kind = "gun",
    variants = {
        {
            id = "glock_21",
            name = ccb.content.text("Glock 21 pistol"),
            description = ccb.content.text("A full-sized version of the highly successful Glock.  This model is chambered in .45 ACP."),
        },
    },
    ascii_picture = "glock_20",
    mass = "835 g",
    volume = "490 ml",
    length = "209 mm",
    price = "602 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            magazine_well = "107 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "glock_21mag_10", "glock_21mag", "glock_21mag26" },
        },
    },
    gun = {
        barrel_length = "117 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "glock_30",
    copy_from = "gun_base_45_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Glock 30 pistol"),
    description = ccb.content.text("A Glock compact pistol chambered in .45 ACP.  Accepts the same magazines as its older brothers."),
    mass = "675 g",
    volume = "422 ml",
    length = "177 mm",
    price = "570 USD",
    materials = { "plastic", "steel" },
    pockets = {
        {
            magazine_well = "107 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = { "glock_21mag_10", "glock_21mag", "glock_21mag26" },
        },
    },
    gun = {
        barrel_length = "96 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "glock_36",
    copy_from = "gun_base_45_semi_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Glock 36 pistol"),
    description = ccb.content.text("A Glock subcompact pistol chambered in .45 ACP.  Due to its slim construction, it only accepts Glock 36 magazines."),
    mass = "565 g",
    volume = "370 ml",
    length = "177 mm",
    price = "570 USD",
    materials = { "plastic", "steel" },
    pockets = { { magazine_well = "107 ml", kind = "MAGAZINE_WELL", allowed_items = { "glock36_mag" } } },
    gun = {
        barrel_length = "96 mm",
        dispersion = 480,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "greasegun",
    copy_from = "gun_base_45_semi_rifle",
    looks_like = "hk_mp5",
    name = ccb.content.text(".45 WWII submachine gun"),
    description = ccb.content.text("A WWII submachine gun, lacking semi-auto fire selector and chambered in .45 ACP."),
    variant_kind = "gun",
    variants = {
        {
            id = "greasegun",
            name = ccb.content.text("M3 submachine gun"),
            description = ccb.content.text("An American-made submachine gun developed during WWII as an alternative to Thompson M1928A1 and used at least till early 1990s.  Simple, cheap, and somewhat crude, the M3 was still quite an effective weapon, mostly made from sheet metal to reduce costs and speed up production.  In times of active use, it was considered as a disposable weapon, which is more expedient to replace than to repair.  Unfortunately, you cannot afford such wastefulness, unlike this submachine gun, which is devoid of even a fire selector for semi-auto fire."),
        },
    },
    mass = "3700 g",
    volume = "2003 ml",
    length = "740 mm",
    price = "23 kUSD",
    materials = { "steel" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "greasegun30mag" } } },
    gun = {
        reload_noise_volume = 10,
        barrel_length = "203 mm",
        range = 2,
        skill = "smg",
        dispersion = 500,
        durability = 7,
        modes = { { id = "DEFAULT", label = ccb.content.text("auto-rpm"), rpm = 450 } },
        built_in_mods = { "wire_stock" },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
        },
    },
}
