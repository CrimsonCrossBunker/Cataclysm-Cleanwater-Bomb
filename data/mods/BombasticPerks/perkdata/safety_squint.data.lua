local ccb = require("ccb")

ccb.content.define_item {
    id = "perk_safety_squint_integrated_goggles",
    copy_from = "goggles_welding",
    looks_like = "integrated_ierde_eyes",
    category = "armor",
    name = ccb.content.plural_text("the safety squint", "the safety squint"),
    description = ccb.content.text("You've got your eyes shut against the glare, but not all the way."),
    mass = "0 g",
    volume = "0 ml",
    materials = { "flesh" },
    symbol = "[",
    color = "dark_gray",
    inheritance = {
        add = {
            flags = {
                "ZERO_WEIGHT",
                "TRADER_AVOID",
                "PERSONAL",
                "INTEGRATED",
                "SEMITANGIBLE",
                "UNBREAKABLE",
                "OVERSIZE",
            },
        },
    },
    subtype_order = { "armor", "artifact" },
    armor = { warmth = 0, thickness = 0, environmental_protection = 0 },
    artifact = { enchantments = { "ITEM_ENCH_BombasticPerks_perk_safety_squint_integrated_goggles_0" } },
}
