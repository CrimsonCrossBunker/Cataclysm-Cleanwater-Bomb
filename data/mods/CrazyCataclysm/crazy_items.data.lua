local ccb = require("ccb")

ccb.content.define_item {
    id = "granade",
    category = "weapons",
    name = ccb.content.plural_text("Granade", "Granades"),
    description = ccb.content.text("Attached to this grenade is a name tag with the name Maya written on it.  Does not seem to work like a grenade, handle with care."),
    mass = "180 g",
    volume = "250 ml",
    price = "400 USD",
    materials = { "steel", "plastic" },
    symbol = "*",
    color = "green",
    melee_damage = { bash = 6 },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "granade_act",
            message = ccb.content.text("You pull the pin on the %s."),
            target_timer = "5 seconds",
        },
    },
}

ccb.content.define_item {
    id = "granade_act",
    category = "weapons",
    name = ccb.content.plural_text("active Granade", "active Granades"),
    description = ccb.content.text("Attached to this grenade is a name tag with the name Maya written on it.  Does not seem to work like a grenade, handle with care.  Better throw it!"),
    mass = "180 g",
    volume = "250 ml",
    price = "0 cent",
    materials = { "steel", "plastic" },
    symbol = "*",
    color = "green",
    flags = { "TRADER_AVOID" },
    melee_damage = { bash = 6 },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Pull pin"),
        },
    },
    tick_actions = {
        {
            kind = "sound",
            message = ccb.content.text("Merged!"),
            volume = 0,
            sound_id = "speech",
            sound_variant = "granade_act",
        },
    },
    countdown_action = "GRANADE_ACT",
}

ccb.content.define_item {
    id = "bio_chest_gun",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Ionic Overload Generator CBM", "Ionic Overload Generator CBMs"),
    description = ccb.content.text("A powerful ion energy generator is implanted on your chest.  Fires a powerful, ever-expanding energy blast.  The resulting blast ignites oxygen creating fires as it moves and an explosion on impact.  Close range use is highly discouraged."),
    price = "2 kUSD 200 USD",
    bionic = { difficulty = 8 },
}

ccb.content.define_item {
    id = "bio_ion_gun",
    name = ccb.content.text("Ionic Overload Generator"),
    description = ccb.content.text("A powerful ion energy generator is implanted on your chest.  Fires a powerful, ever-expanding energy blast that goes through various targets.  The energy shot ignites oxygen creating fires as it moves and an explosion on impact."),
    mass = "2950 g",
    volume = "3 L",
    price = "16 kUSD",
    materials = { "steel", "plastic" },
    symbol = "(",
    color = "cyan",
    flags = { "NEVER_JAMS", "NO_UNLOAD", "TRADER_AVOID", "BIONIC_WEAPON", "USES_BIONIC_POWER" },
    melee_damage = { bash = 12 },
    gun = {
        skill = "rifle",
        range = 45,
        damage = { type = "stab", amount = 250, penetration = 20 },
        energy_drain = "500 kJ",
        dispersion = 10,
        recoil = 100,
        durability = 10,
        loudness = 50,
        reload_time = 0,
        effects = { "PLASMA", "EXPLOSIVE_HUGE", "STREAM_BIG", "IGNITE", "WIDE" },
    },
}

ccb.content.define_item {
    id = "yeet_cannon",
    copy_from = "gun_base_9mm_semi_pistol",
    name = ccb.content.text("Yeet Cannon"),
    description = ccb.content.text("You can YEET all the bullets with this baby.  YEET them right into all of the zombies in your path, all the hulks, the spiders, and those damned mole rats."),
    mass = "709 g",
    volume = "539 ml",
    price = "75 USD",
    materials = { "plastic", "steel", "zinc" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "hptc9mag_8rd", "hptc9mag_10rd", "hptc9mag_15rd" },
        },
    },
    gun = { dispersion = 480, durability = 7 },
}

