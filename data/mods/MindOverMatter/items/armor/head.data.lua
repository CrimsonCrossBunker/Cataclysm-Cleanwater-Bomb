local ccb = require("ccb")

ccb.content.define_item {
    id = "psionic_anchoring_crown",
    name = ccb.content.plural_text("anchoring crown", "anchoring crowns"),
    description = ccb.content.text("A thin steel circlet studded with chunks of matrix crystal.  Your skin prickles slightly where the crown touches it."),
    mass = "80 g",
    volume = "100 ml",
    price = "50 USD",
    survival_price = "25 cent",
    materials = { { id = "steel", portions = 9 }, { id = "nether_crystal" } },
    looks_like = "crown_golden",
    symbol = "[",
    color = "blue",
    flags = { "DIMENSIONAL_ANCHOR", "PADDED" },
    subtype_order = { "armor", "artifact" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 1, coverage = 20, covers = { "head" }, subparts = { "head_crown" } } },
    },
    artifact = { enchantments = { "ITEM_ENCH_MindOverMatter_psionic_anchoring_crown_0" } },
}

ccb.content.define_item {
    id = "psionic_telepathic_dampener",
    name = ccb.content.plural_text("telepathic dampener", "telepathic dampeners"),
    description = ccb.content.text("A steel skullcap with a matrix crystal at its crown.  It looks ridiculous, but the documents you read said it would protect you from telepathic attack."),
    mass = "767 g",
    volume = "2 L",
    price = "30 USD",
    survival_price = "25 cent",
    materials = { { id = "steel", portions = 12 }, { id = "nether_crystal" } },
    looks_like = "hat_hard",
    symbol = "[",
    color = "white",
    flags = { "PADDED", "PORTAL_PROOF" },
    subtype_order = { "armor", "artifact" },
    armor = {
        thickness = 0.33,
        portions = {
            {
                encumbrance = 4,
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_MindOverMatter_psionic_telepathic_dampener_0" } },
}

ccb.content.define_item {
    id = "psionic_mindsight_glasses",
    category = "clothing",
    looks_like = "ar_glasses_advanced",
    name = ccb.content.plural_text("QD944-P 'Mindsight' glasses", "sets of QD944-P 'Mindsight' glasses"),
    description = ccb.content.text("A set of AR-looking glasses.  The code \"QD944-P\" is printed in small letters on the temples."),
    mass = "170 g",
    volume = "750 ml",
    price = "30 kUSD",
    survival_price = "400 USD",
    materials = { { id = "plastic", portions = 12 }, { id = "nether_crystal" } },
    symbol = "[",
    color = "white",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
            default_magazine = "light_battery_electronoetic",
        },
    },
    flags = { "OUTER", "FRAGILE", "SUN_GLASSES", "WATER_BREAK", "PADDED", "ELECTRONIC" },
    faults = { { group = "electronic_general" } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        portions = { { encumbrance = 4, coverage = 100, covers = { "eyes" } } },
        thickness = 1,
        environmental_protection = 1,
    },
    artifact = { enchantments = { "ITEM_ENCH_MindOverMatter_psionic_mindsight_glasses_0" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You activate your %s."),
            target = "psionic_mindsight_glasses_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "psionic_mindsight_glasses_on",
    category = "clothing",
    copy_from = "psionic_mindsight_glasses",
    name = ccb.content.plural_text("QD944-P 'Mindsight' glasses (on)", "sets of QD944-P 'Mindsight' glasses (on)"),
    description = ccb.content.text("A set of AR-looking glasses.  The code \"QD944-P\" is printed in small letters on the temples.  They are currently active."),
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "3500 mW" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You deactivate your %s."),
            target = "psionic_mindsight_glasses",
        },
    },
}
