local ccb = require("ccb")
local content = ccb.content

-- 96 units are consumed per day, with RDA of 1000mg / 96 = 10.42mg
-- 1000mg for 19-50yr olds from https://ods.od.nih.gov/factsheets/calcium-HealthProfessional/#h2
do
    local definition = content.Vitamin {
        id = "calcium",
        name = ccb.content.text("Calcium"),
        kind = "vitamin",
        minimum = -48000,
        maximum = 0,
        rate_turns = 900,
        deficiency = "hypocalcemia",
    }
    definition:weight_micrograms(10420)
    definition:deficiency_range(-19200, -22400)
    definition:deficiency_range(-22401, -25600)
    definition:deficiency_range(-25601, -48000)
    content.add(definition)
end
-- 96 units are consumed per day, with RDA of 18mg / 96 = 0.1875mg
-- 18mg for 19-50yr olds from https://ods.od.nih.gov/factsheets/iron-HealthProfessional/#h2
-- As it varies with sex, the max value was chosen
do
    local definition = content.Vitamin {
        id = "iron",
        name = ccb.content.text("Iron"),
        kind = "vitamin",
        minimum = -24000,
        maximum = 3600,
        rate_turns = 900,
        deficiency = "anemia",
    }
    definition:weight_micrograms(188)
    definition:deficiency_range(-9600, -11200)
    definition:deficiency_range(-11201, -12800)
    definition:deficiency_range(-12801, -24000)
    content.add(definition)
end
-- 96 units are consumed per day, with RDA of 90mg / 96 = 0.9375mg
-- 90mg for 19-50yr olds from https://ods.od.nih.gov/factsheets/VitaminC-HealthProfessional/#h2
-- As it varies with sex, the max value was chosen
do
    local definition = content.Vitamin {
        id = "vitC",
        name = ccb.content.text("Vitamin C"),
        kind = "vitamin",
        minimum = -5600,
        maximum = 0,
        rate_turns = 900,
        deficiency = "scurvy",
    }
    definition:weight_micrograms(938)
    definition:deficiency_range(-2800, -3600)
    definition:deficiency_range(-3601, -4400)
    definition:deficiency_range(-4401, -5600)
    content.add(definition)
end
-- Takes 30 min to kick in, lasts 24 hours (or more).
do
    local definition = content.Vitamin {
        id = "vit_betablocker",
        name = ccb.content.text("Beta-Blocker"),
        kind = "drug",
        minimum = 0,
        maximum = 864,
        rate_turns = 100,
        excess = "betablock",
    }
    definition:excess_range(10, 864)
    definition:excess_range(865, 1728)
    definition:excess_range(1729, 2592)
    content.add(definition)
end
-- Takes 30 min to kick in, lasts 5 days
do
    local definition = content.Vitamin {
        id = "vit_bloodthinner",
        name = ccb.content.text("Blood thinner"),
        kind = "drug",
        minimum = 0,
        maximum = 4320,
        rate_turns = 100,
        excess = "anticoagulant",
    }
    definition:excess_range(10, 4320)
    content.add(definition)
end
-- Takes 30 min to kick in, lasts 6 hours
do
    local definition = content.Vitamin {
        id = "vit_ibuprofen",
        name = ccb.content.text("Ibuprofen"),
        kind = "drug",
        minimum = 0,
        maximum = 432,
        rate_turns = 100,
        excess = "nsaid_eff",
    }
    definition:excess_range(10, 216)
    content.add(definition)
end
-- 1 vit_mme is equivalent to 1% of an MME.  Need to adjust excess.  Rate is set for full elimination of a single oxycodone pill in six hours.
do
    local definition = content.Vitamin {
        id = "vit_mme",
        name = ccb.content.text("Morphine Milligram Equivalent (percentile)"),
        kind = "drug",
        minimum = 0,
        maximum = 40000,
        rate_turns = 6,
        excess = "opiate_eff",
    }
    definition:excess_range(500, 1500)
    definition:excess_range(1501, 5000)
    definition:excess_range(5001, 18000)
    definition:excess_range(18001, 30000)
    definition:excess_range(30001, 39998)
    definition:excess_range(39999, 40000)
    content.add(definition)
