local ccb = require("ccb")

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
