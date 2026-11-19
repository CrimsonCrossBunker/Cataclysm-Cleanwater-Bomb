local ccb = require("ccb")

ccb.content.define_item {
    id = "ruger_arr",
    copy_from = "gun_base_rifle_manual",
    looks_like = "modular_ar15",
    name = ccb.content.text("Ruger American Ranch Rifle"),
    description = ccb.content.text("A compact, magazine-fed, bolt-action hunting rifle designed and manufactured with cost-effectiveness at the peak of concerns, the Ruger American Ranch Rifle series caters to shooters on a budget.  Factory chambered for the powerful, though short-range, .450 Bushmaster cartridge, the weapon was able to stand toe-to-toe with all native North American game despite its minimalist design."),
    mass = "2495 g",
    volume = "2500 ml",
    length = "914 mm",
    price = "669 USD",
    survival_price = "20 USD",
    materials = { "aluminum", "steel", "plastic" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "ruger_arr_mag" } } },
    inheritance = { add = { flags = { "BOLT_ACTION" } } },
    gun = {
        barrel_length = "409 mm",
        ammunition = { "450" },
        dispersion = 120,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}
