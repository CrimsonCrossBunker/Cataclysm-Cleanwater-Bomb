local ccb = require("ccb")

ccb.content.define_item {
    id = "axe_ring",
    name = ccb.content.plural_text("axe ring holster", "axe ring holsters"),
    description = ccb.content.text("A combination of leather and a metal ring to hold an axe on your waist."),
    mass = "180 g",
    volume = "600 ml",
    price = "30 USD",
    survival_price = "2 USD 50 cent",
    materials = { "leather", "steel" },
    symbol = "[",
    looks_like = "sheath",
    color = "brown",
    pockets = {
        {
            moves = 30,
            capacity = "3250 ml",
            mass_limit = "5 kg",
            max_item_length = "100 cm",
            holster = true,
            allowed_flags = { "SHEATH_AXE" },
            volume_encumbrance = 0.3,
        },
    },
    flags = { "NONCONDUCTIVE", "BELTED", "BELT_CLIP", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 0, coverage = 50, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Sheathe axe"),
            message = ccb.content.text("You sheathe your %s"),
        },
    },
}

ccb.content.define_item {
    id = "baldric",
    name = ccb.content.plural_text("longsword scabbard", "longsword scabbards"),
    description = ccb.content.text("A leather scabbard, big enough for anything up to a longsword, or even a bit larger than that.  Designed to be worn at the waist, secured to the sturdy leather belt.  Activate to sheathe/draw a sword."),
    mass = "1625 g",
    volume = "2 L",
    price = "75 USD",
    survival_price = "5 USD",
    materials = { "leather", "wood" },
    symbol = "[",
    looks_like = "sheath",
    color = "brown",
    pockets = {
        {
            magazine_well = "1500 ml",
            capacity = "3 L",
            mass_limit = "4 kg",
            max_item_length = "130 cm",
            moves = 30,
            holster = true,
            allowed_flags = { "SHEATH_SWORD" },
            volume_encumbrance = 0.25,
        },
        {
            holster = true,
            capacity = "2000 ml",
            mass_limit = "1750 g",
            max_item_length = "70 cm",
            moves = 60,
            description = ccb.content.text("Clipped directly to side of the belt."),
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
        {
            holster = true,
            capacity = "2000 ml",
            mass_limit = "1750 g",
            max_item_length = "70 cm",
            moves = 60,
            description = ccb.content.text("Clipped directly to side of the belt."),
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
        {
            holster = true,
            capacity = "2000 ml",
            mass_limit = "1750 g",
            max_item_length = "70 cm",
            moves = 60,
            description = ccb.content.text("Clipped directly to side of the belt."),
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
        {
            holster = true,
            capacity = "2000 ml",
            mass_limit = "1750 g",
            max_item_length = "70 cm",
            moves = 110,
            description = ccb.content.text("Clipped directly to back of the belt."),
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
        {
            holster = true,
            capacity = "2000 ml",
            mass_limit = "1750 g",
            max_item_length = "70 cm",
            moves = 110,
            description = ccb.content.text("Clipped directly to back of the belt."),
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "STURDY" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 2, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Sheathe sword"),
            message = ccb.content.text("You sheathe your %s"),
        },
    },
}

ccb.content.define_item {
    id = "leg_sheath6",
    name = ccb.content.plural_text("throwing knives leg sheath", "throwing knives leg sheaths"),
    description = ccb.content.text("A nylon strap knife sheath worn on the thigh, made to hold 6 very thin knives, such as throwing knives, close at hand.  Activate to sheathe/draw a weapon."),
    mass = "250 g",
    volume = "1000 ml",
    price = "52 USD",
    survival_price = "2 USD 50 cent",
    materials = { "nylon" },
    symbol = "[",
    looks_like = "sheath",
    color = "dark_gray",
    pockets = {
        {
            magazine_well = "50 ml",
            holster = true,
            allowed_flags = { "SHEATH_KNIFE" },
            moves = 30,
            capacity = "100 ml",
            mass_limit = "500 g",
            max_item_length = "35 cm",
        },
        {
            magazine_well = "50 ml",
            holster = true,
            allowed_flags = { "SHEATH_KNIFE" },
            moves = 30,
            capacity = "100 ml",
            mass_limit = "500 g",
            max_item_length = "35 cm",
        },
        {
            magazine_well = "50 ml",
            holster = true,
            allowed_flags = { "SHEATH_KNIFE" },
            moves = 30,
            capacity = "100 ml",
            mass_limit = "500 g",
            max_item_length = "35 cm",
        },
        {
            magazine_well = "50 ml",
            holster = true,
            allowed_flags = { "SHEATH_KNIFE" },
            moves = 30,
            capacity = "100 ml",
            mass_limit = "500 g",
            max_item_length = "35 cm",
        },
        {
            magazine_well = "50 ml",
            holster = true,
            allowed_flags = { "SHEATH_KNIFE" },
            moves = 30,
            capacity = "100 ml",
            mass_limit = "500 g",
            max_item_length = "35 cm",
        },
        {
            magazine_well = "50 ml",
            holster = true,
            allowed_flags = { "SHEATH_KNIFE" },
            moves = 30,
            capacity = "100 ml",
            mass_limit = "500 g",
            max_item_length = "35 cm",
        },
    },
    flags = { "BELTED", "VARSIZE", "OVERSIZE", "WATER_FRIENDLY", "NONCONDUCTIVE" },
    armor = {
        sided = true,
        thickness = 0.3,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                coverage = 50,
                encumbrance = 4,
                volume_encumbrance = 0.25,
                subparts = { "leg_upper_r", "leg_upper_l" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Sheathe knife"),
            message = ccb.content.text("You sheathe your %s"),
        },
    },
}

ccb.content.define_item {
    id = "gartersheath1",
    name = ccb.content.plural_text("garter sheath", "garter sheaths"),
    description = ccb.content.text("A small concealed garter knife sheath worn on the thigh.  Commonly used by assassins under a skirt or dress.  Activate to sheathe/draw a weapon."),
    mass = "160 g",
    volume = "500 ml",
    price = "52 USD",
    survival_price = "2 USD 50 cent",
    materials = { "nylon", "plastic" },
    symbol = "[",
    looks_like = "sheath",
    color = "dark_gray",
    pockets = {
        {
            magazine_well = "200 ml",
            holster = true,
            allowed_flags = { "SHEATH_KNIFE" },
            moves = 30,
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "30 cm",
        },
    },
    flags = { "BELTED", "VARSIZE", "OVERSIZE", "WATER_FRIENDLY", "NONCONDUCTIVE" },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                coverage = 5,
                encumbrance = 4,
                volume_encumbrance = 0.3,
                subparts = { "leg_upper_r", "leg_upper_l" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Sheathe knife"),
            message = ccb.content.text("You sheathe your %s"),
        },
    },
}

ccb.content.define_item {
    id = "gartersheath2",
    name = ccb.content.plural_text("garter double sheath", "garter double sheaths"),
    description = ccb.content.text("A small concealed garter double knife sheath worn on the thigh.  Commonly used by overly cautious assassins under a skirt or dress.  Activate to sheathe/draw a weapon."),
    mass = "320 g",
    volume = "1000 ml",
    price = "52 USD",
    survival_price = "2 USD 50 cent",
    materials = { "nylon", "plastic" },
    symbol = "[",
    looks_like = "sheath",
    color = "dark_gray",
    pockets = {
        {
            magazine_well = "200 ml",
            holster = true,
            allowed_flags = { "SHEATH_KNIFE" },
            moves = 30,
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "30 cm",
        },
        {
            magazine_well = "200 ml",
            holster = true,
            allowed_flags = { "SHEATH_KNIFE" },
            moves = 30,
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "30 cm",
        },
    },
    flags = { "BELTED", "VARSIZE", "OVERSIZE", "WATER_FRIENDLY", "NONCONDUCTIVE" },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                coverage = 10,
                encumbrance = 6,
                volume_encumbrance = 0.3,
                subparts = { "leg_upper_r", "leg_upper_l" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Sheathe knife"),
            message = ccb.content.text("You sheathe your %s"),
        },
    },
}

ccb.content.define_item {
    id = "bootsheath",
    name = ccb.content.plural_text("ankle sheath", "ankle sheaths"),
    description = ccb.content.text("A small concealed knife sheath worn on the ankle.  Activate to sheathe/draw a weapon."),
    mass = "160 g",
    volume = "500 ml",
    price = "52 USD",
    survival_price = "2 USD 50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "sheath",
    color = "brown",
    pockets = {
        {
            magazine_well = "200 ml",
            holster = true,
            allowed_flags = { "SHEATH_KNIFE" },
            moves = 30,
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "30 cm",
        },
    },
    flags = { "BELTED", "OVERSIZE", "ALLOWS_NATURAL_ATTACKS", "WATER_FRIENDLY" },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                materials = { { id = "leather", coverage = 100, thickness = 1 } },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_ankle_r" },
                coverage = 25,
                encumbrance = { 2, 3 },
                layers = { "BELTED" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Sheathe knife"),
            message = ccb.content.text("You sheathe your %s"),
        },
    },
}

ccb.content.define_item {
    id = "bootsheath_birchbark",
    name = ccb.content.plural_text("birchbark ankle sheath", "birchbark ankle sheaths"),
    description = ccb.content.text("A handcrafted small concealed knife sheath worn on the ankle, made from birch bark.  Activate to sheathe/draw a weapon."),
    mass = "190 g",
    volume = "500 ml",
    price = "12 USD",
    survival_price = "1 USD 50 cent",
    materials = { "wood" },
    symbol = "[",
    looks_like = "bootsheath",
    color = "brown",
    pockets = {
        {
            magazine_well = "200 ml",
            holster = true,
            allowed_flags = { "SHEATH_KNIFE" },
            moves = 35,
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "30 cm",
        },
    },
    flags = { "BELTED", "OVERSIZE", "ALLOWS_NATURAL_ATTACKS", "WATER_FRIENDLY" },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                materials = { { id = "wood", coverage = 100, thickness = 1 } },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_ankle_r" },
                coverage = 25,
                encumbrance = { 2, 3 },
                layers = { "BELTED" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Sheathe knife"),
            message = ccb.content.text("You sheathe your %s"),
        },
    },
}

