local ccb = require("ccb")

ccb.content.define_item {
    id = "inventor_electric_fist",
    symbol = "3",
    color = "light_gray",
    looks_like = "gauntlets_chitin",
    name = ccb.content.plural_text("\"Overture\"", "\"Overtures\""),
    description = ccb.content.text("A bulky mess of coils and wires that goes from your fists to your shoulder, and a slot for a small battery behind the elbow.  Upon activation it will start to emit huge electrical charges, frying your enemies when attacked in melee."),
    materials = { "aluminum", "copper" },
    volume = "155 ml",
    mass = "300 g",
    length = "25 cm",
    melee_damage = { electric = 10 },
    max_worn = 1,
    flags = { "MORPHIC", "TRADER_AVOID", "MUNDANE", "INVENTOR_CRAFTED" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            airtight = true,
            watertight = true,
            allowed_flags = { "BATTERY_ULTRA_LIGHT", "BATTERY_LIGHT" },
            capacity = "20 L",
            mass_limit = "20 kg",
            default_magazine = "light_minus_disposable_cell",
        },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = { "battery" } },
    armor = {
        thickness = 0.3,
        portions = { { encumbrance = 4, coverage = 45, covers = { "arm_l", "arm_r" } } },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_inventor_electric_fist_0" } },
    use_actions = {
        {
            kind = "transform",
            target = "inventor_electric_fist_act",
            message = ccb.content.text("You turn on the %s."),
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "inventor_fists_plus",
    copy_from = "inventor_fists",
    name = "advanced heavy CQC system",
    description = "An advanced version of the heavy CQC system.  It contain a self-recharging pneumatic tank that slowly builds pressure that you can use in a fight.",
    symbol = "3",
    color = "light_gray",
    techniques = { "WBLOCK_3", "BRUTAL", "SWEEP", "CQB_BRUTAL" },
    pockets = {
        {
            kind = "MAGAZINE",
            airtight = true,
            ammunition = { oxygen = 3 },
        },
    },
    tool = {},
    armor = {},
    artifact = {
        charge = { recharge_type = "periodic", interval = "1 m", regenerate_ammo = true },
    },
    subtype_order = { "tool", "armor", "artifact" },
}
