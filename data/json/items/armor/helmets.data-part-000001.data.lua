local ccb = require("ccb")

ccb.content.define_item {
    id = "headgear",
    name = ccb.content.text("headgear"),
    description = ccb.content.text("Lightweight sports headgear designed to protect the head while sparring."),
    mass = "500 g",
    volume = "1 L",
    price = "40 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic_pad", "leather" },
    symbol = "[",
    looks_like = "balclava",
    color = "red",
    flags = { "VARSIZE", "OVERSIZE", "STURDY" },
    armor = {
        warmth = 10,
        thickness = 3,
        environmental_protection = 1,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 40,
                covers = { "head" },
                subparts = { "head_crown" },
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 14 },
                    { id = "leather", coverage = 100, thickness = 1.5 },
                },
            },
            {
                coverage = 95,
                covers = { "head" },
                subparts = { "head_forehead", "head_ear_l", "head_ear_r" },
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 14 },
                    { id = "leather", coverage = 100, thickness = 1.5 },
                },
            },
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 95,
                covers = { "mouth" },
                subparts = { "mouth_cheeks", "mouth_chin" },
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 14 },
                    { id = "leather", coverage = 100, thickness = 1.5 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "helmet_army",
    category = "armor",
    name = ccb.content.text("army helmet"),
    description = ccb.content.text("A heavy helmet that provides excellent protection from all sorts of damage.  It is labeled as the advanced combat helmet."),
    mass = "1383 g",
    volume = "1750 ml",
    length = "28 cm",
    price = "150 USD",
    survival_price = "15 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "kevlar_rigid", "plastic" },
    symbol = "[",
    looks_like = "hat_hard",
    color = "green",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "PADDED", "MODULE_HOLDER" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2 L",
            mass_limit = "2 kg",
            moves = 250,
            description = ccb.content.text("Pocket for a face shield, or a front night vision attachment."),
            allowed_flags = { "HELMET_FACE_SHIELD", "HELMET_FRONT_ATTACHMENT" },
            inherits_flags = false,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for an ear attachment."),
            allowed_flags = { "HELMET_EAR_ATTACHMENT" },
            inherits_flags = true,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "250 g",
            moves = 250,
            description = ccb.content.text("Pocket for a nape protector."),
            allowed_flags = { "HELMET_NAPE_PROTECTOR" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a strapped mandible guard."),
            allowed_flags = { "HELMET_MANDIBLE_GUARD_STRAPPED" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "400 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a counterweight pouch."),
            allowed_flags = { "HELMET_BACK_POUCH" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "300 ml",
            mass_limit = "500 g",
            max_item_length = "14 cm",
            moves = 100,
            description = ccb.content.text("Pocket for a flashlight attachment."),
            allowed_flags = { "HELMET_HEAD_ATTACHMENT" },
            transparent = true,
        },
    },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 20,
        thickness = 9,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 50,
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "helmet_army_stripped",
    category = "armor",
    copy_from = "helmet_army",
    name = ccb.content.plural_text("army helmet (stripped)", "army helmets (stripped)"),
    description = ccb.content.text("A heavy helmet that provides excellent protection from all sorts of damage.  It is labeled as the advanced combat helmet.  This one has been stripped of all its mounting points, leaving only the nape and mandible attachment points, and the counterweight pouch."),
    mass = "1153 g",
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "250 g",
            moves = 250,
            description = ccb.content.text("Pocket for a nape protector."),
            allowed_flags = { "HELMET_NAPE_PROTECTOR" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a strapped mandible guard."),
            allowed_flags = { "HELMET_MANDIBLE_GUARD_STRAPPED" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "400 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a counterweight pouch."),
            allowed_flags = { "HELMET_BACK_POUCH" },
        },
    },
    armor = {},
}

