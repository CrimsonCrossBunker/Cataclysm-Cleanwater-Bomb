local ccb = require("ccb")

-- 10 and 12-round magazines exist, but were made for the newer PMM, and are not compatible with the old PM.
ccb.content.define_item {
    id = "makarov",
    copy_from = "gun_base_handgun_semi",
    looks_like = "glock_17",
    name = ccb.content.text("Makarov pistol"),
    description = ccb.content.text("The Makarov was developed by the Soviet Union to replace the Red Army's obsolete WWII-era handguns.  It uses the 9x18mm cartridge, which remains in use among various former Soviet countries."),
    variant_kind = "gun",
    variants = {
        {
            id = "makarov",
            name = ccb.content.text("Makarov PM pistol"),
            description = ccb.content.text("A svelte, Cold War era handgun of Russian heritage, this former military pistol fires the Soviet 9x18mm cartridge.  Constructed completely out of steel components and experiencing relative popularity throughout eastern European countries, it was a favored backup weapon among USSR security forces, soldiers, and covert units."),
        },
    },
    mass = "730 g",
    volume = "346 ml",
    length = "196 mm",
    price = "250 USD",
    survival_price = "20 USD",
    materials = { "steel", "plastic" },
    weapon_categories = { "AUTOMATIC_PISTOLS" },
    pockets = { { magazine_well = "250 ml", kind = "MAGAZINE_WELL", allowed_items = { "makarovmag" } } },
    gun = {
        barrel_length = "94 mm",
        ammunition = { "9x18" },
        dispersion = 480,
        min_cycle_recoil = 270,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "stock mount", count = 1 },
        },
    },
}
