local ccb = require("ccb")

-- Sturmpistole meets express gun, basically.
ccb.content.define_item {
    id = "brogyeki",
    looks_like = "m79",
    name = ccb.content.text("Exodii hand mortar"),
    description = ccb.content.text("Originating from big game express smoothbores and heavy fowling pieces adapted for wallguns, the Brogyeki '23 is an over/under break action 'pistol' that is (unfortunately?) capable of launching its original 27.3x110 Diyua express slug and shot loads as well as the wide array of payloads in 27.3x44 Diyua.  A simple wire stock collapses neatly along its octagonal barrels, which feature a combination of sighting devices necessary for launching its numerous loads, in addition to the usual Exodii retrofits.  Unless you are a quadrupedal cyborg with this gun in a shock absorbing mount, recoil with the 27.3x110 Diyua shells will be *stout*."),
    mass = "2900 g",
    volume = "1775 ml",
    length = "428 mm",
    price = "8 kUSD 500 USD",
    survival_price = "28 USD",
    variant_kind = "gun",
    variants = {
        {
            id = "Brogyeki",
            name = ccb.content.text("Brogyeki '23 hand mortar"),
            description = ccb.content.text("Originating from big game express smoothbores and heavy fowling pieces adapted for wallguns, the Brogyeki '23 is an over/under break action 'pistol' that is (unfortunately?) capable of launching its original 27.3x110 Diyua express slug and shot loads as well as the wide array of payloads in 27.3x44 Diyua.  A simple wire stock collapses neatly along its octagonal barrels, which feature a combination of sighting devices necessary for launching its numerous loads, in addition to the usual Exodii retrofits.  Unless you are a quadrupedal cyborg with this gun in a shock absorbing mount, recoil with the 27.3x110 Diyua shells will be *stout*."),
            weight = 1,
        },
    },
    accuracy = -3,
    materials = { "qt_steel", "aluminum" },
    symbol = "(",
    color = "light_gray",
    faults = {
        { fault = "fault_gun_blackpowder" },
        { fault = "fault_gun_dirt" },
        { fault = "fault_gun_chamber_spent" },
    },
    pockets = {
        {
            kind = "MAGAZINE",
            magazine_well = "61 ml",
            ammunition = { ["273x110"] = 2, ["273x44"] = 2, ["273x44RG"] = 1 },
        },
    },
    flags = { "NEVER_JAMS", "RELOAD_EJECT", "RELOAD_ONE", "EASY_CLEAN", "SINGLE_ACTION" },
    melee_damage = { bash = 6 },
    gun = {
        barrel_length = "212 mm",
        skill = "shotgun",
        ammunition = { "273x44", "273x110", "273x44RG" },
        dispersion = 350,
        durability = 9,
        blackpowder_tolerance = 120,
        clip_size = 1,
        handling = 20,
        reload_time = 140,
        mod_locations = { { id = "stock", count = 1 }, { id = "sling", count = 1 } },
        default_mods = { "wire_stock" },
    },
}

