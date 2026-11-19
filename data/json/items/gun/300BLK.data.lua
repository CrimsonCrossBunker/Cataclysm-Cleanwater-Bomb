local ccb = require("ccb")

-- This is the unfolded version of the weapon. Folded, it's 597 mm
ccb.content.define_item {
    id = "sig_mcx_rattler_sbr",
    copy_from = "gun_base_rifle_semi",
    looks_like = "modular_ar15",
    name = ccb.content.text("SIG MCX Rattler SBR"),
    description = ccb.content.text("A gas-operated rifle, with a short 5.5 inch barrel, built-in thin folding stock, and full rail mount on the upper receiver.  This particular one is a select-fire military version."),
    mass = "2590 g",
    volume = "2850 ml",
    length = "775 mm",
    price = "2 kUSD 719 USD",
    survival_price = "35 USD",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            allowed_items = {
                "stanag30", "stanag5", "stanag5ranger", "stanag10", "stanag10ranger", "stanag20",
                "stanag20ranger", "stanag30ranger", "stanag40", "stanag50", "stanag60", "stanag60drum",
                "stanag90", "stanag100", "stanag100drum", "stanag150", "survivor223mag",
            },
        },
    },
    gun = {
        barrel_length = "140 mm",
        ammunition = { "300blk" },
        dispersion = 160,
        min_cycle_recoil = 1700,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 750 },
        },
        built_in_mods = { "folding_stock" },
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "brass catcher", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "muzzle", count = 1 },
            { id = "rail", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock", count = 1 },
        },
    },
}
