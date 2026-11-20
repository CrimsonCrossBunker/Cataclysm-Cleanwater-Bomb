local ccb = require("ccb")

-- This is based on the Sarcos Guardian, a production model with independent battery power, all weather operation, and capable of lifting up to 200 lbs. It uses three 12 lb batteries that provide 8 hours of operation. The battery life in-game is significantly less in order to utilize medium storage batteries, otherwise this would require the unit to be active to reload itself. This can also be changed out to use other battery types.
ccb.content.define_item {
    id = "utility_exoskeleton_off",
    category = "armor",
    name = ccb.content.plural_text("battery powered utility exoskeleton", "battery powered utility exoskeletons"),
    description = ccb.content.text("A skeletal frame of sturdy metal with attached motors to allow the user to lift and move heavier loads with less strain on the body."),
    mass = "90 kg",
    volume = "130 L",
    price = "115 kUSD",
    survival_price = "400 USD",
    accuracy = { grip = "bad", length = "long", surface = "any", balance = "clumsy" },
    materials = { "steel", "plastic" },
    symbol = "[",
    looks_like = "depowered_armor",
    color = "dark_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = { "medium_storage_battery" },
            default_magazine = "medium_storage_battery",
        },
    },
    flags = { "STURDY", "OVERSIZE", "BELTED", "WATER_FRIENDLY", "ELECTRONIC" },
    faults = { { group = "electronic_general" } },
    melee_damage = { bash = 10 },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        warmth = 0,
        thickness = 8,
        environmental_protection = 0,
        portions = {
            {
                encumbrance = 20,
                coverage = 20,
                covers = {
                    "torso",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                    "leg_l",
                    "leg_r",
                    "foot_l",
                    "foot_r",
                },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_dda_utility_exoskeleton_off_0" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("The %s engages."),
            target = "utility_exoskeleton_on",
        },
    },
}
