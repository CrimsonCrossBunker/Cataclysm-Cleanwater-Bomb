local ccb = require("ccb")

ccb.content.define_item {
    id = "migo_plate_base",
    abstract = true,
    name = ccb.content.text("generic migo plate"),
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "alien_carapace", "flesh" },
    symbol = ",",
    color = "dark_gray",
    armor = { damage_verb = ccb.content.text("crumbles as blood oozes from its insides") },
}

ccb.content.define_item {
    id = "migo_plate_overgrown",
    category = "armor",
    copy_from = "migo_plate_base",
    name = ccb.content.text("overgrown iridescent carapace plate"),
    description = ccb.content.text("A chunk of otherworldly carapace that looks like it was at one point shaped like armor, but is now bulky and overgrown with sharp pieces jutting out haphazardly.  Scarred into the outer surface you can barely make out the label \"STRIKE FACE\".  It looks like you could force it into a ballistic vest."),
    mass = "2800 g",
    volume = "1533 ml",
    flags = { "ABLATIVE_LARGE", "CANT_WEAR", "TRADER_AVOID" },
    armor = {
        thickness = 10,
        broken_item = "migo_plate",
        portions = {
            {
                encumbrance = 6,
                coverage = 45,
                covers = { "torso" },
                subparts = { "torso_upper" },
                materials = {
                    { id = "alien_carapace", coverage = 100, thickness = 5.0 },
                    { id = "flesh", coverage = 95, thickness = 4.0 },
                },
            },
        },
    },
}

-- transforms over a day
ccb.content.define_item {
    id = "migo_plate",
    category = "armor",
    copy_from = "migo_plate_base",
    name = ccb.content.plural_text("iridescent carapace plate", "iridescent carapace plates"),
    description = ccb.content.text("A chunk of otherworldly carapace that seems to have been forced into the shape of a ballistic plate with a slightly concave profile.  Scarred into the outer surface is the label \"STRIKE FACE\".  It looks like you could force it into a ballistic vest."),
    mass = "2000 g",
    volume = "1533 ml",
    revert_to = "migo_plate_overgrown",
    flags = { "ABLATIVE_LARGE", "CANT_WEAR", "TRADER_AVOID", "SPAWN_ACTIVE" },
    armor = {
        thickness = 8,
        broken_item = "migo_plate_undergrown",
        portions = {
            {
                encumbrance = 2,
                coverage = 42,
                covers = { "torso" },
                subparts = { "torso_upper" },
                materials = {
                    { id = "alien_carapace", coverage = 100, thickness = 4.0 },
                    { id = "flesh", coverage = 95, thickness = 4.0 },
                },
            },
        },
    },
    countdown_action = {
        kind = "message",
        message = ccb.content.text_without_extraction("The iridescent carapace plate expands as it grows."),
    },
    countdown_interval = "24 hours",
}

-- transforms over a day
ccb.content.define_item {
    id = "migo_plate_undergrown",
    category = "armor",
    copy_from = "migo_plate_base",
    name = ccb.content.plural_text("undergrown iridescent carapace plate", "undergrown iridescent carapace plates"),
    description = ccb.content.text("A chunk of otherworldly carapace that seems to have been forced into the shape of a ballistic plate with a slightly concave profile.  Scarred into the outer surface is the label \"STRIKE FACE\".  The armor coverage is spotty and it appears to be oozing and pulsing like it is in pain."),
    mass = "1500 g",
    volume = "1533 ml",
    revert_to = "migo_plate",
    flags = { "ABLATIVE_LARGE", "CANT_WEAR", "TRADER_AVOID", "SPAWN_ACTIVE" },
    armor = {
        thickness = 6,
        broken_item = "migo_plate_naked",
        portions = {
            {
                encumbrance = 2,
                coverage = 39,
                covers = { "torso" },
                subparts = { "torso_upper" },
                materials = {
                    { id = "alien_carapace", coverage = 100, thickness = 2.0 },
                    { id = "flesh", coverage = 95, thickness = 4.0 },
                },
            },
        },
    },
    countdown_action = {
        kind = "message",
        message = ccb.content.text_without_extraction("The iridescent carapace plate expands as it grows."),
    },
    countdown_interval = "24 hours",
}

