local ccb = require("ccb")

ccb.content.define_item {
    id = "xedra_jumpsuit",
    copy_from = "jumpsuit",
    looks_like = "jumpsuit",
    name = ccb.content.text("OA jumpsuit"),
    description = ccb.content.text("A brown jumpsuit with OA written in big yellow block letters on the back."),
    color = "brown",
    variants = {
        {
            id = "xedra_jumpsuit_offworld",
            name = ccb.content.text("OA jumpsuit"),
            description = ccb.content.text("A brown jumpsuit with OA written in big yellow block letters on the back."),
            weight = 1,
        },
        {
            id = "xedra_jumpsuit_eater",
            name = ccb.content.text("υ jumpsuit"),
            description = ccb.content.text("A black jumpsuit with white symbol \"υ\" on the back."),
            weight = 1,
        },
        {
            id = "xedra_jumpsuit_dreamer",
            name = ccb.content.text("ϴ jumpsuit"),
            description = ccb.content.text("A black jumpsuit with white symbol \"ϴ\" on the back."),
            weight = 1,
        },
        {
            id = "xedra_jumpsuit_inventor",
            name = ccb.content.text("ν jumpsuit"),
            description = ccb.content.text("A black jumpsuit with white symbol \"ν\" on the back."),
            weight = 1,
        },
        {
            id = "xedra_jumpsuit_dreamsmith",
            name = ccb.content.text("τ jumpsuit"),
            description = ccb.content.text("A black jumpsuit with white symbol \"τ\" on the back."),
            weight = 1,
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "alt_tshirt",
    name = ccb.content.text("slightly off t-shirt"),
    description = ccb.content.text("A short-sleeved cotton tee featuring a uniquely odd design that sets it apart from any you've seen before."),
    copy_from = "tshirt",
    variant_kind = "generic",
    variants = {
        {
            id = "alt_broadway_tshirt2",
            name = ccb.content.plural_text("Seven Faceless Voids for Seven Brothers t-shirt", "Seven Faceless Voids for Seven Brothers t-shirts"),
            description = ccb.content.text("A pink t-shirt with seven ominous figures in bridal wear facing towards seven identical men.  There are tears running down from the eyes of the men."),
            weight = 1,
        },
        {
            id = "alt_broadway_tshirt",
            name = ccb.content.text("Sawzall the Musical t-shirt"),
            description = ccb.content.text("A shirt that says Sawzall the Musical in bold letters, over a giant Sawzall tool."),
            symbol = "M",
            color = "light_gray",
            weight = 1,
        },
        {
            id = "go_star_tshirt",
            name = ccb.content.text("go t-shirt"),
            description = ccb.content.text("This t-shirt displays a picture of a man standing behind a go table, the text is using an unfamiliar alphabet.  His features seem subtly off."),
            symbol = "o",
            color = "dark_gray",
            weight = 1,
        },
        {
            id = "tachli_fan_tshirt",
            name = ccb.content.text("Tachli t-shirt"),
            description = ccb.content.text("A short-sleeved cotton shirt with the logo of a Tachli team printed on its front and back.  It looks like it might be a violent sport."),
            weight = 1,
        },
        {
            id = "rollerball_fan_tshirt",
            name = ccb.content.text("rollerball t-shirt"),
            description = ccb.content.text("A short-sleeved cotton shirt with the logo of a rollerball team, whatever that is, printed on its front and back."),
            weight = 1,
        },
        {
            id = "sunnyvale_tshirt",
            name = ccb.content.text("sunnyvale t-shirt"),
            description = ccb.content.text("This t-shirt displays a purple sun rising over a town that looks like it came out of a Doctor Seuss book."),
            symbol = "o",
            color = "dark_gray",
            weight = 1,
        },
        {
            id = "syndicalist_states_tshirt",
            name = ccb.content.text("CSA t-shirt"),
            description = ccb.content.text("A short-sleeved cotton shirt with a globe at the bottom with a C above the globe with an S to the left and A to the right.  The background is like a flag with the top left being the corner of a black triangle and the bottom right is a red triangle.  They meet in the middle with the globe."),
            weight = 1,
        },
    },
    armor = {},
}

ccb.content.define_item {
    id = "tunic_gossamer",
    copy_from = "tunic",
    name = ccb.content.text("gossamer tunic"),
    description = ccb.content.text("A simple garment made of gossamer.  It's very light, and the fabric shimmers in a rainbow of colors in the sunlight."),
    volume = "1250 ml",
    color = "white",
    materials = { "fae_cotton" },
    armor = {
        portions = {
            { covers = { "torso" }, subparts = { "torso_lower" }, coverage = 100, encumbrance = 2 },
            { covers = { "torso" }, subparts = { "torso_upper" }, coverage = 95 },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = 2 },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                encumbrance = 2,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 80,
            },
        },
    },
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

ccb.content.define_item {
    id = "sleeveless_tunic_gossamer",
    copy_from = "tunic",
    name = ccb.content.text("sleeveless gossamer tunic"),
    description = ccb.content.text("A simple, sleeveless garment made of gossamer.  It's very light, and the fabric shimmers in a rainbow of colors in the sunlight."),
    volume = "1250 ml",
    color = "white",
    materials = { "fae_cotton" },
    armor = {
        portions = {
            { covers = { "torso" }, subparts = { "torso_lower" }, coverage = 100, encumbrance = 2 },
            { covers = { "torso" }, subparts = { "torso_upper" }, coverage = 95 },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
                coverage = 40,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                encumbrance = 2,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 80,
            },
        },
    },
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

ccb.content.define_item {
    id = "doublet_gossamer",
    copy_from = "sweatshirt",
    name = ccb.content.text("gossamer doublet"),
    description = ccb.content.text("A thick overshirt of gossamer, shimmering in a rainbow of colors.  This would have made you the king of the Renn Faire."),
    color = "white",
    materials = { "fae_cotton" },
    armor = {
        valid_mods = {},
        portions = { { encumbrance = 4, coverage = 95, covers = { "torso", "arm_l", "arm_r" } } },
    },
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

ccb.content.define_item {
    id = "dress_gossamer",
    copy_from = "dress",
    name = ccb.content.plural_text("gossamer dress", "gossamer dresses"),
    description = ccb.content.text("A gossamer dress, shimmering in a mix of rainbow colors."),
    color = "white",
    materials = { "fae_cotton" },
    variants = {},
    armor = { portions = { { encumbrance = 5, coverage = 85, covers = { "torso", "leg_l", "leg_r" } } } },
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

ccb.content.define_item {
    id = "gown_gossamer",
    copy_from = "gown",
    name = ccb.content.text("gossamer evening gown"),
    description = ccb.content.text("A full-length gossamer gown, like a waterfall of coruscating light."),
    color = "white",
    materials = { "fae_cotton" },
    variants = {},
    armor = { portions = { { encumbrance = 9, coverage = 75, covers = { "torso", "leg_l", "leg_r" } } } },
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

ccb.content.define_item {
    id = "cloak_gossamer",
    copy_from = "cloak",
    name = ccb.content.text("gossamer cloak"),
    description = ccb.content.text("A gossamer cloak meant to be thrown over your body.  It looks like ripples of multicolored light when worn."),
    color = "white",
    materials = { "fae_cotton" },
    armor = {
        portions = {
            {
                encumbrance = 3,
                coverage = 65,
                covers = { "torso", "arm_l", "arm_r", "leg_l", "leg_r" },
            },
        },
    },
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

ccb.content.define_item {
    id = "jacket_light_gossamer",
    copy_from = "jacket_light",
    name = ccb.content.text("gossamer jacket"),
    description = ccb.content.text("A thin gossamer jacket.  Despite its lack of heft, its surprisingly warm."),
    color = "white",
    materials = { "fae_cotton" },
    flags = { "VARSIZE", "POCKETS", "OUTER" },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 3, 5 } },
            { covers = { "arm_l", "arm_r" }, coverage = 100, encumbrance = { 3, 3 } },
        },
    },
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

ccb.content.define_item {
    id = "robe_wizard_gossamer",
    copy_from = "robe_wizard",
    name = ccb.content.text("gossamer robe"),
    description = ccb.content.text("A flowing gossamer robe, like a waterfall of light.  There are a surprising amount of pockets cunningly hidden in the iridescent folds."),
    color = "white",
    materials = { "fae_cotton" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "2 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "2 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "2 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "2 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "2 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
        {
            kind = "CONTAINER",
            capacity = "800 ml",
            mass_limit = "1 kg",
            max_item_length = "13 cm",
            moves = 120,
        },
    },
    armor = {
        portions = {
            { covers = { "torso" }, coverage = 100, encumbrance = { 5, 7 } },
            {
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = { 4, 4 },
                subparts = { "leg_draped_l", "leg_draped_r" },
                layers = { "BELTED" },
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = {
                    "arm_shoulder_l",
                    "arm_shoulder_r",
                    "arm_upper_r",
                    "arm_upper_l",
                    "arm_elbow_r",
                    "arm_elbow_l",
                },
                coverage = 100,
                encumbrance = { 3, 3 },
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_l", "arm_lower_r" },
                coverage = 95,
                encumbrance = { 0, 0 },
            },
        },
    },
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

ccb.content.define_item {
    id = "gloves_light_gossamer",
    copy_from = "gloves_light",
    name = ccb.content.plural_text("pair of gossamer gloves", "pairs of gossamer gloves"),
    description = ccb.content.text("A pair of gossamer gloves."),
    color = "white",
    materials = { "fae_cotton" },
    armor = { portions = { { encumbrance = 1, coverage = 100, covers = { "hand_l", "hand_r" } } } },
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

ccb.content.define_item {
    id = "loincloth_gossamer",
    copy_from = "loincloth",
    name = ccb.content.text("gossamer breechcloth"),
    description = ccb.content.text("A gossamer covering for your loins, for when you want to feel like you're wearing moonbeams."),
    color = "white",
    materials = { "fae_cotton" },
    armor = {},
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

ccb.content.define_item {
    id = "pants_gossamer",
    copy_from = "pants",
    name = ccb.content.plural_text("gossamer trousers", "gossamer trousers"),
    description = ccb.content.text("A pair of gossamer pants with two pockets.  They shimmer opalescently."),
    color = "white",
    materials = { "fae_cotton" },
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
    },
    variants = {},
    armor = { portions = { { encumbrance = { 5, 7 }, coverage = 100, covers = { "leg_l", "leg_r" } } } },
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

-- Hose here refers to the Medieval clothing.
ccb.content.define_item {
    id = "pants_no_pocket_gossamer",
    copy_from = "pants",
    name = ccb.content.plural_text("gossamer hose", "gossamer hose", "clothing"),
    description = ccb.content.text("A pair of tight-fitting gossamer pants with no pockets.  They would have been the absolute height of fashion five hundred years ago."),
    color = "white",
    materials = { "fae_cotton" },
    pockets = {},
    variants = {},
    armor = { portions = { { encumbrance = 4, coverage = 100, covers = { "leg_l", "leg_r" } } } },
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

ccb.content.define_item {
    id = "skirt_gossamer",
    copy_from = "skirt",
    name = ccb.content.plural_text("gossamer skirt", "gossamer skirt"),
    description = ccb.content.text("A loose gossamer skirt, like a waterfall of light."),
    color = "white",
    materials = { "fae_cotton" },
    pockets = {},
    variants = {},
    armor = {},
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

ccb.content.define_item {
    id = "skirt_long_gossamer",
    copy_from = "skirt_long",
    name = ccb.content.text("long gossamer skirt"),
    description = ccb.content.text("A long gossamer skirt that shimmers like a woven rainbow.  It's warmer and more fashionable than a shorter gossamer skirt."),
    color = "white",
    materials = { "fae_cotton" },
    armor = {},
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

ccb.content.define_item {
    id = "socks_gossamer",
    copy_from = "socks",
    name = ccb.content.plural_text("pair of gossamer socks", "pairs of gossamer socks"),
    description = ccb.content.text("Gossamer socks.  Whether your shoes are made of leather or canvas or moonlight or nightmares, they'll keep your feet from rubbing in them."),
    armor = { portions = { { coverage = 100, covers = { "foot_l", "foot_r" } } } },
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

ccb.content.define_item {
    id = "stockings_gossamer",
    copy_from = "stockings",
    name = ccb.content.plural_text("pair of gossamer stockings", "pairs of gossamer stockings"),
    description = ccb.content.text("A pair of gossamer stockings that shimmer in a rainbow of muted colors."),
    color = "white",
    materials = { "fae_cotton" },
    variants = {},
    armor = {
        portions = {
            { encumbrance = 3, coverage = 100, covers = { "foot_l", "foot_r" } },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r", "leg_knee_l", "leg_knee_r" },
                coverage = 100,
                encumbrance = 3,
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                coverage = 60,
            },
        },
    },
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}

-- Very low encumbrance because these are medieval indoor shoes, not fuzzy bath slippers
ccb.content.define_item {
    id = "slippers_gossamer",
    copy_from = "slippers",
    looks_like = "slippers",
    name = ccb.content.plural_text("pair of gossamer slippers", "pairs of gossamer slippers"),
    description = ccb.content.text("Soft indoor shoes, suitable for wearing whie drinking liquid light from goblets of unmelting ice and dancing the night away."),
    materials = { "fae_cotton" },
    symbol = "[",
    color = "white",
    flags = { "VARSIZE" },
    armor = {
        warmth = 4,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_r", "foot_toes_l" },
                materials = { { id = "fae_cotton", coverage = 100, thickness = 0.5 } },
                encumbrance = 4,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_r", "foot_arch_l" },
                materials = { { id = "fae_cotton", coverage = 100, thickness = 0.5 } },
                coverage = 90,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_r", "foot_heel_l" },
                materials = { { id = "fae_cotton", coverage = 100, thickness = 0.5 } },
                coverage = 10,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "fae_cotton", coverage = 100, thickness = 1.5 },
                    { id = "leather", coverage = 100, thickness = 2.0 },
                },
                coverage = 100,
            },
        },
    },
    inheritance = { scale = { mass = 0.6666, price = 2 } },
}
