local ccb = require("ccb")

ccb.content.define_item {
    id = "chitin_piece",
    category = "spare_parts",
    symbol = ",",
    color = "light_gray",
    name = ccb.content.plural_text("chunk of chitin", "chunks of chitin"),
    snippet_category = "chitin_desc",
    description = ccb.content.text("A piece of an insect's exoskeleton.  It is light and very durable."),
    price = "0 cent",
    survival_price = "25 cent",
    materials = { "chitin" },
    flags = { "NO_SALVAGE" },
    mass = "89 g",
    volume = "250 ml",
    milling = { result = "meal_chitin_piece", recipe = "meal_chitin_piece_mill_1_4" },
}

ccb.content.define_item {
    id = "endochitin",
    category = "spare_parts",
    symbol = ",",
    color = "light_gray",
    name = ccb.content.plural_text("strand of endochitin", "strands of endochitin"),
    snippet_category = "endochitin_desc",
    description = ccb.content.text("A piece of an insect's endoskeleton."),
    price = "0 cent",
    materials = { "chitin" },
    flags = { "NO_SALVAGE" },
    mass = "89 g",
    volume = "300 ml",
    milling = { result = "meal_chitin_piece", recipe = "meal_chitin_piece_mill_1_4" },
}

ccb.content.define_item {
    id = "mutant_bug_hydrogen_sacs",
    symbol = "o",
    color = "light_gray",
    name = ccb.content.plural_text("cluster of gas sacs", "clusters of gas sacs"),
    description = ccb.content.text("A cluster of membranous bubbles, each about the size of a grape, retrieved from inside a mutant insect.  They float like tiny helium balloons - perhaps they are full of a lighter-than-air gas."),
    price = "0 cent",
    materials = { "flesh" },
    flags = { "NO_SALVAGE" },
    mass = "50 g",
    volume = "250 ml",
    comestible = {
        kind = "FOOD",
        shelf_life = "8 hours",
        fun = -25,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "paper",
    name = ccb.content.plural_text("paper", "paper"),
    category = "spare_parts",
    mass = "3 g",
    color = "white",
    symbol = "`",
    description = ccb.content.text("A piece of paper.  Can be used to start fires."),
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "paper" },
    flags = { "TINDER", "PAPER_SHAPED" },
    volume = "6 ml",
    length = "297 mm",
    ammunition = { type = "paper" },
}

ccb.content.define_item {
    id = "lens",
    symbol = ".",
    color = "light_cyan",
    name = ccb.content.plural_text("high-quality lens", "high-quality lenses"),
    category = "spare_parts",
    description = ccb.content.text("A high-quality glass lens, useful for focusing or diffusing light.  Might be useful for starting a fire."),
    price = "1 kUSD 200 USD",
    survival_price = "1 USD",
    materials = { "glass" },
    mass = "1 g",
    volume = "2 ml",
    flags = { "FIRESTARTER" },
    use_actions = { { kind = "firestarter", moves = 1000, slow_moves = 30000, need_sunlight = true } },
}

