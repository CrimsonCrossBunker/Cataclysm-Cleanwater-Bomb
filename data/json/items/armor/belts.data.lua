local ccb = require("ccb")

ccb.content.define_item {
    id = "fireman_belt",
    name = ccb.content.plural_text("firefighter belt", "firefighter belts"),
    description = ccb.content.text("A stout firefighter's belt.  Useful for keeping your bunker gear up, it also doubles as an equipment belt with a reinforced loop for holding a large tool."),
    mass = "210 g",
    volume = "500 ml",
    price = "90 USD",
    survival_price = "7 USD 50 cent",
    materials = { "leather", "steel" },
    symbol = "[",
    looks_like = "holster",
    repair_like = "leather",
    color = "yellow",
    pockets = {
        { capacity = "1 L", mass_limit = "1500 g", moves = 100 },
        {
            volume_encumbrance = 0.5,
            capacity = "2 L",
            mass_limit = "6 kg",
            max_item_length = "90 cm",
            moves = 50,
            allowed_flags = { "BELT_CLIP" },
            holster = true,
            transparent = true,
        },
        {
            holster = true,
            volume_encumbrance = 0.5,
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
            volume_encumbrance = 0.5,
            capacity = "2000 ml",
            mass_limit = "1750 g",
            max_item_length = "70 cm",
            moves = 60,
            description = ccb.content.text("Clipped directly to side of the belt."),
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        portions = {
            {
                encumbrance = { 2, 5 },
                coverage = 50,
                covers = { "torso" },
                subparts = { "torso_waist" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.5 },
                    { id = "steel", coverage = 10, thickness = 0.5 },
                },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Attach what to belt loop?"),
            message = ccb.content.text("You clip your %s to your %s"),
        },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "judo_belt_abstract",
    abstract = true,
    repair_like = "scarf",
    name = ccb.content.text_without_extraction("judo belt template"),
    description = ccb.content.text_without_extraction("This is a template for judo belts.  If found in a game, it is a bug."),
    mass = "125 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "25 cent",
    materials = { "cotton" },
    symbol = "[",
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        thickness = 2,
        portions = { { encumbrance = 2, coverage = 50, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

ccb.content.define_item {
    id = "judo_belt_black",
    copy_from = "judo_belt_abstract",
    name = ccb.content.text("black belt"),
    description = ccb.content.text("A belt worn by martial arts practitioners, advertising a master."),
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "judo_belt_blue",
    copy_from = "judo_belt_abstract",
    name = ccb.content.text("blue belt"),
    description = ccb.content.text("A belt worn by martial arts practitioners, advertising a strong intermediate."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "judo_belt_brown",
    copy_from = "judo_belt_abstract",
    name = ccb.content.text("brown belt"),
    description = ccb.content.text("A belt worn by martial arts practitioners, advertising a near-master."),
    color = "brown",
    armor = {},
}

ccb.content.define_item {
    id = "judo_belt_green",
    copy_from = "judo_belt_abstract",
    name = ccb.content.text("green belt"),
    description = ccb.content.text("A belt worn by martial arts practitioners, advertising an intermediate."),
    color = "green",
    armor = {},
}

ccb.content.define_item {
    id = "judo_belt_orange",
    copy_from = "judo_belt_abstract",
    name = ccb.content.text("orange belt"),
    description = ccb.content.text("A belt worn by martial arts practitioners, advertising a fresh intermediate."),
    color = "light_red",
    armor = {},
}

ccb.content.define_item {
    id = "judo_belt_white",
    copy_from = "judo_belt_abstract",
    name = ccb.content.text("white belt"),
    description = ccb.content.text("A belt worn by martial arts practitioners, advertising a novice."),
    color = "white",
    armor = {},
}

ccb.content.define_item {
    id = "judo_belt_yellow",
    copy_from = "judo_belt_abstract",
    name = ccb.content.text("yellow belt"),
    description = ccb.content.text("A belt worn by martial arts practitioners, advertising a moderate novice."),
    color = "yellow",
    armor = {},
}

ccb.content.define_item {
    id = "leather_belt",
    name = ccb.content.plural_text("leather belt", "leather belts"),
    description = ccb.content.text("A leather belt.  Designed to look good and hold up a pair of pants, but you should be able to attach a small tool or weapon to one of the belt loops."),
    mass = "150 g",
    volume = "350 ml",
    price = "20 USD",
    survival_price = "1 USD",
    repair_like = "leather",
    materials = { { id = "leather", portions = 75 }, { id = "steel", portions = 25 } },
    symbol = "[",
    color = "brown",
    pockets = {
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
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        thickness = 2,
        portions = {
            {
                covers = { "torso" },
                coverage = 50,
                subparts = { "torso_waist" },
                volume_encumbrance = 0.5,
                materials = {
                    { id = "leather", coverage = 100, thickness = 2 },
                    { id = "steel", coverage = 10, thickness = 0.5 },
                },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stick what into your belt"),
            message = ccb.content.text("You tuck your %s into your %s"),
        },
    },
}

ccb.content.define_item {
    id = "obi_gi",
    name = ccb.content.text("obi"),
    description = ccb.content.text("A broad, black obi gi."),
    mass = "125 g",
    volume = "250 ml",
    price = "20 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "dark_gray",
    armor = {},
}

ccb.content.define_item {
    id = "police_belt",
    name = ccb.content.plural_text("police duty belt", "police duty belts"),
    description = ccb.content.text("A black leather belt used by police officers.  It has several pouches and a holder for a baton."),
    mass = "250 g",
    volume = "2 L",
    price = "100 USD",
    survival_price = "7 USD 50 cent",
    materials = { "leather", "steel" },
    symbol = "[",
    looks_like = "fireman_belt",
    repair_like = "leather",
    color = "brown",
    pockets = {
        {
            description = ccb.content.text("flashlight storage"),
            capacity = "500 ml",
            max_item_length = "40 cm",
            mass_limit = "1500 g",
            moves = 100,
        },
        {
            description = ccb.content.text("radio storage"),
            capacity = "500 ml",
            mass_limit = "1500 g",
            moves = 100,
        },
        { capacity = "500 ml", mass_limit = "1500 g", moves = 100 },
        { capacity = "500 ml", mass_limit = "1500 g", moves = 100 },
        {
            holster = true,
            volume_encumbrance = 0.5,
            capacity = "2250 ml",
            mass_limit = "3600 g",
            max_item_length = "70 cm",
            moves = 50,
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
        {
            holster = true,
            volume_encumbrance = 0.5,
            capacity = "2000 ml",
            mass_limit = "1750 g",
            max_item_length = "70 cm",
            moves = 60,
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
        {
            holster = true,
            volume_encumbrance = 0.5,
            capacity = "2000 ml",
            mass_limit = "1750 g",
            max_item_length = "70 cm",
            moves = 60,
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        portions = {
            {
                coverage = 50,
                covers = { "torso" },
                subparts = { "torso_waist" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.0 },
                    { id = "steel", coverage = 10, thickness = 0.5 },
                },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Attach what to holder?"),
            message = ccb.content.text("You attach your %s to your %s."),
        },
    },
}

ccb.content.define_item {
    id = "santa_belt",
    name = ccb.content.plural_text("broad belt", "broad belts"),
    description = ccb.content.text("A broad, buckled leather belt, commonly used by bearded men on Christmas.  Usually worn over a red jacket."),
    mass = "150 g",
    volume = "350 ml",
    price = "90 USD",
    survival_price = "2 USD 50 cent",
    materials = { "leather", "steel" },
    symbol = "[",
    looks_like = "leather_belt",
    repair_like = "leather",
    color = "dark_gray",
    pockets = {
        {
            holster = true,
            capacity = "1200 ml",
            mass_limit = "800 g",
            max_item_length = "90 cm",
            moves = 60,
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        thickness = 1.5,
        portions = { { coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stick what into your belt"),
            message = ccb.content.text("You tuck your %s into your %s"),
        },
    },
}

ccb.content.define_item {
    id = "tool_belt",
    name = ccb.content.plural_text("tool belt", "tool belts"),
    description = ccb.content.text("A common belt with pockets, loops and sheaths to store up to seven tools or blades.  Widely used by handymen and electricians."),
    mass = "1000 g",
    volume = "2500 ml",
    price = "45 USD",
    survival_price = "15 USD",
    materials = { "leather" },
    symbol = "[",
    looks_like = "holster",
    color = "brown",
    pockets = {
        {
            capacity = "1500 ml",
            mass_limit = "5000 g",
            max_item_length = "20 cm",
            moves = 100,
            description = ccb.content.text("Pouch to store multiple items."),
        },
        {
            capacity = "1500 ml",
            mass_limit = "5000 g",
            max_item_length = "20 cm",
            moves = 100,
            description = ccb.content.text("Pouch to store multiple items."),
        },
        {
            holster = true,
            volume_encumbrance = 0.5,
            min_item_volume = "50 ml",
            capacity = "2000 ml",
            mass_limit = "2500 g",
            max_item_length = "70 cm",
            moves = 60,
            description = ccb.content.text("Clipped directly to the belt."),
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
        {
            holster = true,
            volume_encumbrance = 0.5,
            min_item_volume = "50 ml",
            capacity = "2000 ml",
            mass_limit = "2500 g",
            max_item_length = "70 cm",
            moves = 60,
            description = ccb.content.text("Clipped directly to the belt."),
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
        {
            holster = true,
            volume_encumbrance = 0.25,
            min_item_volume = "50 ml",
            capacity = "2000 ml",
            mass_limit = "2500 g",
            max_item_length = "70 cm",
            moves = 50,
            description = ccb.content.text("In a sheath."),
            allowed_flags = { "BELT_CLIP", "SHEATH_KNIFE" },
            transparent = true,
        },
        {
            holster = true,
            volume_encumbrance = 0.25,
            min_item_volume = "50 ml",
            capacity = "1500 ml",
            mass_limit = "2500 g",
            max_item_length = "70 cm",
            moves = 50,
            description = ccb.content.text("In a sheath."),
            allowed_flags = { "BELT_CLIP", "SHEATH_KNIFE" },
            transparent = true,
        },
        {
            holster = true,
            volume_encumbrance = 0.25,
            min_item_volume = "50 ml",
            capacity = "1500 ml",
            mass_limit = "2500 g",
            max_item_length = "70 cm",
            moves = 50,
            description = ccb.content.text("In a sheath."),
            allowed_flags = { "BELT_CLIP", "SHEATH_KNIFE" },
            transparent = true,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        thickness = 2,
        portions = {
            {
                encumbrance = { 2, 12 },
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

-- volume encumber modifier set high since the whole belt is being scaled by 0.35. This equals .5005
-- volume encumber modifier set high since the whole belt is being scaled by 0.35. This equals .5005
-- volume encumber modifier set high since the whole belt is being scaled by 0.35. This equals .5005
-- volume encumber modifier set high since the whole belt is being scaled by 0.35. This equals .5005
ccb.content.define_item {
    id = "webbing_belt",
    name = ccb.content.plural_text("MOLLE webbing belt", "MOLLE webbing belts"),
    description = ccb.content.text("A 2-inch nylon webbing belt commonly used by military forces.  MOLLE-compatible pouches can be attached to the webbing for extra storage."),
    mass = "210 g",
    volume = "500 ml",
    price = "10 USD",
    survival_price = "3 USD",
    materials = { "nylon", "steel" },
    symbol = "[",
    looks_like = "leather_belt",
    repair_like = "nylon",
    color = "yellow",
    pockets = {
        {
            holster = true,
            volume_encumbrance = 1.43,
            capacity = "2000 ml",
            mass_limit = "2500 g",
            max_item_length = "70 cm",
            moves = 60,
            description = ccb.content.text("Clipped directly to belt."),
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
        {
            holster = true,
            volume_encumbrance = 1.43,
            capacity = "2000 ml",
            mass_limit = "2500 g",
            max_item_length = "70 cm",
            moves = 60,
            description = ccb.content.text("Clipped directly to belt."),
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
        {
            holster = true,
            volume_encumbrance = 1.43,
            capacity = "2000 ml",
            mass_limit = "2500 g",
            max_item_length = "70 cm",
            moves = 110,
            description = ccb.content.text("Clipped directly to the back of the belt."),
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
        {
            holster = true,
            volume_encumbrance = 1.43,
            capacity = "2000 ml",
            mass_limit = "2500 g",
            max_item_length = "70 cm",
            moves = 110,
            description = ccb.content.text("Clipped directly to the back of the belt."),
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "NONCONDUCTIVE" },
    armor = {
        thickness = 1.5,
        portions = {
            {
                encumbrance = 1,
                coverage = 50,
                covers = { "torso" },
                subparts = { "torso_waist" },
                volume_encumbrance = 0.35,
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Store tool or blade"),
            message = ccb.content.text("You put your %1$s in your %2$s"),
        },
        { kind = "attach_molle", size = 4 },
        { kind = "detach_molle" },
    },
}

ccb.content.define_item {
    id = "suspenders_cloth",
    name = ccb.content.plural_text("suspenders", "suspenders"),
    description = ccb.content.text("A pair of black suspenders, which reach over the wearer's shoulders and hook to their waist.  Gives a wonderful western feel!"),
    mass = "250 g",
    volume = "500 ml",
    price = "10 USD",
    survival_price = "25 cent",
    materials = { "cotton", "steel" },
    repair_like = "scarf",
    symbol = "#",
    looks_like = "leather_belt",
    color = "dark_gray",
    flags = { "BELTED", "WATER_FRIENDLY" },
    armor = {
        thickness = 1.5,
        portions = { { coverage = 50, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

ccb.content.define_item {
    id = "suspenders_leather",
    name = ccb.content.plural_text("leather suspenders", "leather suspenders"),
    description = ccb.content.text("A pair of leather suspenders, which reach over the wearer's shoulders and hook to their waist.  Gives a wonderful western feel!"),
    materials = { "leather", "steel" },
    color = "brown",
    copy_from = "suspenders_cloth",
    armor = {},
}

ccb.content.define_item {
    id = "suspenders_holster",
    name = ccb.content.plural_text("holster suspenders", "holster suspenders"),
    description = ccb.content.text("A pair of leather suspenders with a holster placed near the stomach."),
    copy_from = "suspenders_leather",
    flags = { "BELTED", "WATER_FRIENDLY" },
    pockets = {
        {
            magazine_well = "350 ml",
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "250 ml",
            capacity = "1000 ml",
            mass_limit = "2 kg",
            max_item_length = "30 cm",
            moves = 50,
        },
    },
    armor = {
        portions = {
            {
                encumbrance = { 3, 4 },
                coverage = 75,
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
