local ccb = require("ccb")

ccb.content.define_item {
    id = "anesthetic",
    name = ccb.content.plural_text("anesthetic", "anesthetic"),
    category = "chems",
    description = ccb.content.text("A variety of powerful hypnotic, analgesic, and stimulative drugs.  It's intended for use in specialized medical equipment, and can't be administered manually.  You can reload an anesthesia kit with it."),
    mass = "714 mg",
    volume = "540 ml",
    price = "83 USD 33 cent",
    survival_price = "30 USD",
    phase = "liquid",
    default_container = "jar_3l_glass_sealed",
    sealed_container = false,
    symbol = "!",
    color = "cyan",
    looks_like = "ether",
    display_type = "BY_VOLUME",
    ammunition = { type = "anesthetic", count = 420 },
}

-- Right now, it's just used in a quest, and should not spawn naturally.
ccb.content.define_item {
    id = "fert_supplement",
    name = ccb.content.plural_text("fertility supplement", "fertility supplement"),
    flags = { "EDIBLE_FROZEN", "WATER_DISSOLVE", "NO_INGEST", "MISSION_ITEM" },
    mass = "1 g",
    color = "pink",
    default_container = "bottle_plastic_pill_supplement",
    symbol = "%",
    description = ccb.content.text("A pill for those looking to have children.  It is of no use to you."),
    price = "1 cent",
    volume = "10 ml",
    display_type = "BY_WEIGHT",
    stackable = true,
    comestible = { kind = "FOOD", calories = 10 },
}

-- Due to change of volume to 1ml from 125, price per unit is now less  then 1 cent, i found the price of a 3.5L of bleach to be roughly $7.50
ccb.content.define_item {
    id = "bleach",
    name = ccb.content.plural_text("bleach", "bleach"),
    mass = "1 g",
    color = "white",
    flags = { "CORROSIVE", "NUTRIENT_OVERRIDE" },
    default_container = "jug_plastic",
    sealed_container = false,
    symbol = "~",
    description = ccb.content.text("Sodium hypochlorite, a common household cleaning agent."),
    price = "0 cent",
    survival_price = "0 cent",
    volume = "1 ml",
    phase = "liquid",
    category = "chems",
    conditional_names = { { kind = "FLAG", key = "DIRTY", name = ccb.content.text("bleach spill") } },
    display_type = "BY_VOLUME",
    comestible = { kind = "INVALID", servings = 1, freezing_point = -8 },
}

ccb.content.define_item {
    id = "ammonia_liquid",
    name = ccb.content.plural_text("liquid ammonia", "liquid ammonia"),
    mass = "124 g",
    color = "white",
    flags = { "CORROSIVE" },
    default_container = "pressure_tank",
    sealed_container = false,
    symbol = "~",
    description = ccb.content.text("Anhydrous ammonia, a useful chemical compound.  It must be stored under pressure or refrigerated.  Don't even think about drinking it."),
    price = "67 cent",
    survival_price = "50 cent",
    volume = "250 ml",
    phase = "liquid",
    stack_size = 1,
    category = "chems",
    display_type = "BY_VOLUME",
    ammunition = { type = "ammonia_liquid" },
}

ccb.content.define_item {
    id = "ammonia_hydroxide",
    name = ccb.content.plural_text("ammonia solution", "ammonia solution"),
    materials = { "ammonia_hydroxide" },
    display_type = "BY_VOLUME",
    mass = "124 g",
    color = "white",
    flags = { "CORROSIVE" },
    sealed_container = false,
    symbol = "~",
    description = ccb.content.text("Ammonium hydroxide, a common household cleaning agent."),
    price = "33 cent",
    survival_price = "25 cent",
    volume = "125 ml",
    phase = "liquid",
    category = "chems",
    comestible = { kind = "INVALID", servings = 1, freezing_point = -78 },
    use_actions = { "BLECH" },
}

ccb.content.define_item {
    id = "fertilizer_liquid",
    name = ccb.content.plural_text("liquid fertilizer", "liquid fertilizer"),
    mass = "67 g",
    color = "yellow",
    flags = { "FERTILIZER", "NUTRIENT_OVERRIDE" },
    fertilizer_quality = 0.8,
    default_container = "jug_plastic",
    sealed_container = false,
    symbol = "~",
    description = ccb.content.text("A nutrient-rich elixir for plants."),
    price = "10 USD",
    survival_price = "1 USD",
    volume = "250 ml",
    phase = "liquid",
    category = "chems",
    display_type = "BY_VOLUME",
    comestible = { kind = "DRINK", quench = -10, healthy = -1, calories = 260, servings = 4, fun = -30 },
    use_actions = { "PLANTBLECH" },
}

