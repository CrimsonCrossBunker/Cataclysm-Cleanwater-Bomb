local ccb = require("ccb")

ccb.content.define_item {
    id = "aura_force",
    category = "armor",
    name = ccb.content.plural_text("force shield", "force shields"),
    description = ccb.content.text("A small, thin torus with a huge battery case, and a belt.  You can activate it to emit a field that covers your whole body which will decelerate all objects it touches."),
    mass = "270 g",
    volume = "660 ml",
    materials = { "aluminum", "leather", "mc_steel", "copper" },
    symbol = "[",
    color = "blue",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            airtight = true,
            watertight = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_MEDIUM" },
            capacity = "20 L",
            mass_limit = "20 kg",
            default_magazine = "medium_battery_cell",
        },
    },
    techniques = { "WBLOCK_1" },
    flags = {
        "MORPHIC",
        "WATERPROOF",
        "STURDY",
        "SOFT",
        "TRADER_AVOID",
        "BELTED",
        "MUNDANE",
        "INVENTOR_CRAFTED",
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = { "battery" } },
    armor = {
        warmth = 0,
        thickness = 3,
        portions = {
            {
                covers = { "torso" },
                coverage = 50,
                subparts = { "torso_waist" },
                encumbrance = 2,
                materials = { { id = "leather", coverage = 100, thickness = 2 } },
            },
            {
                materials = { { id = "aluminum", coverage = 100, thickness = 0.7 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 25,
                encumbrance = 7,
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_aura_force_0" } },
    use_actions = {
        {
            kind = "transform",
            target = "aura_force_on",
            need_charges = 1,
            message = ccb.content.text("The torus starts to emit invisible waves."),
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}