end
-- 1 unit is 1 mg of caffeine.  Dose tiers follow FDA (https://www.fda.gov/consumers/consumer-updates/spilling-beans-how-much-caffeine-too-much) and FSANZ P1056 (https://www.foodstandards.gov.au/sites/default/files/2025-03/P1056%20SD1%202nd%20CFS%20Safety%20Assessment.pdf): single doses up to ~210 mg (3 mg/kg) generally cause no adverse effects; 400 mg/day is the FDA adult daily line; rapid intake of ~1,200 mg or more can cause seizures and arrhythmia.
do
    local definition = content.Vitamin {
        id = "caffeine",
        name = ccb.content.text("Caffeine"),
        kind = "drug",
        minimum = 0,
        maximum = 1600,
        rate_turns = 25,
        excess = "caffeine_eff",
    }
    definition:weight_micrograms(1000)
    definition:excess_range(25, 200)
    definition:excess_range(201, 400)
    definition:excess_range(401, 1000)
    definition:excess_range(1001, 1600)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "nicotine_slow",
        name = ccb.content.text("Slow-release Nicotine"),
        kind = "drug",
        minimum = 0,
        maximum = 48,
        rate_turns = 2400,
    }
    definition:decays_into("nicotine", 1)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "nicotine",
        name = ccb.content.text("Nicotine"),
        kind = "drug",
        minimum = 0,
        maximum = 10,
        rate_turns = 300,
        excess = "cig",
    }
    definition:excess_range(1, 6)
    definition:excess_range(7, 10)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutant_toxin",
        name = ccb.content.text("Toxins"),
        kind = "toxin",
        minimum = 0,
        maximum = 1800,
        rate_turns = 900,
        excess = "toxin_buildup",
    }
    definition:excess_range(500, 949)
    definition:excess_range(950, 1399)
    definition:excess_range(1400, 1800)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagenic_slurry",
        name = ccb.content.text("Mutagenic Slurry"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 1,
        excess = "mutagenic_slurry",
    }
    definition:excess_range(1, 2500)
    definition:decays_into("mutagen", 8)
    definition:decays_into("mutagen_batrachian", 1)
    definition:decays_into("mutagen_bird", 1)
    definition:decays_into("mutagen_cattle", 1)
    definition:decays_into("mutagen_cephalopod", 1)
    definition:decays_into("mutagen_crustacean", 1)
    definition:decays_into("mutagen_feline", 1)
    definition:decays_into("mutagen_fish", 1)
    definition:decays_into("mutagen_gastropod", 1)
    definition:decays_into("mutagen_insect", 1)
    definition:decays_into("mutagen_lizard", 1)
    definition:decays_into("mutagen_lupine", 1)
    definition:decays_into("mutagen_mouse", 1)
    definition:decays_into("mutagen_plant", 1)
    definition:decays_into("mutagen_rabbit", 1)
    definition:decays_into("mutagen_rat", 1)
    definition:decays_into("mutagen_spider", 1)
    definition:decays_into("mutagen_troglobite", 1)
    definition:decays_into("mutagen_chiropteran", 1)
    definition:decays_into("mutagen_ursine", 1)
    definition:decays_into("mutant_toxin", 2)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_chelator",
        name = ccb.content.text("Mutagenic Chelator"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 1,
        excess = "mutagen_chelator",
    }
    definition:excess_range(1, 2500)
    definition:decays_into("mutagen", -2)
    definition:decays_into("mutagen_alpha", -1)
    definition:decays_into("mutagen_batrachian", -1)
    definition:decays_into("mutagen_beast", -1)
    definition:decays_into("mutagen_bird", -1)
    definition:decays_into("mutagen_cattle", -1)
    definition:decays_into("mutagen_cephalopod", -1)
    definition:decays_into("mutagen_chimera", -1)
    definition:decays_into("mutagen_crustacean", -1)
    definition:decays_into("mutagen_elfa", -1)
    definition:decays_into("mutagen_feline", -1)
    definition:decays_into("mutagen_fish", -1)
    definition:decays_into("mutagen_gastropod", -1)
    definition:decays_into("mutagen_human", -1)
    definition:decays_into("mutagen_insect", -1)
    definition:decays_into("mutagen_lizard", -1)
    definition:decays_into("mutagen_lupine", -1)
    definition:decays_into("mutagen_medical", -1)
    definition:decays_into("mutagen_mouse", -1)
    definition:decays_into("mutagen_plant", -1)
    definition:decays_into("mutagen_raptor", -1)
    definition:decays_into("mutagen_rabbit", -1)
    definition:decays_into("mutagen_rat", -1)
    definition:decays_into("mutagen_slime", -1)
    definition:decays_into("mutagen_spider", -1)
    definition:decays_into("mutagen_troglobite", -1)
    definition:decays_into("mutagen_ursine", -1)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen",
        name = ccb.content.text("Mutagenic Catalyst"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_alpha",
        name = ccb.content.text("Alpha Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 5000,
        rate_turns = 3600,
        excess = "mutagen_alpha",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 5000)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_batrachian",
        name = ccb.content.text("Frog Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_batrachian",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_beast",
        name = ccb.content.text("Beast Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_beast",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_bird",
        name = ccb.content.text("Bird Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_bird",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_cattle",
        name = ccb.content.text("Cattle Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_cattle",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_cephalopod",
        name = ccb.content.text("Cephalopod Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_cephalopod",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_chimera",
        name = ccb.content.text("Chimera Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_chimera",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_crustacean",
        name = ccb.content.text("Crustacean Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_crustacean",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_elfa",
        name = ccb.content.text("Elf-A Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_elfa",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_feline",
        name = ccb.content.text("Feline Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_feline",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_fish",
        name = ccb.content.text("Fish Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_fish",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_gastropod",
        name = ccb.content.text("Snail Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_gastropod",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_human",
        name = ccb.content.text("Purifier"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_human",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_insect",
        name = ccb.content.text("Insect Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_insect",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_lizard",
        name = ccb.content.text("Lizard Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_lizard",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_lupine",
        name = ccb.content.text("Lupine Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_lupine",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_medical",
        name = ccb.content.text("Medical Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_medical",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_mouse",
        name = ccb.content.text("Mouse Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_mouse",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_plant",
        name = ccb.content.text("Plant Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_plant",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_rabbit",
        name = ccb.content.text("Rabbit Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_rabbit",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_raptor",
        name = ccb.content.text("Raptor Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_raptor",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_rat",
        name = ccb.content.text("Rat Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_rat",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_chiropteran",
        name = ccb.content.text("Chiropteran Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_chiropteran",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_slime",
        name = ccb.content.text("Slime Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_slime",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_spider",
        name = ccb.content.text("Spider Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_spider",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_troglobite",
        name = ccb.content.text("Troglobite Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_troglobite",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_ursine",
        name = ccb.content.text("Ursine Primer"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_ursine",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_interstice",
        name = ccb.content.text("Interdimensional Contaminant"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_interstice",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "bad_food",
        name = ccb.content.text("Disgusting Diet"),
        kind = "counter",
        minimum = 0,
        maximum = 40,
        rate_turns = 14400,
        excess = "bad_food_ennui",
    }
    definition:excess_range(10, 19)
    definition:excess_range(20, 29)
    definition:excess_range(30, 40)
    definition:flag("NO_DISPLAY")
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "blood",
        name = ccb.content.text("Blood"),
        kind = "counter",
        minimum = -50000,
        maximum = 0,
        rate_turns = -6,
        deficiency = "hypovolemia",
    }
    definition:deficiency_range(-5000, -7500)
    definition:deficiency_range(-7510, -15000)
    definition:deficiency_range(-15010, -20000)
    definition:deficiency_range(-20010, -50000)
    definition:flag("NO_DISPLAY")
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "redcells",
        name = ccb.content.text("Red Blood Cells"),
        kind = "counter",
        minimum = -50000,
        maximum = 0,
        rate_turns = -12,
        deficiency = "redcells_anemia",
    }
    definition:deficiency_range(-7510, -20000)
    definition:deficiency_range(-20010, -35000)
    definition:deficiency_range(-35010, -50000)
    definition:flag("NO_DISPLAY")
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "human_flesh_vitamin",
        name = ccb.content.text("Consumed human flesh"),
        kind = "counter",
        minimum = 0,
        maximum = 10000,
        rate_turns = 3600,
    }
    definition:flag("NO_SELL")
    content.add(definition)
end
-- used so allergies and restrictions could be inherited in cooking process
content.add(content.Vitamin {
    id = "meat_allergen",
    name = ccb.content.text("Meat"),
    kind = "counter",
    minimum = 0,
    maximum = 1,
    rate_turns = 3600,
})
-- used so allergies and restrictions could be inherited in cooking process
content.add(content.Vitamin {
    id = "veggy_allergen",
    name = ccb.content.text("Veggy"),
    kind = "counter",
    minimum = 0,
    maximum = 1,
    rate_turns = 3600,
})
-- used so allergies and restrictions could be inherited in cooking process
content.add(content.Vitamin {
    id = "wheat_allergen",
    name = ccb.content.text("Wheat"),
    kind = "counter",
    minimum = 0,
    maximum = 1,
    rate_turns = 3600,
})
-- used so allergies and restrictions could be inherited in cooking process
content.add(content.Vitamin {
    id = "egg_allergen",
    name = ccb.content.text("Egg"),
    kind = "counter",
    minimum = 0,
    maximum = 1,
    rate_turns = 3600,
})
-- used so allergies and restrictions could be inherited in cooking process
content.add(content.Vitamin {
    id = "fruit_allergen",
    name = ccb.content.text("Fruit"),
    kind = "counter",
    minimum = 0,
    maximum = 1,
    rate_turns = 3600,
})
-- used so allergies and restrictions could be inherited in cooking process
content.add(content.Vitamin {
    id = "junk_allergen",
    name = ccb.content.text("Junk"),
    kind = "counter",
    minimum = 0,
    maximum = 1,
    rate_turns = 3600,
})
-- used so allergies and restrictions could be inherited in cooking process
content.add(content.Vitamin {
    id = "nut_allergen",
    name = ccb.content.text("Nut"),
    kind = "counter",
    minimum = 0,
    maximum = 1,
    rate_turns = 3600,
})
-- used so allergies and restrictions could be inherited in cooking process
content.add(content.Vitamin {
    id = "bread_allergen",
    name = ccb.content.text("Bread"),
    kind = "counter",
    minimum = 0,
    maximum = 1,
    rate_turns = 3600,
})
-- used so allergies and restrictions could be inherited in cooking process
content.add(content.Vitamin {
    id = "milk_allergen",
    name = ccb.content.text("Milk"),
    kind = "counter",
    minimum = 0,
    maximum = 1,
    rate_turns = 3600,
})
do
    local definition = content.Vitamin {
        id = "dermatik_larva_size",
        name = ccb.content.text("Dermatik Larva Size"),
        kind = "counter",
        minimum = 0,
        maximum = 1440,
        rate_turns = 172800,
        excess = "dermatik_visible",
    }
    definition:excess_range(60, 399)
    definition:excess_range(400, 1079)
    definition:excess_range(1080, 1440)
    definition:flag("NO_DISPLAY")
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "triffid_fiber",
        name = ccb.content.text("Triffid Fiber"),
        kind = "counter",
        minimum = 0,
        maximum = 250,
        rate_turns = 7200,
        excess = "triffid_fiber_indigestion",
    }
    definition:excess_range(15, 60)
    definition:excess_range(61, 120)
    definition:excess_range(121, 180)
    definition:excess_range(181, 250)
    definition:flag("NO_DISPLAY")
    content.add(definition)
end
-- 1 unit is 1 ml of pure ethanol
-- For 70 kg person, BAC of 1 ml is about 0.0016%, so 16 units
-- TODO tie it somehow to body weight
do
    local definition = content.Vitamin {
        id = "ethanol",
        name = ccb.content.text("Alcohol"),
        kind = "drug",
        minimum = 0,
        maximum = 1000,
        rate_turns = 1,
    }
    definition:decays_into("BAC", 16)
    content.add(definition)
end
-- 1 unit is 0.1 mg/dL, aka 0.0001% BAC. Average metabolic rate is 150 per hour. Anyhting bigger than 4000 should be deadly for average character
-- TODO: update effect so vitamin excess scales correctly
do
    local definition = content.Vitamin {
        id = "BAC",
        name = ccb.content.text("Alcohol (BAC)"),
        kind = "drug",
        minimum = 0,
        maximum = 10000,
        rate_turns = 24,
        excess = "drunk",
    }
    definition:excess_range(1, 1000)
    definition:excess_range(1001, 2000)
    definition:excess_range(2001, 3000)
    definition:excess_range(3001, 4000)
    definition:excess_range(4001, 10000)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "water_clean_scarlet_toxin",
        name = ccb.content.text("Dissolved trace bromide"),
        kind = "counter",
        minimum = 0,
        maximum = 8,
        rate_turns = 1800,
        excess = "effect_scarlet_water",
    }
    definition:excess_range(1, 2)
    definition:excess_range(3, 4)
    definition:excess_range(4, 5)
    definition:excess_range(5, 6)
    definition:excess_range(7, 8)
    definition:flag("NO_DISPLAY")
    content.add(definition)
end
-- TODO: Should decay faster the higher it is.
do
    local definition = content.Vitamin {
        id = "cannabis",
        name = ccb.content.text("Cannabis"),
        kind = "drug",
        minimum = 0,
        maximum = 100,
        rate_turns = 360,
        excess = "weed_high",
    }
    definition:excess_range(2, 9)
    definition:excess_range(10, 24)
    definition:excess_range(25, 39)
    definition:excess_range(40, 100)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "instability",
        name = ccb.content.text("Instability"),
        kind = "counter",
        minimum = 0,
        maximum = 8000,
        rate_turns = 1,
        excess = "genetics_damaged",
    }
    definition:excess_range(1, 899)
    definition:excess_range(900, 2799)
    definition:excess_range(2800, 8000)
    definition:flag("NO_DISPLAY")
    content.add(definition)
end