ccb.content.define_item {
    id = "fermentable_liquid_mixture",
    name = ccb.content.plural_text("fermentable liquid mixture", "fermentable liquid mixture"),
    volume = "500 ml",
    mass = "500 g",
    description = ccb.content.text("A mixture of various organic wastes and water.  Wait about two months for them to be fermented in a tank.  Also, biogas production will start after one month."),
    copy_from = "fertilizer_liquid",
    price = "0 cent",
    survival_price = "0 cent",
    flags = { "NUTRIENT_OVERRIDE", "TRADER_AVOID" },
    subtype_order = { "composting", "comestible" },
    composting = {
        duration = "60 days",
        products = { { item = "fermented_fertilizer_liquid", count = 1 }, { item = "biogas", count = 250 } },
    },
    comestible = { servings = 1 },
}

ccb.content.define_item {
    id = "fermentable_fish_mixture_active",
    name = ccb.content.plural_text("fermentable fish mixture", "fermentable fish mixture"),
    description = ccb.content.text("A mixture of fish, sugars, and water.  Wait about two months for them to be fermented in an open tank."),
    copy_from = "fermentable_liquid_mixture",
    revert_to = "fermented_fertilizer_liquid",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "comestible", "tool" },
    comestible = {},
    tool = {},
    countdown_interval = "50 days",
}

ccb.content.define_item {
    id = "fermented_fertilizer_liquid",
    name = ccb.content.plural_text("fermented fertilizer liquid", "fermented fertilizer liquid"),
    volume = "500 ml",
    mass = "400 g",
    description = ccb.content.text("A mixture of fermented biomass, will become liquid fertilizer after simple treatment."),
    copy_from = "fertilizer_liquid",
    price = "0 cent",
    survival_price = "0 cent",
    flags = { "NUTRIENT_OVERRIDE", "TRADER_AVOID" },
    comestible = { servings = 1 },
}

-- 0.8  g/cm3
ccb.content.define_item {
    id = "fertilizer_commercial",
    name = ccb.content.plural_text("commercial fertilizer", "commercial fertilizer"),
    mass = "27 g",
    color = "yellow",
    flags = { "FERTILIZER" },
    fertilizer_quality = 1.0,
    default_container = "bag_canvas",
    symbol = "~",
    description = ccb.content.text("Nutrient-rich granules for plants."),
    price = "16 cent",
    survival_price = "16 cent",
    materials = { "powder" },
    volume = "33 ml",
    category = "chems",
    display_type = "BY_WEIGHT",
    stackable = true,
    comestible = { kind = "FOOD", quench = -10, healthy = -1, calories = 43, fun = -15 },
    use_actions = { "PLANTBLECH" },
}

-- Typically sold in larger quantities, but that's handled in the charge count.
-- Previously 10 doses to a gram, so about 400 to the pound.
ccb.content.define_item {
    id = "fungicide",
    category = "chems",
    name = ccb.content.plural_text("fungicide powder", "fungicide powder"),
    mass = "1 g",
    color = "pink",
    flags = { "EDIBLE_FROZEN" },
    default_container = "bag_plastic_small",
    symbol = "!",
    description = ccb.content.text("Agricultural-grade chemical anti-fungal powder designed to destroy infections in plants."),
    price = "5 cent",
    survival_price = "5 cent",
    materials = { "powder" },
    volume = "1 ml",
    display_type = "BY_WEIGHT",
    stackable = true,
    comestible = { stimulation = -7, kind = "MED", healthy = -7, fun = -15 },
    use_actions = { "FUNGICIDE" },
}