-- assuming this is an antique and not a cheap replica
ccb.content.define_item {
    id = "helmet_army_outdated",
    repair_like = "helmet_barbute",
    category = "armor",
    name = ccb.content.text("flak helmet"),
    description = ccb.content.text("A simple helmet meant to protect the head from fragmentation and impacts.  Its simple steel construction renders it outdated by modern military standards."),
    mass = "1400 g",
    volume = "1900 ml",
    length = "28 cm",
    price = "200 USD",
    survival_price = "12 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "hc_steel", "plastic", "leather" },
    repair_materials = { "hc_steel" },
    symbol = "[",
    looks_like = "helmet_army",
    color = "dark_gray",
    flags = { "VARSIZE", "STURDY", "PADDED" },
    variants = {
        {
            id = "helmet_m1",
            name = ccb.content.text("M1 helmet"),
            description = ccb.content.text("A M1 combat helmet, famously worn by American soldiers in the Second World War as well as the Korean and Vietnam wars.  Inferior to modern helmets, but it still remains popular among guerrilla fighters, collectors and war re-enactors."),
            color = "green",
            weight = 10,
        },
        {
            id = "helmet_ssh",
            name = ccb.content.text("SSh-68 helmet"),
            description = ccb.content.text("An old SSh-68 combat helmet from the Soviet Union, likely brought to The States by a collector or migrant.  It is designed to protect against shrapnel and some small arms and will do little to stop a rifle round."),
            color = "light_red",
            weight = 5,
        },
    },
    melee_damage = { bash = 2 },
    armor = {
        warmth = 10,
        portions = {
            {
                materials = {
                    { id = "hc_steel", coverage = 100, thickness = 1.12 },
                    { id = "plastic", coverage = 100, thickness = 3 },
                    { id = "leather", coverage = 10, thickness = 1.0 },
                },
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
        },
    },
}

ccb.content.define_item {
    id = "helmet_soviet_tanker",
    category = "armor",
    name = ccb.content.text("Soviet tanker helmet"),
    description = ccb.content.text("A Soviet era tanker helmet.  It's distinctive foam pads are meant to protect a tank driver from bumps against the cramped interior."),
    price = "100 USD",
    survival_price = "12 USD",
    mass = "950 g",
    volume = "1200 ml",
    symbol = "[",
    looks_like = "helmet_army",
    color = "green",
    flags = { "VARSIZE", "STURDY", "PADDED" },
    armor = {
        warmth = 30,
        portions = {
            {
                layers = { "NORMAL" },
                encumbrance = 10,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead", "head_ear_l", "head_ear_r" },
                coverage = 100,
                materials = {
                    { id = "canvas", thickness = 1 },
                    { id = "canvas", coverage = 40, thickness = 1 },
                    { id = "plastic_pad", coverage = 40, thickness = 15 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "tac_fullhelmet",
    category = "armor",
    name = ccb.content.text("tactical full helmet"),
    description = ccb.content.text("An all-encompassing black helmet that covers your entire face and neck, providing excellent protection from all sorts of damage."),
    mass = "1594 g",
    volume = "2250 ml",
    price = "250 USD",
    survival_price = "25 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "kevlar_rigid", "plastic" },
    symbol = "[",
    looks_like = "helmet_motor",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "SUN_GLASSES", "PADDED", "MODULE_HOLDER" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2 L",
            mass_limit = "2 kg",
            moves = 250,
            description = ccb.content.text("Pocket for a front night vision attachment."),
            allowed_flags = { "HELMET_FRONT_ATTACHMENT" },
            inherits_flags = false,
        },
    },
    melee_damage = { bash = 1 },
    armor = {
        portions = {
            {
                covers = { "head" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            { covers = { "eyes" }, rigid_only = true, coverage = 100, encumbrance = 20 },
            { covers = { "mouth" }, rigid_only = true, coverage = 100, encumbrance = 15 },
        },
        warmth = 25,
        thickness = 8,
        environmental_protection = 2,
    },
}

ccb.content.define_item {
    id = "tac_helmet",
    category = "armor",
    name = ccb.content.text("tactical helmet"),
    description = ccb.content.text("A lightweight black helmet that provides excellent protection from all sorts of damage.  It has a military rail system for attachments."),
    mass = "1180 g",
    volume = "1850 ml",
    price = "200 USD",
    survival_price = "20 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "kevlar_rigid", "plastic" },
    symbol = "[",
    looks_like = "tac_fullhelmet",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "PADDED", "MODULE_HOLDER" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2 L",
            mass_limit = "2 kg",
            moves = 250,
            description = ccb.content.text("Pocket for a face shield, or a front night vision attachment."),
            allowed_flags = { "HELMET_FACE_SHIELD", "HELMET_FRONT_ATTACHMENT" },
            inherits_flags = false,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for an ear attachment."),
            allowed_flags = { "HELMET_EAR_ATTACHMENT" },
            inherits_flags = true,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "250 g",
            moves = 250,
            description = ccb.content.text("Pocket for a nape protector."),
            allowed_flags = { "HELMET_NAPE_PROTECTOR" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a rail-mounted mandible guard."),
            allowed_flags = { "HELMET_MANDIBLE_GUARD" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "400 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a counterweight pouch."),
            allowed_flags = { "HELMET_BACK_POUCH" },
        },
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "300 ml",
            mass_limit = "500 g",
            max_item_length = "14 cm",
            moves = 100,
            description = ccb.content.text("Pocket for a flashlight attachment."),
            allowed_flags = { "HELMET_HEAD_ATTACHMENT" },
            transparent = true,
        },
    },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 20,
        thickness = 8,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 10,
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "firehelmet",
    category = "armor",
    name = ccb.content.text("firefighter helmet"),
    description = ccb.content.text("A distinctive helmet worn by firefighters.  More than just a piece of firefighting equipment, it serves as a badge of honor and respect."),
    mass = "1500 g",
    volume = "1250 ml",
    length = "30 cm",
    price = "240 USD",
    survival_price = "5 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "plastic", "nomex" },
    symbol = "[",
    looks_like = "cowboy_hat",
    color = "yellow",
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "PADDED" },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 15,
        thickness = 6,
        environmental_protection = 6,
        portions = {
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 5.0 },
                    { id = "nomex", coverage = 100, thickness = 1.0 },
                },
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
            {
                materials = { { id = "nomex", coverage = 100, thickness = 1.0 } },
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r", "head_nape" },
            },
        },
    },
}

