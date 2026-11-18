local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "mc_cavalry_sabre",
    result = "mc_cavalry_sabre",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component_any({
            { id = "leather", count = 1 },
            { id = "mc_wire", count = 2 }
        })
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :book("textbook_weapwest", 7)
    :step {
        name = content.text("Drawing out steel, forging the curved sabre blade and full tang"),
        duration_moves = 840000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Forging the knucklebow and guard assembly"),
        duration_moves = 420000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Rough grinding the bevels and fullers"),
        duration_moves = 780000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Final grind, polishing, and sharpening the edge"),
        duration_moves = 660000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Fitting the guard, wrapping the tang"),
        duration_moves = 240000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
)

content.add(content.Recipe {
    id = "hc_cavalry_sabre",
    result = "hc_cavalry_sabre",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component_any({
            { id = "leather", count = 1 },
            { id = "hc_wire", count = 2 }
        })
    :requirement("blacksmithing_standard", 8)
    :requirement("hc_steel_standard", 2)
    :book("textbook_weapwest", 7)
    :step {
        name = content.text("Drawing out steel, forging the curved sabre blade and full tang"),
        duration_moves = 840000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Forging the knucklebow and guard assembly"),
        duration_moves = 420000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Rough grinding the bevels and fullers"),
        duration_moves = 780000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Final grind, polishing, and sharpening the edge"),
        duration_moves = 660000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Fitting the guard, wrapping the tang"),
        duration_moves = 240000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
)

content.add(content.Recipe {
    id = "ch_cavalry_sabre",
    result = "ch_cavalry_sabre",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :component("clay_lump", 2)
    :component("stick", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :requirement("quench", 120)
    :book("textbook_weapwest", 8)
    :byproduct("water", 120)
    :step {
        name = content.text("Forge welding and drawing out steel, forging blade blank and tang"),
        duration_moves = 1320000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Forging the guard from remaining steel"),
        duration_moves = 660000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Rough grinding and establishing the edge geometry.  Truing"),
        duration_moves = 1080000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Applying a thick layer of clay to the spine of the blade, leaving the edge exposed"),
        duration_moves = 210000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Drying clay"),
        duration_moves = 720000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
    }
    :step {
        name = content.text("Heating the blade and quenching in water"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Letting cool.  Scraping off baked clay and grinding away scale to inspect the hardened edge"),
        duration_moves = 360000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Final sanding and polishing"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Carving wooden handle.  Wrapping handle."),
        duration_moves = 600000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
)

content.add(content.Recipe {
    id = "qt_cavalry_sabre",
    result = "qt_cavalry_sabre",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :component("stick", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :requirement("quench", 120)
    :book("textbook_weapwest", 9)
    :byproduct("water", 120)
    :step {
        name = content.text("Forge welding and drawing out steel, forging blade blank and tang"),
        duration_moves = 1380000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Forging intricate guard from remaining steel"),
        duration_moves = 720000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Rough grinding and establishing the edge geometry"),
        duration_moves = 1260000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating and thorough hardening blade"),
        duration_moves = 210000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Carefully grinding forge scale to observe temper colors"),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Tempering"),
        duration_moves = 1980000,
        activity_level = NO_EXERCISE,
        qualities = {
            { { id = "TEMPER", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final sanding and polishing"),
        duration_moves = 1200000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Carving wooden handle.  Wrapping handle.  Hack n' slash!"),
        duration_moves = 600000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
)

content.add(content.Recipe {
    id = "kukri",
    result = "kukri",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :book("manual_knives", 8)
    :book("textbook_weapeast", 7)
    :book("textbook_weparabic", 7)
    :step {
        name = content.text("Drawing out steel, forging the blade blank, and drawing out the tang"),
        duration_moves = 420000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Forging the belly and hammering in the bevels"),
        duration_moves = 360000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing the blade to relieve forging stress"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding the bevels to establish the heavy chopping geometry"),
        duration_moves = 540000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Filing the traditional notch at the base of the blade to arrest stress cracks"),
        duration_moves = 120000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Final sharpening, sanding, and polishing"),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Carving the wooden handle, burning the hidden tang into the wood, and securing it"),
        duration_moves = 300000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
)

content.add(content.Recipe {
    id = "hc_kukri",
    result = "hc_kukri",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :book("manual_knives", 8)
    :book("textbook_armschina", 7)
    :book("textbook_weparabic", 7)
    :step {
        name = content.text("Drawing out steel, forging the blade blank, and drawing out the tang"),
        duration_moves = 420000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Forging the belly and hammering in the bevels"),
        duration_moves = 360000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing the blade to relieve forging stress"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding the bevels to establish the heavy chopping geometry"),
        duration_moves = 540000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Filing the traditional notch at the base of the blade to arrest stress cracks"),
        duration_moves = 120000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Final sharpening, sanding, and polishing"),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Carving the wooden handle, burning the hidden tang into the wood, and securing it"),
        duration_moves = 300000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
)

content.add(content.Recipe {
    id = "ch_kukri",
    result = "ch_kukri",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("quench", 120)
    :book("manual_knives", 9)
    :book("textbook_armschina", 8)
    :book("textbook_weparabic", 8)
    :byproduct("water", 100)
    :step {
        name = content.text("Drawing out medium carbon steel, forging the blade blank, and drawing out the hidden tang"),
        duration_moves = 660000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Forging an exaggerated forward belly to counteract thermal shock bending"),
        duration_moves = 540000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding and filing the notch"),
        duration_moves = 540000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating the entire blade evenly to critical temperature"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Differentially hardening by carefully pouring water over the cutting edge, using the thermal shock to pull the blade into shape.  Quickly hammering out imperfections"),
        duration_moves = 300000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Waiting for spine to air cool slightly before quenching"),
        duration_moves = 120000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Final sharpening, sanding, and polishing"),
        duration_moves = 480000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Carving the wooden handle, burning the tang into the wood and assembling"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", skill_penalty = 0 },
        },
    }
)

content.add(content.Recipe {
    id = "qt_kukri",
    result = "qt_kukri",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("quench", 120)
    :book("manual_knives", 10)
    :book("textbook_armschina", 9)
    :book("textbook_weparabic", 9)
    :byproduct("water", 120)
    :step {
        name = content.text("Drawing out medium carbon steel, forging the blade blank, and drawing out the hidden tang"),
        duration_moves = 660000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Forging an exaggerated forward belly to counteract thermal shock bending"),
        duration_moves = 360000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding and filing the notch"),
        duration_moves = 660000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating the entire blade evenly to critical temperature"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Thorough hardening"),
        duration_moves = 120000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Grinding away forge scale to observe temper colors"),
        duration_moves = 120000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Tempering"),
        duration_moves = 1440000,
        activity_level = NO_EXERCISE,
        qualities = {
            { { id = "TEMPER", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Final sharpening, sanding, and polishing"),
        duration_moves = 480000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Carving the wooden handle, burning the tang into the wood and assembling"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", skill_penalty = 0 },
        },
    }
)

content.add(content.Recipe {
    id = "ch_cutlass",
    result = "ch_cutlass",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :component("stick", 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :requirement("quench", 120)
    :book("textbook_weapwest", 7)
    :byproduct("water", 120)
    :step {
        name = content.text("Forge welding and drawing out steel, forging blade blank and tang"),
        duration_moves = 1320000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Forging the guard from remaining steel"),
        duration_moves = 660000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Rough grinding and establishing the edge geometry.  Truing"),
        duration_moves = 1080000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Applying a thick layer of clay to the spine of the blade, leaving the edge exposed"),
        duration_moves = 210000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Drying clay"),
        duration_moves = 720000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
    }
    :step {
        name = content.text("Heating the blade and quenching in water"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Letting cool.  Scraping off baked clay and grinding away scale to inspect the hardened edge"),
        duration_moves = 360000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Final sanding and polishing"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Carving wooden handle.  Wrapping handle."),
        duration_moves = 600000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
)

content.add(content.Recipe {
    id = "qt_cutlass",
    result = "qt_cutlass",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :component("stick", 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :requirement("quench", 120)
    :book("textbook_weapwest", 8)
    :byproduct("water", 120)
    :step {
        name = content.text("Forge welding and drawing out steel, forging blade blank and tang"),
        duration_moves = 1380000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Forging intricate guard from remaining steel"),
        duration_moves = 720000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Rough grinding and establishing the edge geometry"),
        duration_moves = 1260000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating and thorough hardening blade"),
        duration_moves = 210000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Carefully grinding forge scale to observe temper colors"),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Tempering"),
        duration_moves = 1980000,
        activity_level = NO_EXERCISE,
        qualities = {
            { { id = "TEMPER", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final sanding and polishing"),
        duration_moves = 1200000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Carving wooden handle.  Wrapping handle.  Hack n' slash!"),
        duration_moves = 600000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
)

content.add(content.Recipe {
    id = "ch_arming_sword",
    result = "ch_arming_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :requirement("quench", 120)
    :book("textbook_weapwest", 8)
    :byproduct("water", 120)
    :step {
        name = content.text("Forge welding and cutting steel"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Drawing out steel, forging the blade blank, and drawing out the hidden tang.  Using remaining steel to forge simple pommel"),
        duration_moves = 1680000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding and filing the fuller"),
        duration_moves = 1440000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating the entire blade evenly to critical temperature"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Differentially hardening by edge-quenching in water.  Pulling the blade from the water while the thick spine still retains heat."),
        duration_moves = 120000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Quickly grinding the edge scale to observe colors.  Allowing residual heat from the spine to temper the edge to a straw color"),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final sharpening, sanding, and polishing"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Wrapping tang"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "qt_arming_sword",
    result = "qt_arming_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :requirement("quench", 120)
    :book("textbook_weapwest", 9)
    :byproduct("water", 120)
    :step {
        name = content.text("Forge welding and cutting steel"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Drawing out steel, forging the blade blank, and drawing out the hidden threaded tang.  Using remaining steel to forge pommel"),
        duration_moves = 1740000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding and filing the fuller"),
        duration_moves = 1680000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating the entire blade to critical temperature"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Thorough hardening"),
        duration_moves = 120000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Quickly grinding the edge scale to observe temper colors"),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Tempering"),
        duration_moves = 1980000,
        activity_level = NO_EXERCISE,
        qualities = {
            { { id = "TEMPER", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final sharpening, sanding, and polishing"),
        duration_moves = 1260000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Wrapping tang and threading pommel"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "ch_broadsword",
    result = "ch_broadsword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :requirement("quench", 120)
    :book("textbook_weapwest", 8)
    :byproduct("water", 120)
    :step {
        name = content.text("Forge welding and cutting steel"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Drawing out steel, forging the blade blank, and drawing out the hidden tang.  Using remaining steel to forge simple pommel"),
        duration_moves = 1680000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding and filing the fuller"),
        duration_moves = 1440000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating the entire blade evenly to critical temperature"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Differentially hardening by edge-quenching in water.  Pulling the blade from the water while the thick spine still retains heat."),
        duration_moves = 120000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Quickly grinding the edge scale to observe colors.  Allowing residual heat from the spine to temper the edge to a straw color"),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final sharpening, sanding, and polishing"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Wrapping tang"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "qt_broadsword",
    result = "qt_broadsword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :requirement("quench", 120)
    :book("textbook_weapwest", 9)
    :byproduct("water", 120)
    :step {
        name = content.text("Forge welding and cutting steel"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Drawing out steel, forging the blade blank, and drawing out the hidden threaded tang.  Using remaining steel to forge pommel"),
        duration_moves = 1740000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding and filing the fuller"),
        duration_moves = 1680000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating the entire blade to critical temperature"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Thorough hardening"),
        duration_moves = 120000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Quickly grinding the edge scale to observe temper colors"),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Tempering"),
        duration_moves = 1980000,
        activity_level = NO_EXERCISE,
        qualities = {
            { { id = "TEMPER", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final sharpening, sanding, and polishing"),
        duration_moves = 1260000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Wrapping tang and threading pommel"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "mc_scimitar",
    result = "mc_scimitar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component_any({
            { id = "leather", count = 1 },
            { id = "mc_wire", count = 2 }
        })
    :component("stick", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_weparabic", 7)
    :step {
        name = content.text("Drawing out steel, forging the curved sabre blade and full tang"),
        duration_moves = 840000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Forging the knucklebow and guard assembly"),
        duration_moves = 420000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Rough grinding the bevels and fullers"),
        duration_moves = 780000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Final grind, polishing, and sharpening the edge"),
        duration_moves = 660000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Fitting the guard, wrapping the tang"),
        duration_moves = 240000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
)

content.add(content.Recipe {
    id = "hc_scimitar",
    result = "hc_scimitar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component_any({
            { id = "leather", count = 1 },
            { id = "hc_wire", count = 2 }
        })
    :component("stick", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :book("textbook_weparabic", 7)
    :step {
        name = content.text("Drawing out steel, forging the curved sabre blade and full tang"),
        duration_moves = 840000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Forging the knucklebow and guard assembly"),
        duration_moves = 420000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Rough grinding the bevels and fullers"),
        duration_moves = 780000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Final grind, polishing, and sharpening the edge"),
        duration_moves = 660000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Fitting the guard, wrapping the tang"),
        duration_moves = 240000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
)

content.add(content.Recipe {
    id = "ch_scimitar",
    result = "ch_scimitar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :component("clay_lump", 2)
    :component("stick", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :requirement("quench", 120)
    :book("textbook_weparabic", 8)
    :byproduct("water", 120)
    :step {
        name = content.text("Forge welding and drawing out steel, forging blade blank and tang"),
        duration_moves = 1320000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Forging the guard from remaining steel"),
        duration_moves = 660000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Rough grinding and establishing the edge geometry.  Truing"),
        duration_moves = 1080000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Applying a thick layer of clay to the spine of the blade, leaving the edge exposed"),
        duration_moves = 210000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Drying clay"),
        duration_moves = 720000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
    }
    :step {
        name = content.text("Heating the blade and quenching in water"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Letting cool.  Scraping off baked clay and grinding away scale to inspect the hardened edge"),
        duration_moves = 360000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Final sanding and polishing"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Carving wooden handle.  Wrapping handle."),
        duration_moves = 600000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
)

content.add(content.Recipe {
    id = "qt_scimitar",
    result = "qt_scimitar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :component("stick", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :requirement("quench", 120)
    :book("textbook_weparabic", 9)
    :byproduct("water", 120)
    :step {
        name = content.text("Forge welding and drawing out steel, forging blade blank and tang"),
        duration_moves = 1380000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Forging intricate guard from remaining steel"),
        duration_moves = 720000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Rough grinding and establishing the edge geometry"),
        duration_moves = 1260000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating and thorough hardening blade"),
        duration_moves = 210000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Carefully grinding forge scale to observe temper colors"),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Tempering"),
        duration_moves = 1980000,
        activity_level = NO_EXERCISE,
        qualities = {
            { { id = "TEMPER", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final sanding and polishing"),
        duration_moves = 1200000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Carving wooden handle.  Wrapping handle.  Hack n' slash!"),
        duration_moves = 600000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
)

content.add(content.Recipe {
    id = "ch_estoc",
    result = "ch_estoc",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :component_any({
            { id = "scrap_kevlar", count = 4 },
            { id = "plastic_chunk", count = 2 }
        })
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :requirement("quench", 120)
    :book("textbook_weapwest", 8)
    :byproduct("water", 120)
    :step {
        name = content.text("Forge welding and cutting steel for the blade, tang, pommel and hilt"),
        duration_moves = 540000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Drawing out the blade with a diamond cross section"),
        duration_moves = 1980000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Forging hilt"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Normalizing the blade with extra cycles"),
        duration_moves = 420000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding the blade"),
        duration_moves = 720000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Hardening rapier"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Final grinding and polishing"),
        duration_moves = 540000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
    :step {
        name = content.text("Assembling the hilt, attaching pommel, wrapping the grip, and binding it with wire"),
        duration_moves = 360000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
)

content.add(content.Recipe {
    id = "qt_estoc",
    result = "qt_estoc",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :component_any({
            { id = "scrap_kevlar", count = 4 },
            { id = "plastic_chunk", count = 2 }
        })
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :requirement("quench", 120)
    :book("textbook_weapwest", 9)
    :byproduct("water", 120)
    :step {
        name = content.text("Forge welding steel for the blade, tang, pommel and hilt"),
        duration_moves = 660000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Drawing out the blade with a diamond cross section"),
        duration_moves = 2100000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Forging swept hilt.  Etching touchmark in hilt"),
        duration_moves = 1140000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Normalizing the blade with extra cycles"),
        duration_moves = 450000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding the blade"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Thorough hardening rapier"),
        duration_moves = 120000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Carefully grinding away forge scale"),
        duration_moves = 180000,
        activity_level = BRISK_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Tempering to a spring temper"),
        duration_moves = 1620000,
        activity_level = NO_EXERCISE,
        qualities = {
            { { id = "TEMPER", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final grinding and polishing"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
    :step {
        name = content.text("Assembling the hilt, attaching pommel, wrapping the grip, and binding it with wire"),
        duration_moves = 360000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
)

content.add(content.Recipe {
    id = "ch_longsword",
    result = "ch_longsword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :requirement("quench", 120)
    :book("textbook_weapwest", 8)
    :step {
        name = content.text("Forge welding and cutting steel"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Drawing out steel, forging the blade blank, and drawing out the hidden threaded tang.  Using remaining steel to forge pommel"),
        duration_moves = 1560000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding and filing the fuller"),
        duration_moves = 1260000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating and differentially hardening blade"),
        duration_moves = 300000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Final sharpening, sanding, and polishing"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Wrapping tang and threading pommel"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "qt_longsword",
    result = "qt_longsword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :requirement("quench", 120)
    :book("textbook_weapwest", 9)
    :byproduct("water", 120)
    :step {
        name = content.text("Forge welding and cutting steel"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Drawing out steel, forging the blade blank, and drawing out the hidden threaded tang.  Using remaining steel to forge pommel"),
        duration_moves = 1770000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding and filing the fuller"),
        duration_moves = 1440000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating the entire blade to critical temperature"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Thorough hardening"),
        duration_moves = 120000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Quickly grinding the edge scale to observe temper colors"),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Tempering"),
        duration_moves = 1620000,
        activity_level = NO_EXERCISE,
        qualities = {
            { { id = "TEMPER", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final sharpening, sanding, and polishing"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Wrapping tang and threading pommel"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "ch_wakizashi",
    result = "ch_wakizashi",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :component("clay_lump", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :requirement("quench", 120)
    :book("textbook_weapeast", 8)
    :byproduct("water", 120)
    :step {
        name = content.text("Cutting steel.  Forging the blade to shape and drawing out the tang"),
        duration_moves = 720000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Truing the profile and rough grinding the bevels"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Applying refractory clay to the spine for differential hardening"),
        duration_moves = 270000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Letting clay dry"),
        duration_moves = 720000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
    }
    :step {
        name = content.text("Heating to critical temperature and water quenching"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Letting spine bleed heat into the blade.  Stripping off clay and quenching fully"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Final grinding"),
        duration_moves = 720000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Carving and fitting the handle components"),
        duration_moves = 540000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
)

content.add(content.Recipe {
    id = "qt_wakizashi",
    result = "qt_wakizashi",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :requirement("quench", 120)
    :book("textbook_weapeast", 9)
    :byproduct("water", 120)
    :step {
        name = content.text("Cutting steel.  Forging the blade to shape and drawing out the tang"),
        duration_moves = 960000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Truing the profile and rough grinding the bevels"),
        duration_moves = 1020000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating to critical temperature and thorough hardening"),
        duration_moves = 90000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Tempering"),
        duration_moves = 1440000,
        activity_level = NO_EXERCISE,
        qualities = {
            { { id = "TEMPER", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final grinding"),
        duration_moves = 840000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Carving and fitting the handle components"),
        duration_moves = 660000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
)

content.add(content.Recipe {
    id = "ch_katana",
    result = "ch_katana",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :component("stick", 1)
    :component("mc_wire", 2)
    :component("clay_lump", 2)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :requirement("quench", 120)
    :book("textbook_weapeast", 9)
    :byproduct("water", 120)
    :step {
        name = content.text("Cutting steel.  Forging the blade straight and drawing out the tang"),
        duration_moves = 1320000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Truing the profile and rough grinding the bevels"),
        duration_moves = 1140000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Applying clay to spine"),
        duration_moves = 240000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Letting clay dry"),
        duration_moves = 1080000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
    }
    :step {
        name = content.text("Heating to critical temperature and water quenching"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Letting spine bleed heat into the blade.  Stripping off clay and quenching fully"),
        duration_moves = 210000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Final grinding.  Establishing razor-sharp edge"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Carving handle and assembling"),
        duration_moves = 480000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
)

content.add(content.Recipe {
    id = "qt_katana",
    result = "qt_katana",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :component_any({
            { id = "scrap_kevlar", count = 2 },
            { id = "plastic_chunk", count = 1 }
        })
    :component("stick", 1)
    :component("mc_wire", 2)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :requirement("quench", 120)
    :book("textbook_weapeast", 10)
    :byproduct("water", 120)
    :step {
        name = content.text("Cutting steel.  Forging the blade to shape and drawing out the tang"),
        duration_moves = 1620000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing blade"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Truing the profile and rough grinding the bevels"),
        duration_moves = 1620000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating to critical temperature and thorough hardening"),
        duration_moves = 240000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Tempering"),
        duration_moves = 1620000,
        activity_level = NO_EXERCISE,
        qualities = {
            { { id = "TEMPER", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final grinding.  Establishing razor-sharp edge"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Carving handle.  Fitting the handle components.  Masaka, a masterpiece!"),
        duration_moves = 540000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
)

content.add(content.Recipe {
    id = "qt_nodachi",
    result = "qt_nodachi",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :component_any({
            { id = "scrap_kevlar", count = 4 },
            { id = "plastic_chunk", count = 2 }
        })
    :component("stick", 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("mc_steel_standard", 5)
    :requirement("quench", 120)
    :book("textbook_weapeast", 10)
    :byproduct("water", 120)
    :step {
        name = content.text("Forging the blank ensuring consistent grain flow"),
        duration_moves = 2160000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing the steel"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding"),
        duration_moves = 1980000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating the blade to critical temperature"),
        duration_moves = 180000,
        activity_level = BRISK_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Tempering"),
        duration_moves = 1980000,
        activity_level = NO_EXERCISE,
        qualities = {
            { { id = "TEMPER", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final sharpening and polishing"),
        duration_moves = 1440000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Constructing the reinforced handle.  A masterpiece!"),
        duration_moves = 540000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
)

content.add(content.Recipe {
    id = "halberd",
    result = "halberd",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("spear_shaft", 1)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :component("nail", 2)
    :requirement("blacksmithing_standard", 12)
    :requirement("steel_standard", 3)
    :requirement("metal_punch", 1)
    :book("textbook_weapwest", 6)
    :step {
        name = content.text("Cutting steel.  Forging the blade, socket, and langets"),
        duration_moves = 1080000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding the bevels and filing the socket"),
        duration_moves = 540000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Final grind"),
        duration_moves = 540000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Inserting nails through the langet holes.  Wrapping handle"),
        duration_moves = 540000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
)

content.add(content.Recipe {
    id = "glaive",
    result = "glaive",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("spear_shaft", 1)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :component("nail", 2)
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 2)
    :requirement("metal_punch", 1)
    :book("textbook_weapwest", 6)
    :step {
        name = content.text("Cutting steel.  Forging the blade, socket, and langets"),
        duration_moves = 1080000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding the bevels and filing the socket"),
        duration_moves = 540000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Final grind"),
        duration_moves = 540000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Inserting nails through the langet holes.  Wrapping handle"),
        duration_moves = 540000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
)
