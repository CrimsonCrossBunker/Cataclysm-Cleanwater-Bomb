local ccb = require("ccb")

ccb.content.define_item {
    id = "itzcuauhtli_wrist_computer",
    name = ccb.content.plural_text("māchīuhpōhualhuaztli", "māchīuhpōhualhuaztimeh"),
    description = "Your trustworthy connection to the local mātlatzālantli, the māchīuhpōhualhuaztli allows you to store and read texts through tonaltēzcatl projection, look up info, keep track of your biometrics, play games, record visuals or sound, connect with far-distant friends and family, act as a calendar and event planner, and even identify you to agents of the government or, gods forbid, the Tlamachchiuhqueh, should that become necessary.  There's nothing to connect to on this blighted world, but the other functions should still work.",
    symbol = "[",
    color = "cyan",
    category = "clothing",
    variant_kind = "generic",
    mass = "30 g",
    volume = "100 ml",
    price = "500000 USD",
    survival_price = "50 USD",
    e_port = "laptop",
    flags = {
        "WATCH",
        "WATER_FRIENDLY",
        "ALARMCLOCK",
        "BELTED",
        "CALORIES_INTAKE",
        "NO_UNLOAD",
        "NO_RELOAD",
        "ALLOWS_NATURAL_ATTACKS",
        "OVERSIZE",
        "NO_REPAIR",
        "FIFTH_SUN_TECHNOLOGY",
    },
    materials = {
        { id = "nether_crystal", portions = 5 },
        { id = "plastic", portions = 95 },
    },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { battery = 10000 },
        },
        {
            kind = "E_FILE_STORAGE",
            capacity = "1 ml",
            mass_limit = "1 g",
            memory_capacity = "512 TB",
            weight_multiplier = 0,
            rigid = true,
        },
    },
    variants = {
        {
            id = "itzcuauhtli_wrist_computer_standard",
            name = ccb.content.plural_text("māchīuhpōhualhuaztli", "māchīuhpōhualhuaztimeh"),
            description = "Your trustworthy connection to the local mātlatzālantli, the māchīuhpōhualhuaztli allows you to store and read texts through tonaltēzcatl projection, look up info, keep track of your biometrics, play games, record visuals or sound, connect with far-distant friends and family, act as a calendar and event planner, and even identify you to agents of the government or, gods forbid, the Tlamachchiuhqueh, should that become necessary.  There's nothing to connect to on this blighted world, but the other functions should still work.",
            weight = 1,
        },
        {
            id = "itzcuauhtli_wrist_computer_non_fifth_sun",
            name = ccb.content.plural_text("strange watch", "strange watches"),
            description = "This looks like a smartwatch but it doesn't have a screen.  There are two buttons on each side, and when you press one of them, a series of glowing holograms spring up over your wrist.  They depict what looks like a menu, but everything is written in blobby symbols that look vaguely…Mayan?  You've never seen anything like this before.",
            weight = 1,
        },
    },
    use_actions = {
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        "CAMERA",
        "CALORIES_INTAKE_TRACKER",
        "PORTABLE_GAME",
        "FITNESS_CHECK",
    },
    tool = { charges_per_use = 1, transfer_rate = "1 GB" },
    armor = {
        sided = true,
        portions = {
            {
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
                coverage = 100,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}