-- Expressgun meets puntgun/wall gun.  Based on an H&H 4 bore shotgun.
ccb.content.define_item {
    id = "brogyaga",
    copy_from = "gun_base_rifle_manual",
    looks_like = "trexgun",
    name = ccb.content.text("Exodii express gun"),
    description = ccb.content.text("An over/under fowling piece with a long barrel, Brogyaga were favored for their versatility in taking large game and fowl with their 27.3x110 Diyua shells.  They would be pressed into combat during two global conflicts, initially as 'light' wall guns, and later as the downsized and down-loaded Brogyeki '23, before being brought along by the Exodii to dimensions unknown.  Though unwieldy in combat as either a primary or secondary, Brogyaga serve as useful parts donors for Brogyeki counterparts, fantastic pieces for the occasional hunting party, and popular trade goods for the locals."),
    mass = "7700 g",
    volume = "2980 ml",
    length = "110 cm",
    price = "6 kUSD 600 USD",
    survival_price = "30 USD",
    variant_kind = "gun",
    variants = {
        {
            id = "Brogyaga",
            name = ccb.content.text("Brogyaga express gun"),
            description = ccb.content.text("An over/under fowling piece with a long barrel, Brogyaga were favored for their versatility in taking large game and fowl with their 27.3x110 Diyua shells.  They would be pressed into combat during two global conflicts, initially as 'light' wall guns, and later as the downsized and down-loaded Brogyeki '23, before being brought along by the Exodii to dimensions unknown.  Though unwieldy in combat as either a primary or secondary, Brogyaga serve as useful parts donors for Brogyeki counterparts, fantastic pieces for the occasional hunting party, and popular trade goods for the locals."),
            weight = 1,
        },
    },
    materials = { "qt_steel", "wood" },
    color = "dark_gray",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["273x110"] = 2, ["273x44"] = 2 } } },
    flags = { "NEVER_JAMS", "RELOAD_EJECT", "RELOAD_ONE", "EASY_CLEAN" },
    gun = {
        ammunition = { "273x44", "273x110", "273x44RG" },
        dispersion = 250,
        durability = 9,
        blackpowder_tolerance = 120,
        clip_size = 1,
        reload_time = 280,
        barrel_length = "1051 mm",
        barrel_volume = "934 ml",
        mod_locations = {
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 2 },
        },
    },
}

-- note for translators, its pronounced "Ka-hu-na-o-fa-aye" and doesn't actually mean anything, you can translate the syllables directly.
ccb.content.define_item {
    id = "khuunaofaai",
    copy_from = "m4_carlgustav",
    looks_like = "m202_flash",
    name = ccb.content.text("Exodii ordnance cannon"),
    description = ccb.content.text("An oddball in the Exodii's oddball selection of armaments - This robust, shoulder mounted weapons platform started life not as a weapon, but as a ceremonial firework cannon, mounted in droves atop of parade tanks the size of buildings by some globe spanning military culture.  Little of its original design remains under the retrofits and wear, with even its engravings worn down to nothing by time.  It finds its niche in disposing incoming hordes from large distances, helped by the variety of chemical payloads its been modified to fire."),
    mass = "8180 g",
    volume = "10360 ml",
    materials = { "qt_steel", "gold" },
    length = "1080 mm",
    survival_price = "125 USD",
    variant_kind = "gun",
    variants = {
        {
            id = "Khuunaofaai",
            name = ccb.content.text("Khuunäöfaai ordnance cannon"),
            description = ccb.content.text("An oddball in the Exodii's oddball selection of armaments - This robust, shoulder mounted weapons platform started life not as a weapon, but as a ceremonial firework cannon, mounted in droves atop of parade tanks the size of buildings by some globe spanning military culture.  Little of its original design remains under the retrofits and wear, with even its engravings worn down to nothing by time.  The Khuunäöfaai finds its niche in disposing incoming hordes from large distances, helped by the variety of chemical payloads its been modified to fire."),
            weight = 1,
        },
    },
    color = "red",
    flags = { "NEVER_JAMS", "NON_FOULING" },
    melee_damage = { bash = 12 },
    pockets = {
        {
            magazine_well = "1250 ml",
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "exodii_khuunaofaai_mag_firework", "exodii_khuunaofaai_mag_incendiary",
                "exodii_khuunaofaai_mag_corrosive", "exodii_khuunaofaai_mag_adhesive",
            },
        },
    },
    gun = {
        mod_locations = { { id = "sights_mount", count = 1 }, { id = "sling", count = 1 } },
        reload_noise_volume = 20,
        ammunition = {
            "khuunaofaai_payload",
            "khuunaofaai_payload_fire",
            "khuunaofaai_payload_acid",
            "khuunaofaai_payload_glue",
        },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_corrosive_spray",
    name = ccb.content.text_without_extraction("corrosive spray"),
    description = ccb.content.text_without_extraction("Your weapon coats its target in highly corrosive chemicals"),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile", "ally", "ground" },
    effect_data = "corroding",
    min_duration = 1300,
    max_duration = 1300,
    min_aoe = 6,
    max_aoe = 6,
    difficulty = 1,
    min_range = 10,
    max_range = 10,
    field = "fd_acid",
    min_field_intensity = 3,
    max_field_intensity = 3,
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_adhesive_spray",
    name = ccb.content.text_without_extraction("adhesive spray"),
    description = ccb.content.text_without_extraction("Your weapon coats its target in quickly hardening resin"),
    effect = "ter_transform",
    effect_data = "exodii_foam",
    shape = "blast",
    valid_targets = { "ground" },
    min_aoe = 5,
    max_aoe = 5,
    difficulty = 1,
    min_range = 10,
    max_range = 10,
}