ccb.content.define_item {
    id = "salt_water",
    name = ccb.content.plural_text("salt water", "salt water"),
    materials = { { id = "water", portions = 877 }, { id = "salt", portions = 123 } },
    mass = "260 g",
    color = "light_cyan",
    default_container = "bottle_plastic",
    sealed_container = false,
    symbol = "~",
    description = ccb.content.text("Water with salt added.  Not good for drinking."),
    flags = { "NUTRIENT_OVERRIDE", "NO_AUTO_CONSUME" },
    price = "0 cent",
    survival_price = "0 cent",
    volume = "250 ml",
    phase = "liquid",
    category = "chems",
    display_type = "BY_VOLUME",
    comestible = { kind = "DRINK", quench = -30, healthy = -1, servings = 1, freezing_point = -2, fun = -1 },
}

ccb.content.define_item {
    id = "soapy_water",
    name = ccb.content.plural_text("soapy water", "soapy water"),
    materials = { "water" },
    mass = "260 g",
    color = "light_cyan",
    default_container = "bottle_plastic",
    sealed_container = false,
    symbol = "~",
    description = ccb.content.text("Water with soap added.  Not good for drinking."),
    price = "0 cent",
    survival_price = "0 cent",
    volume = "250 ml",
    phase = "liquid",
    category = "chems",
    display_type = "BY_VOLUME",
    comestible = { kind = "INVALID", quench = -5, healthy = -1, servings = 1, freezing_point = -2, fun = -1 },
}

ccb.content.define_item {
    id = "chem_sulphuric_acid",
    category = "chems",
    price = "2 USD 50 cent",
    survival_price = "12 cent",
    name = ccb.content.plural_text("sulfuric acid", "sulfuric acid"),
    symbol = "=",
    color = "white",
    flags = { "DROP_ACTION_ONLY_IF_LIQUID" },
    description = ccb.content.text("Sulfuric acid: viscous, foul-smelling and extremely corrosive, particularly to organic matter and evil clowns.  Although used to prepare a number of chemicals, it is mostly known as battery acid, due to its widest commercial application."),
    materials = { "acid" },
    volume = "250 ml",
    mass = "455 g",
    phase = "liquid",
    default_container = "bottle_glass",
    display_type = "BY_VOLUME",
    comestible = { kind = "INVALID", servings = 1, freezing_point = -36 },
    drop_action = { kind = "emit_actor", emissions = { "emit_acid_drop" }, scale_quantity = true },
}

ccb.content.define_item {
    id = "chem_muriatic_acid",
    category = "chems",
    price = "2 USD 50 cent",
    survival_price = "5 cent",
    name = ccb.content.plural_text("hydrochloric acid", "hydrochloric acid"),
    symbol = "=",
    color = "white",
    flags = { "DROP_ACTION_ONLY_IF_LIQUID" },
    description = ccb.content.text("Hydrochloric acid, also known as muriatic acid.  It is a strong acid that has a distinctive smell, important and frequently used ever since its discovery.  It still has a vast multitude of uses."),
    volume = "250 ml",
    mass = "202 g",
    phase = "liquid",
    default_container = "bottle_glass",
    display_type = "BY_VOLUME",
    comestible = { kind = "INVALID", servings = 1, freezing_point = -50 },
    drop_action = { kind = "emit_actor", emissions = { "emit_acid_drop" }, scale_quantity = true },
}

ccb.content.define_item {
    id = "chem_acetone",
    category = "chems",
    price = "50 cent",
    survival_price = "5 cent",
    name = ccb.content.plural_text("acetone", "acetone"),
    symbol = "=",
    color = "white",
    description = ccb.content.text("Acetone, best known as the primary constituent of most nail polish removers.  Flammable, and can be easily used for potent homemade explosives, as demonstrated by the terrorist attacks of 2016."),
    volume = "250 ml",
    mass = "190 g",
    materials = { "acetone" },
    phase = "liquid",
    default_container = "bottle_glass",
    display_type = "BY_VOLUME",
    ammunition = { type = "components" },
}

ccb.content.define_item {
    id = "chem_nitric_acid",
    category = "chems",
    price = "3 USD",
    survival_price = "9 cent",
    name = ccb.content.plural_text("nitric acid", "nitric acid"),
    symbol = "=",
    color = "white",
    flags = { "DROP_ACTION_ONLY_IF_LIQUID" },
    description = ccb.content.text("Nitric acid, a strong oxidant and an extremely corrosive material.  Mainly used in the production of synthetic fertilizers, for the etching of circuit boards, and in woodworking.  Remains quite useful both for making a vast array of pyrotechnic and explosive agents and as a direct weapon: not many beings enjoy being doused in nitric acid."),
    materials = { "acid" },
    volume = "250 ml",
    mass = "375 g",
    phase = "liquid",
    default_container = "bottle_glass",
    display_type = "BY_VOLUME",
    comestible = { kind = "INVALID", servings = 1, freezing_point = -42 },
    drop_action = { kind = "emit_actor", emissions = { "emit_acid_drop" }, scale_quantity = true },
}

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

