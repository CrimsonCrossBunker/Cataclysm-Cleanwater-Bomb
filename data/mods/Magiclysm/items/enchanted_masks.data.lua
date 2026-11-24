local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "mmask",
    abstract = true,
    category = "armor",
    name = ccb.content.text_without_extraction("magic mask"),
    description = ccb.content.text_without_extraction("A generic magic mask."),
    mass = "442 g",
    volume = "750 ml",
    price = "2 kUSD",
    accuracy = -3,
    materials = { "steel", "leather" },
    symbol = "[",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY", "STURDY" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 10,
        thickness = 2,
        environmental_protection = 1,
        portions = { { encumbrance = 10, coverage = 95, covers = { "eyes", "mouth" }, rigid_only = true } },
    },
}

ccb.content.define_item {
    id = "mmask_disappearance",
    name = ccb.content.plural_text("mask of disappearance", "masks of disappearance"),
    description = ccb.content.text("A mask with no facial features at all, just eye and mouth holes, upon activation it makes everything ignore your presence for a while."),
    copy_from = "mmask",
    materials = { "steel", "leather" },
    flags = { "NO_UNLOAD", "NO_RELOAD" },
    pockets = { { kind = "MAGAZINE", holster = true, ammunition = { crystallized_mana = 1 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1 },
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "12 h", regenerate_ammo = true } },
    use_actions = {
        {
            kind = "cast_spell",
            spell = "invisibility",
            no_fail = true,
            level = 15,
            need_worn = true,
        },
    },
}

ccb.content.define_item {
    id = "mmask_vision",
    name = ccb.content.plural_text("mask of perfect vision", "masks of perfect vision"),
    description = ccb.content.text("A decidedly steampunk-looking half mask that covers the eye area of the face, it has large lenses that correct and greatly enhance the vision of the wearer."),
    copy_from = "mmask",
    materials = { "steel", "leather" },
    flags = {
        "WATER_FRIENDLY",
        "SUN_GLASSES",
        "FIX_NEARSIGHT",
        "FIX_FARSIGHT",
        "ZOOM",
        "NORMAL",
        "SKINTIGHT",
    },
    qualities = { { id = "GLARE", level = 1 } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {
        environmental_protection = 6,
        portions = { { encumbrance = 5, coverage = 100, covers = { "eyes" }, rigid_only = true } },
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mmask_vision_0" } },
}