-- Based on the Truvelo CMS.  No rifle grenades since it has a magazine.
ccb.content.define_item {
    id = "sapra",
    looks_like = "smle_mk3",
    name = ccb.content.text("Exodii Sapra grenade launcher"),
    description = ccb.content.text("The Sapra '36 is a short smoothbore bolt-action grenade launcher, fitted with a 5-round box magazine and a large, efficient muzzle brake.  Designed in the interwar period following the proliferation of Brogyeki '23, the Sapra was intended to assist in riots, ambushes and assaulting in urban operations, where explosives applied in quick succession could make short work of targets.  To further assist in riot operations, the Sapra can be fitted with a bayonet, a frivolity that the Exodii almost immediately discarded.  Unlike the Brogyeki, the Sapra is incapable of chambering the longer 27.3x110 Diyua shells.  The Exodii have replaced the stock with an aluminum alloy chassis, leaving behind the original wood ones as they became damaged."),
    mass = "5900 g",
    volume = "1930 ml",
    length = "980 mm",
    price = "13 kUSD 200 USD",
    survival_price = "100 USD",
    variant_kind = "gun",
    variants = {
        {
            id = "sapra",
            name = ccb.content.text("Sapra '36 grenade launcher"),
            description = ccb.content.text("The Sapra '36 is a short smoothbore bolt-action grenade launcher, fitted with a 5-round box magazine and a large, efficient muzzle brake.  Designed in the interwar period following the proliferation of Brogyeki '23, the Sapra was intended to assist in riots, ambushes and assaulting in urban operations, where explosives applied in quick succession could make short work of targets.  To further assist in riot operations, the Sapra can be fitted with a bayonet, a frivolity that the Exodii almost immediately discarded.  Unlike the Brogyeki, the Sapra is incapable of chambering the longer 27.3x110 Diyua shells.  The Exodii have replaced the stock with an aluminum alloy chassis, leaving behind the original wood ones as they became damaged."),
            weight = 1,
        },
    },
    accuracy = -1,
    materials = { "qt_steel", "aluminum" },
    symbol = "(",
    color = "dark_gray",
    pockets = { { magazine_well = "82 ml", kind = "MAGAZINE_WELL", allowed_items = { "exodiisapramag5" } } },
    flags = { "NEVER_JAMS", "EASY_CLEAN" },
    melee_damage = { bash = 8 },
    gun = {
        ammunition = { "273x44" },
        skill = "launcher",
        dispersion = 300,
        durability = 7,
        blackpowder_tolerance = 110,
        barrel_length = "380 mm",
        default_mods = { "muzzle_brake" },
        mod_locations = {
            { id = "muzzle", count = 1 },
            { id = "rail_mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
            { id = "stock accessory", count = 2 },
            { id = "underbarrel", count = 1 },
        },
    },
}

-- barrel should be a bit shorter than the pamd71z as it's less accurate
ccb.content.define_item {
    id = "pamd68",
    copy_from = "gun_base_rifle_semi",
    looks_like = "modular_ar15",
    name = ccb.content.text("Exodii battle rifle"),
    description = ccb.content.text("The most popular gun to use the 12.3ln cartridge was, of course, the PA md. 71.  Its predecessor, the md. 68, was viewed by many as a sort of failure: although it was reliable and powerful, it was too heavy to be used as a good infantry weapon, and not really heavy enough to be a good support gun.  Enough were made, though, that during the zombie apocalypse, it gained a great deal of resurgent popularity as a light emplacement gun that used readily available ammunition.  It perfectly served the purposes of the Exodii, who had far less concern about its unwieldiness."),
    mass = "9480 g",
    volume = "2800 ml",
    length = "1000 mm",
    price = "3 kUSD 500 USD",
    survival_price = "40 USD",
    variant_kind = "gun",
    variants = {
        {
            id = "pamd68",
            name = ccb.content.text("PA md. 68 rifle"),
            description = ccb.content.text("The most popular gun to use the 12.3ln cartridge was, of course, the PA md. 71.  Its predecessor, the md. 68, was viewed by many as a sort of failure: although it was reliable and powerful, it was too heavy to be used as a good infantry weapon, and not really heavy enough to be a good support gun.  Enough were made, though, that during the zombie apocalypse, it gained a great deal of resurgent popularity as a light emplacement gun that used readily available ammunition.  It perfectly served the purposes of the Exodii, who had far less concern about its unwieldiness."),
        },
    },
    materials = { "qt_steel", "aluminum" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "exodiiBRmag", "exodiiBRmag_153", "exodiiBRmag_26" },
        },
    },
    gun = {
        barrel_length = "508 mm",
        ammunition = { "123ln" },
        dispersion = 190,
        durability = 9,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("burst"), quantity = 2 },
            { id = "SEMI", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 1500 },
        },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bayonet lug", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
            { id = "stock accessory", count = 2 },
            { id = "underbarrel", count = 1 },
        },
        barrel_volume = "1200 ml",
    },
}

