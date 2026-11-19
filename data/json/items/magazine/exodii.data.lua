local ccb = require("ccb")

-- just 10 shots stacked on top of one another as a clip
ccb.content.define_item {
    id = "exodiiminimag",
    looks_like = "garandclip",
    name = ccb.content.text("Exodii zombie hunting rifle magazine"),
    description = ccb.content.text("A small, sleek magazine based on a classic PA md. 71 clip, with some redesigns by the Exodii for better use in lighter-than-air drones.  Its small size is less appropriate for ground-fighting of hordes of zombies, as it is a bit inconvenient to reload."),
    mass = "30 g",
    volume = "250 ml",
    length = "120 mm",
    price = "6 USD",
    survival_price = "50 cent",
    materials = { "qt_steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["123ln"] = 10 } } },
    variant_kind = "gun",
    variants = {
        {
            id = "exodiiminimag",
            name = ccb.content.text("PA md. 71 Exodii 10-round magazine"),
            description = ccb.content.text("A small, sleek magazine based on a classic PA md. 71 clip, with some redesigns by the Exodii for better use in lighter-than-air drones.  Its small size is less appropriate for ground-fighting of hordes of zombies, as it is a bit inconvenient to reload."),
        },
    },
    magazine = { ammunition = { "123ln" }, reload_time = 220 },
}

ccb.content.define_item {
    id = "exodiiBRmag",
    looks_like = "stanag30",
    name = ccb.content.text("Exodii battle rifle pan magazine"),
    description = ccb.content.text("An unreasonably large pan magazine for the already heavy PA md. 68 battle rifle.  While the original magazines were double stack box magazines, the PA md. 68 started being pushed into aircraft and vehicle support roles, necessitating a larger pan magazine."),
    mass = "600 g",
    volume = "1250 ml",
    length = "255 mm",
    price = "105 USD",
    survival_price = "4 USD 50 cent",
    materials = { "qt_steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["123ln"] = 60 } } },
    variant_kind = "gun",
    variants = {
        {
            id = "exodiiBRmag",
            name = ccb.content.text("PA md. 68 Exodii 60-round magazine"),
            description = ccb.content.text("An unreasonably large pan magazine for the already heavy PA md. 68 battle rifle.  While the original magazines were double stack box magazines, the PA md. 68 started being pushed into aircraft and vehicle support roles, necessitating a larger pan magazine."),
        },
    },
    magazine = { ammunition = { "123ln" }, reload_time = 180 },
}

ccb.content.define_item {
    id = "exodiiBRmag_153",
    looks_like = "stanag30",
    name = ccb.content.text("Exodii battle rifle large pan magazine"),
    description = ccb.content.text("An even more enormous magazine than the 60-round magazine, this beast of a pan magazine boasts a capacity of 153 rounds.  While impressive in capacity, it's reliability is questionable and its portability is nonexistent.  It saw some vehicle use near the end of the 3rd Carpathian war and was a bit further refined after that, but never saw much widescale adoption.  The Exodii however care little about portability, and scraped up every last one they could find."),
    mass = "1700 g",
    volume = "3500 ml",
    length = "270 mm",
    price = "205 USD",
    survival_price = "40 USD",
    materials = { "qt_steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["123ln"] = 153 } } },
    variant_kind = "gun",
    variants = {
        {
            id = "exodiiBRmag_153",
            name = ccb.content.text("PA md. 68 Exodii 153-round magazine"),
            description = ccb.content.text("An even more enormous magazine than the 60-round magazine, this beast of a pan magazine boasts a capacity of 153 rounds.  While impressive in capacity, it's reliability is questionable and its portability is nonexistent.  It saw some vehicle use near the end of the 3rd Carpathian war and was a bit further refined after that, but never saw much widescale adoption.  The Exodii however care little about portability, and scraped up every last one they could find."),
        },
    },
    magazine = { ammunition = { "123ln" }, reload_time = 240, jam_multiplier = 1.2 },
}

ccb.content.define_item {
    id = "exodiiBRmag_26",
    looks_like = "stanag30",
    name = ccb.content.text("Exodii battle rifle box magazine"),
    description = ccb.content.text("The original PA md. 68 magazine, a simple straight box magazine.  While usable, the weight of the rifle made it quite unpopular for ground troops, and the low capacity made it not very useful for mounted use.  Large stockpiles of surplus magazines sat around in warehouses before the Exodii scooped them up.  Still not commonly used by the Exodii, but still plentiful and low cost."),
    mass = "190 g",
    volume = "350 ml",
    length = "255 mm",
    price = "105 USD",
    survival_price = "1 USD 50 cent",
    materials = { "qt_steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["123ln"] = 26 } } },
    variant_kind = "gun",
    variants = {
        {
            id = "exodiiBRmag_26",
            name = ccb.content.text("PA md. 68 Exodii 26-round magazine"),
            description = ccb.content.text("The original PA md. 68 magazine, a simple straight box magazine.  While usable, the weight of the rifle made it quite unpopular for ground troops, and the low capacity made it not very useful for mounted use.  Large stockpiles of surplus magazines sat around in warehouses before the Exodii scooped them up.  Still not commonly used by the Exodii, but still plentiful and low cost."),
        },
    },
    magazine = { ammunition = { "123ln" }, reload_time = 120 },
}

ccb.content.define_item {
    id = "exodiisapramag5",
    looks_like = "exodiiminimag",
    name = ccb.content.text("Sapra '36 magazine"),
    description = ccb.content.text("A large, five round single stack magazine for the Sapra '36."),
    mass = "710 g",
    volume = "449 ml",
    length = "132 mm",
    price = "135 USD",
    survival_price = "4 USD 70 cent",
    materials = { "qt_steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["273x44"] = 5 } } },
    magazine = { ammunition = { "273x44" }, reload_time = 110 },
}

ccb.content.define_item {
    id = "exodii_khuunaofaai_mag_firework",
    looks_like = "metal_tank_little",
    name = ccb.content.text("ordnance cannon celebration canister"),
    description = ccb.content.text("A pressurized tank containing the original firework payload of the Exodii's own ordnance cannon.  This chemical payload contains two different compounds of copper, so that the projectiles burn a sharp blue and green to represent the united Earth it came from.  It isn't intended for combat, but getting hit by a massive firework is dangerous enough that it was brought along.  The tank capacity is larger than the other loads the Exodii created for it."),
    mass = "1268 g",
    volume = "1250 ml",
    variant_kind = "gun",
    variants = {
        {
            id = "exodii_khuunaofaai_mag_firework",
            name = ccb.content.text("Khuunäöfaai celebration canister"),
            description = ccb.content.text("A pressurized tank containing the original firework payload of the Khuunäöfaai.  This chemical payload contains two different compounds of copper, so that the projectiles burn a sharp blue and green to represent the united Earth it came from.  It isn't intended for combat, but getting hit by a massive firework is dangerous enough that it was brought along.  The tank capacity is larger than the other loads the Exodii created for it."),
            weight = 1,
        },
    },
    symbol = "#",
    color = "light_gray",
    length = "160 mm",
    survival_price = "10 USD",
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            airtight = true,
            ammunition = { khuunaofaai_payload = 10 },
            watertight = true,
        },
    },
    flags = { "MAG_BULKY", "NO_UNLOAD", "NO_RELOAD" },
    materials = { "qt_steel" },
    magazine = { ammunition = { "khuunaofaai_payload" }, capacity = 10, count = 10 },
}

ccb.content.define_item {
    id = "exodii_khuunaofaai_mag_incendiary",
    copy_from = "exodii_khuunaofaai_mag_firework",
    name = ccb.content.text("ordnance cannon incendiary canister"),
    description = ccb.content.text("A pressurized tank containing one of the special payloads the Exodii made for their ordnance cannon, something akin to white phosphorous on your Earth.  Its simplicity and effectiveness against targets big and small makes it the cannon's most popular ammunition by far."),
    variant_kind = "gun",
    variants = {
        {
            id = "exodii_khuunaofaai_mag_incendiary",
            name = ccb.content.text("Khuunäöfaai incendiary canister"),
            description = ccb.content.text("A pressurized tank containing one of the special payloads the Exodii made for the Khuunäöfaai, something akin to white phosphorous on your Earth.  Its simplicity and effectiveness against targets big and small makes it the cannon's most popular ammunition by far."),
            weight = 1,
        },
    },
    survival_price = "10 USD",
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            airtight = true,
            ammunition = { khuunaofaai_payload_fire = 4 },
            watertight = true,
        },
    },
    magazine = { ammunition = { "khuunaofaai_payload_fire" }, capacity = 4, count = 4 },
}

ccb.content.define_item {
    id = "exodii_khuunaofaai_mag_corrosive",
    copy_from = "exodii_khuunaofaai_mag_firework",
    name = ccb.content.text("ordnance cannon corrosive canister"),
    description = ccb.content.text("A pressurized tank containing one of the special payloads the Exodii made for their ordnance cannon, a mixture of several acids and peroxides capable of rapidly breaking down the organic tissues of zombies and mutants alike.  Apparently developed for cases where the incendiary payload would fail, like low to zero oxygen environments and targets capable of self-extinguishing - It's somewhat alarming the Exodii run into those scenarios frequently enough to justify producing this."),
    variant_kind = "gun",
    variants = {
        {
            id = "exodii_khuunaofaai_mag_corrosive",
            name = ccb.content.text("Khuunäöfaai corrosive canister"),
            description = ccb.content.text("A pressurized tank containing one of the special payloads the Exodii made for the Khuunäöfaai, a mixture of several acids and peroxides capable of rapidly breaking down the organic tissues of zombies and mutants alike.  Apparently developed for cases where the incendiary payload would fail, like low to zero oxygen environments and targets capable of self-extinguishing - It's somewhat alarming the Exodii run into those scenarios frequently enough to justify producing this."),
            weight = 1,
        },
    },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            airtight = true,
            ammunition = { khuunaofaai_payload_acid = 4 },
            watertight = true,
        },
    },
    magazine = { ammunition = { "khuunaofaai_payload_acid" }, capacity = 4, count = 4 },
}

