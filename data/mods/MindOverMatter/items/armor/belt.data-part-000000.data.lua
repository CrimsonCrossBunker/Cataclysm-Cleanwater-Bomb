local ccb = require("ccb")

ccb.content.define_item {
    id = "psionic_shield_belt",
    name = ccb.content.plural_text("shield belt", "shield belts"),
    description = ccb.content.text("A simple synthetic fabric belt with a box to the right of the belt loop.  The box has a toggleable switch and a stylized shield with Ψ and the XEDRA logo inside it."),
    mass = "350 g",
    volume = "500 ml",
    price = "100 USD",
    survival_price = "50 USD",
    materials = { "nylon", "steel", "nether_crystal" },
    symbol = "[",
    looks_like = "leather_belt",
    color = "yellow",
    flags = { "BELTED", "OVERSIZE", "NONCONDUCTIVE", "NO_REPAIR", "COMBAT_TOGGLEABLE" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = { "battery" } },
    armor = {
        thickness = 1.5,
        portions = {
            {
                encumbrance = 2,
                coverage = 50,
                covers = { "torso" },
                subparts = { "torso_waist" },
                volume_encumbrance = 0.35,
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_MindOverMatter_psionic_shield_belt_0" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You flip the switch on the box and a red LED lights up."),
            damage_failure = ccb.content.text_without_extraction("You flip the switch on the box, but nothing happens."),
            target = "psionic_shield_belt_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The switch clicks but nothing happens."),
            need_worn = true,
            menu_text = ccb.content.text("Flip the switch"),
            moves = 75,
        },
    },
}
