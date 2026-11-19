local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "40x46mm_grenade",
    abstract = true,
    name = ccb.content.text_without_extraction("40x46mm grenade"),
    volume = "129 ml",
    mass = "230 g",
    length = "99 mm",
    price = "100 USD",
    survival_price = "60 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "steel", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 1,
    ammunition = {
        count = 6,
        type = "40x46mm",
        range = 60,
        dispersion = 30,
        recoil = 1400,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "40x46mm_m1006",
    copy_from = "40x46mm_grenade",
    name = ccb.content.plural_text("40x46mm M1006 sponge", "40x46mm M1006 sponge"),
    description = ccb.content.text("A low velocity less-lethal 40x46mm round with a foam and plastic projectile intended to cause pain and disorientation to the target.  May still injure or kill."),
    ascii_picture = "40x46mm_m1006",
    price = "23 USD",
    survival_price = "5 cent",
    mass = "68 g",
    inheritance = { add = { projectile_effects = { "LARGE_BEANBAG", "NO_PENETRATE_OBSTACLES" } } },
    ammunition = { damage = { type = "bullet", amount = 10 }, casing = "40x46mm_m212_casing" },
}

ccb.content.define_item {
    id = "40x46mm_m433",
    copy_from = "40x46mm_grenade",
    name = ccb.content.plural_text("40x46mm M433 HEDP", "40x46mm M433 HEDP"),
    description = ccb.content.text("A low velocity 40x46mm high explosive dual-purpose grenade.  It can penetrate 2 inches of steel armor, and the fragmentation of the projectile body also makes it suitable for use against infantry."),
    ascii_picture = "40x46mm_m433",
    inheritance = { add = { projectile_effects = { "EXPLOSIVE_m433" } } },
    ammunition = { damage = { type = "bullet", amount = 200, penetration = 30 }, casing = "40x46mm_m118_casing" },
}

ccb.content.define_item {
    id = "40x46mm_m576",
    copy_from = "40x46mm_grenade",
    name = ccb.content.plural_text("40x46mm M576 buckshot", "40x46mm M576 buckshot"),
    description = ccb.content.text("A 40x46mm buckshot load, designed for use in thick vegetation or room clearing.  Due to the limitations of weapons built to fire 40x46mm grenades, it's much less powerful than you'd expect."),
    ascii_picture = "40x46mm_m576",
    mass = "120 g",
    inheritance = { add = { projectile_effects = { "SHOT", "NOGIB" } } },
    ammunition = {
        range = 12,
        damage = { type = "bullet", amount = 30 },
        shot_damage = { type = "bullet", amount = 7 },
        projectile_count = 20,
        shot_spread = 500,
        recoil = 900,
        casing = "40x46mm_m199_casing",
    },
}

ccb.content.define_item {
    id = "40x46mm_m651",
    copy_from = "40x46mm_grenade",
    name = ccb.content.plural_text("40x46mm M651 tear gas", "40x46mm M651 tear gas"),
    description = ccb.content.text("A low velocity 40x46mm tear gas canister.  It is effective for riot control and driving infantry from entrenched positions, and is able to penetrate thin wood."),
    ascii_picture = "40x46mm_m651",
    mass = "290 g",
    inheritance = { add = { projectile_effects = { "NO_EMBED" } } },
    ammunition = {
        damage = { type = "bullet", amount = 24 },
        drop = "gasbomb_act",
        casing = "40x46mm_m195_casing",
    },
}

ccb.content.define_item {
    id = "40x46mm_hornets_nest_22lr",
    copy_from = "40x46mm_grenade",
    name = ccb.content.plural_text("40x46mm .22 LR beehive", "40x46mm .22 LR beehive"),
    description = ccb.content.text("A set of ten .22 LR bullets compressed into a 40mm adapter.  Fires all ten rounds simultaneously."),
    mass = "114 g",
    price = "15 USD",
    survival_price = "24 USD",
    materials = { "aluminum", "brass", "lead", "powder" },
    inheritance = { scale = { dispersion = 1.8 } },
    ammunition = {
        damage = { type = "bullet", amount = 100 },
        shot_damage = { type = "bullet", amount = 10 },
        projectile_count = 10,
        shot_spread = 1,
        casing = "40x46mm_hornets_nest_22lr_casing",
    },
}