ccb.content.define_item {
    id = "water_sewage",
    name = ccb.content.plural_text("sewage water", "sewage water"),
    materials = { "water", "feces" },
    mass = "262 g",
    color = "green",
    default_container = "bottle_plastic",
    sealed_container = false,
    symbol = "~",
    description = ccb.content.text("Turbid liquid from the sewers with an awful stench."),
    volume = "250 ml",
    phase = "liquid",
    category = "chems",
    display_type = "BY_VOLUME",
    comestible = { kind = "INVALID", servings = 1 },
}

-- 35% solution, so 1.38 g/cm3
ccb.content.define_item {
    id = "lye",
    name = ccb.content.plural_text("lye", "lye"),
    mass = "69 g",
    color = "white",
    symbol = "~",
    description = ccb.content.text("A liquid form of sodium hydroxide.  It is highly corrosive; handle with care."),
    price = "78 cent",
    survival_price = "5 cent",
    volume = "50 ml",
    phase = "liquid",
    category = "chems",
    display_type = "BY_VOLUME",
    comestible = { kind = "INVALID", servings = 1 },
}

-- 5%, so 1.047 g/cm3
ccb.content.define_item {
    id = "lye_potassium",
    name = ccb.content.plural_text("potassium lye", "potassium lye"),
    mass = "52 g",
    color = "white",
    symbol = "~",
    description = ccb.content.text("A liquid form of potassium hydroxide.  It is highly corrosive; handle with care."),
    price = "67 cent",
    survival_price = "5 cent",
    volume = "50 ml",
    phase = "liquid",
    category = "chems",
    display_type = "BY_VOLUME",
    comestible = { kind = "INVALID", servings = 1 },
}

-- 0.7134 g/cm3
ccb.content.define_item {
    id = "ether",
    category = "chems",
    price = "10 cent",
    survival_price = "5 cent",
    name = ccb.content.plural_text("ether", "ether"),
    symbol = "!",
    color = "white",
    default_container = "bottle_glass",
    description = ccb.content.text("A useful industrial solvent, and the first inhalative anesthetic in widespread use.  Its uncomfortable side effects and tendency to explode caused it to fall out of favor decades ago in the developed world.  If you can't get the good stuff, however, it might make a passable substitute."),
    volume = "1 ml",
    mass = "713 mg",
    phase = "liquid",
    display_type = "BY_VOLUME",
    stackable = true,
    comestible = { quench = -96, healthy = -20, fun = -20, kind = "INVALID", servings = 1 },
}

-- 1.1004 g/cm3
ccb.content.define_item {
    id = "chem_DMSO",
    category = "chems",
    price = "10 cent",
    survival_price = "5 cent",
    name = ccb.content.plural_text("dimethyl sulfoxide", "dimethyl sulfoxide"),
    symbol = "~",
    color = "light_cyan",
    default_container = "bottle_glass",
    description = ccb.content.text("Dimethyl sulfoxide, or DMSO, is a common and important aprotic solvent, capable of dissolving a huge range of things.  It has the unusual property of being absorbed very quickly through the skin, causing a garlic flavor in the mouth, even if it touched your arm."),
    volume = "1 ml",
    mass = "1100 mg",
    phase = "liquid",
    display_type = "BY_VOLUME",
    stackable = true,
    comestible = { quench = -96, healthy = -20, fun = -20, kind = "INVALID", servings = 1 },
}

-- 1.489 g/cm3 at 25C
ccb.content.define_item {
    id = "chem_chloroform",
    category = "chems",
    price = "20 cent",
    survival_price = "5 cent",
    name = ccb.content.plural_text("chloroform", "chloroform"),
    symbol = "~",
    color = "light_cyan",
    default_container = "bottle_glass",
    description = ccb.content.text("Famous for its properties as an illicit sedative, this substance is also a very good solvent.  In particular, it's used a lot in nuclear magnetic resonance spectroscopy."),
    volume = "1 ml",
    mass = "1489 mg",
    phase = "liquid",
    display_type = "BY_VOLUME",
    comestible = { quench = -96, healthy = -20, fun = -20, kind = "INVALID", servings = 1 },
}