-- around the length of other long 30-06 rifles and heavier AR's
ccb.content.define_item {
    id = "pamd71z",
    copy_from = "gun_base_rifle_semi",
    looks_like = "modular_ar15",
    name = ccb.content.text("Exodii zombie hunting rifle"),
    description = ccb.content.text("This extremely popular Romanian rifle, made famous in the third Carpathian War, has been redesigned slightly by the Exodii for precision shots against high-priority targets.  In a pinch this modified design can fire a 2-shot burst, with the goal of shredding the target and preventing revivification.  However, the recoil is much greater for a human than it would be for a cyborg or giant quadruped, causing the burst to more often miss than hit."),
    mass = "3910 g",
    volume = "3 L",
    length = "1100 mm",
    price = "800 USD",
    survival_price = "32 USD 50 cent",
    variant_kind = "gun",
    variants = {
        {
            id = "pamd71z",
            name = ccb.content.text("PS md. 71z rifle"),
            description = ccb.content.text("This extremely popular Romanian rifle, made famous in the third Carpathian War, has been redesigned slightly by the Exodii for precision shots against high-priority targets.  In a pinch this modified design can fire a 2-shot burst, with the goal of shredding the target and preventing revivification.  However, the recoil is much greater for a human than it would be for a cyborg or giant quadruped, causing the burst to more often miss than hit."),
        },
    },
    materials = { "qt_steel", "aluminum" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "exodiiminimag" } } },
    gun = {
        barrel_length = "610 mm",
        ammunition = { "123ln" },
        dispersion = 100,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("burst"), quantity = 2 },
        },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bayonet lug", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 2 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
        barrel_volume = "250 ml",
    },
}