-- Lightweight 10 oz denim jeans.
ccb.content.define_item {
    id = "red_jeans",
    name = ccb.content.plural_text("red jeans", "red jeans"),
    description = ccb.content.text("A pair of tight-fitting candy-apple-red jeans with two deep pockets."),
    mass = "600 g",
    volume = "2 L",
    price = "50 USD",
    survival_price = "1 USD 50 cent",
    materials = { "denim" },
    symbol = "[",
    looks_like = "jeans",
    color = "red",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
    },
    flags = { "VARSIZE", "POCKETS" },
    armor = {
        warmth = 10,
        thickness = 0.65,
        portions = { { encumbrance = { 7, 11 }, coverage = 100, covers = { "leg_l", "leg_r" } } },
    },
}

ccb.content.define_item {
    id = "firekatana_off",
    name = "Rising Sun",
    description = "This is a katana with a nozzle just behind the cutting edge of the blade.  People love fire, and people love katana, so why not put them together?  The gas burners attached to this blade can really turn up the heat on your foes.  Use to ignite.",
    symbol = "/",
    color = "light_gray",
    category = "weapons",
    mass = "1400 g",
    volume = "2250 ml",
    price = "980 USD",
    flags = { "FIRE", "DURABLE_MELEE", "SHEATH_SWORD" },
    techniques = { "RAPID", "WBLOCK_2" },
    materials = { "steel" },
    melee_damage = { bash = 4, cut = 31 },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            watertight = true,
            ammunition = { gasoline = 50 },
        },
    },
    qualities = {
        { id = "CUT", level = 1 },
        { id = "BUTCHER", level = 6 },
    },
    use_actions = {
        {
            kind = "fireweapon_off",
            target_id = "firekatana_on",
            moves = 10,
            noise = 10,
            success_message = "The Sun rises.",
        },
    },
    tool = {
        charges_per_use = 1,
        ammo_types = { "gasoline" },
    },
}

ccb.content.define_item {
    id = "firekatana_on",
    name = "Rising Sun",
    description = "This is a katana that glows with the fury and heat of the SUN!  Well, okay it's not THAT hot, but getting hit with it still stings like the dickens.  Use to shut off the gas.",
    symbol = "/",
    color = "red",
    category = "weapons",
    mass = "1400 g",
    volume = "2250 ml",
    price = "980 USD",
    revert_to = "firekatana_off",
    light = 240,
    flags = { "FIRE", "CHARGEDIM", "FLAMING", "DURABLE_MELEE", "TRADER_AVOID", "WATER_EXTINGUISH" },
    techniques = { "RAPID", "WBLOCK_2" },
    materials = { "steel" },
    melee_damage = { bash = 4, cut = 31 },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            watertight = true,
            ammunition = { gasoline = 50 },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "firekatana_off",
            message = "The Sun sets.",
            menu_text = "Turn off",
        },
        { kind = "firestarter", moves = 30 },
    },
    tick_actions = {
        {
            kind = "fireweapon_on",
            noise_chance = 35,
            noise_message = "The Sun shines brightly.",
            charges_extinguish_message = "The Light Fades.",
            water_extinguish_message = "Your sword hisses in the water and goes out.",
        },
    },
    tool = {
        turns_per_charge = 30,
        ammo_types = { "gasoline" },
    },
}

ccb.content.define_item {
    id = "zweifire_off",
    name = ccb.content.plural_text("flammenschwert (aus)", "flammenschwerter (aus)"),
    description = "Ein großes zweihändiges Schwert aus Deutschland, an dessen Klinge sich, unter Zuführung von Benzin, eine anhaltende Flamme erzeugen lässt.  Es ist eine sehr mächtige Waffe.",
    symbol = "/",
    color = "light_gray",
    category = "weapons",
    mass = "3400 g",
    volume = "3750 ml",
    price = "1 kUSD 600 USD",
    flags = { "DURABLE_MELEE", "SHEATH_SWORD", "ALWAYS_TWOHAND" },
    techniques = { "WBLOCK_1", "WIDE", "BRUTAL", "SWEEP" },
    materials = { "steel" },
    melee_damage = { bash = 17, cut = 40 },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            watertight = true,
            ammunition = { gasoline = 50 },
        },
    },
    qualities = {
        { id = "CUT", level = 1 },
        { id = "BUTCHER", level = 1 },
    },
    use_actions = {
        {
            kind = "fireweapon_off",
            target_id = "zweifire_on",
            moves = 10,
            noise = 10,
            success_message = "Die Klinge deines Schwertes brennt!",
        },
    },
    tool = {
        charges_per_use = 1,
        ammo_types = { "gasoline" },
    },
}