ccb.content.define_item {
    id = "migo_sideplate_overgrown",
    copy_from = "migo_plate_overgrown",
    name = ccb.content.text("overgrown iridescent carapace side plate"),
    armor = {
        broken_item = "migo_sideplate",
        portions = {
            {
                encumbrance = 2,
                coverage = 35,
                covers = { "torso" },
                subparts = { "torso_lower" },
                materials = {
                    { id = "alien_carapace", coverage = 100, thickness = 5.0 },
                    { id = "flesh", coverage = 95, thickness = 4.0 },
                },
            },
        },
    },
    inheritance = {
        add = { flags = { "ABLATIVE_MEDIUM" } },
        remove = { flags = { "ABLATIVE_LARGE" } },
        scale = { volume = 0.5, mass = 0.5 },
    },
}

ccb.content.define_item {
    id = "migo_sideplate",
    copy_from = "migo_plate",
    name = ccb.content.text("iridescent carapace side plate"),
    revert_to = "migo_sideplate_overgrown",
    armor = {
        broken_item = "migo_sideplate_undergrown",
        portions = {
            {
                encumbrance = 1,
                coverage = 32,
                covers = { "torso" },
                subparts = { "torso_lower" },
                materials = {
                    { id = "alien_carapace", coverage = 100, thickness = 4.0 },
                    { id = "flesh", coverage = 95, thickness = 4.0 },
                },
            },
        },
    },
    inheritance = {
        add = { flags = { "ABLATIVE_MEDIUM" } },
        remove = { flags = { "ABLATIVE_LARGE" } },
        scale = { volume = 0.5, mass = 0.5 },
    },
}

ccb.content.define_item {
    id = "migo_sideplate_undergrown",
    copy_from = "migo_plate_undergrown",
    name = ccb.content.text("undergrown iridescent carapace side plate"),
    revert_to = "migo_sideplate",
    armor = {
        broken_item = "migo_sideplate_naked",
        portions = {
            {
                encumbrance = 1,
                coverage = 29,
                covers = { "torso" },
                subparts = { "torso_lower" },
                materials = {
                    { id = "alien_carapace", coverage = 100, thickness = 2.0 },
                    { id = "flesh", coverage = 95, thickness = 4.0 },
                },
            },
        },
    },
    inheritance = {
        add = { flags = { "ABLATIVE_MEDIUM" } },
        remove = { flags = { "ABLATIVE_LARGE" } },
        scale = { volume = 0.5, mass = 0.5 },
    },
}

ccb.content.define_item {
    id = "migo_sideplate_naked",
    copy_from = "migo_plate_naked",
    name = ccb.content.plural_text("small plate of scarred flesh", "small plates of scarred flesh"),
    revert_to = "migo_sideplate_undergrown",
    armor = {
        portions = {
            {
                encumbrance = 1,
                coverage = 0,
                covers = { "torso" },
                subparts = { "torso_lower" },
                materials = { { id = "flesh", coverage = 100, thickness = 4.0 } },
            },
        },
    },
    inheritance = {
        add = { flags = { "ABLATIVE_MEDIUM" } },
        remove = { flags = { "ABLATIVE_LARGE" } },
        scale = { volume = 0.5, mass = 0.5 },
    },
}