ccb.content.define_item {
    id = "bscabbard",
    name = ccb.content.plural_text("back scabbard", "back scabbards"),
    description = ccb.content.text("A leather scabbard, big enough for almost any sword.  Designed to be strapped to the back, it's very difficult to draw from without considerable practice.  Activate to sheath/draw a sword."),
    mass = "1890 g",
    volume = "2250 ml",
    price = "90 USD",
    survival_price = "7 USD 50 cent",
    materials = { "leather", "wood" },
    symbol = "[",
    looks_like = "baldric",
    color = "brown",
    pockets = {
        {
            magazine_well = "1750 ml",
            capacity = "3750 ml",
            mass_limit = "5 kg",
            max_item_length = "180 cm",
            holster = true,
            moves = 60,
            allowed_flags = { "SHEATH_SWORD" },
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = { 6, 10 },
                coverage = 20,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Sheathe sword"),
            message = ccb.content.text("You sheathe your %s"),
        },
    },
}

ccb.content.define_item {
    id = "scabbard",
    name = ccb.content.plural_text("scabbard", "scabbards"),
    description = ccb.content.text("A large, adjustable sheath for holding swords and other large blades.  Activate to sheathe/draw a weapon."),
    mass = "1360 g",
    volume = "1750 ml",
    price = "60 USD",
    survival_price = "5 USD",
    materials = { "leather", "wood" },
    symbol = "[",
    looks_like = "holster",
    color = "brown",
    pockets = {
        {
            magazine_well = "1250 ml",
            capacity = "2 L",
            mass_limit = "4 kg",
            max_item_length = "100 cm",
            holster = true,
            moves = 30,
            allowed_flags = { "SHEATH_SWORD" },
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = { 3, 4 },
                coverage = 15,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Sheath sword"),
            message = ccb.content.text("You sheath your %s"),
        },
    },
}