ccb.content.define_item {
    id = "battletorch",
    category = "weapons",
    name = ccb.content.plural_text("Louisville Slaughterer", "Louisville Slaughterers"),
    description = ccb.content.text("This is sturdy wood bat, wrapped in gasoline-soaked rags and flame-resistant Nomex fabric.  Light it, and the ball game will REALLY heat up.  You'll need a lighter or matches to light it."),
    mass = "1485 g",
    volume = "2 L",
    price = "160 USD",
    accuracy = { grip = "weapon", length = "long", surface = "any", balance = "good" },
    materials = { "wood", "nomex" },
    symbol = "/",
    color = "brown",
    techniques = { "WBLOCK_1" },
    flags = { "DURABLE_MELEE" },
    melee_damage = { bash = 18 },
    tool = { initial_charges = 25, max_charges = 25, charges_per_use = 1 },
    use_actions = {
        {
            kind = "transform",
            target = "battletorch_lit",
            message = ccb.content.text("You light the Louisville Slaughterer."),
            need_fire = 1,
            menu_text = ccb.content.text("Light", "verb"),
        },
    },
}

ccb.content.define_item {
    id = "zweifire_on",
    name = ccb.content.plural_text("flammenschwert", "flammenschwerter"),
    description = "Ein großes zweihändiges Schwert aus Deutschland, an dessen Klinge sich, unter Zuführung von Benzin, eine anhaltende Flamme erzeugen lässt.  Es ist eine sehr mächtige Waffe.",
    symbol = "/",
    color = "red",
    category = "weapons",
    mass = "3400 g",
    volume = "3750 ml",
    price = "1 kUSD 600 USD",
    revert_to = "zweifire_off",
    light = 240,
    flags = {
        "FIRE",
        "CHARGEDIM",
        "FLAMING",
        "DURABLE_MELEE",
        "TRADER_AVOID",
        "WATER_EXTINGUISH",
        "ALWAYS_TWOHAND",
    },
    techniques = { "WBLOCK_1", "WIDE", "BRUTAL", "SWEEP" },
    materials = { "steel" },
    melee_damage = { bash = 17, cut = 40 },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            watertight = true,
            ammunition = { gasoline = 50 },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "zweifire_off",
            message = "Die Flamme deines Schwertes erlischt.",
            menu_text = "Turn off",
        },
        { kind = "firestarter", moves = 30 },
    },
    tick_actions = {
        {
            kind = "fireweapon_on",
            noise_chance = 35,
            noise_message = "Das Feuer um deine Schwertklinge leuchtet hell!",
            charges_extinguish_message = "Deinem Flammenschwert ist der Brennstoff ausgegangen!",
            water_extinguish_message = "Dein Schwert zischt und erlischt.",
        },
    },
    tool = {
        turns_per_charge = 30,
        ammo_types = { "gasoline" },
    },
}

