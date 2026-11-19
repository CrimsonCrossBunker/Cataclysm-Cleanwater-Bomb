local ccb = require("ccb")

ccb.content.define_item {
    id = "robofac_head_rig_ar",
    category = "armor",
    name = ccb.content.plural_text("Hub 01 visual augmentation headgear", "Hub 01 visual augmentation headgear"),
    looks_like = "tac_helmet",
    description = ccb.content.text("Heavy duty hooded headwear for the true frontier explorer, made with robust Nylon sheeting reinforced with Kevlar fibers.  The top consists of a series of plastic plates with hooks and velcro strips, perhaps for attaching additional parts, and an integrated camera array.  A multi-faceted augmented reality headset rests of the forehead like a pair of slim, boxy ski goggles, with side plugs for auxiliary devices.  The AR lenses are equipped with adaptive light correction, light amplification and thermal imaging, and an augmented reality overlay equipped with various gadgets, including a rangefinder and adaptive targeting system, making target acquisition quicker.  Activate it to turn on all systems."),
    mass = "1400 g",
    volume = "1200 ml",
    price = "200 USD",
    survival_price = "40 USD",
    materials = { "nylon", "kevlar", "plastic" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "5000 ml",
            mass_limit = "5 kg",
            moves = 200,
            description = ccb.content.text("Hooks for an armored helm plate."),
            allowed_flags = { "ABLATIVE_HELMET" },
        },
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0,
            memory_capacity = "1 TB",
        },
    },
    flags = {
        "VARSIZE", "WATERPROOF", "STURDY", "PADDED", "OUTER", "RAINPROOF", "SOFT", "MUNDANE",
        "ELECTRONIC", "CAN_USE_IN_DARK",
    },
    techniques = { "WBLOCK_1" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, transfer_rate = "30 MB", ammo_types = "battery" },
    armor = {
        warmth = 10,
        thickness = 3,
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.5 },
                    { id = "kevlar", coverage = 100, thickness = 1.5 },
                },
                covers = { "head" },
                coverage = 95,
                encumbrance = 55,
                volume_encumbrance = 0,
            },
        },
    },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the AR headset and switch it on.\n\"HELLO MERCENARY\".\nVisual systems:   ONLINE.\nRadio systems:    ONLINE.\nTargeting HUD:    ONLINE."),
            target = "robofac_head_rig_ar_on",
        },
        "CAMERA",
        "EBOOKSAVE",
        "E_FILE_DEVICE",
    },
}