ccb.content.define_item {
    id = "nylon_scabbard",
    name = ccb.content.plural_text("nylon scabbard", "nylon scabbards"),
    description = ccb.content.text("A large, adjustable sheath for holding swords and other large blades, made with nylon.  Activate to sheathe/draw a weapon."),
    mass = "1360 g",
    volume = "1750 ml",
    price = "60 USD",
    survival_price = "5 USD",
    materials = { "nylon", "wood" },
    symbol = "[",
    looks_like = "holster",
    color = "brown",
    pockets = {
        {
            magazine_well = "1250 ml",
            capacity = "2 L",
            mass_limit = "4 kg",
            max_item_length = "100 cm",
            holster = true,
            moves = 30,
            allowed_flags = { "SHEATH_SWORD" },
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = { 3, 4 },
                coverage = 15,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Sheathe sword"),
            message = ccb.content.text("You sheathe your %s"),
        },
    },
}

ccb.content.define_item {
    id = "sheath",
    name = ccb.content.plural_text("sheath", "sheathes"),
    description = ccb.content.text("A leather sheath for holding knives and other small blades.  It is easy to use without much practice.  Activate to sheathe/draw a weapon."),
    mass = "200 g",
    volume = "500 ml",
    price = "35 USD",
    survival_price = "2 USD 50 cent",
    materials = { "leather" },
    symbol = "|",
    looks_like = "scabbard",
    color = "brown",
    pockets = {
        {
            magazine_well = "350 ml",
            holster = true,
            capacity = "750 ml",
            mass_limit = "2 kg",
            max_item_length = "70 cm",
            moves = 20,
            allowed_flags = { "SHEATH_KNIFE" },
        },
    },
    flags = { "BELTED", "BELT_CLIP", "OVERSIZE", "WATER_FRIENDLY", "PALS_SMALL" },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                coverage = 5,
                covers = { "leg_l", "leg_r" },
                encumbrance = { 0, 1 },
                subparts = { "leg_hip_r", "leg_hip_l" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Sheathe knife"),
            message = ccb.content.text("You sheathe your %s"),
        },
    },
}

