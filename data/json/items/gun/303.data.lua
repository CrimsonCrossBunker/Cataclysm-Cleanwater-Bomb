local ccb = require("ccb")

ccb.content.define_item {
    id = "smle_mk3",
    copy_from = "gun_base_rifle_manual",
    looks_like = "modular_ar15",
    name = ccb.content.text("Enfield battle rifle"),
    description = ccb.content.text("An iconic weapon of both the First and Second World Wars, this bolt-action rifle has seen deployment in the hands of Commonwealth troops across Europe and beyond.  Firing the .303-caliber cartridge and making use of 10-round Enfield magazines, the firearm's reputation precedes it."),
    variant_kind = "gun",
    variants = {
        {
            id = "smle_mk3",
            name = ccb.content.text("Lee-Enfield No. 1 Mk III rifle"),
            description = ccb.content.text("An English darling and icon of the First World War, the Short Magazine Lee-Enfield Mk III was the standard issue battle rifle of the British commonwealth from 1907.  Chambered for .303 ammunition, the rifle makes use of ten-round detachable magazines.  With its full-length wooden handguard, brass buttplate, and smooth action, the Lee-Enfield cuts a recognizable profile in either the trenches of the Great War or the zombie-strewn wastelands."),
        },
    },
    mass = "3960 g",
    volume = "3000 ml",
    length = "1132 mm",
    price = "573 USD 75 cent",
    survival_price = "30 USD",
    materials = { "steel", "wood" },
    pockets = { { kind = "MAGAZINE_WELL", allowed_items = { "enfield_303mag" } } },
    inheritance = { add = { flags = { "BOLT_ACTION" } } },
    gun = {
        barrel_length = "640 mm",
        ammunition = { "303" },
        dispersion = 170,
        mod_locations = {
            { id = "barrel", count = 1 },
            { id = "bayonet lug", count = 1 },
            { id = "mechanism", count = 2 },
            { id = "rail mount", count = 1 },
            { id = "sights mount", count = 1 },
            { id = "sling", count = 1 },
            { id = "stock accessory", count = 1 },
            { id = "stock mount", count = 1 },
            { id = "underbarrel mount", count = 1 },
        },
    },
}

ccb.content.define_item {
    id = "number4_mki",
    copy_from = "smle_mk3",
    looks_like = "modular_ar15",
    name = ccb.content.text("updated Enfield rifle"),
    description = ccb.content.text("An evolution of Britain's First World War battle rifle, this bolt-action firearm uses the same .303-caliber cartridge as its forerunner.  Much beloved across the globe by collectors, rifles like this served as England's infantry rifle well into the 1950s, with a specialized sniper variant remaining in service until the early nineties."),
    variant_kind = "gun",
    variants = {
        {
            id = "number4_mki",
            name = ccb.content.text("Lee-Enfield No. 4 Mk I rifle"),
            description = ccb.content.text("A Second World War progression of the British Commonwealth's Lee-Enfield battle rifle, the No. 4 began its decades-long service life in 1939.  Externally similar to its forefather, the rifle possesses a reinforced receiver, an adjusted nose cap, and a heavier barrel.  Still chambered for the same .303-caliber cartridge, the No. 4 represents one of the most populous firearm imports in U.S. history."),
        },
    },
    mass = "4110 g",
    length = "1129 mm",
    gun = { dispersion = 150 },
}