ccb.content.define_item {
    id = "pamd68mountable",
    copy_from = "pamd68",
    name = ccb.content.text("mountable Exodii battle rifle"),
    description = ccb.content.text("The most popular gun to use the 12.3ln cartridge was, of course, the PA md. 71.  Its predecessor, the md. 68, was viewed by many as a sort of failure: although it was reliable and powerful, it was too heavy to be used as a good infantry weapon, and not really heavy enough to be a good support gun.  Enough were made, though, that during the zombie apocalypse, it gained a great deal of resurgent popularity as a light emplacement gun that used readily available ammunition.  It perfectly served the purposes of the Exodii, who had far less concern about its unwieldiness.  This one has been modified for use in vehicle turrets on Earth."),
    mass = "9630 g",
    volume = "2865 ml",
    variant_kind = "gun",
    variants = {
        {
            id = "pamd68mountable",
            name = ccb.content.text("mountable PA md. 68 rifle"),
            description = ccb.content.text("The most popular gun to use the 12.3ln cartridge was, of course, the PA md. 71.  Its predecessor, the md. 68, was viewed by many as a sort of failure: although it was reliable and powerful, it was too heavy to be used as a good infantry weapon, and not really heavy enough to be a good support gun.  Enough were made, though, that during the zombie apocalypse, it gained a great deal of resurgent popularity as a light emplacement gun that used readily available ammunition.  It perfectly served the purposes of the Exodii, who had far less concern about its unwieldiness.  This one has been modified for use in vehicle turrets on Earth."),
        },
    },
    gun = {},
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "spell_plasma_fan",
    name = ccb.content.text_without_extraction("Plasma fan"),
    description = ccb.content.text_without_extraction("Your weapon releases a searing fan of plasma."),
    effect = "attack",
    shape = "cone",
    field = "fd_plasma",
    min_field_intensity = 1,
    max_field_intensity = 3,
    valid_targets = { "hostile", "ally", "ground" },
    flags = { "LOUD", "NO_EXPLOSION_SFX", "RANDOM_DAMAGE", "IGNITE_FLAMMABLE", "IGNORE_WALLS", "SPLIT_DAMAGE" },
    min_damage = 20,
    max_damage = 30,
    min_bash_scaling = 6,
    max_bash_scaling = 6,
    min_aoe = 15,
    max_aoe = 15,
    min_range = 10,
    max_range = 10,
    difficulty = 1,
    sound_description = ccb.content.text("fzzzt"),
    damage_type = "heat",
}

