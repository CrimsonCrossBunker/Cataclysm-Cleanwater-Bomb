local ccb = require("ccb")

ccb.content.define_item {
    id = "crafting_assistant",
    category = "armor",
    name = ccb.content.plural_text("Crafting Assistant Robot", "Crafting Assistant Robots"),
    description = ccb.content.text("A bulky wearable robot that significantly helps with all crafting tasks while powered.  It has some strange obsession with frequently taking apart and reassembling its own arms and its programming is far too focused on creation and disassembly for it to have any combat or destructive use."),
    mass = "7500 g",
    volume = "5550 ml",
    looks_like = "bot_nursebot",
    materials = { "steel", "aluminum" },
    symbol = "[",
    color = "light_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            airtight = true,
            watertight = true,
            allowed_flags = { "BATTERY_MEDIUM", "BATTERY_HEAVY" },
            capacity = "20 L",
            mass_limit = "20 kg",
            default_magazine = "medium_battery_cell",
        },
    },
    flags = {
        "MORPHIC", "BELTED", "ALLOWS_NATURAL_ATTACKS", "WATER_FRIENDLY", "OVERSIZE", "ELECTRONIC",
        "INVENTOR_CRAFTED",
    },
    faults = { { group = "electronic_general" } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = { "battery" } },
    armor = { portions = { { coverage = 50, covers = { "torso" }, subparts = { "torso_hanging_back" } } } },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_crafting_assistant_0" } },
    use_actions = {
        {
            kind = "transform",
            target = "crafting_assistant_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
            message = ccb.content.text("The assistant deploys its new arms, ready to help with crafting."),
        },
    },
}
