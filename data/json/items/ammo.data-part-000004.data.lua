local ccb = require("ccb")

-- ["about a dollar per kg of charcoal commercially. fetches $0.001 per chunk to survivors", "zero until price will be able to use sub cent price"]
-- 5 ml per chunk, .208 kg/liter for 1040mg per chunk to give it parity with coal, as 5mL charcoal is worth roughly 31kJ (1u of coal)
ccb.content.define_item {
    id = "charcoal",
    category = "spare_parts",
    price = "0 cent",
    survival_price = "0 cent",
    name = ccb.content.plural_text("charcoal", "charcoal"),
    display_type = "BY_WEIGHT",
    symbol = "=",
    color = "dark_gray",
    description = ccb.content.text("A flammable carbon-based material produced by slowly burning wood.  Utilized in recipes requiring a pure, hot flame.  Can also be used in filters to remove contaminants from air and water."),
    materials = { "charcoal" },
    phase = "solid",
    volume = "5 ml",
    mass = "1040 mg",
    stack_size = 1,
    ammunition = { type = "charcoal", count = 1 },
}

ccb.content.define_item {
    id = "carbon_electrode",
    category = "spare_parts",
    name = ccb.content.text("carbon electrode rod"),
    description = ccb.content.text("This carbon electrode is basically made from wood and sugar, and it actually works."),
    survival_price = "50 cent",
    materials = { "charcoal" },
    symbol = "=",
    color = "dark_gray",
    phase = "solid",
    volume = "50 ml",
    mass = "10 g",
    ammunition = { type = "charcoal" },
}

-- about a $0.15 per kg of coal commercially. fetches $0.001 per chunk to survivors
-- Density somewhere around 0.931 g/cm3 (bulk density of anthracite), roughly 31kJ per unit of coal
ccb.content.define_item {
    id = "coal_lump",
    category = "spare_parts",
    price = "5 cent",
    survival_price = "20 cent",
    name = ccb.content.plural_text("coal", "coal"),
    display_type = "BY_WEIGHT",
    symbol = "=",
    color = "dark_gray",
    description = ccb.content.text("Flammable black chunks of carbon-based material, commonly used for cooking and heating."),
    materials = { "coal" },
    phase = "solid",
    volume = "200 ml",
    mass = "931 mg",
    stack_size = 200,
    ammunition = { type = "coal", count = 1000 },
}

ccb.content.define_item {
    id = "albuterol",
    category = "drugs",
    name = ccb.content.plural_text("albuterol", "albuterol"),
    symbol = "=",
    color = "blue",
    description = ccb.content.text("A bronchodilator that relaxes muscles in the airways and increases air flow to the lungs."),
    materials = { "plastic" },
    volume = "1 ml",
    mass = "1 mg",
    flags = { "TRADER_AVOID" },
    phase = "gas",
    ammunition = { type = "albuterol" },
}

ccb.content.define_item {
    id = "ampoule",
    category = "drugs",
    price = "500 USD",
    survival_price = "50 USD",
    name = ccb.content.text("RA21E medical ampoule"),
    symbol = "=",
    color = "cyan",
    description = ccb.content.text("A tiny glass vial filled with advanced fast-healing chemicals which can only be activated by a Rivtech jet injector device.  The packaged instructions describe its efficacy in dealing with infections, wounds, intoxications, envenomations, and general tiredness in enthusiastic detail.  A short safety section at the end warns - in much smaller typeface - against using more than two doses per hour."),
    materials = { "glass" },
    volume = "250 ml",
    mass = "1 g",
    stack_size = 20,
    ammunition = { type = "ampoule", count = 2 },
}

ccb.content.define_item {
    id = "stimpack_ammo",
    category = "drugs",
    price = "300 USD",
    survival_price = "50 USD",
    name = ccb.content.text("RA10K stimulant module"),
    symbol = "=",
    color = "cyan",
    description = ccb.content.text("A pressurized multi-chamber glass vial filled with powerful chemical stimulants which can only be activated by a Rivtech stimulant delivery system."),
    materials = { "glass" },
    volume = "250 ml",
    mass = "1 g",
    stack_size = 10,
    ammunition = { type = "stimpack_ammo", count = 5 },
}

ccb.content.define_item {
    id = "liq_bandage",
    category = "drugs",
    price = "2 USD",
    survival_price = "40 cent",
    name = ccb.content.plural_text("liquid bandage", "liquid bandage"),
    symbol = "=",
    color = "white",
    description = ccb.content.text("A polymer dissolved in solvent, with antiseptic added, for topical treatment of minor cuts and scrapes."),
    materials = { "water" },
    volume = "10 ml",
    mass = "33 mg",
    phase = "liquid",
    ammunition = { count = 30, type = "liq_bandage" },
}