ccb.content.define_item {
    id = "migo_plate_naked",
    copy_from = "migo_plate_base",
    name = ccb.content.plural_text("plate of scarred flesh", "plates of scarred flesh"),
    description = "A chunk of otherworldly flesh that seems to have been forced into the shape of a ballistic plate with a slightly concave profile.  There is no armor left on this plate, just a mass of writhing alien flesh oozing in pain.  However, it looks like it is slowly growing back.",
    symbol = ",",
    color = "dark_gray",
    category = "armor",
    mass = "1000 g",
    volume = "1533 ml",
    price = "0 cent",
    survival_price = "0 cent",
    revert_to = "migo_plate_undergrown",
    flags = { "ABLATIVE_LARGE", "CANT_WEAR", "TRADER_AVOID", "SPAWN_ACTIVE" },
    materials = { "flesh" },
    countdown_interval = "24 hours",
    countdown_action = {
        kind = "message",
        message = "The plate of scarred flesh expands as it grows.",
    },
    armor = {
        thickness = 4,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 0,
                encumbrance = 2,
                materials = {
                    { id = "flesh", thickness = 4.0, coverage = 100 },
                },
            },
        },
    },
    inheritance = {
        remove = {
            materials = { "alien_carapace" },
        },
    },
}

ccb.content.define_item {
    id = "migo_skin",
    name = ccb.content.plural_text("second skin", "second skins"),
    description = ccb.content.text("A slimy layer of liquid has completely engulfed your body from the neck down and seems to move with you - the sensation is uncomfortable.  The liquid appears bound to the resonating collar at your neck; the inside of the collar reads \"CAREFUL CHOKING HAZARD!  THIS WAY DOWN\".  The ooze flows freely, covering your entire body but never crossing the gorget to get to your head."),
    mass = "1500 g",
    volume = "1 L",
    price = "25 USD",
    survival_price = "4 USD",
    materials = { "alien_liquid", "unobtanium" },
    symbol = "[",
    looks_like = "union_suit",
    color = "white",
    flags = { "SKINTIGHT", "STURDY", "TRADER_AVOID", "FILTHY", "NO_CLEAN", "SOFT", "OVERSIZE" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "unobtanium", coverage = 10, thickness = 0.5 },
                    { id = "alien_liquid", coverage = 100, thickness = 1 },
                },
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 100,
                encumbrance = 0,
            },
            {
                materials = {
                    { id = "unobtanium", coverage = 85, thickness = 0.5 },
                    { id = "alien_liquid", coverage = 100, thickness = 1 },
                },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 100,
                encumbrance = 0,
            },
            {
                materials = { { id = "alien_liquid", coverage = 100, thickness = 1 } },
                covers = { "torso", "arm_l", "arm_r" },
                subparts = {
                    "torso_lower",
                    "arm_upper_l",
                    "arm_elbow_l",
                    "arm_lower_l",
                    "arm_upper_r",
                    "arm_elbow_r",
                    "arm_lower_r",
                },
                coverage = 100,
                encumbrance = 2,
            },
            {
                materials = { { id = "alien_liquid", coverage = 100, thickness = 1 } },
                covers = { "leg_l", "leg_r", "foot_l", "foot_r", "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 2,
            },
        },
        warmth = 1,
        thickness = 1,
        environmental_protection = 5,
    },
    use_actions = {
        {
            kind = "transform",
            target = "migo_skin_off",
            message = ccb.content.text("The gorget hums and the liquid gets sucked back into it."),
            menu_text = ccb.content.text("Deactivate"),
        },
    },
}

ccb.content.define_item {
    id = "migo_skin_off",
    name = ccb.content.plural_text("resonating gorget", "resonating gorgets"),
    description = ccb.content.text("A heavy-duty gorget or collar made from odd materials that hums slightly.  It feels damp to the touch and there is a mechanical button of some kind on the front.  The inside reads \"CAREFUL CHOKING HAZARD!  THIS WAY DOWN\"."),
    mass = "1500 g",
    volume = "100 ml",
    price = "25 USD",
    survival_price = "4 USD",
    materials = { "unobtanium" },
    symbol = "[",
    looks_like = "silver_necklace",
    color = "white",
    flags = { "SKINTIGHT", "STURDY", "TRADER_AVOID", "SOFT" },
    armor = {
        portions = {
            {
                materials = { { id = "unobtanium", coverage = 100, thickness = 0.5 } },
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 10,
                encumbrance = 0,
            },
            {
                materials = { { id = "unobtanium", coverage = 100, thickness = 0.5 } },
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 85,
                encumbrance = 0,
            },
        },
        warmth = 1,
        thickness = 1,
        environmental_protection = 1,
    },
    use_actions = {
        {
            kind = "transform",
            need_worn = true,
            target = "migo_skin",
            message = ccb.content.text("Murky ooze begins to leak out of the gorget and engulf your body from the neck down!"),
            menu_text = ccb.content.text("Activate"),
        },
    },
}

