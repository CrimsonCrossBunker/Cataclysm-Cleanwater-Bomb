local ccb = require("ccb")

-- Setting battery volume to 0 causes weirdness in vehicle tests.  Please don't do that.
-- 1 battery is 1 kJ of energy. 40 batteries is an alkaline C-cell.
ccb.content.define_item {
    id = "battery",
    category = "spare_parts",
    price = "120 USD",
    survival_price = "2 cent",
    name = ccb.content.plural_text("battery", "battery"),
    symbol = "=",
    color = "yellow",
    description = ccb.content.text("Some free-floating battery charge.  It can be reloaded into rechargeable battery cells, but can never be unloaded."),
    flags = { "TRADER_AVOID", "ZERO_WEIGHT", "NO_DROP" },
    materials = { "battery" },
    volume = "100 ml",
    ammunition = { effects = { "COOKOFF" }, type = "battery", count = 100 },
}

-- liquid butane has a density of 573 mg per ml
ccb.content.define_item {
    id = "butane",
    name = ccb.content.plural_text("butane", "butane"),
    symbol = "~",
    description = ccb.content.text("A common flammable liquid, used in lighters."),
    volume = "1 ml",
    mass = "573 mg",
    color = "white",
    flags = { "TRADER_AVOID" },
    phase = "liquid",
    ammunition = { type = "butane" },
}

ccb.content.define_item {
    id = "notch",
    name = ccb.content.plural_text("notch", "notches"),
    symbol = "v",
    description = ccb.content.text("A notch used with a fire drill to create an ember."),
    volume = "1 ml",
    mass = "1 mg",
    color = "brown",
    flags = { "TRADER_AVOID", "NO_DROP" },
    phase = "solid",
    ammunition = { type = "notch" },
}

ccb.content.define_item {
    id = "aerosol_paint",
    name = ccb.content.plural_text("aerosol paint", "aerosol paint"),
    symbol = "~",
    description = ccb.content.text("Paint that comes in a sealed, pressurized container and is released in an aerosol spray when a valve button is depressed."),
    volume = "1 ml",
    mass = "1 mg",
    color = "white",
    flags = { "TRADER_AVOID" },
    phase = "liquid",
    ammunition = { type = "aerosol_paint" },
}

ccb.content.define_item {
    id = "permanent_ink",
    name = ccb.content.plural_text("permanent ink", "permanent ink"),
    symbol = "~",
    description = ccb.content.text("Ink comprised of a main carrier solvent, a glyceride, a pyrrolidone, a resin, and a colorant, making it water resistant."),
    volume = "1 ml",
    mass = "1 mg",
    color = "white",
    flags = { "TRADER_AVOID" },
    phase = "liquid",
    ammunition = { type = "permanent_ink" },
}

ccb.content.define_item {
    id = "candle_wax",
    name = ccb.content.plural_text("candle wax", "candle wax"),
    symbol = "~",
    description = ccb.content.text("A solid flammable substance, used to make candles."),
    volume = "1 ml",
    mass = "1 mg",
    color = "white",
    flags = { "TRADER_AVOID" },
    ammunition = { type = "candle_wax" },
}

ccb.content.define_item {
    id = "flare_nitrate",
    name = ccb.content.plural_text("flare pyrotechnic", "flare pyrotechnic"),
    symbol = "~",
    description = ccb.content.text("A pyrotechnic chemical used in flares."),
    volume = "1 ml",
    mass = "1 mg",
    color = "white",
    flags = { "TRADER_AVOID" },
    ammunition = { type = "flare_nitrate" },
}