ccb.content.define_item {
    id = "helmet_ball",
    category = "armor",
    name = ccb.content.text("baseball helmet"),
    description = ccb.content.text("A hard plastic helmet that covers the head and ears.  Designed to protect against a baseball to the head."),
    mass = "615 g",
    volume = "1750 ml",
    price = "31 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic", "plastic_pad" },
    symbol = "[",
    looks_like = "hat_hard",
    color = "blue",
    techniques = { "WBLOCK_1" },
    flags = { "PADDED" },
    armor = {
        warmth = 15,
        thickness = 3,
        environmental_protection = 1,
        portions = {
            {
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 12 },
                    { id = "plastic", coverage = 100, thickness = 3 },
                },
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
            {
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 12 },
                    { id = "plastic", coverage = 100, thickness = 3 },
                },
                encumbrance_modifiers = { "NONE" },
                coverage = 95,
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "helmet_aztec",
    category = "armor",
    name = ccb.content.text("eagle cuacalalatli"),
    description = ccb.content.text("A hardwood Mesoamerican helmet that resembles the head of an eagle.  It was worn by the renowned eagle warriors of the Aztec, both ceremonially and for protection.  Its inside is lined with cotton, and it is ornamented with many feathers, carvings and colors."),
    mass = "1500 g",
    volume = "2500 ml",
    symbol = "[",
    color = "brown",
    looks_like = "helmet_plate",
    price = "150 USD",
    survival_price = "12 USD 50 cent",
    materials = { "wood", "cotton" },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 1 },
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY", "PADDED", "WATERPROOF", "NO_REPAIR" },
    armor = {
        warmth = 15,
        portions = {
            {
                materials = {
                    { id = "wood", coverage = 100, thickness = 6 },
                    { id = "cotton", coverage = 95, thickness = 2 },
                },
                covers = { "head" },
                subparts = { "head_forehead", "head_crown", "head_ear_l", "head_ear_r" },
                encumbrance = 50,
                coverage = 100,
            },
            {
                materials = {
                    { id = "wood", coverage = 100, thickness = 6 },
                    { id = "cotton", coverage = 95, thickness = 2 },
                },
                covers = { "head" },
                subparts = { "head_nape" },
                coverage = 40,
            },
            {
                materials = {
                    { id = "wood", coverage = 100, thickness = 6 },
                    { id = "cotton", coverage = 95, thickness = 2 },
                },
                covers = { "mouth" },
                subparts = { "mouth_chin" },
                coverage = 100,
            },
            {
                materials = {
                    { id = "wood", coverage = 100, thickness = 6 },
                    { id = "cotton", coverage = 95, thickness = 2 },
                },
                covers = { "mouth" },
                subparts = { "mouth_cheeks" },
                coverage = 20,
            },
        },
    },
}