ccb.content.define_item {
    id = "exodii_khuunaofaai_mag_adhesive",
    copy_from = "exodii_khuunaofaai_mag_firework",
    name = ccb.content.text("ordnance cannon adhesive canister"),
    description = ccb.content.text("A pressurized tank containing one of the special payloads the Exodii made for their ordnance cannon, an industrial grade chemical that adheres to anything it touches and hardens into a concrete-like resin.  Invented on some alternate Earth for quickly fixing holes in Zeppelin and high-altitude craft, the Exodii found the substance useful for area denial, cover creation, or encasing nasty things in when they couldn't be bothered to waste bullets on them."),
    variant_kind = "gun",
    variants = {
        {
            id = "exodii_khuunaofaai_mag_adhesive",
            name = ccb.content.text("Khuunäöfaai adhesive canister"),
            description = ccb.content.text("A pressurized tank containing one of the special payloads the Exodii made for the Khuunäöfaai, an industrial grade chemical that adheres to anything it touches and hardens into a concrete-like resin.  Invented on some alternate Earth for quickly fixing holes in Zeppelin and high-altitude craft, the Exodii found the substance useful for area denial, cover creation, or encasing nasty things in when they couldn't be bothered to waste bullets on them."),
            weight = 1,
        },
    },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            airtight = true,
            ammunition = { khuunaofaai_payload_glue = 4 },
            watertight = true,
        },
    },
    magazine = { ammunition = { "khuunaofaai_payload_glue" }, capacity = 4, count = 4 },
}