ccb.content.define_item {
    id = "feeding_kit",
    name = ccb.content.plural_text("feeding kit", "feeding kits"),
    description = ccb.content.text("This is a collection of syringes with nozzles, an aerosol sprayer, and a few other attachments.  It seems designed for looking after some kind of creature that wants to stay wet."),
    mass = "85 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "plastic", "steel" },
    symbol = ",",
    color = "red",
    pockets = { { kind = "MAGAZINE", ammunition = { water = 5 }, watertight = true } },
    flags = { "ALLOWS_REMOTE_USE" },
    tool = { charges_per_use = 1 },
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_metal",
            materials = { "alien_liquid" },
            skill = "survival",
            tool_quality = 0,
            cost_scaling = 0.1,
            move_cost = 100,
        },
    },
}

ccb.content.define_item {
    id = "armor_star_samurai",
    category = "armor",
    name = ccb.content.plural_text("ryūsei battle kit", "ryūsei battle kits"),
    description = ccb.content.text("A strange belt wrapped with circuitry and hundreds of banded metal discs.  When you touch it, it seems to vibrate slightly."),
    mass = "40 g",
    volume = "200 ml",
    price = "0 cent",
    survival_price = "80 USD",
    materials = { "unobtanium", "superalloy" },
    symbol = "[",
    looks_like = "armor_lightplate",
    color = "dark_gray",
    length = "40 cm",
    flags = { "STURDY", "BELTED", "MUNDANE" },
    pockets = {
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            weight_multiplier = 0.0,
            capacity = "6000 ml",
            mass_limit = "20000 kg",
            max_item_length = "100 cm",
            moves = 800,
            description = ccb.content.text("Synchronization point for ryūsei dō plate."),
            allowed_flags = { "STAR_PLATE" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            weight_multiplier = 0.0,
            capacity = "5000 ml",
            mass_limit = "20000 kg",
            max_item_length = "100 cm",
            moves = 800,
            description = ccb.content.text("Synchronization point for ryūsei kote plate."),
            allowed_flags = { "STAR_SHOULDER" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            weight_multiplier = 0.0,
            capacity = "5000 ml",
            mass_limit = "20000 kg",
            max_item_length = "100 cm",
            moves = 800,
            description = ccb.content.text("Synchronization point for ryūsei kote plate."),
            allowed_flags = { "STAR_SHOULDER" },
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            weight_multiplier = 0.0,
            capacity = "6000 ml",
            mass_limit = "20000 kg",
            max_item_length = "100 cm",
            moves = 800,
            description = ccb.content.text("Synchronization point for ryūsei hai-date plate."),
            allowed_flags = { "STAR_SKIRT" },
        },
        {
            description = ccb.content.text("Floating clip (seems like anything would fit)."),
            capacity = "4 L",
            mass_limit = "10 kg",
            max_item_length = "150 cm",
            min_item_length = "30 cm",
            moves = 80,
            holster = true,
            volume_encumbrance = 0.5,
            weight_multiplier = 0.0,
        },
        {
            description = ccb.content.text("Large Quiver."),
            weight_multiplier = 0.0,
            ammunition = { strange_arrow = 5 },
            moves = 40,
            volume_encumbrance = 0.2,
        },
        {
            kind = "CONTAINER",
            capacity = "1500 ml",
            mass_limit = "8 kg",
            max_item_length = "305 mm",
            moves = 80,
            volume_encumbrance = 0.3,
            weight_multiplier = 0.0,
        },
    },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 0,
        thickness = 3,
        portions = { { encumbrance = 2, coverage = 100, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
    artifact = { enchantments = { "ench_meteor_armor" } },
}

ccb.content.define_item {
    id = "armor_star_samurai_mask",
    name = ccb.content.plural_text("filtering menpo", "filtering menpo"),
    category = "armor",
    description = ccb.content.text("A sealed mask with strange filtering components on the front turned up in the shape of horns.  Inscriptions mark the glass of the lenses creating spiral patterns that blur the vision."),
    flags = { "SLEEP_IGNORE", "MUNDANE" },
    mass = "897 g",
    volume = "1 L",
    price = "49 USD",
    survival_price = "7 USD 50 cent",
    materials = { "monolith" },
    symbol = "[",
    color = "dark_gray",
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {
        portions = {
            { covers = { "eyes" }, rigid_only = true, coverage = 100, encumbrance = 10 },
            { covers = { "mouth" }, rigid_only = true, coverage = 100, encumbrance = 30 },
        },
        warmth = 20,
        thickness = 2,
        environmental_protection = 16,
    },
    artifact = { enchantments = { "ench_meteor_mask" } },
}

-- torso armor for the space samurai
ccb.content.define_item {
    id = "armor_star_samurai_torso",
    category = "armor",
    name = ccb.content.plural_text("ryūsei dō", "ryūsei dō"),
    description = ccb.content.text("An impossibly large slab of dark reflective material wrapped in bands of multicolored alloy.  It seems shaped to fit over a humanoid torso."),
    mass = "300 kg",
    volume = "6000 ml",
    price = "0 cent",
    survival_price = "80 USD",
    materials = { { id = "monolith_heavy", portions = 19 }, { id = "superalloy", portions = 1 } },
    symbol = "[",
    looks_like = "armor_lightplate",
    color = "dark_gray",
    length = "60 cm",
    flags = { "STURDY", "OUTER", "STAR_PLATE" },
    armor = {
        warmth = 0,
        thickness = 25,
        portions = {
            { encumbrance = 15, coverage = 85, covers = { "torso" } },
            {
                encumbrance = 0,
                coverage = 100,
                covers = { "head" },
                subparts = { "head_nape", "head_throat" },
            },
        },
    },
}

-- shoulder armor for the space samurai
ccb.content.define_item {
    id = "armor_star_samurai_shoulder",
    category = "armor",
    name = ccb.content.plural_text("ryūsei kote", "ryūsei kote"),
    description = ccb.content.text("An impossibly large slab of dark reflective material wrapped in bands of multicolored alloy.  It seems shaped as though it would tie to the upper arms."),
    mass = "100 kg",
    volume = "4000 ml",
    price = "0 cent",
    survival_price = "80 USD",
    materials = { { id = "monolith_heavy", portions = 19 }, { id = "superalloy", portions = 1 } },
    symbol = "[",
    looks_like = "armor_lightplate",
    color = "dark_gray",
    length = "60 cm",
    flags = { "STURDY", "OUTER", "STAR_SHOULDER" },
    armor = {
        warmth = 0,
        thickness = 25,
        portions = {
            {
                encumbrance = 8,
                coverage = 95,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_upper_l", "arm_shoulder_r", "arm_upper_r" },
            },
        },
    },
}

-- leg armor for the space samurai
ccb.content.define_item {
    id = "armor_star_samurai_legs",
    category = "armor",
    name = ccb.content.plural_text("ryūsei hai-date", "ryūsei hai-date"),
    description = ccb.content.text("An impossibly large slab of dark reflective material wrapped in bands of multicolored alloy.  It has been forced into a conical shape as though it could somehow be worn as a skirt."),
    mass = "275 kg",
    volume = "5500 ml",
    price = "0 cent",
    survival_price = "80 USD",
    materials = { { id = "monolith_heavy", portions = 19 }, { id = "superalloy", portions = 1 } },
    symbol = "[",
    looks_like = "armor_lightplate",
    color = "dark_gray",
    length = "60 cm",
    flags = { "STURDY", "OUTER", "STAR_SKIRT" },
    armor = {
        warmth = 0,
        thickness = 25,
        portions = {
            {
                encumbrance = 15,
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_upper_l", "leg_hip_r", "leg_upper_r" },
            },
        },
    },
}