-- About 10 USD per kilogram in current prices.  Density is 2.48 g/cm3, rounded down to account for its granularity, weight is given per 1 minute of scrubbing
ccb.content.define_item {
    id = "rebreather_filler_soda_lime",
    category = "spare_parts",
    price = "13 cent",
    survival_price = "10 cent",
    name = ccb.content.plural_text("rebreather scrubbing filler", "rebreather scrubbing filler"),
    materials = { "powder_nonflam" },
    symbol = "=",
    color = "white",
    description = ccb.content.text("Granulated mixture of slaked lime, potassium hydroxide and/or sodium hydroxide that is used as CO2 scrubbing agent in rebreathers."),
    volume = "33 ml",
    mass = "13 g",
    ammunition = { type = "rebreather_filter", count = 1 },
}

-- Density is 2.14 g/cm3, rounded down to account for it being powder, weight is given per 1 minute of scrubbing
ccb.content.define_item {
    id = "rebreather_filler_ko2",
    category = "spare_parts",
    price = "24 cent",
    survival_price = "30 cent",
    name = ccb.content.plural_text("rebreather oxygen regenerator filler", "rebreather oxygen regenerator filler"),
    materials = { "powder" },
    symbol = "=",
    color = "white",
    description = ccb.content.text("Potassium superoxide powder, used as oxygen regenerating agent in rebreathers.  Keep away from water."),
    flags = { "WATER_DISSOLVE" },
    volume = "13 ml",
    mass = "6 g",
    ammunition = { type = "rebreather_o2_regenerator", count = 1 },
}

ccb.content.define_item {
    id = "gasfilter_s",
    category = "tool_magazine",
    materials = { "charcoal" },
    price = "1 cent",
    survival_price = "1 cent",
    name = ccb.content.text("filter mask cartridge"),
    symbol = "=",
    color = "light_gray",
    description = ccb.content.text("A small, replaceable filter cartridge for an air filtration mask."),
    volume = "1 ml",
    mass = "200 mg",
    ammunition = { type = "gasfilter_s", count = 1 },
}

-- Obviously, activated carbon isn't magically weightless, but it's used as ammunition within gas mask filters, and the filters shouldn't equally magically grow lighter as the coal binds with chemicals. Considering that this is never found beyond gas mask canisters, having zero weight should make no difference to the player.
ccb.content.define_item {
    id = "gasfilter_m",
    category = "tool_magazine",
    name = ccb.content.plural_text("activated carbon", "activated carbon"),
    description = ccb.content.text("A small amount of coal-derived carbon material with many small pores, used for the adsorption of harmful chemicals.  Most commonly employed within respirator filters, it traps and retains chemical gases and vapor contaminants while allowing filtered air to pass unhindered.  Once all the carbon has been bonded to intruding chemicals, the filter is expired and must be replaced."),
    volume = "1 ml",
    price = "1 cent",
    survival_price = "1 cent",
    symbol = "=",
    materials = { "charcoal" },
    color = "light_gray",
    flags = { "TRADER_AVOID", "ZERO_WEIGHT" },
    ammunition = { type = "gasfilter_m", count = 1 },
}

ccb.content.define_item {
    id = "nicotine_liquid",
    category = "drugs",
    price = "10 USD",
    survival_price = "5 USD",
    name = ccb.content.plural_text("nicotine liquid", "nicotine liquid"),
    symbol = "=",
    color = "yellow",
    description = ccb.content.text("Liquid made up of propylene glycol, vegetable glycerin, flavorings, and nicotine.  Intended for use in an advanced electronic cigarette."),
    phase = "liquid",
    volume = "30 ml",
    mass = "1 g",
    ammunition = { type = "components", count = 30 },
}

ccb.content.define_item {
    id = "fish_bait",
    category = "spare_parts",
    name = ccb.content.plural_text("fish bait", "fish bait"),
    description = ccb.content.text("A handful of bait, used in traps to lure fish."),
    mass = "1 g",
    volume = "250 ml",
    symbol = "=",
    color = "light_red",
    stack_size = 50,
    ammunition = { count = 20, type = "fish_bait" },
}

ccb.content.define_item {
    id = "spiked_rocket",
    price = "10 USD",
    survival_price = "1 USD",
    name = ccb.content.text("spiked homemade rocket"),
    symbol = ",",
    color = "dark_gray",
    description = ccb.content.text("A hand-built rocket, consisting of a spike welded onto a pipe filled with improvised rocket fuel.  Horribly inaccurate, as can be expected of this grade of weapon, but packs a fierce punch… if it hits."),
    materials = { "steel", "powder" },
    volume = "1500 ml",
    mass = "1510 g",
    ammunition = {
        type = "homebrew_rocket",
        damage = { type = "stab", amount = 40, penetration = 10 },
        range = 18,
        dispersion = 180,
        recoil = 130,
        effects = { "COOKOFF", "TRAIL" },
    },
}

