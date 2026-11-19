local ccb = require("ccb")

ccb.content.define_item {
    id = "bfg50",
    copy_from = "gun_base_rifle_manual",
    looks_like = "m107a1",
    name = ccb.content.text("single-shot .50-caliber rifle"),
    description = ccb.content.text("Relatively trim as far as .50-caliber rifles go, this single-shot firearm was a reasonably affordable entry-level gun for civilians wishing to play with some very large, very punchy toys.  Now, at the world's Armageddon, it would be wise to make that singular round-capacity count on some high-priority craniums."),
    variant_kind = "gun",
    variants = {
        {
            id = "bfg50",
            name = ccb.content.plural_text("Serbu BFG-50", "Serbu BFG-50"),
            description = ccb.content.text("A single-shot, bolt-action rifle made by Serbu Firearms, the BFG-50 was a very affordable firearm for those wishing to shoot .50 BMG."),
        },
    },
    mass = "8500 g",
    volume = "4000 ml",
    length = "1315 mm",
    price = "2 kUSD 395 USD",
    survival_price = "90 USD",
    materials = { "steel" },
    flags = { "RELOAD_EJECT", "EASY_CLEAN", "NO_TURRET" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["50"] = 1 } } },
    gun = {
        barrel_length = "749 mm",
        range = 45,
        ammunition = { "50" },
        damage = { type = "bullet", amount = -5 },
        dispersion = 110,
        barrel_volume = "1250 ml",
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
        default_mods = { "rifle_scope" },
        built_in_mods = { "bipod", "muzzle_brake" },
        clip_size = 1,
    },
}

-- The size calculations are taken from a CZ 600 with a half-extended buttstock, sitting at 790 mm, between the minimum and maximum of 690 and 890 mm. In addition, the length of a 16-inch barrel has been deducted and will be made up for by the installable barrel assemblies.
-- This should be removed once vehicle turrets are capable of mounting guns with mods attached. As it stands, trying to mount this style of weapon would require the player to remove the conversion kit, thus rendering it unusable anyhow.
ccb.content.define_item {
    id = "cz600",
    copy_from = "gun_base_rifle_manual",
    looks_like = "modular_ar15",
    name = ccb.content.text("bolt-action trail carbine"),
    description = ccb.content.text("Compact, svelte, and lightweight, this Leen bolt-action rifle packs the same features of larger sporting weapons into a backpack-sized package.  Possessing an adjustable buttstock, a detachable magazine-based system, and a quick-swap barrel that can be exchanged to accommodate the firing of .223 Remington or 7.62x39mm Soviet ammunition, the weapon is a commendable backpacker or prepper rifle."),
    variant_kind = "gun",
    variants = {
        {
            id = "cz600",
            name = ccb.content.text("CZ 600 TRAIL rifle"),
            description = ccb.content.text("A handy bolt-action offering from CZ, the 600 Trail is a box magazine-fed ranch rifle that utilizes an aluminum chassis to keep its overall heft to a minimum.  Possessing an extendable buttstock, extensive modularity, and a quick-swap barrel assembly switchable to accommodate the firing of either .223 or 7.62x39mm ammunition, the rifle was intended for use by backpackers, trail hikers, and preppers."),
        },
    },
    mass = "1800 g",
    volume = "2500 ml",
    length = "384 mm",
    price = "1 kUSD 155 USD",
    survival_price = "40 USD",
    materials = { "aluminum", "steel", "plastic" },
    symbol = "(",
    color = "dark_gray",
    flags = { "NO_TURRET", "EASY_CLEAN" },
    gun = {
        ammunition = { "NULL" },
        dispersion = 150,
        built_in_mods = { "adjustable_stock" },
        mod_locations = {
            { id = "bore", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail", count = 2 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 2 },
            { id = "stock", count = 1 },
        },
    },
}