ccb.content.define_item {
    id = "battletorch_lit",
    category = "weapons",
    name = ccb.content.plural_text("Louisville Slaughterer", "Louisville Slaughterers"),
    description = ccb.content.text("This is a sturdy wood bat, wrapped in gasoline-soaked rags and flame-resistant Nomex fabric.  It is burning brightly, and makes it much easier to see the baselines at night games (It also makes the umpire FAR more likely to call a ball instead of a strike)."),
    mass = "1485 g",
    volume = "2 L",
    price = "160 USD",
    accuracy = { grip = "weapon", length = "long", surface = "any", balance = "good" },
    materials = { "wood", "nomex" },
    symbol = "/",
    color = "red",
    revert_to = "battletorch_done",
    techniques = { "WBLOCK_1" },
    light = 310,
    flags = {
        "FIRE",
        "CHARGEDIM",
        "FLAMING",
        "DURABLE_MELEE",
        "TRADER_AVOID",
        "WATER_EXTINGUISH",
        "SPAWN_ACTIVE",
    },
    melee_damage = { bash = 18 },
    tool = { initial_charges = 25, max_charges = 25, turns_per_charge = 20 },
    use_actions = {
        { kind = "firestarter", moves = 30 },
        {
            kind = "transform",
            target = "battletorch",
            message = ccb.content.text("The Louisville Slaughterer is extinguished."),
            menu_text = ccb.content.text("Extinguish"),
        },
    },
}

ccb.content.define_item {
    id = "flu_shot_fun",
    copy_from = "flu_shot",
    name = ccb.content.text("flu shot"),
    comestible = {
        kind = "MED",
        vitamins = { { id = "mutagen", amount = 2000 }, { id = "mutagen_batrachian", amount = 2300 } },
    },
    inheritance = { add = { flags = { "NUTRIENT_OVERRIDE" } }, remove = { flags = { "NO_INGEST" } } },
}

ccb.content.define_item {
    id = "party_rock",
    symbol = "*",
    color = "pink",
    name = ccb.content.text("party rock"),
    description = ccb.content.text("Party rock condensed into physical form.  This should be too much for any mere mortal to handle."),
    category = "spare_parts",
    materials = { "stone" },
    flags = { "TRADER_AVOID", "NPC_THROWN", "SLING_PROJECTILE" },
    mass = "657 g",
    volume = "250 ml",
    qualities = { { id = "HAMMER", level = 1 } },
    melee_damage = { bash = 7 },
    ammunition = {
        type = "rock",
        damage = { type = "bash", amount = 2 },
        range = 10,
        dispersion = 14,
        loudness = 0,
        effects = { "NON_FOULING", "RECOVER_80" },
    },
}

ccb.content.define_item {
    id = "akmag90",
    looks_like = "stanag30",
    name = ccb.content.text("AK 90-round magazine"),
    description = ccb.content.text("A homemade AK magazine made out of welding magazines together.  Looks really stupid, and doesn't work."),
    mass = "978 g",
    volume = "1137 ml",
    length = "675 mm",
    price = "2 USD",
    survival_price = "50 cent",
    materials = { "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["762"] = 90 } } },
    magazine = { ammunition = { "762" }, reload_time = 200, jam_multiplier = 1200 },
}

ccb.content.define_item {
    id = "aksemi",
    copy_from = "aksemi",
    name = ccb.content.text("AK-47 rifle"),
    description = ccb.content.text("Civilian-legal clones of the AK-47, with no ability to fire full-auto.  Despite lacking that ability, they're still reliable and useful rifles, even if much rarer ammo and magazine wise than the more common AR-15 platform."),
    variant_kind = "gun",
    variants = {
        {
            id = "aksemi_vska",
            name = ccb.content.text("Century Arms VSKA"),
            description = ccb.content.text("This one is a VSKA, manufactured in the USA by Century Arms."),
            weight = 16,
            append = true,
        },
        {
            id = "aksemi_wasr",
            name = ccb.content.text("Century Arms WASR-10"),
            description = ccb.content.text("This one is a WASR-10, imported by Century Arms."),
            weight = 8,
            append = true,
        },
        {
            id = "aksemi_zpap",
            name = ccb.content.text("Zastava ZPAP M70"),
            description = ccb.content.text("This one is a ZPAP M70, imported by Zastava."),
            weight = 5,
            append = true,
        },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "akmag30", "akmag10", "akmag20", "akmag40", "akmag90", "akdrum75" },
        },
    },
    gun = {},
}

