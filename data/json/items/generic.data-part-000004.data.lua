local ccb = require("ccb")

ccb.content.define_item {
    id = "straw_pile",
    name = ccb.content.plural_text("pile of straw", "piles of straw"),
    category = "spare_parts",
    symbol = ",",
    color = "light_gray",
    description = ccb.content.text("A pile of dry grass.  Can be used to craft a straw bed if there is nothing else to sleep on."),
    materials = { "veggy", "dry_plant" },
    flags = { "TRADER_AVOID", "INEDIBLE", "CATTLE", "TINDER", "RABBIT" },
    mass = "34 g",
    volume = "250 ml",
    comestible = { kind = "FOOD", calories = 15, vitamins = { { id = "veggy_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "standard_template_construct",
    name = "nanofabricator template",
    description = "A state-of-the-art optical storage system.  This small slate of transparent glass holds, inscribed as a miniature pattern, the instructions required to create an item through a nanofabricator.",
    symbol = ",",
    color = "cyan",
    category = "spare_parts",
    mass = "317 g",
    volume = "250 ml",
    price = "1 kUSD 500 USD",
    survival_price = "10 USD",
    nanofab_template_group = "nanofab_recipes",
    template_requirements = "nanofabricator",
    flags = { "NANOFAB_TEMPLATE", "TRADER_AVOID" },
    materials = { "steel", "plastic" },
    melee_damage = { bash = 1 },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
}

ccb.content.define_item {
    id = "standard_template_construct_combat_exoskeleton",
    copy_from = "standard_template_construct",
    name = "nanofabricator exoskeleton template",
    description = "A state-of-the-art optical storage system.  This small slate of transparent glass holds, inscribed as a miniature pattern, the instructions required to create an item through a nanofabricator.  A small text at the bottom indicates that this one is specifically used to create combat exoskeletons.",
    nanofab_template_group = "nanofab_recipes_combat_exoskeletons",
}

ccb.content.define_item {
    id = "debug_template",
    copy_from = "standard_template_construct",
    name = "nanofabricator template",
    description = "A state-of-the-art optical storage system, containing the instruction set to replicate itself.",
    color = "yellow",
    nanofab_template_group = "debug_template_item",
    template_requirements = "copper_scrap_equivalent",
}