ccb.content.define_item {
    id = "sheath_birchbark",
    name = ccb.content.plural_text("birchbark sheath", "birchbark sheaths"),
    description = ccb.content.text("A handcrafted sheath made from birch bark, for holding knives and other small blades, with a strap attached.  Activate to sheathe/draw a weapon."),
    mass = "250 g",
    volume = "500 ml",
    price = "15 USD",
    survival_price = "2 USD",
    materials = { "wood" },
    symbol = "|",
    looks_like = "sheath",
    color = "brown",
    pockets = {
        {
            magazine_well = "350 ml",
            holster = true,
            capacity = "750 ml",
            mass_limit = "2 kg",
            max_item_length = "70 cm",
            moves = 25,
            allowed_flags = { "SHEATH_KNIFE" },
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                coverage = 5,
                covers = { "leg_l", "leg_r" },
                encumbrance = { 0, 1 },
                subparts = { "leg_hip_r", "leg_hip_l" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Sheathe knife"),
            message = ccb.content.text("You sheathe your %s"),
        },
    },
}

ccb.content.define_item {
    id = "spearsling",
    name = ccb.content.plural_text("spear strap", "spear straps"),
    description = ccb.content.text("A leather strap tied around the torso for toting spears while keeping your hands free.  You have to duck to get through doors while one's in it, though.  Activate to holster/draw a weapon."),
    mass = "160 g",
    volume = "500 ml",
    price = "52 USD",
    survival_price = "2 USD 50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "bscabbard",
    color = "brown",
    pockets = {
        {
            holster = true,
            moves = 30,
            allowed_flags = { "SHEATH_SPEAR" },
            capacity = "4000 ml",
            mass_limit = "7 kg",
            max_item_length = "250 cm",
            volume_encumbrance = 0.5,
        },
    },
    flags = { "BELTED", "OVERSIZE", "ALLOWS_NATURAL_ATTACKS", "WATER_FRIENDLY" },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = 1,
                coverage = 10,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Holster spear"),
            message = ccb.content.text("You holster your %s."),
        },
    },
}

ccb.content.define_item {
    id = "spearsling_canvas",
    copy_from = "spearsling",
    name = ccb.content.text("canvas spear strap"),
    description = ccb.content.text("A canvas strap tied around the torso for toting spears while keeping your hands free.  You have to duck to get through doors while one's in it, though.  Activate to holster/draw a weapon."),
    materials = { "canvas" },
    price = "25 USD",
    survival_price = "1 USD 50 cent",
    symbol = "[",
    color = "blue",
    armor = {},
}
