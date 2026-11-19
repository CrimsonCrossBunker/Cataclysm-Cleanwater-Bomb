local ccb = require("ccb")

ccb.content.define_item {
    id = "m202_flash",
    looks_like = "m79",
    symbol = "(",
    color = "dark_gray",
    name = ccb.content.plural_text("M74 rocket launcher", "M74 rocket launcher"),
    description = ccb.content.text("An American rocket launcher designed in the 1970s to replace WWII-era flamethrowers still in use in Vietnam.  It has four barrels sharing the 66mm caliber of the M72 LAW."),
    variant_kind = "gun",
    variants = {
        {
            id = "m202_flash",
            name = ccb.content.plural_text("M202A1 FLASH", "M202A1 FLASH"),
            description = ccb.content.text("An American rocket launcher designed in the 1970s to replace WWII-era flamethrowers still in use in Vietnam.  It has four barrels sharing the 66mm caliber of the M72 LAW."),
        },
    },
    price = "29 kUSD",
    survival_price = "40 USD",
    materials = { "steel" },
    mass = "5220 g",
    volume = "12120 ml",
    length = "693 mm",
    accuracy = -3,
    flags = { "BACKBLAST", "NEVER_JAMS" },
    pockets = { { magazine_well = "500 ml", kind = "MAGAZINE_WELL", allowed_items = { "m74_clip" } } },
    melee_damage = { bash = 12 },
    gun = {
        skill = "launcher",
        ammunition = { "m235" },
        reload_noise_volume = 10,
        dispersion = 300,
        durability = 7,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("single shot"), quantity = 1 },
            { id = "BURST", label = ccb.content.text("all barrels"), quantity = 4 },
        },
        reload_time = 600,
        loudness = 200,
        mod_locations = { { id = "sling", count = 1 } },
    },
}
