local ccb = require("ccb")

-- Based on Anduril IVAS system.  Renamed 'Integrated' to 'Military' so as to not confuse it with other internal, integrated items in game. Dispersion bonus is high to make up for combating effects of eye encumbrance - final bonus is modest.
ccb.content.define_item {
    id = "military_vis_aug_system",
    category = "armor",
    name = ccb.content.plural_text("military visual augmentation system", "military visual augmentation system"),
    description = ccb.content.text("An experimental and cumbersome augmented reality headset developed for the military.  It consists of a broad eyepiece, a rugged multi-camera array, and a puck computer, all designed to be strapped over a helmet.  The lenses are equipped with adaptive light correction, light amplification and thermal imaging, and an augmented reality overlay equipped with various gadgets, including a rangefinder and adaptive targeting system, making target acquisition quicker.  Activate it to turn on all systems."),
    mass = "1500 g",
    volume = "1400 ml",
    price = "40000 USD",
    survival_price = "10 USD",
    materials = { "plastic", "qt_steel", "glass" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        { kind = "MAGAZINE", rigid = true, ammunition = { battery = 500 } },
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0,
            memory_capacity = "1 TB",
        },
    },
    flags = { "ELECTRONIC", "CAN_USE_IN_DARK", "BELTED", "PADDED", "MUNDANE", "USE_UPS", "NO_UNLOAD" },
    faults = { { group = "electronic_general" } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, transfer_rate = "30 MB", ammo_types = "battery" },
    armor = {
        thickness = 2,
        portions = {
            { covers = { "eyes" }, coverage = 100, encumbrance = 30, rigid_only = true },
            { covers = { "head" }, encumbrance = 20, coverage = 80, subparts = { "head_forehead" } },
            { covers = { "head" }, encumbrance = 5, coverage = 40, subparts = { "head_crown" } },
        },
    },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Switch on the AR system"),
            message = ccb.content.text("You activate your AR system.\nAnduril IVASos v1.2: ONLINE.\nVisual systems:      ONLINE.\nRadio systems:       ONLINE.\nTargeting HUD:       ONLINE.\nGPS:                  ERROR."),
            target = "military_vis_aug_system_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
        "CAMERA",
        "EBOOKSAVE",
        "E_FILE_DEVICE",
    },
}
