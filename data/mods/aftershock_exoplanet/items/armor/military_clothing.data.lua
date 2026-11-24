local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_jumpsuit_military",
    copy_from = "jumpsuit",
    looks_like = "jumpsuit",
    name = ccb.content.plural_text("military overalls", "military overalls"),
    description = ccb.content.text("A sturdy Nomex jumpsuit, normally worn by armed forces during transit or beneath combat armor while in the field."),
    materials = { { id = "nylon", portions = 7 }, { id = "nomex", portions = 3 } },
    variants = {},
    color = "light_gray",
    armor = { thickness = 0.4 },
}

-- volume encumber set high since the whole vest is already scaled. This equals .4 overall
-- volume encumber set high since the whole vest is already scaled. This equals .4 overall
ccb.content.define_item {
    id = "afs_ilbe",
    copy_from = "load_bearing_vest",
    name = ccb.content.plural_text("U3s ILBE", "U3s ILBE"),
    description = ccb.content.text("Load bearing equipment that can be configured to attach PALS compatible pouches, meant to be worn in conjunction with armor.  It has two magnetic attachment points for a rifle and a sidearm.  Standard issue in UICA forces."),
    mass = "1500 g",
    variants = {},
    pockets = {
        {
            description = ccb.content.text("Rifle attachment point."),
            kind = "CONTAINER",
            holster = true,
            min_item_length = "40 cm",
            capacity = "8 L",
            mass_limit = "8200 g",
            max_item_length = "120 cm",
            volume_encumbrance = 1.6,
            moves = 30,
        },
        {
            description = ccb.content.text("Sidearm attachment point."),
            kind = "CONTAINER",
            holster = true,
            min_item_length = "10 cm",
            capacity = "1 L",
            mass_limit = "3000 g",
            max_item_length = "40 cm",
            volume_encumbrance = 1.2,
            moves = 30,
        },
    },
    armor = {
        portions = {
            {
                encumbrance = 2,
                coverage = 85,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_hanging_front" },
                volume_encumbrance = 0.25,
            },
        },
    },
    use_actions = { { kind = "holster" }, { kind = "attach_molle", size = 8 }, { kind = "detach_molle" } },
}

ccb.content.define_item {
    id = "afs_backpack_rockets",
    name = ccb.content.text("U38m munitions carrier"),
    description = ccb.content.text("A large carrying frame designed to hold up to 10 rockets or similarly shaped munitions on your back.  Most often used in conjunction with a lifting frame to manage the weight."),
    mass = "4 kg",
    volume = "18000 ml",
    price = "1 kUSD",
    survival_price = "1 kUSD",
    materials = { "nylon", "aluminum" },
    symbol = "[",
    looks_like = "backpack",
    color = "brown",
    pockets = {
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
        { kind = "CONTAINER", ammunition = { ["84x246mm"] = 1, afs_82mm_flashbulb = 1 } },
    },
    flags = { "BELTED", "WATERPROOF" },
    max_worn = 1,
    armor = {
        warmth = 10,
        thickness = 2,
        portions = {
            {
                encumbrance = { 3, 12 },
                volume_encumbrance = 0.2,
                coverage = 100,
                covers = { "torso" },
                subparts = { "torso_hanging_back", "torso_waist" },
            },
        },
    },
}