-- 1.07 g/cm3
ccb.content.define_item {
    id = "chem_phenol",
    category = "chems",
    price = "10 cent",
    survival_price = "5 cent",
    name = ccb.content.plural_text("phenol", "phenol"),
    symbol = "~",
    color = "light_cyan",
    default_container = "bottle_glass",
    description = ccb.content.text("A useful and potent solvent with a wide range of reactive applications.  It can be used to make a huge number of plastics and polymers, it can be an antiseptic, it can strip paint and break down epoxy, and it can burn your skin away like tissue paper under a heat gun.  Wear gloves."),
    volume = "1 ml",
    mass = "1070 mg",
    phase = "liquid",
    display_type = "BY_VOLUME",
    comestible = { quench = -96, healthy = -20, fun = -20, kind = "INVALID", servings = 1 },
}

ccb.content.define_item {
    id = "chem_benzene",
    category = "chems",
    price = "10 cent",
    survival_price = "5 cent",
    name = ccb.content.plural_text("benzene", "benzene"),
    symbol = "~",
    color = "light_cyan",
    default_container = "bottle_glass",
    description = ccb.content.text("A colorless, highly flammable liquid with a sweet odor, one of the elementary petrochemicals.  Being used primarily as a precursor to the manufacture of chemicals with more complex structure, it's a major industrial chemical, but finds limited use in consumer items because of its toxicity."),
    materials = { "oil" },
    volume = "1 ml",
    mass = "877 mg",
    phase = "liquid",
    flags = { "INEDIBLE" },
    display_type = "BY_VOLUME",
    comestible = { kind = "INVALID", servings = 1, freezing_point = 5 },
}

ccb.content.define_item {
    id = "chem_toluene",
    category = "chems",
    price = "10 cent",
    survival_price = "5 cent",
    name = ccb.content.plural_text("toluene", "toluene"),
    symbol = "~",
    color = "light_cyan",
    default_container = "bottle_glass",
    description = ccb.content.text("A colorless, toxic, and highly flammable liquid which smells like paint thinner.  It's predominantly used as an industrial feedstock and a solvent, and is also used as an intoxicative inhalant in a manner unintended by manufacturers."),
    materials = { "oil" },
    volume = "1 ml",
    mass = "870 mg",
    phase = "liquid",
    flags = { "INEDIBLE" },
    display_type = "BY_VOLUME",
    comestible = { kind = "INVALID", servings = 1, freezing_point = -95 },
}

ccb.content.define_item {
    id = "chem_glycerol",
    category = "chems",
    price = "10 cent",
    survival_price = "5 cent",
    name = ccb.content.plural_text("glycerol", "glycerol"),
    symbol = "~",
    color = "light_cyan",
    default_container = "bottle_glass",
    description = ccb.content.text("Also called glycerin, this clear, odorless liquid is both a handy skin moisturizer and an ingredient necessary to make dynamite."),
    volume = "15 ml",
    mass = "20 g",
    phase = "liquid",
    display_type = "BY_VOLUME",
    comestible = { quench = -15, healthy = -1, kind = "INVALID", servings = 1 },
}

ccb.content.define_item {
    id = "pur_tablets",
    name = "water purification tablet",
    description = "Intended for the clarification and disinfection of unsafe drinking water while camping or traveling, this sodium dichloroisocyanurate-based purification tablet removes dangerous contaminants using powerful chemicals.  The label says to use one tablet per liter (4 units of water).",
    symbol = "!",
    color = "white",
    category = "chems",
    display_type = "BY_WEIGHT",
    mass = "1 g",
    volume = "2 ml",
    price = "9 cent",
    survival_price = "20 cent",
    stackable = true,
    flags = { "NO_INGEST", "WATER_DISSOLVE" },
    materials = { "powder" },
    variables = { water_per_tablet = 4 },
    comestible = { kind = "MED" },
}

