local content = require("ccb").content

local NO_EXERCISE = 1

-- 撤销 PR #86581 — 恢复僵尸尸体的实用性
content.add(content.Recipe {
    id = "chem_ethanol",
    result = "chem_ethanol",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_FUEL",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 30, true)
    :tool("thermometer", 1)
    :component_any({
            { id = "mixed_alcohol_strong", count = 14 },
            { id = "mixed_alcohol_weak", count = 10 },
            { id = "wash_liquor", count = 42, requirement = true }
        })
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 2, 1)
    :book("textbook_chemistry")
    :book("distilling_cookbook", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_distilling")
    :result_charges(250)
    :byproduct("water_clean", 1)
)

content.add(content.Recipe {
    id = "methed_alcohol",
    result = "methed_alcohol",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_FUEL",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 60, true)
    :component("moonshine", 40)
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 1, 1)
    :book("textbook_chemistry")
    :book("distilling_cookbook")
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_distilling")
    :result_charges(250)
    :byproduct("water_clean", 1)
)

content.add(content.Recipe {
    id = "biodiesel",
    result = "biodiesel",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_FUEL",
    duration_moves = 2520000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    flags = { "ALLOW_ROTTEN" },
    result_multiplier = 4,
}
    :tool_charges("surface_heat", 100, true)
    :component_any({
            { id = "water_clean", count = 4 },
            { id = "water", count = 4 }
        })
    :component_any({
            { id = "chem_ethanol", count = 100 },
            { id = "chem_methanol", count = 100 },
            { id = "denat_alcohol", count = 100 },
            { id = "methed_alcohol", count = 100 }
        })
    :component_any({
            { id = "lye_powder", count = 8 },
            { id = "lye", count = 1 },
            { id = "chem_potassium_hydroxide", count = 40 },
            { id = "lye_potassium", count = 1 }
        })
    :component_any({
            { id = "cooking_oil", count = 64 },
            { id = "edible_tallow", count = 20, requirement = true },
            { id = "tallow_tainted", count = 8 },
            { id = "any_fat", count = 160, requirement = true },
            { id = "lamp_oil", count = 1000 },
            { id = "motor_oil", count = 1000 }
        })
    :quality("CHEM", 2, 1)
    :book("textbook_biodiesel", 5)
    :proficiency("prof_intro_chemistry")
    :batch_discount(99, 1)
    :result_charges(250)
    :byproduct("chem_glycerol", 4)
)

-- byproduct yield is measured in multiples of 250 (~200 grams)
-- Figures based primarily on Performance of Thermochemical Conversion of Fat, Oils, and Grease into
-- Kerosene-like Fuel in Different Production Scales.
-- cracking done at ~550 degrees c with 10kg of water, 10kg of fat, and 1kg of washing soda.
-- about 60-65% of the fatty mass is turned into OLP (organic liquid product). 5-10% is coke, and 20-30% of
-- the result is non condensible vapor (lost)
-- about 15% of the total reaction becomes kerosene-like hydrocarbons and about 50% becomes diesel-like
-- hydrocarbons. So it is intentional that this produces 3x the diesel as kerosene.
-- Thus the whole recipe produces about 5 kg of diesel (6000 ml) and 1.5 liters of kerosene (1800 ml)
-- These reactors operate at 10-15 KW power levels for long periods of time and each batch is processing a
-- pretty large amount of material. Specific heats give us about 40 MJ just to get to temp (550c)
content.add(content.Recipe {
    id = "lamp_oil",
    result = "lamp_oil",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_FUEL",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
    flags = { "ALLOW_ROTTEN" },
}
    :tool_charges("catalytic_cracking_reactor_tool", 50000)
    :tool_any({
            { id = "water", charges = 40 },
            { id = "water_clean", charges = 40 }
        })
    :component("chem_washing_soda", 40)
    :component_any({
            { id = "edible_tallow", count = 450, requirement = true },
            { id = "tallow_tainted", count = 180 },
            { id = "cooking_oil", count = 660 },
            { id = "any_fat", count = 500, requirement = true },
            { id = "ghee", count = 720 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :quality("EXTRACT", 3, 1)
    :book("catalytic_cracking_handbook", 5)
    :proficiency("prof_intro_chemistry")
    :result_charges(1800)
    :byproduct("diesel", 24)
)

content.add(content.Recipe {
    id = "crude_lamp_oil",
    result = "crude_lamp_oil",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_FUEL",
    duration_moves = 500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :component_any({
            { id = "edible_tallow", count = 5, requirement = true },
            { id = "tallow_tainted", count = 2 },
            { id = "cooking_oil", count = 16 }
        })
    :proficiency("prof_intro_chemistry")
    :batch_discount(95, 5)
    :result_charges(250)
)
