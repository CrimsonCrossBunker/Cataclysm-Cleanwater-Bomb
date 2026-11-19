local ccb = require("ccb")

ccb.content.define_item {
    id = "type99",
    copy_from = "gun_base_rifle_manual",
    looks_like = "modular_ar15",
    name = ccb.content.text("7.7mm battle rifle"),
    description = ccb.content.text("A stout and rugged battle rifle that traces its origins to the hands of imperial Japanese forces and saw extensive use in the Pacific theatre of the Second World War, this bolt-action firearm shoots the 7.7x58mm Arisaka cartridge.  Powerful, dependable, and elegantly built, Japan's 20th-century infantry rifle may yet find service guarding the lives of her former enemies."),
    variant_kind = "gun",
    variants = {
        {
            id = "type99",
            name = ccb.content.text("Arisaka Type 99 rifle"),
            description = ccb.content.text("The standard service arm of the imperial Japanese army during the Second World War, chambered for the powerful 7.7x58mm cartridge and built to replace the weaker Type 38, the Type 99 is a sturdy and formidable bolt-action rifle with a Mauser-inspired action renowned for its strength.  Though the rifle was historically sneered at in the US due to extensive anti-Japanese propaganda and the lower quality of later-production guns, the weapon is, by most metrics, a finely produced and effective shoulder arm.  This particular Arisaka is an early-war example with anti-aircraft sights and an intact 6-petal chrysanthemum seal."),
            weight = 1,
        },
        {
            id = "type99ld",
            name = ccb.content.text("Arisaka Type 99 rifle"),
            description = ccb.content.text("Standing as a clear example of what happens when a country losing a war realizes that it's running out of resources and its rifles are ripe for corner-cutting, this Type 99 Arisaka, the standard service arm of imperial Japan from 1939, is a crewed end-of-war example.  Coated in machining marks, lacking an upper handguard, and with the early production anti-aircraft sights long since done away with, where early production Arisaka rifles are a feat in elegant engineering, this one is a last-ditch bang stick hammered together in a mostly bombed-out factory.  Aesthetics not withstanding, this weapon is still an effective and powerful shoulder arm, just… not the prettiest."),
        },
    },
    mass = "3790 g",
    volume = "2680 ml",
    length = "1118 mm",
    price = "650 USD",
    survival_price = "18 USD 50 cent",
    materials = { "steel", "wood" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ["77mm_arisaka"] = 5 },
            allowed_speedloaders = { "clip_77mm_arisaka" },
        },
    },
    inheritance = { add = { flags = { "BOLT_ACTION" } } },
    gun = {
        barrel_length = "657 mm",
        ammunition = { "77mm_arisaka" },
        dispersion = 150,
        clip_size = 5,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bayonet lug", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}

-- The only reason this exists as its own item rather than a variant of the Type 99 is so players wouldn't be able to mount the scope on normal Type 99 rifles and could only use it on the 99 Sniper.
ccb.content.define_item {
    id = "type99_sniper",
    copy_from = "type99",
    name = ccb.content.text("7.7mm sniper rifle"),
    description = ccb.content.text("A precision weapon issued to Japanese forces part way through the Second World War and proving to be little more than an off-the-rack 7.7mm battle rifle fitted with a telescopic sight, the rifle, despite being only marginally different from its closer-range cohorts, was a formidable implement upon the battle fields of the Pacific theatre."),
    variant_kind = "gun",
    variants = {
        {
            id = "type99_sniper",
            name = ccb.content.text("Arisaka Type 99 sniper rifle"),
            description = ccb.content.text("The standard sniper's weapon of Imperial Japan, this rifle is essentially an early production Type 99 Arisaka fitted with an offset optical sight and a bent bolt handle to facilitate stripper clip loading and easy manipulation despite the scope's presence.  While its 7.7x58mm chambering resulted in a muzzle flash and report that were significantly greater than those of the Type 97, which it sought to replace, the rifle's man-stopping potential is nothing to be trifled with."),
            weight = 1,
        },
    },
    gun = { built_in_mods = { "type99_scope" } },
}
