local ccb = require("ccb")

ccb.content.define_item {
    id = "helmet_inventor",
    category = "armor",
    name = ccb.content.plural_text("helmet of creative juices", "helmets of creative juices"),
    description = ccb.content.text("The helmet of creative juices may look like a child's homemade toy, but its effects when turned on are real enough.  While wearing it, your thoughts are buffered from the outside world by a soft white noise that varies from person to person as to what they actually hear.  Some hear the ocean, a fan blowing or paper crumpling.  Whatever the sound, it helps you to think faster and more creatively than before."),
    mass = "1383 g",
    volume = "1750 ml",
    materials = { "mc_steel", "plastic" },
    symbol = "[",
    looks_like = "hat_hard",
    color = "green",
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
        "MORPHIC", "WATERPROOF", "STURDY", "PADDED", "TRADER_AVOID", "PSYSHIELD_PARTIAL", "MUNDANE",
        "INVENTOR_CRAFTED",
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    armor = {
        warmth = 20,
        thickness = 1.1,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 50,
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_helmet_inventor_0" } },
    use_actions = {
        {
            kind = "transform",
            target = "helmet_inventor_on",
            message = ccb.content.text("You turn on the %s."),
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}