-- 5in bbl, therefore 4x23 damage per 410 bbti.  The launcher's bbl can't contribute to velocity, so the bbl length that really matters is the adapter's.
ccb.content.define_item {
    id = "40x46mm_hornets_nest_410",
    copy_from = "40x46mm_grenade",
    name = ccb.content.plural_text("40x46mm .410 hornet's nest", "40x46mm .410 hornet's nest"),
    description = ccb.content.text("A set of four .410 000 shotshells and a large pistol primer loaded into a 40mm adapter.  Fires all four rounds at once with an internal firing assembly, which is set off by the primer."),
    mass = "245 g",
    price = "7 USD 10 cent",
    survival_price = "32 USD 40 cent",
    materials = { "aluminum", "brass", "lead", "powder" },
    inheritance = { scale = { dispersion = 1.4 } },
    ammunition = {
        damage = { type = "bullet", amount = 92 },
        shot_damage = { type = "bullet", amount = 10 },
        projectile_count = 20,
        shot_spread = 300,
        casing = "40x46mm_hornets_nest_410_casing",
    },
}

-- 5in bbl, therefore 4x22 damage per 410 bbti.  The launcher's bbl can't contribute to velocity, so the bbl length that really matters is the adapter's.
ccb.content.define_item {
    id = "40x46mm_hornets_nest_410_slug",
    copy_from = "40x46mm_grenade",
    name = ccb.content.plural_text("40x46mm .410 slug's nest", "40x46mm .410 slug's nest"),
    description = ccb.content.text("A set of four .410 slug shells and a large pistol primer loaded into a 40mm adapter.  Fires all four rounds at once with an internal firing assembly, which is set off by the primer."),
    mass = "245 g",
    price = "7 USD 10 cent",
    survival_price = "32 USD 40 cent",
    materials = { "aluminum", "brass", "lead", "powder" },
    inheritance = { scale = { dispersion = 1.4 } },
    ammunition = {
        damage = { type = "bullet", amount = 88 },
        shot_damage = { type = "bullet", amount = 22 },
        projectile_count = 4,
        shot_spread = 1,
        casing = "40x46mm_hornets_nest_410_casing",
    },
}

-- 5in bbl, therefore 4x21 damage per  410 bbti.  The launcher's bbl can't contribute to velocity, so the bbl length that really matters is the adapter's.
ccb.content.define_item {
    id = "40x46mm_hornets_nest_410_bird",
    copy_from = "40x46mm_grenade",
    name = ccb.content.plural_text("40x46mm .410 bird's nest", "40x46mm .410 bird's nest"),
    description = ccb.content.text("A set of four .410 birdshot shells and a large pistol primer loaded into a 40mm adapter.  Fires all four rounds at once with an internal firing assembly, which is set off by the primer."),
    mass = "245 g",
    price = "7 USD 10 cent",
    survival_price = "32 USD 40 cent",
    materials = { "aluminum", "brass", "lead", "powder" },
    inheritance = { scale = { dispersion = 1.4 } },
    ammunition = {
        damage = { type = "bullet", amount = 84 },
        shot_damage = { type = "bullet", amount = 0.2 },
        projectile_count = 528,
        shot_spread = 300,
        casing = "40x46mm_hornets_nest_410_casing",
    },
}

ccb.content.define_item {
    id = "40x46mm_hornets_nest_410_scrap",
    copy_from = "40x46mm_hornets_nest_410",
    name = ccb.content.plural_text("40x46mm .410 scrap nest", "40x46mm .410 scrap nest"),
    description = ccb.content.text("A set of four .410 'scrap-shot' shells and a large pistol primer loaded into a 40mm adapter.  Fires all four rounds at once with an internal firing assembly, which is set off by the primer."),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        scale = {
            price = 0.4,
            survival_price = 0.4,
            shot_spread = 1.2,
            damage = { type = "bullet", amount = 0.6 },
        },
    },
    ammunition = {},
}