ccb.content.define_item {
    id = "straw_pile",
    name = ccb.content.plural_text("pile of straw", "piles of straw"),
    category = "spare_parts",
    symbol = ",",
    color = "light_gray",
    description = ccb.content.text("A pile of dry grass.  Can be used to craft a straw bed if there is nothing else to sleep on."),
    materials = { "veggy", "dry_plant" },
    flags = { "TRADER_AVOID", "INEDIBLE", "CATTLE", "TINDER", "RABBIT" },
    mass = "34 g",
    volume = "250 ml",
    comestible = { kind = "FOOD", calories = 15, vitamins = { { id = "veggy_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "standard_template_construct",
    name = "nanofabricator template",
    description = "A state-of-the-art optical storage system.  This small slate of transparent glass holds, inscribed as a miniature pattern, the instructions required to create an item through a nanofabricator.",
    symbol = ",",
    color = "cyan",
    category = "spare_parts",
    mass = "317 g",
    volume = "250 ml",
    price = "1 kUSD 500 USD",
    survival_price = "10 USD",
    nanofab_template_group = "nanofab_recipes",
    template_requirements = "nanofabricator",
    flags = { "NANOFAB_TEMPLATE", "TRADER_AVOID" },
    materials = { "steel", "plastic" },
    melee_damage = { bash = 1 },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
}

ccb.content.define_item {
    id = "standard_template_construct_combat_exoskeleton",
    copy_from = "standard_template_construct",
    name = "nanofabricator exoskeleton template",
    description = "A state-of-the-art optical storage system.  This small slate of transparent glass holds, inscribed as a miniature pattern, the instructions required to create an item through a nanofabricator.  A small text at the bottom indicates that this one is specifically used to create combat exoskeletons.",
    nanofab_template_group = "nanofab_recipes_combat_exoskeletons",
}

ccb.content.define_item {
    id = "debug_template",
    copy_from = "standard_template_construct",
    name = "nanofabricator template",
    description = "A state-of-the-art optical storage system, containing the instruction set to replicate itself.",
    color = "yellow",
    nanofab_template_group = "debug_template_item",
    template_requirements = "copper_scrap_equivalent",
}

-- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
ccb.content.define_item {
    id = "cigar_lit",
    name = ccb.content.plural_text("cigar", "cigars"),
    color = "brown",
    symbol = "!",
    description = ccb.content.text("The smoke billowing from this cigar has a sweet, musty odor."),
    mass = "9 g",
    volume = "15 ml",
    category = "drugs",
    emissions = { "emit_tobacco_trail" },
    revert_to = "cigar_butt",
    materials = { "paper" },
    light = 8,
    flags = { "LITCIG", "TOBACCO", "TRADER_AVOID", "FIRESTARTER", "FRAGILE", "OVERSIZE", "SPAWN_ACTIVE" },
    armor = {
        warmth = 6,
        portions = {
            {
                materials = { { id = "paper", coverage = 100, thickness = 0.1 } },
                encumbrance = 25,
                coverage = 70,
                covers = { "mouth" },
            },
        },
    },
    use_actions = {
        { kind = "firestarter", moves = 500, slow_moves = 6000 },
        {
            kind = "transform",
            target = "cigar_butt",
            message = ccb.content.text("You extinguish the cigar."),
            menu_text = ccb.content.text("Extinguish"),
        },
    },
}

-- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
ccb.content.define_item {
    id = "cig_lit",
    name = ccb.content.plural_text("cigarette", "cigarettes"),
    color = "white",
    symbol = "!",
    description = ccb.content.text("Smoke swirls from the lit end of this cigarette, filling the air with the thrilling smell of burning chemicals."),
    mass = "1 g",
    volume = "4 ml",
    category = "drugs",
    emissions = { "emit_tobacco_trail" },
    revert_to = "cig_butt",
    materials = { "paper" },
    light = 2,
    flags = { "LITCIG", "TOBACCO", "TRADER_AVOID", "FIRESTARTER", "FRAGILE", "OVERSIZE", "SPAWN_ACTIVE" },
    armor = {
        warmth = 3,
        portions = {
            {
                materials = { { id = "paper", coverage = 100, thickness = 0.1 } },
                encumbrance = 15,
                coverage = 25,
                covers = { "mouth" },
            },
        },
    },
    use_actions = {
        { kind = "firestarter", moves = 500, slow_moves = 6000 },
        {
            kind = "transform",
            target = "cig_butt",
            message = ccb.content.text("You extinguish the cigarette."),
            menu_text = ccb.content.text("Extinguish"),
        },
    },
}

-- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
ccb.content.define_item {
    id = "joint_lit",
    name = ccb.content.plural_text("joint", "joints"),
    color = "light_green",
    symbol = "!",
    description = ccb.content.text("The smell of skunk permeates the air as a thin trail of smoke floats off of this joint."),
    mass = "1 g",
    volume = "4 ml",
    category = "drugs",
    emissions = { "emit_joint_trail" },
    revert_to = "joint_roach",
    materials = { "paper" },
    light = 2,
    flags = { "LITCIG", "TRADER_AVOID", "FIRESTARTER", "FRAGILE", "OVERSIZE", "SPAWN_ACTIVE" },
    armor = {
        warmth = 3,
        portions = {
            {
                materials = { { id = "paper", coverage = 100, thickness = 0.1 } },
                encumbrance = 15,
                coverage = 25,
                covers = { "mouth" },
            },
        },
    },
    use_actions = {
        { kind = "firestarter", moves = 500, slow_moves = 6000 },
        {
            kind = "transform",
            target = "joint_roach",
            message = ccb.content.text("You extinguish the joint."),
            menu_text = ccb.content.text("Extinguish"),
        },
    },
}

ccb.content.define_item {
    id = "pouch_autoclave",
    name = ccb.content.plural_text("autoclave pouch", "autoclave pouches"),
    description = "A medical device that bears the approval of the FDA (Food and Drug Administration).  If used properly, this pouch can keep things sterile indefinitely.",
    symbol = "]",
    color = "light_gray",
    category = "other",
    mass = "2 g",
    volume = "25 ml",
    price = "5 cent",
    survival_price = "1 USD",
    materials = { "plastic", "paper" },
    use_actions = { "PACK_CBM" },
    ammunition = { type = "NULL", count = 25 },
}

-- NO_I18N
-- NO_I18N
-- Based on my own cash card that I measured with a ruler. Yes I'm professional like that. 8.4cm x 5.3cm x 0.1cm. Really it's slightly less than 5ml but we don't do volume lower than 1ml.
ccb.content.define_item {
    id = "card_plastic_abstract",
    abstract = true,
    symbol = ",",
    color = "cyan",
    name = ccb.content.text_without_extraction("abstract plastic card"),
    description = ccb.content.text_without_extraction("A generic plastic card item template with numbers based off a credit card."),
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "plastic" },
    mass = "5 g",
    volume = "5 ml",
    length = "84 mm",
    flags = { "CREDIT_CARD_SHAPED" },
    accuracy = { grip = "bad", length = "hand", surface = "any", balance = "neutral" },
    tool = {},
}

ccb.content.define_item {
    id = "cash_card",
    category = "currency",
    copy_from = "card_plastic_abstract",
    symbol = "$",
    color = "yellow",
    name = ccb.content.plural_text("cash card", "cash cards"),
    ascii_picture = "cashcard",
    description = ccb.content.text("A yellow plastic card used to electronically store money.  It holds up to 2 million dollars."),
    price = "10 USD",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { money = 200000000 } } },
    inheritance = { add = { flags = { "NO_UNLOAD", "NO_RELOAD", "TRADER_AVOID" } } },
    tool = { ammo_types = { "money" } },
}

