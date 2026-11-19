local ccb = require("ccb")

ccb.content.define_item {
    id = "gasfilter_sm",
    category = "tool_magazine",
    name = ccb.content.text("filter mask cartridge"),
    description = ccb.content.text("A small-sized, replaceable filter cartridge for an air filtration mask."),
    mass = "2 g",
    volume = "250 ml",
    survival_price = "3 USD 75 cent",
    materials = { "plastic", "rubber", "charcoal" },
    symbol = "=",
    color = "yellow",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "GASFILTER_SM" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { gasfilter_s = 100 } } },
    magazine = { ammunition = { "gasfilter_s" }, count = 100, capacity = 100 },
}

-- Statistics modelled after https://www.avon-protection.com/media/cttpaix4/avon-protection_cbrncf50-ce-filter_data-sheet_en.pdf
-- Intended to simulate a standard, CBRN-rated filter cartridge with a 40mm NATO thread.
-- As it turns out, protecting your lungs from sucking down toxins is expensive.
ccb.content.define_item {
    id = "gasfilter_med",
    category = "tool_magazine",
    name = ccb.content.text("CBRN filter canister"),
    description = ccb.content.text("A cylindrical, black-finished filter canister packed with charcoal retained between dual particulate membranes, rated to protect against chemical weapons, nerve agents, biological contaminants, radioactive dust, and all manner of other unpleasant vapors or particles.  That is, though, only if you screw it into an appropriate respirator before hand and the charcoal isn't expired."),
    mass = "365 g",
    volume = "910 ml",
    length = "111 mm",
    price = "82 USD",
    survival_price = "1 USD 50 cent",
    materials = { "plastic", "rubber", "charcoal" },
    symbol = "=",
    color = "dark_gray",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "GASFILTER_MED" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { gasfilter_m = 100 } } },
    magazine = { ammunition = { "gasfilter_m" }, count = 100, capacity = 100 },
}

ccb.content.define_item {
    id = "rebreather_cartridge_air",
    category = "tool_magazine",
    name = ccb.content.plural_text("rebreather scrubber cartridge, air tank", "rebreather scrubber cartridges, air tanks"),
    price = "85 USD",
    survival_price = "10 USD",
    symbol = "=",
    color = "light_gray",
    description = ccb.content.text("A replaceable CO2 scrubber cartridge for a rebreather, coupled with a 3 L pressurized tank.  This one has its tank filled with atmospheric air."),
    materials = { "aluminum", "rubber", "steel" },
    volume = "6500 ml",
    mass = "5500 g",
    flags = { "NO_SALVAGE", "NO_RELOAD", "REBREATHER_CART" },
    pockets = {
        {
            kind = "MAGAZINE",
            watertight = true,
            rigid = true,
            ammunition = { rebreather_filter = 90 },
        },
    },
    magazine = { ammunition = { "rebreather_filter" } },
}

ccb.content.define_item {
    id = "rebreather_cartridge_o2",
    category = "tool_magazine",
    name = ccb.content.plural_text("rebreather scrubber cartridge, oxygen tank", "rebreather scrubber cartridges, oxygen tanks"),
    price = "85 USD",
    survival_price = "10 USD",
    symbol = "=",
    color = "light_gray",
    description = ccb.content.text("A replaceable CO2 scrubber cartridge for a rebreather, coupled with a 3 L pressurized tank.  This one has its tank filled with oxygen."),
    materials = { "aluminum", "rubber", "steel" },
    volume = "6500 ml",
    mass = "5500 g",
    flags = { "NO_SALVAGE", "NO_RELOAD", "REBREATHER_CART" },
    pockets = {
        {
            kind = "MAGAZINE",
            watertight = true,
            rigid = true,
            ammunition = { rebreather_filter = 180 },
        },
    },
    magazine = { ammunition = { "rebreather_filter" } },
}

ccb.content.define_item {
    id = "rebreather_cartridge_regen",
    category = "tool_magazine",
    name = ccb.content.text("rebreather oxygen regenerator cartridge"),
    price = "85 USD",
    survival_price = "10 USD",
    symbol = "=",
    color = "light_gray",
    description = ccb.content.text("A replaceable oxygen regenerator cartridge for a rebreather."),
    materials = { "rubber", "steel" },
    volume = "2000 ml",
    mass = "1000 g",
    flags = { "NO_SALVAGE", "NO_RELOAD", "REBREATHER_CART" },
    pockets = {
        {
            kind = "MAGAZINE",
            watertight = true,
            rigid = true,
            ammunition = { rebreather_o2_regenerator = 360 },
        },
    },
    magazine = { ammunition = { "rebreather_o2_regenerator" } },
}