ccb.content.define_item {
    id = "ak47",
    copy_from = "ak47",
    name = ccb.content.text("AKM rifle"),
    description = ccb.content.text("One of the most recognizable assault rifles ever made, the AKM is renowned for its durability even under the worst conditions."),
    variant_kind = "gun",
    variants = {
        {
            id = "ak47",
            name = ccb.content.text("AKM"),
            description = ccb.content.text("Arguably the most mass-produced firearm ever made, the AKM has cemented itself in history, and a few country flags.  Designed after WW2, it was meant to replace the PPSh-41's role, but soon became the main infantry rifle.  While many believe it is a copy of the German StG-44, it more resembles an M1 Garand in operation.  Despite it's age, it still sees plenty of use in conflicts today."),
        },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "akmag30", "akmag10", "akmag20", "akmag40", "akmag90", "akdrum75" },
        },
    },
    gun = {},
}

ccb.content.define_item {
    id = "mk47",
    copy_from = "mk47",
    name = ccb.content.text("American AK rifle"),
    description = ccb.content.text("The CMMG Mk47 Mutant is an American rifle, natively chambered for 7.62x39mm ammo.  Features a characteristic free-floating handguard, with a similar action mechanism to the AR-15, repurposed for the bigger, more potent ammo."),
    variant_kind = "gun",
    variants = {
        {
            id = "mk47",
            name = ccb.content.text("Mk47 Mutant rifle"),
            description = ccb.content.text("The CMMG Mk47 Mutant is an American rifle, natively chambered for 7.62x39mm ammo.  Features a characteristic free-floating handguard, with a similar action mechanism to the AR-15, repurposed for the bigger, more potent ammo."),
        },
    },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "akmag30", "akmag10", "akmag20", "akmag40", "akmag90", "akdrum75" },
        },
    },
    gun = {},
}

ccb.content.define_item {
    id = "ceramic_plate",
    copy_from = "ceramic_plate",
    category = "armor",
    name = ccb.content.text("ceramic plate"),
    length = "20 cm",
    description = ccb.content.text("A ceramic dinner plate, unremarkable in every way."),
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_LARGE", "ABLATIVE_MEDIUM", "CANT_WEAR", "NO_SALVAGE" },
    armor = {
        thickness = 1,
        broken_item = "destroyed_ceramic_plate",
        damage_verb = ccb.content.text("makes a crunch, something has shifted"),
        portions = { { encumbrance = 0, coverage = 45, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
}

ccb.content.define_item {
    id = "destroyed_ceramic_plate",
    copy_from = "ceramic_plate",
    name = ccb.content.text("compromised ceramic plate"),
    description = ccb.content.text("A ceramic dinner plate that's been shattered."),
    looks_like = "esapi_plate",
    materials = { "damaged_ceramic" },
    armor = {},
}

ccb.content.define_item {
    id = "kitchen_gun",
    copy_from = "m9",
    name = ccb.content.plural_text("Kitchen Gun™", "Kitchen Guns™"),
    description = ccb.content.text("Say goodbye to daily stains and dirty surfaces with new Kitchen Gun!  Just aim at the dust, blood, or splinters, and then shoot it a bunch of times to clean it.  Blast the filth away with Kitchen Gun™!"),
    gun = { effects = { "CLEAN_DUST", "CLEAN_SPLINTERS", "CLEAN_BLOOD" } },
}

ccb.content.define_item {
    id = "iv_mutagen_troglobite",
    copy_from = "iv_mutagen_troglobite",
    name = ccb.content.plural_text("gamer mutagenic primer", "gamer mutagenic primers"),
}

ccb.content.define_item {
    id = "mutagen_troglobite",
    copy_from = "mutagen_troglobite",
    name = ccb.content.plural_text("gamer mutagen", "gamer mutagens"),
}
