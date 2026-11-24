local ccb = require("ccb")

ccb.content.define_item {
    id = "art_robe",
    copy_from = "robe",
    name = ccb.content.text("royal robe"),
    description = ccb.content.text("An ornately decorated robe with an unfamiliar royal symbol on it.  The humanoid figure on the seal has two pairs of eyes.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    armor = {},
}

ccb.content.define_item {
    id = "art_cloak",
    copy_from = "cloak",
    name = ccb.content.text("ancient burial shroud"),
    description = ccb.content.text("A cloak of thin, faded cloth.  The faint silhouette of a long-dead humanoid is barely visible on it.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    armor = {},
}

-- remove fur coat variants
ccb.content.define_item {
    id = "art_coat",
    copy_from = "coat_fur",
    name = ccb.content.text("ornate fur coat"),
    description = ccb.content.text("A heavy, finely crafted coat made of the fur of an unidentifiable creature.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    variants = {},
    armor = {},
}

ccb.content.define_item {
    id = "art_mask",
    category = "armor",
    name = ccb.content.text("ancient stone mask"),
    description = ccb.content.text("A sinister mask made of a smooth green stone.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    mass = "750 g",
    volume = "750 ml",
    price = "40 USD",
    survival_price = "10 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "stone" },
    symbol = "[",
    color = "green",
    flags = { "WATER_FRIENDLY" },
    armor = {
        warmth = 5,
        thickness = 0.2,
        environmental_protection = 1,
        portions = { { encumbrance = 10, coverage = 95, covers = { "eyes", "mouth" } } },
    },
}

ccb.content.define_item {
    id = "art_helm",
    copy_from = "helmet_bronze",
    name = ccb.content.text("ancient bronze helmet"),
    description = ccb.content.text("A helmet with an imposing face plate.  Though the corrosion has completely defaced the symbols written on the sides, it seems sturdy.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    armor = {},
}

ccb.content.define_item {
    id = "art_gloves",
    copy_from = "gloves_leather",
    name = ccb.content.plural_text("ornate leather gloves (pair)", "ornate leather gloves (pair)"),
    description = ccb.content.text("A set of worn leather gloves embossed with gold.  The unidentifiable leather it is made from is oddly soft.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    armor = {},
}

ccb.content.define_item {
    id = "art_boots",
    copy_from = "boots",
    name = ccb.content.plural_text("ancient leather boots (pair)", "ancient leather boots (pair)"),
    description = ccb.content.text("A pair of ancient leather boots.  Though the flaps of leather are crudely sewn together, the red hue it is dyed with is striking.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    armor = {},
}

ccb.content.define_item {
    id = "art_ring",
    copy_from = "gold_ring",
    name = ccb.content.text("amber ring"),
    description = ccb.content.text("A band of gold with a smooth piece of amber set into it.  A strange worm is encased in the amber, making a perfect spiral with its sealed body.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    armor = {},
}

ccb.content.define_item {
    id = "art_staff",
    copy_from = "i_staff",
    name = ccb.content.plural_text("ancient staff", "ancient staffs"),
    description = ccb.content.text("A well-balanced stick of treated wood with metal caps.  A red stone is embedded in the handle.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    tool = {},
}

ccb.content.define_item {
    id = "art_sword",
    copy_from = "longsword",
    name = ccb.content.plural_text("ancient sword", "ancient swords"),
    description = ccb.content.text("A sword made out of a striking black metal.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    tool = {},
}

ccb.content.define_item {
    id = "art_harp",
    name = ccb.content.plural_text("ancient harp", "ancient harps"),
    category = "tools",
    mass = "3200 g",
    color = "brown",
    accuracy = { grip = "solid", length = "long", surface = "any", balance = "clumsy" },
    symbol = "7",
    description = ccb.content.text("A harp made of black wood.  Faint hypnotic notes ring in the air each time you touch it.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    price = "10 USD",
    survival_price = "2 USD 50 cent",
    materials = { { id = "wood", portions = 19 }, { id = "steel" } },
    volume = "6750 ml",
    length = "97 cm",
    flags = { "FRAGILE_MELEE", "BELTED", "SLEEP_IGNORE" },
    melee_damage = { bash = 18 },
    tool = {},
    use_actions = {
        {
            kind = "musical_instrument",
            speed_penalty = 15,
            volume = 0,
            fun = 5,
            fun_bonus = 5,
            description_interval = 20,
            player_messages = {
                "You strum a string and the note hangs in the air far longer than you would expect.",
                "You improvise a tune on the harp.  The sound is beautiful, even if you can't remember what you just played.",
                "You pluck a chord on the harp.  It doesn't sound anything at all like the sounds of the individual strings.",
            },
            npc_messages = { "plucks a few notes on the harp, though no sound seems to come." },
        },
    },
}

-- Tool qualities equivalent to steak knife, combat equiv.  to copper knife + 1 w/ RAPID and BLOCK1, size/weight off combat knife +1
ccb.content.define_item {
    id = "art_dagger",
    name = ccb.content.plural_text("ancient athame", "ancient athames"),
    description = ccb.content.text("A ritual knife used by some ancient civilization.  Unreadable runes are carved into the handle.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    mass = "504 g",
    volume = "500 ml",
    length = "25 cm",
    price = "30 USD",
    accuracy = { grip = "solid", length = "hand", surface = "line", balance = "neutral" },
    materials = { "wood", "steel" },
    symbol = ";",
    color = "light_gray",
    techniques = { "WBLOCK_1" },
    qualities = { { id = "CUT", level = 1 }, { id = "CUT_FINE", level = 1 }, { id = "BUTCHER", level = 11 } },
    weapon_categories = { "KNIVES" },
    flags = { "SHEATH_KNIFE", "TRADER_AVOID" },
    melee_damage = { bash = 2, stab = 13 },
    tool = {},
}

ccb.content.define_item {
    id = "art_spear",
    copy_from = "spear_steel",
    name = ccb.content.plural_text("ancient spear", "ancient spears"),
    description = ccb.content.text("A sturdy wooden pole with a sharp metal spike on the end.  The handle has the symbol of a blue sun on it.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    tool = {},
}

ccb.content.define_item {
    id = "art_club",
    copy_from = "club_wooden",
    name = ccb.content.plural_text("ancient club", "ancient clubs"),
    description = ccb.content.text("A misshapen rod of gnarled, knotted wood.  The knots in the wood exhibit a strange fractal pattern.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    tool = {},
}
