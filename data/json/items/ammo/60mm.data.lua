local ccb = require("ccb")

-- 190 g of comp-b, so explosion power should be 250; let's pretend case mass is third of the rest of the weight, so 500 g
ccb.content.define_item {
    id = "60mm_shell_m720a1",
    name = ccb.content.text("high-explosive mortar shell"),
    description = ccb.content.text("High-explosive mortar cartridge, designed to be used against troops, light vehicles, light bunkers or similar targets."),
    variant_kind = "gun",
    variants = {
        {
            id = "60mm_shell_m720",
            name = ccb.content.plural_text("M720A1 60mm mortar shell (HE)", "M720A1 60mm mortar shells (HE)"),
            description = ccb.content.text("High-explosive mortar cartridge, designed to be used against troops, light vehicles, light bunkers or similar targets."),
        },
    },
    mass = "1700 g",
    volume = "680 ml",
    length = "376 mm",
    price = "400 USD",
    survival_price = "10 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { { id = "steel", portions = 80 }, { id = "powder", portions = 20 } },
    symbol = "=",
    color = "dark_gray",
    stack_size = 1,
    ammunition = { count = 1, type = "mortar_60mm", effects = { "SPECIAL_COOKOFF", "EXPLOSIVE_60mmHE" } },
}

-- 358 g of pax-21, which is replacement for comp b - weaker (~1.0 tnt equivalent), but safer, so explosion power should be 358; let's pretend case mass is third of the rest of the weight, so 430 g
ccb.content.define_item {
    id = "60mm_shell_m768",
    copy_from = "60mm_shell_m720a1",
    name = ccb.content.text("high-explosive mortar shell"),
    description = ccb.content.text("High-explosive mortar cartridge, designed to be used against troops, light vehicles, light bunkers or similar targets.  This one is more modern version, both more safe and more powerful."),
    variant_kind = "gun",
    variants = {
        {
            id = "60mm_shell_m768",
            name = ccb.content.plural_text("M768 60mm mortar shell (HE)", "M768 60mm mortar shells (HE)"),
            description = ccb.content.text("High-explosive mortar cartridge, designed to be used against troops, light vehicles, light bunkers or similar targets.  This one is more modern version, more safe and more powerful, but uses more simple impact fuze."),
        },
    },
    mass = "1655 g",
    price = "600 USD",
    inheritance = {
        add = { projectile_effects = { "EXPLOSIVE_60mmHE2" } },
        remove = { projectile_effects = { "EXPLOSIVE_60mmHE" } },
    },
    ammunition = {},
}
