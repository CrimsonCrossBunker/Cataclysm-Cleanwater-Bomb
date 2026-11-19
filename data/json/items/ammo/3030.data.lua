local ccb = require("ccb")

-- Based on https://www.federalpremium.com/rifle/power-shok/11-3030A.html
ccb.content.define_item {
    id = "3030",
    name = ccb.content.plural_text(".30-30 Winchester SP", ".30-30 Winchester SP"),
    description = ccb.content.text("A 150 grain Soft Point 30-30 Winchester round.  .30-30 Winchester is a common rifle round, being in use for hunting and recreation for over 100 years.  It holds the title of being the first non-military cartridge designed for smokeless powder, despite still using the old naming scheme for black powder cartridges."),
    ascii_picture = "4570_sp",
    mass = "35 g",
    volume = "117 ml",
    length = "65 mm",
    price = "2 USD",
    survival_price = "8 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "+",
    color = "green",
    stack_size = 20,
    ammunition = {
        count = 20,
        type = "3030",
        casing = "3030_casing",
        range = 26,
        damage = { type = "bullet", amount = 56 },
        dispersion = 60,
        recoil = 2580,
        effects = { "COOKOFF" },
    },
}

-- 30-30 can be reloaded with .308 bullets, so you could in theory do this.
ccb.content.define_item {
    id = "reloaded_3030_fmj",
    name = ccb.content.plural_text(".30-30 Winchester FMJ, reloaded", ".30-30 Winchester FMJ, reloaded"),
    description = ccb.content.text(".30-30 Winchester is a common rifle round, being in use for hunting and recreation for over 100 years.  It holds the title of being the first non-military cartridge designed for smokeless powder, despite still using the old naming scheme for black powder cartridges.  Despite FMJ rounds rarely being sold, 30-30 can accept .308 bullets and has been reloaded with such."),
    ascii_picture = "4570_sp",
    mass = "35 g",
    volume = "167 ml",
    length = "65 mm",
    price = "2 USD",
    survival_price = "8 USD",
    materials = { "brass", "lead", "powder" },
    symbol = "+",
    color = "green",
    stack_size = 20,
    ammunition = {
        count = 20,
        type = "3030",
        casing = "3030_casing",
        range = 26,
        damage = { type = "bullet", amount = 46, penetration = 9 },
        dispersion = 60,
        recoil = 2580,
        effects = { "COOKOFF", "RECYCLED" },
    },
}

ccb.content.define_item {
    id = "reloaded_3030",
    copy_from = "3030",
    name = ccb.content.plural_text(".30-30 Winchester SP, reloaded", ".30-30 Winchester SP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "reloaded_3030_bp",
    copy_from = "3030",
    name = ccb.content.plural_text(".30-30 Winchester SP, black powder", ".30-30 Winchester SP, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.3, recoil = 0.7, dispersion = 1.2, damage = { type = "bullet", amount = 0.7 } },
    },
    ammunition = { range = 18 },
}

ccb.content.define_item {
    id = "reloaded_3030_fmj_bp",
    copy_from = "reloaded_3030_fmj",
    name = ccb.content.plural_text(".30-30 Winchester FMJ, black powder", ".30-30 Winchester FMJ, black powder"),
    inheritance = {
        add = { projectile_effects = { "BLACKPOWDER" } },
        scale = {
            price = 0.3,
            recoil = 0.7,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.77, penetration = 0.5 },
        },
    },
    ammunition = { range = 18 },
}