ccb.content.define_item {
    id = "helmet_barbute",
    category = "armor",
    name = ccb.content.text("barbute helm"),
    description = ccb.content.text("A medieval helmet that provides excellent protection for the head, with a Y shaped opening for the face."),
    mass = "1175 g",
    volume = "2500 ml",
    price = "300 USD",
    survival_price = "40 USD",
    materials = { "steel", "leather" },
    symbol = "[",
    looks_like = "helmet_plate",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 1 },
    armor = {
        portions = {
            {
                covers = { "head" },
                subparts = { "head_forehead", "head_crown", "head_ear_l", "head_ear_r" },
                coverage = 100,
                encumbrance_modifiers = { "NONE" },
            },
            {
                covers = { "head" },
                subparts = { "head_nape" },
                coverage = 20,
                encumbrance_modifiers = { "NONE" },
            },
            { covers = { "eyes" }, coverage = 65, encumbrance = 0 },
            {
                covers = { "mouth" },
                subparts = { "mouth_cheeks" },
                coverage = 100,
                encumbrance = 0,
                rigid_only = true,
            },
            {
                covers = { "mouth", "head" },
                subparts = { "mouth_lips", "mouth_nose", "mouth_chin" },
                coverage = 50,
                encumbrance = 0,
                rigid_only = true,
            },
        },
        warmth = 10,
        thickness = 4,
    },
}

ccb.content.define_item {
    id = "xl_helmet_barbute",
    copy_from = "helmet_barbute",
    name = ccb.content.text("barbute helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_barbute_xs",
    copy_from = "helmet_barbute",
    name = ccb.content.text("barbute helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "helmet_bike",
    category = "armor",
    name = ccb.content.text("bike helmet"),
    description = ccb.content.text("A thick foam helmet.  Designed to protect against concussion."),
    mass = "400 g",
    volume = "1500 ml",
    length = "26 cm",
    price = "170 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic", "plastic_pad" },
    symbol = "[",
    looks_like = "hat_hard",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "PADDED" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "200 ml",
            mass_limit = "50 g",
            moves = 250,
            description = ccb.content.text("Pocket for a shield visor."),
            allowed_flags = { "HELMET_FACE_SHIELD" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "500 ml",
            mass_limit = "400 g",
            moves = 250,
            description = ccb.content.text("Pocket for a strapped mandible guard."),
            allowed_flags = { "HELMET_MANDIBLE_GUARD_STRAPPED" },
        },
    },
    melee_damage = { bash = 1 },
    armor = {
        warmth = 15,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown" },
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 14 },
                    { id = "plastic", coverage = 100, thickness = 1.5 },
                },
            },
            {
                coverage = 80,
                covers = { "head" },
                subparts = { "head_forehead" },
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 14 },
                    { id = "plastic", coverage = 100, thickness = 1.5 },
                },
            },
        },
    },
}

-- Human surface area is roughly 18600 cm^2, based off of rules of 9 the head is 9% leaving us with 1 674 cm^2.
-- Chitin has a density of 1.45g/cm^3, thickness of 0.32 cm, coverage of 80% leaves us with 777 grams.
-- Leather has a density of 1.1g/cm^3, thickness of 0.07 cm, coverage of 100% leaves us with 129 grams.
-- Totalled up this is 906 grams with some rounding
ccb.content.define_item {
    id = "helmet_chitin",
    category = "armor",
    name = ccb.content.text("chitinous scale mail hood"),
    description = ccb.content.text("Chitin sections overlapping with each other secured to a leather backing in the shape of a hood.  The odd irregular shapes make full coverage impossible, not helped by how poor of a material chitin is.  Seems to be made more out of desperation than anything, and would benefit greatly from some underlying armor."),
    mass = "906 g",
    volume = "2 L",
    price = "380 USD",
    survival_price = "50 cent",
    materials = { { id = "chitin", portions = 35 }, { id = "leather", portions = 1 } },
    symbol = "[",
    looks_like = "helmet_larmor",
    color = "green",
    flags = { "OUTER" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "chitin", coverage = 80, thickness = 3.2 },
                    { id = "leather", coverage = 100, thickness = 0.7 },
                },
                covers = { "head" },
                subparts = {
                    "head_crown",
                    "head_forehead",
                    "head_ear_l",
                    "head_ear_r",
                    "head_nape",
                    "head_throat",
                },
                coverage = 95,
                encumbrance_modifiers = { "NONE" },
            },
        },
        warmth = 20,
    },
}

