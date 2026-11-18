local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6
local ACTIVE_EXERCISE = 8

content.add(content.Recipe {
    id = "kris",
    result = "kris",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 2)
    :book("textbook_weapeast", 9)
    :step {
        name = content.text("Heating steel and cutting stock for blade"),
        duration_moves = 360000,
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
        name = content.text("Drawing out tang.  Drawing out and forging the wavy blade"),
        duration_moves = 1560000,
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
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Grinding the edge and shaping the bevels along the curves.  Polishing"),
        duration_moves = 720000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Carving and shaping the wooden handle"),
        duration_moves = 360000,
        activity_level = MODERATE_EXERCISE,
        proficiencies = {
            { id = "prof_carving", time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 },
        },
    }
    :step {
        name = content.text("Fitting and securing the tang into the handle"),
        duration_moves = 60000,
        activity_level = LIGHT_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "sword_cane",
    result = "sword_cane",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :requirement("blacksmithing_standard", 3)
    :requirement("steel_chunk_any", 3)
    :book("textbook_weapwest", 8)
    :step {
        name = content.text("Forge welding steel and cutting stock for the thin blade"),
        duration_moves = 360000,
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
        name = content.text("Drawing out a long, narrow blade and tang"),
        duration_moves = 720000,
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
        name = content.text("Normalizing"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Grinding and polishing"),
        duration_moves = 540000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Sawing, shaping, and carefully hollowing out the wooden cane body"),
        duration_moves = 1080000,
        activity_level = ACTIVE_EXERCISE,
        qualities = {
            { { id = "SAW_W", level = 2, count = 1 } },
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "FILE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Carving the handle, securing the tang, and tuning the friction fit of the cane scabbard"),
        duration_moves = 120000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
)

content.add(content.Recipe {
    id = "lc_spear_steel",
    result = "lc_spear_steel",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("spear_shaft", 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :requirement("metal_punch", 1)
    :step {
        name = content.text("Preparing and forming steel for the spearhead"),
        duration_moves = 240000,
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
        name = content.text("Forming the mounting socket using taper drift as mandrel"),
        duration_moves = 120000,
        activity_level = BRISK_EXERCISE,
        tools = {
            { { id = "drift", count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Drawing out metal for blade"),
        duration_moves = 240000,
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
        name = content.text("Grinding and polishing"),
        duration_moves = 180000,
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
        name = content.text("Carving the tip of the shaft to fit the socket and securing the head"),
        duration_moves = 180000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", time_multiplier = 1.5, skill_penalty = 0 },
        },
    }
)

content.add(content.Recipe {
    id = "spear_steel",
    result = "spear_steel",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("spear_shaft", 1)
    :component("nail", 2)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("metal_punch", 1)
    :book("textbook_weapwest", 3)
    :step {
        name = content.text("Preparing and forming steel for the spearhead"),
        duration_moves = 240000,
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
        name = content.text("Forming the mounting socket using taper drift as mandrel"),
        duration_moves = 120000,
        activity_level = BRISK_EXERCISE,
        tools = {
            { { id = "drift", count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Drawing out metal for blade"),
        duration_moves = 240000,
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
        name = content.text("Punching hole in the socket for rivet"),
        duration_moves = 90000,
        activity_level = MODERATE_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Normalizing the forged spearhead to relieve stress"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Grinding and polishing.  Preparing nail for riveting"),
        duration_moves = 480000,
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
        name = content.text("Preparing shaft to secure spearhead.  Riveting spearhead with nail and peening"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "DRILL", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", time_multiplier = 1.5, skill_penalty = 0 },
        },
    }
)

content.add(content.Recipe {
    id = "hc_spear_steel",
    result = "hc_spear_steel",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component("spear_shaft", 1)
    :component("nail", 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :requirement("metal_punch", 1)
    :book("textbook_weapwest", 4)
    :step {
        name = content.text("Preparing and forming steel for the spearhead"),
        duration_moves = 240000,
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
        name = content.text("Forming the mounting socket using taper drift as mandrel"),
        duration_moves = 120000,
        activity_level = BRISK_EXERCISE,
        tools = {
            { { id = "drift", count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Drawing out metal for blade"),
        duration_moves = 240000,
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
        name = content.text("Punching hole in the socket for rivet"),
        duration_moves = 90000,
        activity_level = MODERATE_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Normalizing the forged spearhead to relieve stress"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Grinding and polishing.  Preparing nail for riveting"),
        duration_moves = 480000,
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
        name = content.text("Preparing shaft to secure spearhead.  Riveting spearhead with nail and peening"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "DRILL", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", time_multiplier = 1.5, skill_penalty = 0 },
        },
    }
)

content.add(content.Recipe {
    id = "ch_spear_steel",
    result = "ch_spear_steel",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("spear_shaft", 1)
    :component("nail", 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("metal_punch", 1)
    :requirement("quench", 120)
    :book("textbook_weapwest", 6)
    :byproduct("water", 120)
    :step {
        name = content.text("Preparing and forming steel for the spearhead"),
        duration_moves = 300000,
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
        name = content.text("Forming the mounting socket using taper drift as mandrel"),
        duration_moves = 180000,
        activity_level = BRISK_EXERCISE,
        tools = {
            { { id = "drift", count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Drawing out metal for blade"),
        duration_moves = 240000,
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
        name = content.text("Punching hole in the socket for rivet"),
        duration_moves = 90000,
        activity_level = MODERATE_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Normalizing the spearhead"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding.  Preparing nail for riveting"),
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
        name = content.text("Heating spearhead and carefully slack quenching.  Watching steel until desired toughness is achieved"),
        duration_moves = 240000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Final grind and polish"),
        duration_moves = 600000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Carving the tip of the shaft to fit the socket and securing the head.  Riveting spearhead with nail and peening"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "DRILL", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", time_multiplier = 1.5, skill_penalty = 0 },
        },
    }
)

content.add(content.Recipe {
    id = "qt_spear_steel",
    result = "qt_spear_steel",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("spear_shaft", 1)
    :component("leather", 2)
    :component("nail", 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("metal_punch", 1)
    :requirement("quench", 120)
    :book("textbook_weapwest", 6)
    :byproduct("water", 120)
    :step {
        name = content.text("Preparing and forming steel for the spearhead"),
        duration_moves = 300000,
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
        name = content.text("Forming the mounting socket using taper drift as mandrel"),
        duration_moves = 180000,
        activity_level = BRISK_EXERCISE,
        tools = {
            { { id = "drift", count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Drawing out metal for blade"),
        duration_moves = 240000,
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
        name = content.text("Punching hole in the socket for rivet.  Cutting your touchmark on the flat of the spearhead"),
        duration_moves = 180000,
        activity_level = MODERATE_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Normalizing the spearhead"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding.  Preparing nail for riveting"),
        duration_moves = 840000,
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
        name = content.text("Thorough hardening"),
        duration_moves = 120000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Carefully grinding off forge scale to observe temper color"),
        duration_moves = 120000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
    }
    :step {
        name = content.text("Tempering the spearhead to purple-bluish"),
        duration_moves = 1440000,
        activity_level = NO_EXERCISE,
        qualities = {
            { { id = "TEMPER", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final grind and polish to perfection"),
        duration_moves = 780000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Carving the tip of the shaft to fit the socket and securing the head.  Riveting spearhead with nail and peening"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "DRILL", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", time_multiplier = 1.5, skill_penalty = 0 },
        },
    }
)

content.add(content.Recipe {
    id = "pike_bronze",
    result = "pike_bronze",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("scrap_bronze", 2)
    :component("long_pole", 1)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :book("bronze_book", 4)
    :book("bronze_mag", 5)
    :book("textbook_weapwest", 5)
    :step {
        name = content.text("Melting the bronze scrap and casting"),
        duration_moves = 540000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "casting_mold", count = 1 } },
        },
        proficiencies = {
            { id = "prof_redsmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Removing the rough casting from the mold and cutting off the sprue"),
        duration_moves = 180000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "SAW_M", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Cold-forging and work-hardening the bronze edges"),
        duration_moves = 720000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_redsmithing_adv" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Filing and grinding the hardened bronze"),
        duration_moves = 360000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Carving a taper into the pole, fitting the bronze socket, and wrapping a leather grip"),
        duration_moves = 360000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", skill_penalty = 0 },
        },
    }
)

content.add(content.Recipe {
    id = "lc_pike",
    result = "lc_pike",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("long_pole", 1)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :requirement("metal_punch", 1)
    :book("textbook_weapwest", 5)
    :step {
        name = content.text("Forge welding and cutting steel for the spearhead"),
        duration_moves = 360000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Forming the mounting socket using taper drift as mandrel"),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        tools = {
            { { id = "drift", count = 1 } },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Drawing out metal for blade"),
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
        name = content.text("Grinding and polishing"),
        duration_moves = 600000,
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
        name = content.text("Carving the tip of the shaft to fit the socket and securing the head"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", time_multiplier = 1.5, skill_penalty = 0 },
        },
    }
)

content.add(content.Recipe {
    id = "pike",
    result = "pike",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("long_pole", 1)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :component("nail", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :requirement("metal_punch", 1)
    :book("textbook_weapwest", 5)
    :step {
        name = content.text("Forge welding and cutting steel for the spearhead"),
        duration_moves = 480000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Forming the mounting socket using taper drift as mandrel"),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        tools = {
            { { id = "drift", count = 1 } },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Punching hole in the socket for rivet"),
        duration_moves = 90000,
        activity_level = MODERATE_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Drawing out metal for blade"),
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
        name = content.text("Normalizing"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Grinding and polishing"),
        duration_moves = 780000,
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
        name = content.text("Carving the tip of the shaft to fit the socket and securing the head.  Wrapping and riveting"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", time_multiplier = 1.5, skill_penalty = 0 },
        },
    }
)

content.add(content.Recipe {
    id = "hc_pike",
    result = "hc_pike",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("long_pole", 1)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :component("nail", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("hc_steel_standard", 2)
    :requirement("metal_punch", 1)
    :book("textbook_weapwest", 7)
    :step {
        name = content.text("Forge welding and cutting steel for the spearhead"),
        duration_moves = 480000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Forming the mounting socket using taper drift as mandrel"),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        tools = {
            { { id = "drift", count = 1 } },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Punching hole in the socket for rivet"),
        duration_moves = 90000,
        activity_level = MODERATE_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Drawing out metal for blade"),
        duration_moves = 600000,
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
        name = content.text("Normalizing to soften high carbon steel"),
        duration_moves = 420000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Grinding and polishing"),
        duration_moves = 780000,
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
        name = content.text("Carving the tip of the shaft to fit the socket and securing the head.  Wrapping and riveting"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "DRILL", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", time_multiplier = 1.5, skill_penalty = 0 },
        },
    }
)

content.add(content.Recipe {
    id = "ch_pike",
    result = "ch_pike",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :component("long_pole", 1)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :component("nail", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :requirement("metal_punch", 1)
    :requirement("quench", 120)
    :book("textbook_weapwest", 7)
    :byproduct("water", 120)
    :step {
        name = content.text("Forge welding and cutting steel for the spearhead"),
        duration_moves = 480000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Forming the mounting socket using taper drift as mandrel"),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        tools = {
            { { id = "drift", count = 1 } },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Drawing out metal for blade"),
        duration_moves = 600000,
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
        name = content.text("Normalizing for slack quenching"),
        duration_moves = 270000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding"),
        duration_moves = 840000,
        activity_level = BRISK_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating and slack quenching pike.  Watching edge for desired hardness."),
        duration_moves = 300000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Final grinding and polishing"),
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
        name = content.text("Carving the tip of the shaft to fit the socket and securing the head.  Wrapping and riveting"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", time_multiplier = 1.5, skill_penalty = 0 },
        },
    }
)

content.add(content.Recipe {
    id = "qt_pike",
    result = "qt_pike",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :component("long_pole", 1)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :component("nail", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :requirement("metal_punch", 1)
    :requirement("quench", 120)
    :book("textbook_weapwest", 8)
    :byproduct("water", 120)
    :step {
        name = content.text("Forge welding and cutting steel for the spearhead"),
        duration_moves = 480000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Forming the mounting socket using taper drift as mandrel.  Etching touchmark on underside of socket"),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        tools = {
            { { id = "drift", count = 1 } },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Drawing out metal for blade"),
        duration_moves = 600000,
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
        name = content.text("Normalizing"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding"),
        duration_moves = 960000,
        activity_level = BRISK_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating and thorough hardening"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Grinding away forge scale to observe temper color"),
        duration_moves = 180000,
        activity_level = MODERATE_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Tempering the pike to purple-bluish"),
        duration_moves = 1560000,
        activity_level = NO_EXERCISE,
        qualities = {
            { { id = "TEMPER", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final grinding and polishing"),
        duration_moves = 960000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Carving the tip of the shaft to fit the socket and securing the head.  Wrapping and riveting"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", time_multiplier = 1.5, skill_penalty = 0 },
        },
    }
)

content.add(content.Recipe {
    id = "ch_knife_rambo",
    result = "ch_knife_rambo",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("quench", 120)
    :byproduct("water", 120)
    :step {
        name = content.text("Heating and preparing steel"),
        duration_moves = 240000,
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
        name = content.text("Drawing out the blade, forming the hollow handle, and forge-welding together"),
        duration_moves = 480000,
        activity_level = BRISK_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Hotcutting saw teeth"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalization cycle to relieve major forging stresses"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding on primary bevels and saw teeth"),
        duration_moves = 540000,
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
        name = content.text("Heating and edge-quenching"),
        duration_moves = 180000,
        activity_level = MODERATE_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Final polish, sealing the hollow handle, and seating the pommel"),
        duration_moves = 600000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
            { id = "prof_metalworking" },
        },
    }
)

content.add(content.Recipe {
    id = "qt_knife_rambo",
    result = "qt_knife_rambo",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "fabrication",
    difficulty = 8,
}
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("quench", 120)
    :byproduct("water", 120)
    :step {
        name = content.text("Heating and preparing steel"),
        duration_moves = 240000,
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
        name = content.text("Drawing out the blade, forming the hollow handle, and forge-welding together"),
        duration_moves = 480000,
        activity_level = BRISK_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Hotcutting saw teeth"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalization cycle to relieve forging stresses"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding on primary bevels and saw teeth"),
        duration_moves = 540000,
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
        name = content.text("Heating and thorough hardening"),
        duration_moves = 120000,
        activity_level = MODERATE_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Tempering the knife to a spring temper"),
        duration_moves = 1080000,
        activity_level = NO_EXERCISE,
        qualities = {
            { { id = "TEMPER", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final polish, sealing the hollow handle, and seating the pommel"),
        duration_moves = 720000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
            { id = "prof_metalworking" },
        },
    }
)

content.add(content.Recipe {
    id = "bronze_knife",
    result = "bronze_knife",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("cordage_short", 2, true)
    :component("scrap_bronze", 2)
    :component_any({
            { id = "leather", count = 1 },
            { id = "fur", count = 1 }
        })
    :component("adhesive", 2, true)
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :step {
        name = content.text("Melting scrap bronze and molding"),
        duration_moves = 540000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "casting_mold", count = 1 } },
        },
        proficiencies = {
            { id = "prof_redsmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Removing the rough casting and cleaning off sprue"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Cold-forging and planishing the bronze knife to work-harden the blade edges"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_redsmithing_adv" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Grinding the hardened bronze to a sharp edge and polishing the blade"),
        duration_moves = 540000,
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
        name = content.text("Applying adhesive and tightly wrapping the tang with cordage and leather for a secure grip"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "knife_trench",
    result = "knife_trench",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :book("manual_knives", 4)
    :book("recipe_melee", 5)
    :step {
        name = content.text("Forge welding and cutting steel for the blade, tang, and guard"),
        duration_moves = 180000,
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
        name = content.text("Drawing out the double-edged blade profile and forming the handle tang"),
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
        name = content.text("Forging and shaping the guard.  Forge welding to knife"),
        duration_moves = 540000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
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
        name = content.text("Grinding and filing"),
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
        name = content.text("Carving wooden scales from the stock and pinning them to the tang inside the guard"),
        duration_moves = 300000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "hc_knife_trench",
    result = "hc_knife_trench",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :requirement("blacksmithing_standard", 8)
    :requirement("hc_steel_standard", 2)
    :book("manual_knives", 4)
    :book("recipe_melee", 5)
    :step {
        name = content.text("Forge welding and cutting steel for the blade, tang, and guard"),
        duration_moves = 180000,
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
        name = content.text("Drawing out the double-edged blade profile and forming the handle tang"),
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
        name = content.text("Forging and shaping the guard.  Forge welding to knife"),
        duration_moves = 540000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
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
        name = content.text("Grinding and filing"),
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
        name = content.text("Carving wooden scales from the stock and pinning them to the tang inside the guard"),
        duration_moves = 300000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "ch_knife_trench",
    result = "ch_knife_trench",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :requirement("quench", 120)
    :book("manual_knives", 5)
    :book("recipe_melee", 6)
    :byproduct("water", 120)
    :step {
        name = content.text("Forge welding and cutting steel for the blade, tang, and guard"),
        duration_moves = 180000,
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
        name = content.text("Drawing out the double-edged blade profile and forming the handle tang"),
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
        name = content.text("Forging and shaping the guard.  Forge welding to knife"),
        duration_moves = 540000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
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
        name = content.text("Rough grinding"),
        duration_moves = 540000,
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
        name = content.text("Heating knife and carefully slack quenching.  Watching steel until desired toughness is achieved"),
        duration_moves = 300000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Final grind and polish"),
        duration_moves = 420000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
    :step {
        name = content.text("Carving wooden scales from the stock and pinning them to the tang inside the guard"),
        duration_moves = 300000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "qt_knife_trench",
    result = "qt_knife_trench",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :requirement("quench", 120)
    :book("manual_knives", 6)
    :book("recipe_melee", 7)
    :byproduct("water", 120)
    :step {
        name = content.text("Forge welding and cutting steel for the blade, tang, and guard"),
        duration_moves = 180000,
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
        name = content.text("Drawing out the double-edged blade profile and forming the handle tang"),
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
        name = content.text("Forging and shaping the guard.  Etching touchmark into underside of handle.  Forge welding to knife"),
        duration_moves = 540000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
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
        name = content.text("Rough grinding"),
        duration_moves = 540000,
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
        name = content.text("Thorough hardening"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Grinding away forge scale to observe temper"),
        duration_moves = 180000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
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
        name = content.text("Final grind and polish"),
        duration_moves = 600000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
    :step {
        name = content.text("Carving wooden scales from the stock and pinning them to the tang inside the guard"),
        duration_moves = 300000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "lc_rapier",
    result = "lc_rapier",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :book("textbook_weapwest", 7)
    :step {
        name = content.text("Heating and cutting low-carbon steel stock for the long blade and hilt"),
        duration_moves = 180000,
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
        name = content.text("Drawing out the long, slender blade and forging the tang"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Forging a simple crossguard"),
        duration_moves = 360000,
        activity_level = BRISK_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Grinding the blade to achieve proper distal taper"),
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
        name = content.text("Fitting the guard, shaping the grip, and peening the tang to secure the hilt"),
        duration_moves = 180000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "rapier",
    result = "rapier",
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
    :book("textbook_weapwest", 8)
    :step {
        name = content.text("Forge welding steel for the blade, tang, and hilt"),
        duration_moves = 300000,
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
        duration_moves = 1020000,
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
        name = content.text("Forging simple hilt"),
        duration_moves = 480000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Grinding the blade to create distal taper and point"),
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
        name = content.text("Assembling the hilt, wrapping the grip, and binding it with wire"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
)

content.add(content.Recipe {
    id = "hc_rapier",
    result = "hc_rapier",
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
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :book("textbook_weapwest", 8)
    :step {
        name = content.text("Forge welding steel for the blade, tang, and hilt"),
        duration_moves = 300000,
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
        duration_moves = 1020000,
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
        name = content.text("Forging simple hilt"),
        duration_moves = 480000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Normalizing the blade"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Grinding the blade to create distal taper and point"),
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
        name = content.text("Assembling the hilt, wrapping the grip, and binding it with wire"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
)

content.add(content.Recipe {
    id = "ch_rapier",
    result = "ch_rapier",
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
    :component("hc_wire", 2)
    :requirement("blacksmithing_standard", 8)
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
    id = "qt_rapier",
    result = "qt_rapier",
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
    :component("hc_wire", 2)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 3)
    :requirement("quench", 120)
    :book("textbook_weapwest", 8)
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
    id = "tanto",
    result = "tanto",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :book("textbook_weapeast", 6)
    :book("manual_knives", 7)
    :book("recipe_melee", 8)
    :step {
        name = content.text("Heating and cutting steel for  blade and tang"),
        duration_moves = 180000,
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
        name = content.text("Drawing out the steel and forging single-edged blade geometry and point"),
        duration_moves = 540000,
        activity_level = BRISK_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing the blade to relieve stress"),
        duration_moves = 240000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Grinding and polishing the blade"),
        duration_moves = 480000,
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
        name = content.text("Carving the tsuka, tightly wrapping it for grip, and securing the tang"),
        duration_moves = 480000,
        activity_level = MODERATE_EXERCISE,
    }
)
