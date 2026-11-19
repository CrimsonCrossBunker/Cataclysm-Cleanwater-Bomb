local ccb = require("ccb")

ccb.content.define_item {
    id = "inventor_leg_weight",
    category = "armor",
    name = ccb.content.plural_text("leg weight suspension system", "leg weight suspension systems"),
    description = ccb.content.text("Compact leg attachments that distribute your weight onto the ground nearby using some kind of force.  It makes you leave giant spherical footprints, but makes carrying heavy weight much easier."),
    mass = "1657 g",
    volume = "1500 ml",
    materials = { "mc_steel", "copper", "leather" },
    symbol = "[",
    looks_like = "legguard_hard",
    color = "light_red",
    flags = { "MORPHIC", "STURDY", "OUTER", "BELTED", "MUNDANE", "INVENTOR_CRAFTED" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM", "BATTERY_HEAVY" },
            capacity = "20 L",
            mass_limit = "20 kg",
            default_magazine = "medium_battery_cell",
        },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = "battery" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 50,
                subparts = { "torso_waist" },
                encumbrance = 2,
                materials = { { id = "leather", coverage = 100, thickness = 2 } },
            },
            {
                materials = {
                    { id = "mc_steel", coverage = 100, thickness = 0.6 },
                    { id = "copper", coverage = 100, thickness = 0.6 },
                },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 20,
                encumbrance = 7,
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_inventor_leg_weight_0" } },
    use_actions = {
        {
            kind = "transform",
            target = "inventor_leg_weight_on",
            message = ccb.content.text("You turn on the %s."),
        },
    },
}
