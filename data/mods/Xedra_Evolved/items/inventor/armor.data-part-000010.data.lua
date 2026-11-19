local ccb = require("ccb")

ccb.content.define_item {
    id = "wolf_mask",
    category = "clothing",
    name = ccb.content.plural_text("wolf's mask", "wolf's masks"),
    description = ccb.content.text("A huge, respirator-like mask covering the whole head except for the right eye.  Upon activation it protects you lungs from toxic gases as well as improving your breathing and stamina."),
    mass = "405 g",
    volume = "1479 ml",
    materials = { "aluminum" },
    symbol = "[",
    looks_like = "mask_gas",
    color = "dark_gray",
    flags = { "MORPHIC", "MUNDANE", "INVENTOR_CRAFTED" },
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
        thickness = 0.4,
        environmental_protection = 4,
        portions = {
            { covers = { "eyes" }, rigid_only = true, coverage = 100, encumbrance = 3 },
            {
                covers = { "mouth", "muzzle", "beak", "insect_proboscis" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 7,
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_wolf_mask_0" } },
    use_actions = {
        {
            kind = "transform",
            target = "wolf_mask_act",
            message = ccb.content.text("You turn on the %s."),
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}
