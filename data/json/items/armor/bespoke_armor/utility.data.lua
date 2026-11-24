local ccb = require("ccb")

ccb.content.define_item {
    id = "survivor_belt_notools",
    name = ccb.content.plural_text("handmade utility belt", "handmade utility belts"),
    description = ccb.content.text("A custom-built leather belt covered with pouches, with a sheath to carry a smaller blade, a holster to carry a pistol and a loop for holding larger tools.  Perfect for quick access to the apocalypse essentials."),
    mass = "1549 g",
    volume = "2250 ml",
    price = "150 USD",
    survival_price = "25 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "holster",
    color = "brown",
    pockets = {
        {
            holster = true,
            capacity = "1 L",
            mass_limit = "2 kg",
            max_item_length = "70 cm",
            moves = 20,
            allowed_flags = { "SHEATH_KNIFE" },
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "1000 g",
            max_item_length = "13 cm",
            moves = 50,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "1000 g",
            max_item_length = "13 cm",
            moves = 50,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "1000 g",
            max_item_length = "13 cm",
            moves = 50,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "1000 g",
            max_item_length = "13 cm",
            moves = 50,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "1000 g",
            max_item_length = "13 cm",
            moves = 50,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "1000 g",
            max_item_length = "13 cm",
            moves = 50,
        },
        {
            magazine_well = "350 ml",
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "300 ml",
            capacity = "1000 ml",
            mass_limit = "2 kg",
            max_item_length = "30 cm",
            moves = 50,
        },
        {
            capacity = "2 L",
            mass_limit = "6 kg",
            max_item_length = "90 cm",
            moves = 50,
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
    },
    flags = { "WATER_FRIENDLY", "STURDY", "BELTED", "OVERSIZE" },
    armor = {
        thickness = 2,
        portions = {
            {
                encumbrance = { 2, 6 },
                coverage = 100,
                covers = { "torso" },
                subparts = { "torso_waist" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Store tool or blade"),
            message = ccb.content.text("You put your %1$s in your %2$s"),
        },
    },
}

ccb.content.define_item {
    id = "survivor_goggles",
    category = "armor",
    name = ccb.content.plural_text("handmade hazard goggles", "handmade hazard goggles"),
    description = ccb.content.text("A custom-built pair of armored goggles with tinted lenses.  Comfortable and built to last, they provide excellent protection from environmental dangers."),
    mass = "212 g",
    volume = "250 ml",
    price = "75 USD",
    survival_price = "30 USD",
    materials = { "hard_plastic_transp", "leather_treated" },
    symbol = "[",
    looks_like = "glasses_bal",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY", "SUN_GLASSES", "OVERSIZE", "VARSIZE", "STURDY" },
    armor = {
        warmth = 5,
        thickness = 4,
        environmental_protection = 15,
        portions = {
            {
                materials = {
                    { id = "leather_treated", coverage = 20, thickness = 2 },
                    { id = "hard_plastic_transp", coverage = 100, thickness = 4 },
                },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 25,
            },
        },
    },
}

ccb.content.define_item {
    id = "survivor_vest",
    name = ccb.content.plural_text("handmade harness", "handmade harnesses"),
    description = ccb.content.text("A custom-built light harness covered with pouches and including an integral tactical sling for a small rifle or other such weapon.  Durable and carefully crafted to be comfortable to wear.  Activate to holster/draw your weapon."),
    mass = "320 g",
    volume = "1250 ml",
    price = "200 USD",
    survival_price = "40 USD",
    materials = { "leather", "canvas" },
    symbol = "[",
    looks_like = "tacvest",
    color = "green",
    pockets = {
        {
            description = ccb.content.text("Rifle sling."),
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "1000 ml",
            capacity = "8 L",
            mass_limit = "8200 g",
            max_item_length = "120 cm",
            volume_encumbrance = 0.4,
            moves = 30,
        },
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "5 kg",
            max_item_length = "20 cm",
            volume_encumbrance = 0.3,
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "5 kg",
            max_item_length = "20 cm",
            volume_encumbrance = 0.3,
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "5 kg",
            max_item_length = "20 cm",
            volume_encumbrance = 0.3,
            moves = 80,
        },
    },
    flags = { "WATER_FRIENDLY", "STURDY", "BELTED" },
    armor = {
        thickness = 2,
        portions = {
            {
                encumbrance = 1,
                coverage = 20,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_hanging_front" },
            },
        },
    },
    use_actions = { { kind = "holster" } },
}

ccb.content.define_item {
    id = "xl_survivor_vest",
    copy_from = "survivor_vest",
    name = ccb.content.plural_text("handmade harness", "handmade harnesses"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_survivor_vest",
    copy_from = "survivor_vest",
    name = ccb.content.plural_text("handmade harness", "handmade harnesses"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- The exodii PAPR, with space for a baselard and handcanon shells
ccb.content.define_item {
    id = "nomad_papr_blower_273diyua_off",
    name = ccb.content.plural_text("nomad utility belt", "nomad utility belts"),
    description = ccb.content.text("A sturdy leather belt and powered air purifying respirator blower designed for exploring the apocalyptic wasteland.  On one side hangs an archaic dagger sheath.  The other side has a custom open-top pouch lined with 10 cartridge loops fit for 27.3x110 Diyua shotshells.  Mounted to the back is a spartan PAPR blower, shielded in plastic, with connections for a bionic interface.  If loaded with a filter and paired with a PAPR mask this will protect from all manner of post-apocalyptic environmental threats.  Activate it to turn it on."),
    mass = "1549 g",
    volume = "2250 ml",
    price = "150 USD",
    survival_price = "25 USD",
    materials = { { id = "leather", portions = 4 }, { id = "plastic", portions = 1 } },
    symbol = "[",
    looks_like = "holster",
    color = "brown",
    pockets = {
        {
            id = "papr_blower_filter",
            kind = "MAGAZINE_WELL",
            allowed_flags = { "GASFILTER_MED" },
            default_magazine = "gasfilter_med",
            rigid = true,
        },
        {
            holster = true,
            capacity = "1 L",
            mass_limit = "2 kg",
            max_item_length = "70 cm",
            moves = 20,
            allowed_flags = { "SHEATH_KNIFE" },
        },
        {
            kind = "CONTAINER",
            max_item_length = "120 mm",
            capacity = "2840 ml",
            mass_limit = "2260 g",
            moves = 25,
            allowed_items = {
                "273x110flock",
                "273x110canister",
                "273x110slugheavy",
                "273x110sluglight",
                "273x110slugmedium",
            },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "STURDY", "BELTED", "OVERSIZE", "USES_BIONIC_POWER" },
    subtype_order = { "armor", "tool" },
    armor = {
        thickness = 2,
        portions = {
            {
                encumbrance = { 2, 6 },
                coverage = 100,
                covers = { "torso" },
                subparts = { "torso_waist" },
            },
        },
    },
    tool = { ammo_types = { "battery", "gasfilter_m" } },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Store item"),
            message = ccb.content.text("You put your %1$s in your %2$s"),
        },
        {
            kind = "transform",
            message = ccb.content.text("You activate the PAPR blower on your %s."),
            target = "nomad_papr_blower_273diyua_on",
        },
    },
}

ccb.content.define_item {
    id = "nomad_papr_blower_273diyua_on",
    copy_from = "nomad_papr_blower_273diyua_off",
    name = ccb.content.plural_text("nomad utility belt (on)", "nomad utility belts (on)"),
    description = ccb.content.text("A sturdy leather belt and powered air purifying respirator blower designed for exploring the apocalyptic wasteland.  On one side hangs an archaic dagger sheath.  The other side has a custom open-top pouch lined with 10 cartridge loops fit for 27.3x110 Diyua shotshells.  Mounted to the back is a spartan PAPR blower, shielded in plastic, with connections for a bionic interface.  If loaded with a filter and paired with a PAPR mask this will protect from all manner of post-apocalyptic environmental threats.  The blower is active and draining power.  Activate it to turn it off."),
    revert_to = "nomad_papr_blower_273diyua_off",
    inheritance = { add = { flags = { "PAPR_BLOWER", "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    subtype_order = { "armor", "tool" },
    armor = {},
    tool = { power_draw = "4000 mW" },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Store item"),
            message = ccb.content.text("You put your %1$s in your %2$s"),
        },
        {
            kind = "transform",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn the PAPR blower on the %s off."),
            target = "nomad_papr_blower_273diyua_off",
            ammo_scale = 0,
        },
    },
    tick_actions = {
        "PAPR_BLOWER",
        {
            kind = "sound",
            sound_type = "movement",
            message = ccb.content.text("whooooo…"),
            sound_id = "humming",
            sound_variant = "machinery",
            volume = 12,
        },
    },
}

-- The exodii PAPR, with space for a baselard and battle rifle mags
ccb.content.define_item {
    id = "nomad_papr_blower_magpouch_off",
    name = ccb.content.plural_text("nomad utility belt", "nomad utility belts"),
    description = ccb.content.text("A sturdy leather belt and powered air purifying respirator blower designed for exploring the apocalyptic wasteland.  On one side hangs an archaic dagger sheath.  The other side has three pouches, each fit for a 26-round PA md. 68 box magazine (although anything that size or smaller will fit).  Mounted to the back is a spartan PAPR blower, shielded in plastic, with connections for a bionic interface.  If loaded with a filter and paired with a PAPR mask this will protect from all manner of post-apocalyptic environmental threats.  Activate it to turn it on."),
    mass = "1549 g",
    volume = "2250 ml",
    price = "150 USD",
    survival_price = "25 USD",
    materials = { { id = "leather", portions = 4 }, { id = "plastic", portions = 1 } },
    symbol = "[",
    looks_like = "holster",
    color = "brown",
    pockets = {
        {
            id = "papr_blower_filter",
            kind = "MAGAZINE_WELL",
            allowed_flags = { "GASFILTER_MED" },
            default_magazine = "gasfilter_med",
            rigid = true,
        },
        {
            holster = true,
            capacity = "1 L",
            mass_limit = "2 kg",
            max_item_length = "70 cm",
            moves = 20,
            allowed_flags = { "SHEATH_KNIFE" },
        },
        {
            kind = "CONTAINER",
            max_item_length = "255 mm",
            capacity = "400 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "255 mm",
            capacity = "400 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
        {
            kind = "CONTAINER",
            max_item_length = "255 mm",
            capacity = "400 ml",
            mass_limit = "2 kg",
            moves = 40,
            allowed_flags = { "MAG_COMPACT" },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "STURDY", "BELTED", "OVERSIZE", "USES_BIONIC_POWER" },
    subtype_order = { "armor", "tool" },
    armor = {
        thickness = 2,
        portions = {
            {
                encumbrance = { 2, 6 },
                coverage = 100,
                covers = { "torso" },
                subparts = { "torso_waist" },
            },
        },
    },
    tool = { ammo_types = { "battery", "gasfilter_m" } },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Store item"),
            message = ccb.content.text("You put your %1$s in your %2$s"),
        },
        {
            kind = "transform",
            message = ccb.content.text("You activate the PAPR blower on your %s."),
            target = "nomad_papr_blower_magpouch_on",
        },
    },
}

ccb.content.define_item {
    id = "nomad_papr_blower_magpouch_on",
    copy_from = "nomad_papr_blower_magpouch_off",
    name = ccb.content.plural_text("nomad utility belt (on)", "nomad utility belts (on)"),
    description = ccb.content.text("A sturdy leather belt and powered air purifying respirator blower designed for exploring the apocalyptic wasteland.  On one side hangs an archaic dagger sheath.  The other side has three pouches made to snugly and securely hold 26-round PA md. 68 box magazines, although anything that size or smaller will fit.  Mounted to the back is a spartan PAPR blower, shielded in plastic, with connections for a bionic interface.  If loaded with a filter and paired with a PAPR mask this will protect from all manner of post-apocalyptic environmental threats.  The blower is active and draining power.  Activate it to turn it off."),
    revert_to = "nomad_papr_blower_magpouch_off",
    inheritance = { add = { flags = { "PAPR_BLOWER", "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    subtype_order = { "armor", "tool" },
    armor = {},
    tool = { power_draw = "4000 mW" },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Store item"),
            message = ccb.content.text("You put your %1$s in your %2$s"),
        },
        {
            kind = "transform",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn the PAPR blower on the %s off."),
            target = "nomad_papr_blower_magpouch_off",
            ammo_scale = 0,
        },
    },
    tick_actions = {
        "PAPR_BLOWER",
        {
            kind = "sound",
            sound_type = "movement",
            message = ccb.content.text("whooooo…"),
            sound_id = "humming",
            sound_variant = "machinery",
            volume = 12,
        },
    },
}

-- The exodii PAPR, with space for a baselard and Diyua grenade shells
ccb.content.define_item {
    id = "nomad_papr_blower_273grenade_off",
    name = ccb.content.plural_text("nomad utility belt", "nomad utility belts"),
    description = ccb.content.text("A sturdy leather belt and powered air purifying respirator blower designed for exploring the apocalyptic wasteland.  On one side hangs an archaic dagger sheath.  The other side has a custom open-top pouch lined with 10 cartridge loops fit for 27.3x Diyua grenades.  Mounted to the back is a spartan PAPR blower, shielded in plastic, with connections for a bionic interface.  If loaded with a filter and paired with a PAPR mask this will protect from all manner of post-apocalyptic environmental threats.  Activate it to turn it on."),
    mass = "1549 g",
    volume = "2250 ml",
    price = "150 USD",
    survival_price = "25 USD",
    materials = { { id = "leather", portions = 4 }, { id = "plastic", portions = 1 } },
    symbol = "[",
    looks_like = "holster",
    color = "brown",
    pockets = {
        {
            id = "papr_blower_filter",
            kind = "MAGAZINE_WELL",
            allowed_flags = { "GASFILTER_MED" },
            default_magazine = "gasfilter_med",
            rigid = true,
        },
        {
            holster = true,
            capacity = "1 L",
            mass_limit = "2 kg",
            max_item_length = "70 cm",
            moves = 20,
            allowed_flags = { "SHEATH_KNIFE" },
        },
        {
            kind = "CONTAINER",
            max_item_length = "120 mm",
            capacity = "1760 ml",
            mass_limit = "1760 g",
            moves = 25,
            allowed_items = { "273x44HE", "273x44flare", "273x44trainer", "273x44thermobaric" },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "WATER_FRIENDLY", "STURDY", "BELTED", "OVERSIZE", "USES_BIONIC_POWER" },
    subtype_order = { "armor", "tool" },
    armor = {
        thickness = 2,
        portions = {
            {
                encumbrance = { 2, 6 },
                coverage = 100,
                covers = { "torso" },
                subparts = { "torso_waist" },
            },
        },
    },
    tool = { ammo_types = { "battery", "gasfilter_m" } },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Store item"),
            message = ccb.content.text("You put your %1$s in your %2$s"),
        },
        {
            kind = "transform",
            message = ccb.content.text("You activate the PAPR blower on your %s."),
            target = "nomad_papr_blower_273grenade_on",
        },
    },
}

ccb.content.define_item {
    id = "nomad_papr_blower_273grenade_on",
    copy_from = "nomad_papr_blower_273grenade_off",
    name = ccb.content.plural_text("nomad utility belt (on)", "nomad utility belts (on)"),
    description = ccb.content.text("A sturdy leather belt and powered air purifying respirator blower designed for exploring the apocalyptic wasteland.  On one side hangs an archaic dagger sheath.  The other side has a custom open-top pouch lined with 10 cartridge loops fit for 27.3x Diyua grenades.  Mounted to the back is a spartan PAPR blower, shielded in plastic, with connections for a bionic interface.  If loaded with a filter and paired with a PAPR mask this will protect from all manner of post-apocalyptic environmental threats.  The blower is active and draining power.  Activate it to turn it off."),
    revert_to = "nomad_papr_blower_273grenade_off",
    inheritance = { add = { flags = { "PAPR_BLOWER", "TRADER_AVOID", "SPAWN_ACTIVE" } } },
    subtype_order = { "armor", "tool" },
    armor = {},
    tool = { power_draw = "4000 mW" },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Store item"),
            message = ccb.content.text("You put your %1$s in your %2$s"),
        },
        {
            kind = "transform",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn the PAPR blower on the %s off."),
            target = "nomad_papr_blower_273grenade_off",
            ammo_scale = 0,
        },
    },
    tick_actions = {
        "PAPR_BLOWER",
        {
            kind = "sound",
            sound_type = "movement",
            message = ccb.content.text("whooooo…"),
            sound_id = "humming",
            sound_variant = "machinery",
            volume = 12,
        },
    },
}