ccb.content.define_item {
    id = "ree_33_4_mag",
    looks_like = "stanag30",
    name = ccb.content.text("3.3 naval 4-round magazine"),
    description = ccb.content.text("A bulky 4-round magazine for the Exodii naval rifle.  Grants some amount of portability, if the gun itself can be named portable."),
    variant_kind = "gun",
    variants = {
        {
            id = "ree_33_4_mag",
            name = ccb.content.text("3.3 naval 4-round magazine"),
            description = ccb.content.text("A bulky 4-round magazine for the Exodii Ree 3.3 rifle.  Grants some amount of portability, if the gun itself can be named portable."),
        },
    },
    mass = "340 g",
    volume = "1200 ml",
    length = "245 mm",
    survival_price = "2 USD 50 cent",
    materials = { "qt_steel" },
    symbol = "#",
    color = "light_gray",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["33naval"] = 4 } } },
    magazine = { ammunition = { "33naval" }, reload_time = 500 },
}

ccb.content.define_item {
    id = "ree_33_53_mag",
    looks_like = "stanag30",
    name = ccb.content.text("3.3 naval 53-round box magazine"),
    description = ccb.content.text("Giant metal box with a belt, which allows it to be used as a high-capacity magazine for the Exodii naval rifle."),
    variant_kind = "gun",
    variants = {
        {
            id = "ree_33_53_mag",
            name = ccb.content.text("3.3 naval 53-round box magazine"),
            description = ccb.content.text("Giant metal box with a belt, which allows it to be used as a high-capacity magazine for the Exodii Ree 3.3 rifle."),
        },
    },
    mass = "4600 g",
    volume = "14000 ml",
    length = "245 mm",
    survival_price = "2 USD 50 cent",
    materials = { "qt_steel" },
    symbol = "#",
    color = "light_gray",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["33naval"] = 53 } } },
    magazine = { ammunition = { "33naval" }, reload_time = 400 },
}

ccb.content.define_item {
    id = "caotel_plasma_ring",
    looks_like = "stanag30",
    name = ccb.content.text("Caotel plasma condenser"),
    description = ccb.content.text("A strange annular device analogous to a magazine, automatically ejected whenever the last of its mounted power cells are depleted.  In fact, you are not sure whether its meant to be reusable or not."),
    mass = "1020 g",
    flags = { "MAG_BULKY", "MAG_EJECT" },
    volume = "1450 ml",
    length = "120 mm",
    survival_price = "40 USD",
    materials = { "qt_steel" },
    symbol = "#",
    color = "light_gray",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { caotel_cell = 12 } } },
    magazine = { ammunition = { "caotel_cell" }, reload_time = 1800 },
}
