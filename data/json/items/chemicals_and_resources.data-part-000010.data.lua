local ccb = require("ccb")

-- For sanity, make each unit of this equivalent to 1 unit (0.01 mole) of chem_carbide
-- 1 mole CaO equiv. of quicklime: 56.0774g, 16.78ml if solid chunk
-- 3 moles C equiv. of coal_lump (anthracite, 90% carbon): (3×12.011/0.9) = 40.03667g, 26.69ml if solid chunk
-- 56.0774 + 40.0367 = 96.1141g (100 units); 16.78 + 26.69 = 43.47ml, round to 50 due to powder form
ccb.content.define_item {
    id = "cac2powder",
    category = "chems",
    price = "2 USD",
    survival_price = "5 USD",
    name = ccb.content.plural_text("calcium carbide premix powder", "calcium carbide premix powder"),
    symbol = "=",
    color = "dark_gray",
    description = ccb.content.text("A powdered mixture of coke and lime ready to be smelted into usable calcium carbide in an arc furnace."),
    materials = { "powder_nonflam" },
    phase = "solid",
    volume = "50 ml",
    mass = "961 mg",
    stackable = true,
    ammunition = { type = "components", count = 100 },
}

-- base density of 1.33g/ml and energy of ~40kJ per unit
-- hexamine tablets sold commercially for 13 usd per 216 grams (162u)
ccb.content.define_item {
    id = "chem_hexamine",
    category = "chems",
    price = "20 USD",
    survival_price = "1 USD",
    name = ccb.content.plural_text("hexamine wax", "hexamine wax"),
    symbol = "=",
    color = "red",
    description = ccb.content.text("A handful of waxy hexamine tablets which could be broken up into smaller crumbs if needed.  This ubiquitous fuel was used to start up almost every garden grill, and no 'real' camping trip could do its cooking without it, until the Cataclysm.  Nowadays, it is even more valuable than before, being the key component in the preparation of several military-grade explosives."),
    materials = { "powder" },
    volume = "200 ml",
    mass = "1330 mg",
    default_container = "box_small",
    stack_size = 200,
    stackable = true,
    ammunition = { type = "esbit", count = 1620 },
}

ccb.content.define_item {
    id = "chem_hydrogen_peroxide_conc",
    category = "chems",
    price = "10 USD",
    survival_price = "1 USD",
    name = ccb.content.plural_text("liquid hydrogen peroxide (concentrated)", "liquid hydrogen peroxide (concentrated)"),
    symbol = "~",
    color = "white",
    description = ccb.content.text("Concentrated hydrogen peroxide is a powerful oxidant, violently decomposing in contact with most reducing agents.  Can be used as rocket fuel or to make high explosives.  Causes severe burns to any organic matter and may ignite it on contact."),
    volume = "250 ml",
    mass = "325 g",
    phase = "liquid",
    default_container = "bottle_glass",
    display_type = "BY_VOLUME",
    ammunition = { type = "components" },
}

ccb.content.define_item {
    id = "chem_acetic_acid",
    category = "chems",
    price = "2 USD",
    survival_price = "1 USD",
    name = ccb.content.plural_text("acetic acid", "acetic acid"),
    symbol = "~",
    color = "white",
    description = ccb.content.text("Concentrated acetic acid, typically used as a chemical reagent and antifungal agent.  Despite its horrid smell, it was used to prepare several types of perfumes, but would making perfume not be too fancy for post-apocalyptic New England?"),
    volume = "250 ml",
    mass = "262 g",
    materials = { "acid" },
    phase = "liquid",
    default_container = "bottle_glass",
    display_type = "BY_VOLUME",
    ammunition = { type = "components" },
}

ccb.content.define_item {
    id = "chem_formaldehyde",
    category = "chems",
    price = "2 USD",
    survival_price = "1 USD",
    name = ccb.content.plural_text("formaldehyde", "formaldehyde"),
    symbol = "~",
    color = "white",
    description = ccb.content.text("Formaldehyde, here dissolved in water, was widely used before the Cataclysm as a precursor to production of many chemicals and materials and as an embalming agent.  Easily identifiable by its pungent odor.  Terribly toxic, carcinogenic, and volatile."),
    volume = "250 ml",
    mass = "300 g",
    phase = "liquid",
    default_container = "bottle_glass",
    display_type = "BY_VOLUME",
    ammunition = { type = "components" },
}