ccb.content.define_item {
    id = "latex",
    name = ccb.content.plural_text("latex", "latex"),
    description = ccb.content.text("A liquid precursor to rubber found in some plants."),
    mass = "500 mg",
    volume = "50 ml",
    price = "0 cent",
    survival_price = "10 cent",
    symbol = "=",
    color = "white",
    stack_size = 100,
    phase = "liquid",
    looks_like = "milk",
    display_type = "BY_VOLUME",
    comestible = { kind = "INVALID", servings = 1 },
}

ccb.content.define_item {
    id = "acetylene",
    name = ccb.content.plural_text("acetylene", "acetylene"),
    description = "A flammable gas that explodes under pressure.  Combined with oxygen, acetylene makes a great welding gas.",
    symbol = "=",
    color = "red",
    category = "chems",
    phase = "liquid",
    display_type = "BY_VOLUME",
    mass = "40 g",
    volume = "250 ml",
    price = "12 USD",
    survival_price = "2 USD 50 cent",
    explode_in_fire = true,
    stack_size = 100,
    flags = { "NO_DROP", "IRREMOVABLE" },
    materials = { "hydrocarbons" },
    blast = { power = 20, shrapnel = 0 },
    comestible = { kind = "INVALID", servings = 1 },
}

ccb.content.define_item {
    id = "formic_acid",
    name = ccb.content.plural_text("formic acid", "formic acid"),
    description = "Common in nature as an insect venom, this substance has a number of industrial uses such as preservation and manufacturing.",
    symbol = "=",
    color = "white",
    looks_like = "ether",
    phase = "liquid",
    display_type = "BY_VOLUME",
    mass = "204 g",
    volume = "250 ml",
    price = "0 cent",
    survival_price = "10 cent",
    explode_in_fire = true,
    stack_size = 1,
    flags = { "NUTRIENT_OVERRIDE" },
    materials = { "acid" },
    blast = { power = 5, shrapnel = 0 },
    comestible = { kind = "INVALID", servings = 1 },
}

-- NO_I18N
-- 100 ml venom
ccb.content.define_item {
    id = "venom_gland",
    abstract = true,
    name = ccb.content.text_without_extraction("venom gland"),
    category = "chems",
    mass = "130 g",
    volume = "110 ml",
    symbol = "o",
    looks_like = "mutant_bug_hydrogen_sacs",
    comestible = { kind = "FOOD", shelf_life = "4 hours" },
}

ccb.content.define_item {
    id = "venom_wasp",
    copy_from = "venom_gland",
    name = ccb.content.plural_text("wasp venom gland", "wasp venom glands"),
    description = ccb.content.text("A fragile, slightly quivering organ for the production and storage of wasp venom.  You could extract some very useful chemicals from it with the right know-how, but only if you hurry."),
    color = "light_green",
    comestible = { fun = -50 },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "venom_bee",
    copy_from = "venom_gland",
    name = ccb.content.plural_text("bee venom gland", "bee venom glands"),
    description = ccb.content.text("A fragile, slightly quivering organ for the production and storage of honeybee venom.  You could extract some very useful chemicals from it with the right know-how, but only if you hurry."),
    color = "yellow",
    comestible = { fun = -50 },
    use_actions = { "POISON" },
}