ccb.content.define_item {
    id = "xl_helmet_chitin",
    copy_from = "helmet_chitin",
    looks_like = "helmet_chitin",
    name = ccb.content.text("chitinous scale mail hood"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_chitin_xs",
    copy_from = "helmet_chitin",
    looks_like = "helmet_chitin",
    name = ccb.content.text("chitinous scale mail hood"),
    flags = { "WATERPROOF", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "helmet_conical",
    category = "armor",
    name = ccb.content.text("conical helm"),
    description = ccb.content.text("A conical iron helm with additional protection for the neck, associated with the Mongol Empire."),
    mass = "1425 g",
    volume = "3500 ml",
    price = "400 USD",
    survival_price = "35 USD",
    materials = { "iron", "fur" },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "brown",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    melee_damage = { bash = 3 },
    armor = {
        warmth = 35,
        thickness = 3,
        portions = {
            {
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_forehead", "head_crown", "head_ear_l", "head_ear_r" },
            },
            { coverage = 90, covers = { "head" }, subparts = { "head_nape" } },
        },
    },
}

ccb.content.define_item {
    id = "xl_helmet_conical",
    copy_from = "helmet_conical",
    name = ccb.content.text("conical helm"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_conical_xs",
    copy_from = "helmet_conical",
    looks_like = "helmet_conical",
    name = ccb.content.text("conical helm"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "helmet_acidchitin",
    copy_from = "helmet_chitin",
    looks_like = "helmet_chitin",
    name = ccb.content.text("biosilicified chitin helmet"),
    description = ccb.content.text("A helmet crafted from the carefully cleaned and pruned biosilicified exoskeletons of acidic ants.  Covers the whole head.  Acid-resistant but brittle."),
    survival_price = "17 USD 50 cent",
    materials = { "acidchitin" },
    armor = {},
    inheritance = { offset = { melee_damage = { bash = 1 } } },
}

ccb.content.define_item {
    id = "xl_helmet_acidchitin",
    copy_from = "helmet_acidchitin",
    looks_like = "helmet_acidchitin",
    name = ccb.content.text("biosilicified chitin helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_acidchitin_xs",
    copy_from = "helmet_acidchitin",
    looks_like = "helmet_acidchitin",
    name = ccb.content.text("biosilicified chitin helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "helmet_football",
    category = "armor",
    name = ccb.content.text("football helmet"),
    description = ccb.content.text("A heavy polycarbonate helmet normally worn by football players.  It comes with a visor to protect the eyes."),
    mass = "1360 g",
    volume = "2250 ml",
    price = "198 USD",
    survival_price = "2 USD 50 cent",
    materials = { "thermo_resin", "plastic_pad" },
    symbol = "[",
    looks_like = "helmet_motor",
    color = "yellow",
    flags = { "WATER_FRIENDLY", "PADDED" },
    armor = {
        portions = {
            {
                covers = { "head" },
                coverage = 100,
                subparts = { "head_crown", "head_forehead" },
                encumbrance_modifiers = { "NONE" },
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 14 },
                    { id = "thermo_resin", coverage = 100, thickness = 3 },
                },
            },
            {
                covers = { "head" },
                coverage = 95,
                subparts = { "head_ear_l", "head_ear_r" },
                materials = {
                    { id = "plastic_pad", coverage = 100, thickness = 14 },
                    { id = "thermo_resin", coverage = 100, thickness = 3 },
                },
            },
            {
                covers = { "eyes" },
                rigid_only = true,
                coverage = 70,
                encumbrance = 5,
                breathability = "POOR",
                materials = { { id = "thermo_resin", coverage = 100, thickness = 4 } },
            },
            {
                covers = { "mouth" },
                rigid_only = true,
                coverage = 85,
                encumbrance = 0,
                breathability = "GOOD",
                materials = { { id = "thermo_resin", coverage = 100, thickness = 4 } },
            },
        },
        warmth = 10,
    },
}

ccb.content.define_item {
    id = "helmet_galea",
    category = "armor",
    name = ccb.content.plural_text("galea", "galeae"),
    description = ccb.content.text("An Imperial Roman helmet, with distinct projections protecting the sides of the head."),
    mass = "1310 g",
    volume = "2500 ml",
    price = "350 USD",
    survival_price = "35 USD",
    materials = { "iron", "leather" },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "STURDY" },
    melee_damage = { bash = 3 },
    armor = {
        portions = {
            {
                covers = { "head" },
                coverage = 100,
                subparts = { "head_crown", "head_forehead" },
                encumbrance_modifiers = { "NONE" },
            },
            { covers = { "head" }, coverage = 20, subparts = { "head_ear_l", "head_ear_r" } },
            { covers = { "head" }, coverage = 80, subparts = { "head_nape" } },
            {
                covers = { "mouth" },
                coverage = 40,
                subparts = { "mouth_cheeks", "mouth_chin" },
                encumbrance = 0,
                rigid_only = true,
            },
        },
        warmth = 10,
        thickness = 3,
    },
}

ccb.content.define_item {
    id = "xl_helmet_galea",
    copy_from = "helmet_galea",
    name = ccb.content.plural_text("galea", "galeae"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_galea_xs",
    copy_from = "helmet_galea",
    name = ccb.content.plural_text("galea", "galeae"),
    flags = { "VARSIZE", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

-- Leaving this at $500 as it's either antique/priceless or player-made/Bartered, leastwise on the initial search.
ccb.content.define_item {
    id = "helmet_kabuto",
    category = "armor",
    name = ccb.content.plural_text("kabuto", "kabuto"),
    description = ccb.content.text("A medieval Japanese helmet with a scowling face mask that provides excellent protection to the entire head and face."),
    mass = "1625 g",
    volume = "3500 ml",
    price = "500 USD",
    survival_price = "50 USD",
    materials = { "iron", "leather" },
    symbol = "[",
    looks_like = "helmet_barbute",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    flags = { "STURDY" },
    melee_damage = { bash = 3 },
    armor = {
        portions = {
            {
                covers = { "head" },
                subparts = { "head_crown", "head_ear_l", "head_ear_r", "head_forehead", "head_nape" },
                coverage = 100,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            {
                covers = { "head" },
                subparts = { "head_throat" },
                coverage = 95,
                encumbrance_modifiers = { "RESTRICTS_NECK", "WELL_SUPPORTED" },
            },
            { covers = { "eyes" }, rigid_only = true, coverage = 35, encumbrance = 0 },
            {
                covers = { "mouth" },
                subparts = { "mouth_lips" },
                rigid_only = true,
                coverage = 80,
                encumbrance = 10,
            },
            {
                covers = { "mouth" },
                subparts = { "mouth_cheeks", "mouth_chin", "mouth_nose" },
                rigid_only = true,
                coverage = 100,
            },
        },
        warmth = 25,
        thickness = 4,
        environmental_protection = 1,
    },
}

ccb.content.define_item {
    id = "xl_helmet_kabuto",
    copy_from = "helmet_kabuto",
    name = ccb.content.plural_text("kabuto", "kabuto"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_kabuto_xs",
    copy_from = "helmet_kabuto",
    name = ccb.content.plural_text("kabuto", "kabuto"),
    flags = { "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "helmet_larmor",
    category = "armor",
    name = ccb.content.text("leather armor helmet"),
    description = ccb.content.text("A thick leather helmet that provides excellent protection for the head."),
    mass = "658 g",
    volume = "2 L",
    price = "140 USD",
    survival_price = "20 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "hat_hard",
    color = "brown",
    techniques = { "WBLOCK_1" },
    flags = { "VARSIZE", "WATER_FRIENDLY", "STURDY" },
    armor = {
        warmth = 10,
        thickness = 4.5,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_ear_l", "head_ear_r" },
            },
            { coverage = 90, covers = { "head" }, subparts = { "head_forehead" } },
        },
    },
}

ccb.content.define_item {
    id = "xl_helmet_larmor",
    copy_from = "helmet_larmor",
    name = ccb.content.text("leather armor helmet"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_larmor_xs",
    copy_from = "helmet_larmor",
    name = ccb.content.text("leather armor helmet"),
    flags = { "VARSIZE", "WATER_FRIENDLY", "STURDY", "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "helmet_skull",
    name = ccb.content.text("wolf skull helmet"),
    description = ccb.content.text("The top part of a large wolf skull, equipped with leather straps to secure it on your head.  Every inch of the skull has been carved with a maze of fine, intertwined symbols that make your eyes water."),
    mass = "1 kg",
    volume = "4 L",
    price = "14 USD",
    survival_price = "2 USD",
    materials = { "leather", "bone" },
    symbol = "[",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY" },
    armor = {
        thickness = 3,
        portions = {
            {
                encumbrance_modifiers = { "IMBALANCED" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown" },
            },
            {
                encumbrance_modifiers = { "IMBALANCED" },
                coverage = 60,
                covers = { "head" },
                subparts = { "head_forehead" },
            },
        },
    },
}

ccb.content.define_item {
    id = "helmet_liner",
    name = ccb.content.text("helmet liner"),
    description = ccb.content.text("A cloth liner worn inside a helmet to help keep your head warm in cold climates."),
    mass = "110 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "balclava",
    color = "green",
    flags = { "VARSIZE", "SKINTIGHT" },
    armor = {
        warmth = 30,
        thickness = 0.5,
        portions = { { encumbrance_modifiers = { "NONE" }, coverage = 100, covers = { "head" } } },
    },
}