ccb.content.define_item {
    id = "explosive_hm_rocket",
    price = "20 USD",
    survival_price = "1 USD",
    name = ccb.content.text("explosive homemade rocket"),
    symbol = ",",
    color = "dark_gray",
    description = ccb.content.text("A hand-built rocket, consisting of a simple explosive warhead attached onto a pipe, filled with improvised rocket fuel.  Not very powerful, but can be made from scratch."),
    materials = { "steel", "powder" },
    volume = "1250 ml",
    mass = "990 g",
    ammunition = {
        type = "homebrew_rocket",
        damage = { type = "stab", amount = 30, penetration = 10 },
        range = 23,
        dispersion = 170,
        recoil = 130,
        effects = { "SPECIAL_COOKOFF", "TRAIL", "EXPLOSIVE" },
    },
}

ccb.content.define_item {
    id = "incendiary_hm_rocket",
    price = "13 USD",
    survival_price = "1 USD",
    name = ccb.content.text("incendiary homemade rocket"),
    symbol = ",",
    color = "red",
    description = ccb.content.text("A hand-built rocket, consisting of a container of flammable gel attached onto a pipe, filled with improvised rocket fuel.  A short-range incendiary - handle with care!"),
    materials = { "steel", "powder" },
    volume = "1500 ml",
    mass = "1190 g",
    ammunition = {
        type = "homebrew_rocket",
        damage = { type = "stab", amount = 20 },
        range = 13,
        dispersion = 200,
        recoil = 130,
        effects = { "SPECIAL_COOKOFF", "TRAIL", "NAPALM" },
    },
}

ccb.content.define_item {
    id = "unfinished_charcoal",
    category = "spare_parts",
    price = "0 cent",
    survival_price = "0 cent",
    name = ccb.content.plural_text("unfinished charcoal", "unfinished charcoal"),
    symbol = "=",
    color = "brown",
    description = ccb.content.text("The result of an interrupted charcoal-making process.  Useless, except as fuel in a charcoal kiln."),
    materials = { "wood" },
    volume = "300 ml",
    mass = "250 g",
    ammunition = { type = "unfinished_char" },
}

ccb.content.define_item {
    id = "chain_link",
    category = "spare_parts",
    price = "1 USD 50 cent",
    survival_price = "50 cent",
    name = ccb.content.text("chain link"),
    symbol = "=",
    color = "light_gray",
    description = ccb.content.text("A set of small metal rings, suitable for constructing chainmail."),
    materials = { "iron" },
    volume = "250 ml",
    mass = "320 mg",
    ammunition = { type = "components", count = 425 },
}

ccb.content.define_item {
    id = "nitrox",
    category = "chems",
    price = "5 USD",
    survival_price = "2 USD 50 cent",
    name = ccb.content.plural_text("nitrox", "nitrox"),
    materials = { { id = "nitrogen", portions = 68 }, { id = "oxygen", portions = 32 } },
    symbol = "=",
    color = "white",
    sealed_container = false,
    description = ccb.content.text("A mixture of oxygen and nitrogen in proportions suitable for sustaining divers."),
    volume = "250 ml",
    mass = "1 g",
    phase = "gas",
    ammunition = { type = "nitrox" },
}

ccb.content.define_item {
    id = "extinguishing_agent",
    category = "chems",
    price = "5 USD",
    survival_price = "2 USD 50 cent",
    name = ccb.content.plural_text("extinguishing agent", "extinguishing agent"),
    symbol = "%",
    color = "white",
    sealed_container = false,
    description = ccb.content.text("A dry chemical solution effective at extinguishing fires."),
    volume = "250 ml",
    mass = "1 g",
    phase = "gas",
    ammunition = { type = "extinguishing_agent", count = 10 },
}

ccb.content.define_item {
    id = "teargas_spray",
    category = "chems",
    price = "5 USD",
    survival_price = "5 USD",
    name = ccb.content.plural_text("tear gas spray", "tear gas spray"),
    symbol = "%",
    color = "white",
    sealed_container = false,
    description = ccb.content.text("A noxious aerosolized irritant used to fend off attackers both human and bear alike."),
    volume = "250 ml",
    mass = "1 g",
    phase = "gas",
    ammunition = { type = "teargas_spray", count = 10 },
}

ccb.content.define_item {
    id = "tinder",
    category = "spare_parts",
    name = ccb.content.plural_text("tinder", "tinder"),
    description = ccb.content.text("Flammable material, finely divided for easy combustion."),
    mass = "10 g",
    volume = "250 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "wood" },
    flags = { "NO_SALVAGE", "TINDER" },
    symbol = "=",
    color = "brown",
    melee_damage = { bash = 1 },
    ammunition = { count = 50, type = "tinder" },
}