ccb.content.define_item {
    id = "venom_paralytic",
    copy_from = "venom_gland",
    name = ccb.content.plural_text("sac of paralytic venom", "sacs of paralytic venom"),
    description = ccb.content.text("A grayish, flexible vesicle filled to the brim with the potent paralytic agent the triffids use to subdue still-moving fertilizer such as yourself.  If you know your way around poisons you might be able to find a use for it."),
    materials = { "veggy" },
    color = "light_gray",
    comestible = { fun = -50, vitamins = { { id = "veggy_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "triffid_fungicide",
    copy_from = "venom_gland",
    name = ccb.content.plural_text("sac of triffid fungicide", "sacs of triffid fungicide"),
    description = ccb.content.text("A triffid sac filled with what appears to be a triffid-produced antifungal agent.  It will likely already work as an antifungal compound for more offensive applications, but requires further refining before it can be used as a medical drug."),
    materials = { "veggy" },
    color = "light_blue",
    comestible = { fun = -50, vitamins = { { id = "veggy_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "conc_venom",
    category = "chems",
    name = ccb.content.plural_text("concentrated venom", "concentrated venom"),
    description = ccb.content.text("A transparent, lightly greenish liquid, refined from the venom of bees and wasps.  Active ingredients include (nor-)adrenaline, dopamine, histamine, and protein toxins.  It is now relatively stable, but will require further separation to be useful for anything other than killing you."),
    phase = "liquid",
    mass = "5 g",
    volume = "5 ml",
    stack_size = 1,
    default_container = "test_tube",
    symbol = ";",
    color = "light_green",
    display_type = "BY_VOLUME",
    stackable = true,
    ammunition = { count = 10, type = "components" },
}

ccb.content.define_item {
    id = "conc_paralytic",
    name = ccb.content.plural_text("concentrated paralytic", "concentrated paralytic"),
    description = ccb.content.text("A concentrated paralytic agent, originally from a triffid.  Given your experience with its effects (chiefly gathered while sourcing this batch) and their striking similarity to earthly flora, you figure it's related to curarines.  Might come in handy in crafting more useful things."),
    copy_from = "conc_venom",
    color = "light_gray",
    ammunition = {},
}

ccb.content.define_item {
    id = "rocuronium",
    category = "chems",
    name = ccb.content.plural_text("rocuronium", "rocuronium"),
    description = ccb.content.text("Rocuronium bromide, a fast-acting muscle relaxant.  Used primarily in emergency medicine because of its relative stability, it can serve as a component of a balanced anesthesia in a pinch."),
    mass = "10 g",
    volume = "10 ml",
    phase = "liquid",
    default_container = "test_tube",
    symbol = ";",
    color = "light_gray",
    price = "20 USD",
    survival_price = "2 USD",
    stack_size = 1,
    display_type = "BY_VOLUME",
    ammunition = { type = "components", count = 1 },
}

-- 1.082 g/cm3
ccb.content.define_item {
    id = "acetic_anhydride",
    category = "chems",
    name = ccb.content.plural_text("acetic anhydride", "acetic anhydride"),
    description = ccb.content.text("A colorless liquid that smells strongly of vinegar.  If you have enough chemical knowledge, you could use it to easily convert morphine into heroin."),
    materials = { "oil" },
    default_container = "bottle_glass",
    mass = "54100 mg",
    volume = "50 ml",
    price = "50 cent",
    survival_price = "2 cent",
    phase = "liquid",
    symbol = "~",
    color = "dark_gray",
    looks_like = "chem_ethanol",
    display_type = "BY_VOLUME",
    comestible = {
        kind = "INVALID",
        sleepiness = -20,
        servings = 1,
        quench = -99,
        healthy = -20,
        fun = -99,
        freezing_point = -73,
    },
    use_actions = { "POISON", "BLECH" },
}

-- Density of around 0.92 g/ml
ccb.content.define_item {
    id = "liquid_soap",
    name = ccb.content.plural_text("liquid soap", "liquid soap"),
    category = "chems",
    mass = "46 g",
    color = "light_cyan",
    default_container = "bottle_bathroom",
    sealed_container = false,
    symbol = "~",
    description = ccb.content.text("Standard skin-safe liquid soap, the type you might see on a kitchen sink, shower shelf, or bathroom soap dispenser, but it should work reasonably well for cleaning anything that's filthy."),
    price = "0 cent",
    survival_price = "0 cent",
    volume = "250 ml",
    phase = "liquid",
    flags = { "DETERGENT" },
    display_type = "BY_VOLUME",
    comestible = { kind = "INVALID", servings = 5 },
}

ccb.content.define_item {
    id = "pine_resin",
    name = ccb.content.plural_text("pine resin", "pine resin"),
    category = "chems",
    description = ccb.content.text("A sticky, sludgy mass of sap harvested from a pine tree."),
    mass = "250 g",
    volume = "250 ml",
    price = "0 cent",
    survival_price = "10 cent",
    symbol = "=",
    color = "white",
    stackable = true,
    comestible = { kind = "INVALID" },
}

-- density: 0.76–4.20 g/cm3 according to Google, I'm going with the middle ground
ccb.content.define_item {
    id = "silicone",
    name = ccb.content.plural_text("silicone caulk", "silicone caulk"),
    category = "chems",
    description = ccb.content.text("A thick gray paste used as a sealant in many construction projects."),
    mass = "2480 mg",
    volume = "100 ml",
    price = "9 USD 36 cent",
    survival_price = "4 USD",
    stack_size = 10,
    phase = "liquid",
    default_container = "squeeze_tube",
    sealed_container = true,
    symbol = "s",
    color = "light_gray",
    flags = { "UNRECOVERABLE" },
    display_type = "BY_VOLUME",
    ammunition = { type = "components" },
}

-- depending on the lore as what acid these enemies use this could change, muriatic acid is stomach acid
ccb.content.define_item {
    id = "blood_acid",
    copy_from = "chem_muriatic_acid",
    price = "0 cent",
    survival_price = "0 cent",
    name = ccb.content.plural_text("toxic acidic blood", "toxic acidic blood"),
    symbol = "~",
    color = "red",
    description = ccb.content.text("Blood mixed with acidic compounds, extremely corrosive, a means of refining this could net some useful chemicals."),
    comestible = {},
}

ccb.content.define_item {
    id = "blood_acid_insect",
    copy_from = "formic_acid",
    category = "chems",
    survival_price = "0 cent",
    name = ccb.content.plural_text("virulent acidic blood", "virulent acidic blood"),
    symbol = "~",
    color = "red",
    description = ccb.content.text("Blood mixed with acidic compounds, extremely corrosive, a means of refining this could net some useful chemicals."),
    volume = "250 ml",
    mass = "305 g",
    default_container = "bottle_glass",
    flags = { "DROP_ACTION_ONLY_IF_LIQUID" },
    comestible = {},
    drop_action = { kind = "emit_actor", emissions = { "emit_acid_drop" }, scale_quantity = true },
}

ccb.content.define_item {
    id = "blood_acid_plant",
    copy_from = "chem_acetic_acid",
    price = "0 cent",
    survival_price = "0 cent",
    name = ccb.content.plural_text("putrid acidic blood", "putrid acidic blood"),
    symbol = "~",
    color = "green",
    description = ccb.content.text("Blood mixed with acidic compounds, smells putrid, a means of refining this could net some useful chemicals."),
    flags = { "DROP_ACTION_ONLY_IF_LIQUID" },
    comestible = { kind = "INVALID", servings = 1 },
    drop_action = { kind = "emit_actor", emissions = { "emit_acid_drop" }, scale_quantity = true },
}

-- weight and freezing temp adjusted assuming the acid is diluted by essentially 50% water
ccb.content.define_item {
    id = "blood_acid_underground",
    copy_from = "chem_sulphuric_acid",
    price = "0 cent",
    survival_price = "0 cent",
    name = ccb.content.plural_text("foul acidic blood", "foul acidic blood"),
    symbol = "~",
    color = "red",
    mass = "352 g",
    description = ccb.content.text("Blood mixed with acidic compounds, foul-smelling and extremely corrosive, a means of refining this could net some useful chemicals."),
    comestible = { freezing_point = -18 },
}

-- Represents all glues that can withstand <1800 psi of tensile strength, such as PVA, bone glue and rubber cement.
-- 1 charge of weak glue should cover an area of 5mm^2
ccb.content.define_item {
    id = "glue_weak",
    category = "spare_parts",
    name = ccb.content.plural_text("weak glue", "weak glue"),
    description = ccb.content.text("A weak adhesive to use in arts & crafts or other low stress applications.  You can't eat it."),
    symbol = "~",
    color = "white",
    materials = { "epoxy" },
    mass = "1 g",
    volume = "100 ml",
    survival_price = "5 cents",
    phase = "liquid",
    flags = { "UNRECOVERABLE", "NO_SALVAGE" },
    display_type = "BY_VOLUME",
    ammunition = { type = "components", count = 100 },
}

-- Represents all glues that can withstand >1800 psi of tensile strength, such as cyanoacrylate, polyurethane and epoxy.
-- 1 charge of strong glue should cover an area of 5mm^2
ccb.content.define_item {
    id = "glue_strong",
    copy_from = "glue_weak",
    name = ccb.content.plural_text("strong glue", "strong glue"),
    description = ccb.content.text("A strong adhesive to use for structural repairs or other high stress applications.  You can't sniff it, but you can use it to close up wounds in a pinch."),
    survival_price = "10 cents",
    ammo = {},
    use_actions = { { kind = "heal", bandages_power = 1, bleed = 4, moves = 1000 } },
}