ccb.content.define_item {
    id = "exodii_plasma_projectile",
    name = ccb.content.plural_text("Caotel Sr2.2 (Projectile)", "Caotel Sr2.2 (Projectile)"),
    description = "Nothing but ruins and ash-choked skies remained in the world where this exotic weapon was manufactured, and the Exodii, ever pragmatic, choose not to explore beyond what was necessary to perform a second, emergency escape.  A single discharge from the Caotel easily melts through conventional armor and flash-incinerates anything behind it, but its state of disrepair limits the number of shots it can fire in quick succession.",
    symbol = "(",
    color = "cyan",
    looks_like = "plasma_gun",
    mass = "8500 g",
    volume = "4 L",
    length = "100 cm",
    price = "100 USD",
    survival_price = "100 USD",
    flags = { "NEVER_JAMS", "NON_FOULING", "OVERHEATS" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            capacity = "20 L",
            mass_limit = "20 kg",
            magazine_well = "120 ml",
            holster = true,
            allowed_items = { "caotel_plasma_ring" },
        },
    },
    faults = {
        { fault = "fault_overheat_explosion" },
        { fault = "fault_overheat_venting" },
        { fault = "fault_overheat_safety" },
    },
    use_actions = {
        {
            kind = "transform",
            target = "exodii_plasma_fan",
            ammo_scale = 0,
            message = "A cacophony of symbols flash across the weapon's display, but it seems to stabilize nonetheless.",
            menu_text = "Switch Firing Mode",
        },
    },
    gun = {
        skill = "rifle",
        ammunition = { "caotel_cell" },
        range = 20,
        dispersion = 200,
        recoil = 30,
        durability = 4,
        loudness = 5,
        reload_time = 300,
        effects = { "PLASMA", "EXPLOSIVE_SMALL" },
        heat_per_shot = 20,
        cooling = 1,
        overheat_threshold = 59,
        damage = {
            { type = "bullet", amount = 120, penetration = 60 },
            { type = "biological", amount = 60 },
        },
        mod_locations = {
            { id = "sling", count = 1 },
            { id = "condenser", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "exodii_plasma_fan",
    copy_from = "exodii_plasma_projectile",
    name = ccb.content.plural_text("Caotel Sr2.2 (FAN)", "Caotel Sr2.2 (FAN)"),
    description = "Nothing but ruins and ash-choked skies remained in the world where this exotic weapon was manufactured, and the Exodii, ever pragmatic, choose not to explore beyond what was necessary to perform a second, emergency escape.  Even a second of exposure to the Caotel's plasma fan is enough to flash-incinerate anything, but its state of disrepair limits the amount of time its destructive power can be sustained.",
    looks_like = "plasma_gun",
    use_actions = {
        {
            kind = "transform",
            target = "exodii_plasma_projectile",
            ammo_scale = 0,
            message = "A cacophony of symbols flash across the weapon's display, but it seems to stabilize nonetheless.",
            menu_text = "Switch Firing Mode",
        },
    },
    gun = {
        skill = "launcher",
        range = 12,
        effects = { "PLASMA", "PLASMA_FAN" },
        heat_per_shot = 15,
        damage = {
            { type = "heat", amount = 50, penetration = 60 },
        },
    },
}

-- effectively a weird single-shot self-loading Oerlikon KBA (but longer, and of course not an autocannon) with a 23x152mm round
-- desired to be single shot or with attachable mag, but because MAGAZINE and MAGAZINE_WELL are mortal enemies, 4 round magazine is used instead.
ccb.content.define_item {
    id = "ree_33",
    copy_from = "gun_base_rifle_semi",
    looks_like = "m2browning",
    name = ccb.content.text("exodii naval rifle"),
    description = ccb.content.text("Originally designed for naval defense of a small island country, this gun served Exodii as long as they existed, being one of its reliable tools in later stages of world decay.  Cheap ammunition, a simple mechanism, and immense power output would make it a great weapon for any survivor who is able to carry nearly a hundred kilo of its weight and is in need to penetrate a small bunker.  Unless your body is compatible with Exodii Standard Combat Bodyframe, you can only use it with a heavy-duty tripod, and only while prone.  Due to the size of a top-mounted magazine, the user needs to use a scope mounted on the side of a gun."),
    variant_kind = "gun",
    variants = {
        {
            id = "ree_33",
            name = ccb.content.plural_text("Ree 3.3 exodii rifle", "Ree 3.3 exodii rifle", "`Ree` in this case is butchered `Roe`, to carry some sort of nautical vibe"),
            description = ccb.content.text("Originally designed for naval defense of a small island country, this gun served Exodii as long as they existed, being one of its reliable tools in later stages of world decay.  Cheap ammunition, a simple mechanism, and immense power output would make it a great weapon for any survivor who is able to carry nearly a hundred kilo of its weight and is in need to penetrate a small bunker.  Unless your body is compatible with Exodii Standard Combat Bodyframe, you can only use it with a heavy-duty tripod, and only while prone.  Due to the size of a top-mounted magazine, the user needs to use a scope mounted on the side of a gun."),
        },
    },
    min_strength = 90,
    mass = "77000 g",
    volume = "151425 ml",
    length = "3365 mm",
    survival_price = "200 USD",
    accuracy = { grip = "bad", length = "long", surface = "any", balance = "clumsy" },
    materials = { "qt_steel" },
    flags = { "NEVER_JAMS", "SINGLE_ACTION" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "ree_33_4_mag", "ree_33_53_mag" } } },
    melee_damage = { bash = 7 },
    gun = {
        barrel_length = "2890 mm",
        ammunition = { "33naval" },
        range = 100,
        dispersion = 130,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bayonet lug", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 2 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
        min_cycle_recoil = 80000,
        default_mods = { "ree_33_tripod", "rifle_scope" },
    },
}