ccb.content.define_item {
    id = "wallet_travel",
    category = "clothing",
    symbol = ";",
    color = "dark_gray",
    name = ccb.content.plural_text("travel wallet", "travel wallets"),
    description = ccb.content.text("A flat case with a neck strap, used to carry items such as currency, identification documents, laminated cards, and other small items."),
    price = "150 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic", "leather" },
    flags = {
        "OVERSIZE",
        "BELTED",
        "ALLOWS_NATURAL_ATTACKS",
        "TARDIS",
        "COLLAPSE_CONTENTS",
        "POWERARMOR_COMPATIBLE",
    },
    mass = "708 g",
    volume = "500 ml",
    pockets = {
        {
            kind = "CONTAINER",
            rigid = true,
            mass_limit = "600 g",
            capacity = "500 ml",
            moves = 400,
            allowed_flags = { "BANK_NOTE_SHAPED", "CREDIT_CARD_SHAPED" },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        thickness = 2,
        portions = { { encumbrance = 2, coverage = 100, covers = { "torso" }, subparts = { "torso_neck" } } },
    },
}

ccb.content.define_item {
    id = "lanyard",
    category = "clothing",
    symbol = "[",
    color = "white",
    name = ccb.content.plural_text("lanyard", "lanyards"),
    description = ccb.content.text("A flat, clear plastic sleeve for identification documents, laminated cards, and other small items.  It has a neck strap attached."),
    price = "10 cent",
    survival_price = "1 cent",
    materials = { "plastic" },
    flags = { "OVERSIZE", "BELTED", "ALLOWS_NATURAL_ATTACKS", "POWERARMOR_COMPATIBLE", "PADDED" },
    mass = "250 g",
    volume = "250 ml",
    length = "5 cm",
    pockets = {
        {
            kind = "CONTAINER",
            rigid = false,
            mass_limit = "60 g",
            capacity = "150 ml",
            max_item_length = "85 mm",
            moves = 100,
            allowed_flags = { "BANK_NOTE_SHAPED", "CREDIT_CARD_SHAPED" },
        },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        thickness = 1,
        portions = { { encumbrance = 0, covers = { "torso" }, subparts = { "torso_neck" } } },
    },
}
