local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6
local ACTIVE_EXERCISE = 8

content.add(content.Recipe {
    id = "bat",
    result = "bat",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("wooden_post", 1)
    :byproduct("splinter", 30)
    :step {
        name = content.text("Sawing rough shape"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "SAW_W", level = 1, count = 1 } },
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", time_multiplier = 2 },
        },
    }
    :step {
        name = content.text("Filing final shape"),
        duration_moves = 720000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FILE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", time_multiplier = 2 },
        },
    }
)

content.add(content.Recipe {
    id = "hollow_cane",
    result = "hollow_cane",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("2x4", 1)
    :component("nails", 5, true)
    :requirement("adhesive", 1)
    :step {
        name = content.text("Sawing rough shape"),
        duration_moves = 120000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "SAW_W", level = 1, count = 1 } },
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", time_multiplier = 2 },
        },
    }
    :step {
        name = content.text("Filing final shape"),
        duration_moves = 60000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", time_multiplier = 2 },
        },
    }
    :step {
        name = content.text("Assembling"),
        duration_moves = 60000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 1, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "shillelagh",
    result = "shillelagh",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("log", 1)
    :requirement("wood_sealant_any", 1)
    :requires_skill("survival", 2)
    :step {
        name = content.text("Sawing to length"),
        duration_moves = 120000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "SAW_W", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Carving shaft and head"),
        duration_moves = 360000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", time_multiplier = 1.5 },
        },
    }
    :step {
        name = content.text("Smoke-curing wood"),
        duration_moves = 1440000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        tools = {
            { { id = "smoking_heat", charges = 120, requirement = true } },
        },
    }
    :step {
        name = content.text("Applying sealant"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "shillelagh_weighted",
    result = "shillelagh_weighted",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("shillelagh", 1)
    :component("weights", 15, true)
    :requirement("forging_standard", 5)
    :step {
        name = content.text("Drilling core cavity"),
        duration_moves = 60000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "DRILL", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Melting and pouring metal"),
        duration_moves = 480000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            {
                { id = "crucible", count = 1 },
                { id = "crucible_clay", count = 1 },
            },
        },
        proficiencies = {
            { id = "prof_metalworking", time_multiplier = 2 },
        },
    }
)

content.add(content.Recipe {
    id = "blackjack",
    result = "blackjack",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("leather", 5)
    :component("spring", 1)
    :component("weights", 10, true)
    :requirement("sewing_standard", 10)
    :requires_skill("survival", 1)
    :step {
        name = content.text("Cutting and preparing leather"),
        duration_moves = 90000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_standard", multiplier = 10 },
        },
        proficiencies = {
            { id = "prof_leatherworking_basic" },
        },
    }
    :step {
        name = content.text("Assembling core and weights"),
        duration_moves = 120000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing leather casing"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 10 },
        },
        proficiencies = {
            { id = "prof_leatherworking_basic", time_multiplier = 2 },
        },
    }
)

content.add(content.Recipe {
    id = "makeshift_sap",
    result = "makeshift_sap",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    autolearn = true,
    skill = "survival",
}
    :component("leather", 2)
    :component_any({
            { id = "steel_chunk_any", count = 1, requirement = true },
            { id = "weights", count = 8, requirement = true }
        })
    :requirement("sewing_standard", 10)
    :step {
        name = content.text("Packing weight and rough shaping"),
        duration_moves = 60000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing leather binding"),
        duration_moves = 60000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 10 },
        },
        proficiencies = {
            { id = "prof_leatherworking_basic", time_multiplier = 2 },
        },
    }
)

-- glue is for ~60cm2 for the cables
content.add(content.Recipe {
    id = "shock_staff",
    result = "shock_staff",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("i_staff", 1)
    :component("tazer", 1)
    :component("cable", 4)
    :component("nuts_bolts", 4)
    :requirement("drilling_standard", 5)
    :requirement("glue_strong", 30)
    :requires_skill("electronics", 3)
    :book("textbook_electronics", 3)
    :book("advanced_electronics", 3)
    :book("recipe_melee", 4)
    :step {
        name = content.text("Preparing staff by drilling and mounting electronics"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "WRENCH", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Routing and stripping cables"),
        duration_moves = 780000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_shock_weapons" },
        },
    }
    :step {
        name = content.text("Gluing in the cables"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "2h_flail_wood",
    result = "2h_flail_wood",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick_long", count = 1 }
        })
    :component("leather", 5)
    :requires_skill("bashing", 2)
    :step {
        name = content.text("Carving striking head and handle"),
        duration_moves = 420000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "SAW_W", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Cutting and preparing leather cord"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_leatherworking_basic", skill_penalty = 0 },
        },
    }
    :step {
        name = content.text("Assembling and binding"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_standard", multiplier = 10 },
        },
    }
)

content.add(content.Recipe {
    id = "2h_flail_steel",
    result = "2h_flail_steel",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("stick_long", 1)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_weapwest", 6)
    :step {
        name = content.text("Forging chain links and steel head"),
        duration_moves = 1080000,
        activity_level = BRISK_EXERCISE,
        tools = {
            { { id = "swage", count = 1 } },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Shaping and normalizing head"),
        duration_moves = 840000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_toolsmithing" },
        },
    }
    :step {
        name = content.text("Final shaping and filing"),
        duration_moves = 1080000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
    :step {
        name = content.text("Preparing handle and leather wrapping"),
        duration_moves = 150000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "FILE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", skill_penalty = 0 },
            { id = "prof_leatherworking_basic", skill_penalty = 0 },
        },
    }
    :step {
        name = content.text("Final assembly"),
        duration_moves = 60000,
        activity_level = NO_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "2h_club_kanabo_studded",
    result = "2h_club_kanabo_studded",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("log", 1)
    :component("scrap", 20)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :requires_skill("bashing", 1)
    :book("textbook_weapeast", 2)
    :step {
        name = content.text("Carving rough club shape"),
        duration_moves = 540000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "SAW_W", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Melting scrap and forging studs"),
        duration_moves = 1440000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Truing and normalizing studs"),
        duration_moves = 360000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Final club shaping and filing"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Drilling holes and mounting studs"),
        duration_moves = 90000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "DRILL", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "2h_club_kanabo_spiked",
    result = "2h_club_kanabo_spiked",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("log", 1)
    :component("scrap", 20)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :requires_skill("bashing", 1)
    :book("textbook_weapeast", 2)
    :step {
        name = content.text("Carving rough club shape"),
        duration_moves = 540000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "SAW_W", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Melting scrap and forging studs"),
        duration_moves = 1440000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Truing and normalizing studs"),
        duration_moves = 360000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Final club shaping and filing"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Drilling holes and mounting studs"),
        duration_moves = 90000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "DRILL", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "lucern_hammer",
    result = "lucern_hammer",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("stick_long", 1)
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :component("nail", 5)
    :requirement("blacksmithing_standard", 12)
    :requirement("steel_standard", 3)
    :book("textbook_weapwest", 6)
    :step {
        name = content.text("Heating steel and forge welding lumps for hammer head and beak"),
        duration_moves = 540000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Cutting off excess and squaring the steel stock"),
        duration_moves = 600000,
        activity_level = BRISK_EXERCISE,
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
        name = content.text("Punching and drifting eye"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        requirements = {
            { id = "metal_punch", multiplier = 1 },
        },
    }
    :step {
        name = content.text("Drawing out and curving steel for beak."),
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
        name = content.text("Forming hammer head.  Hotcutting grooves in the head"),
        duration_moves = 660000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_toolsmithing" },
        },
    }
    :step {
        name = content.text("Forge welding steel for top spike and langets"),
        duration_moves = 720000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Forming top spike socket and drawing out spike and langets.  Punching sockets"),
        duration_moves = 480000,
        activity_level = BRISK_EXERCISE,
        tools = {
            { { id = "drift", count = 1 } },
            { { id = "hammer", count = 1 } },
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
        name = content.text("Shrink fitting head to spike socket and forge welding them together"),
        duration_moves = 180000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Normalizing the fused head"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
    }
    :step {
        name = content.text("Rough grinding.  Bevel shaping"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Final grind and polish"),
        duration_moves = 480000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
    :step {
        name = content.text("Preparing handle and leather wrapping"),
        duration_moves = 150000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "FILE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", skill_penalty = 0 },
        },
    }
    :step {
        name = content.text("Attaching langets into handle"),
        duration_moves = 90000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "DRILL", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "lc_aztec_sword",
    result = "lc_aztec_sword",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component("2x4", 2)
    :requirement("blacksmithing_standard", 6)
    :requirement("lc_steel_standard", 3)
    :requirement("wood_sealant_any", 2)
    :step {
        name = content.text("Rough shaping the body"),
        duration_moves = 600000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "SAW_W", level = 2, count = 1 } },
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Chiseling channels for the steel inserts"),
        duration_moves = 360000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Flattening and drawing out steel"),
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
        name = content.text("Hotcutting steel inserts"),
        duration_moves = 240000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
    }
    :step {
        name = content.text("Filing steep bevels"),
        duration_moves = 720000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Seating the steel teeth and applying sealant"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Smoothing shape"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FILE", level = 1, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "mc_aztec_sword",
    result = "mc_aztec_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("2x4", 2)
    :component_any({
            { id = "leather", count = 3 },
            { id = "fur", count = 3 },
            { id = "faux_fur", count = 3 }
        })
    :requirement("blacksmithing_standard", 6)
    :requirement("mc_steel_standard", 3)
    :requirement("wood_sealant_any", 2)
    :book("textbook_mesoam", 4)
    :step {
        name = content.text("Roughly shaping the body"),
        duration_moves = 630000,
        activity_level = ACTIVE_EXERCISE,
        qualities = {
            { { id = "SAW_W", level = 2, count = 1 } },
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Cutting channels for the steel inserts"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Forging and drawing out stock"),
        duration_moves = 540000,
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
        name = content.text("Hotcutting and shaping steel teeth"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
    }
    :step {
        name = content.text("Rough grinding"),
        duration_moves = 720000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing the steel teeth"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Final edge honing"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FILE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Seating the teeth and applying resin sealant"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Fault correcting body.  Wrapping the handle for grip"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "hc_aztec_sword",
    result = "hc_aztec_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("2x4", 2)
    :component_any({
            { id = "leather", count = 3 },
            { id = "fur", count = 3 },
            { id = "faux_fur", count = 3 }
        })
    :requirement("blacksmithing_standard", 6)
    :requirement("hc_steel_standard", 3)
    :requirement("wood_sealant_any", 2)
    :book("textbook_mesoam", 5)
    :step {
        name = content.text("Roughly shaping the body"),
        duration_moves = 660000,
        activity_level = ACTIVE_EXERCISE,
        qualities = {
            { { id = "SAW_W", level = 2, count = 1 } },
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Chiseling channels for the steel inserts"),
        duration_moves = 450000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "CHISEL", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Forging and carefully drawing out stock"),
        duration_moves = 600000,
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
        name = content.text("Hotcutting and shaping steel teeth"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
    }
    :step {
        name = content.text("Rough grinding"),
        duration_moves = 720000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Annealing the steel teeth to prevent shattering"),
        duration_moves = 720000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Final shaping and edge honing"),
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
        name = content.text("Seating the teeth and applying resin sealant"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Fault correcting body.  Wrapping the handle for grip"),
        duration_moves = 180000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "ch_aztec_sword",
    result = "ch_aztec_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("2x4", 2)
    :component_any({
            { id = "leather", count = 3 },
            { id = "scrap_kevlar", count = 3 }
        })
    :requirement("blacksmithing_standard", 6)
    :requirement("mc_steel_standard", 3)
    :requirement("wood_sealant_any", 2)
    :requirement("quench", 120)
    :book("textbook_mesoam", 6)
    :byproduct("water", 120)
    :step {
        name = content.text("Roughly shaping the body"),
        duration_moves = 660000,
        activity_level = ACTIVE_EXERCISE,
        qualities = {
            { { id = "SAW_W", level = 2, count = 1 } },
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Chiseling channels for the steel inserts"),
        duration_moves = 450000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "CHISEL", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Forging and carefully drawing out stock"),
        duration_moves = 600000,
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
        name = content.text("Hotcutting and shaping steel teeth"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
    }
    :step {
        name = content.text("Normalizing steel to prepare for hardening"),
        duration_moves = 540000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding"),
        duration_moves = 720000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating the steel teeth and edge quenching"),
        duration_moves = 720000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Waiting for spine to cool slightly.  Softening edge slightly through residual heat and watching steel color"),
        duration_moves = 90000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Quenching spine of teeth carefully"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Final shaping and carefully honing hardened steel"),
        duration_moves = 360000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Seating the teeth and applying resin sealant"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Fault correcting body.  Wrapping the handle for grip"),
        duration_moves = 180000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "qt_aztec_sword",
    result = "qt_aztec_sword",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("2x4", 2)
    :component_any({
            { id = "leather", count = 3 },
            { id = "scrap_kevlar", count = 3 }
        })
    :requirement("blacksmithing_standard", 10)
    :requirement("mc_steel_standard", 3)
    :requirement("wood_sealant_any", 2)
    :requirement("quench", 120)
    :book("textbook_mesoam", 6)
    :byproduct("water", 120)
    :step {
        name = content.text("Roughly shaping the body"),
        duration_moves = 660000,
        activity_level = ACTIVE_EXERCISE,
        qualities = {
            { { id = "SAW_W", level = 2, count = 1 } },
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Chiseling channels for the steel inserts"),
        duration_moves = 450000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "CHISEL", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Forging and carefully drawing out stock"),
        duration_moves = 600000,
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
        name = content.text("Hotcutting and shaping steel teeth"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
    }
    :step {
        name = content.text("Normalizing steel to prepare for hardening"),
        duration_moves = 540000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding"),
        duration_moves = 960000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 1, count = 1 } },
            { { id = "GRIND", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating the steel and thorough hardening"),
        duration_moves = 480000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Tempering"),
        duration_moves = 1440000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "TEMPER", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final shaping and honing steel"),
        duration_moves = 360000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Seating the teeth and applying resin sealant"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
    }
    :step {
        name = content.text("Fault correcting body.  Wrapping the handle for grip"),
        duration_moves = 180000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "lc_aztec_spear",
    result = "lc_aztec_spear",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component("spear_shaft", 1)
    :component("2x4", 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("lc_steel_standard", 1)
    :requirement("wood_sealant_any", 1)
    :book("textbook_mesoam", 3)
    :step {
        name = content.text("Rough shaping the spearhead"),
        duration_moves = 240000,
        activity_level = ACTIVE_EXERCISE,
        qualities = {
            { { id = "SAW_W", level = 2, count = 1 } },
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Chiseling channels for the steel inserts"),
        duration_moves = 120000,
        activity_level = ACTIVE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Flattening and drawing out steel"),
        duration_moves = 360000,
        activity_level = BRISK_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Hotcutting steel inserts"),
        duration_moves = 120000,
        activity_level = BRISK_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
    }
    :step {
        name = content.text("Filing and grinding bevels"),
        duration_moves = 540000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 1, count = 1 } },
            { { id = "GRIND", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Seating the steel teeth and attaching to shaft"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Smoothing shape"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FILE", level = 1, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "mc_aztec_spear",
    result = "mc_aztec_spear",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("spear_shaft", 1)
    :component("2x4", 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("mc_steel_standard", 1)
    :requirement("wood_sealant_any", 1)
    :book("textbook_mesoam", 4)
    :step {
        name = content.text("Roughly shaping the spear base"),
        duration_moves = 360000,
        activity_level = ACTIVE_EXERCISE,
        qualities = {
            { { id = "SAW_W", level = 2, count = 1 } },
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Cutting channels for the steel inserts"),
        duration_moves = 240000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Forging and drawing out stock"),
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
        name = content.text("Hotcutting and shaping steel teeth"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
    }
    :step {
        name = content.text("Rough grinding"),
        duration_moves = 660000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 1, count = 1 } },
            { { id = "GRIND", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing the steel teeth"),
        duration_moves = 300000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Final edge honing"),
        duration_moves = 180000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Seating the teeth and attaching head to shaft"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Smoothing shape"),
        duration_moves = 120000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "hc_aztec_spear",
    result = "hc_aztec_spear",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("spear_shaft", 1)
    :component("2x4", 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("hc_steel_standard", 1)
    :requirement("wood_sealant_any", 1)
    :book("textbook_mesoam", 5)
    :step {
        name = content.text("Roughly shaping the spear base"),
        duration_moves = 420000,
        activity_level = ACTIVE_EXERCISE,
        qualities = {
            { { id = "SAW_W", level = 2, count = 1 } },
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Chiseling channels for the steel inserts"),
        duration_moves = 360000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "CHISEL", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Forging and carefully drawing out stock"),
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
        name = content.text("Hotcutting and shaping steel teeth"),
        duration_moves = 300000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
    }
    :step {
        name = content.text("Rough grinding"),
        duration_moves = 780000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "FILE", level = 1, count = 1 } },
            { { id = "GRIND", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Annealing the steel teeth to prevent shattering"),
        duration_moves = 600000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Final shaping and edge honing"),
        duration_moves = 180000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Seating the teeth and attaching to shaft"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
    }
    :step {
        name = content.text("Smoothing shape"),
        duration_moves = 180000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "ch_aztec_spear",
    result = "ch_aztec_spear",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("spear_shaft", 1)
    :component("2x4", 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("mc_steel_standard", 1)
    :requirement("wood_sealant_any", 1)
    :requirement("quench", 120)
    :book("textbook_mesoam", 6)
    :byproduct("water", 120)
    :step {
        name = content.text("Roughly shaping the spear base"),
        duration_moves = 600000,
        activity_level = ACTIVE_EXERCISE,
        qualities = {
            { { id = "SAW_W", level = 2, count = 1 } },
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Chiseling channels for the steel inserts"),
        duration_moves = 420000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "CHISEL", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Forging and carefully drawing out stock"),
        duration_moves = 540000,
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
        name = content.text("Hotcutting and shaping steel teeth"),
        duration_moves = 300000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Normalizing steel to prepare for hardening"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding"),
        duration_moves = 840000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "FILE", level = 1, count = 1 } },
            { { id = "GRIND", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating the steel teeth and edge quenching"),
        duration_moves = 720000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Waiting for spine to cool slightly.  Watch edge for temper"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Quenching spine of teeth carefully"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Final shaping and carefully honing hardened steel"),
        duration_moves = 300000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Seating the teeth and attaching to shaft"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Smoothing shape"),
        duration_moves = 120000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "qt_aztec_spear",
    result = "qt_aztec_spear",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("spear_shaft", 1)
    :component("2x4", 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("wood_sealant_any", 1)
    :requirement("quench", 120)
    :book("textbook_mesoam", 6)
    :byproduct("water", 120)
    :step {
        name = content.text("Roughly shaping the spear base"),
        duration_moves = 540000,
        activity_level = ACTIVE_EXERCISE,
        qualities = {
            { { id = "SAW_W", level = 2, count = 1 } },
            { { id = "CUT", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Chiseling channels for the steel inserts"),
        duration_moves = 360000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "CHISEL", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving" },
        },
    }
    :step {
        name = content.text("Forging and carefully drawing out stock"),
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
        name = content.text("Hotcutting and shaping steel teeth"),
        duration_moves = 300000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "hotcut_any", multiplier = 1 },
        },
    }
    :step {
        name = content.text("Normalizing steel to prepare for hardening"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding"),
        duration_moves = 600000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Heating the steel and thorough hardening"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Tempering"),
        duration_moves = 1440000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "TEMPER", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final shaping and honing steel"),
        duration_moves = 300000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Seating the teeth and attaching to shaft"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
    }
    :step {
        name = content.text("Smoothing shape"),
        duration_moves = 180000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "sword_wood",
    result = "sword_wood",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    autolearn = true,
    skill = "fabrication",
}
    :component("2x4", 1)
    :step {
        name = content.text("Sawing plank into sword shape.  Trying to convince yourself it's a real sword"),
        duration_moves = 150000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "SAW_W", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carpentry_basic", skill_penalty = 0 },
            { id = "prof_carving", skill_penalty = 0 },
        },
    }
)

content.add(content.Recipe {
    id = "lc_warhammer",
    result = "lc_warhammer",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("2x4", 1)
    :requirement("blacksmithing_standard", 5)
    :requirement("lc_steel_standard", 2)
    :requirement("metal_punch", 1)
    :book("textbook_weapwest", 5)
    :book("recipe_melee", 5)
    :step {
        name = content.text("Heating steel and forge welding lumps for hammer head"),
        duration_moves = 360000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Cutting off excess and squaring the steel stock"),
        duration_moves = 540000,
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
        name = content.text("Punching and drifting the eye"),
        duration_moves = 210000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_toolsmithing" },
        },
    }
    :step {
        name = content.text("Drawing out and curving steel for the back spike"),
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
        name = content.text("Forming the hammer face and chiseling grooves"),
        duration_moves = 270000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
            { { id = "CHISEL", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_toolsmithing" },
        },
    }
    :step {
        name = content.text("Rough grinding and shaping the spike and face"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Final grind and polish"),
        duration_moves = 270000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
    :step {
        name = content.text("Sawing plank and shaping the wooden handle"),
        duration_moves = 240000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "SAW_W", level = 2, count = 1 } },
            { { id = "FILE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", skill_penalty = 0 },
        },
    }
    :step {
        name = content.text("Fitting and wedging the head to the handle"),
        duration_moves = 60000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "warhammer",
    result = "warhammer",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("2x4", 1)
    :component("nail", 4)
    :requirement("blacksmithing_standard", 5)
    :requirement("mc_steel_standard", 3)
    :requirement("metal_punch", 1)
    :book("textbook_weapwest", 6)
    :book("recipe_melee", 6)
    :step {
        name = content.text("Heating steel and forge welding lumps for hammer head and langlets"),
        duration_moves = 360000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Cutting off excess and squaring the steel stock"),
        duration_moves = 540000,
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
        name = content.text("Punching and drifting the eye"),
        duration_moves = 540000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_toolsmithing" },
        },
    }
    :step {
        name = content.text("Drawing out and curving steel for the back spike"),
        duration_moves = 420000,
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
        name = content.text("Drawing out langets and forge welding them to the head"),
        duration_moves = 360000,
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
        name = content.text("Forming the hammer face and chiseling grooves"),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
            { { id = "CHISEL", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_toolsmithing" },
        },
    }
    :step {
        name = content.text("Normalizing the hammer head"),
        duration_moves = 300000,
        activity_level = NO_EXERCISE,
    }
    :step {
        name = content.text("Rough grinding and shaping the spike and face"),
        duration_moves = 720000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Final grind and polish"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
    :step {
        name = content.text("Sawing plank and shaping the wooden handle"),
        duration_moves = 360000,
        activity_level = ACTIVE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "SAW_W", level = 2, count = 1 } },
            { { id = "FILE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", skill_penalty = 0 },
        },
    }
    :step {
        name = content.text("Fitting and wedging the head to the handle.  Attaching langets"),
        duration_moves = 90000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "DRILL", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "hc_warhammer",
    result = "hc_warhammer",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("2x4", 1)
    :component("nail", 4)
    :requirement("blacksmithing_standard", 5)
    :requirement("hc_steel_standard", 2)
    :requirement("metal_punch", 1)
    :book("textbook_weapwest", 6)
    :book("recipe_melee", 6)
    :step {
        name = content.text("Heating steel and forge welding lumps for hammer head"),
        duration_moves = 360000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Cutting off excess and squaring the steel stock"),
        duration_moves = 600000,
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
        name = content.text("Punching and drifting the eye"),
        duration_moves = 660000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_toolsmithing" },
        },
    }
    :step {
        name = content.text("Drawing out and curving steel for the back spike"),
        duration_moves = 480000,
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
        name = content.text("Drawing out langets and forge welding them to the head"),
        duration_moves = 360000,
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
        name = content.text("Forming the hammer face and chiseling grooves"),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
            { { id = "CHISEL", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_toolsmithing" },
        },
    }
    :step {
        name = content.text("Normalizing the hammer head"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
    }
    :step {
        name = content.text("Rough grinding and shaping the spike and face"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Final grind and polish"),
        duration_moves = 420000,
        activity_level = ACTIVE_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
    :step {
        name = content.text("Sawing plank and shaping the wooden handle"),
        duration_moves = 360000,
        activity_level = ACTIVE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "SAW_W", level = 2, count = 1 } },
            { { id = "FILE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", skill_penalty = 0 },
        },
    }
    :step {
        name = content.text("Fitting and wedging the head to the handle.  Attaching langets"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "DRILL", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "ch_warhammer",
    result = "ch_warhammer",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("2x4", 1)
    :component("nail", 4)
    :requirement("blacksmithing_standard", 5)
    :requirement("mc_steel_standard", 2)
    :requirement("metal_punch", 1)
    :requirement("quench", 120)
    :book("textbook_weapwest", 7)
    :book("recipe_melee", 7)
    :byproduct("water", 120)
    :step {
        name = content.text("Heating steel and forge welding lumps for hammer head"),
        duration_moves = 360000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Cutting off excess and squaring the steel stock"),
        duration_moves = 780000,
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
        name = content.text("Punching and drifting the eye"),
        duration_moves = 930000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_toolsmithing" },
        },
    }
    :step {
        name = content.text("Drawing out and curving steel for the beak"),
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
        name = content.text("Drawing out langets and forge welding them to the head"),
        duration_moves = 480000,
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
        name = content.text("Forming the hammer face and chiseling grooves"),
        duration_moves = 480000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
            { { id = "CHISEL", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_toolsmithing" },
        },
    }
    :step {
        name = content.text("Normalizing the hammer head"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
    }
    :step {
        name = content.text("Rough grinding and shaping the spike and face"),
        duration_moves = 840000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Another normalizing cycle before hardening"),
        duration_moves = 120000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Carefully heating and quenching the hammer head face, and the beak's edge"),
        duration_moves = 480000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Carefully letting the body air cool slightly to reduce brittleness.  Quenching in short bursts"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Final grind and polish on hardened steel"),
        duration_moves = 600000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Sawing plank and shaping the wooden handle"),
        duration_moves = 360000,
        activity_level = ACTIVE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "SAW_W", level = 2, count = 1 } },
            { { id = "FILE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", skill_penalty = 0 },
        },
    }
    :step {
        name = content.text("Fitting and wedging the head to the handle.  Attaching langets"),
        duration_moves = 240000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "DRILL", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "qt_warhammer",
    result = "qt_warhammer",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :component("2x4", 1)
    :component("nail", 4)
    :requirement("blacksmithing_standard", 5)
    :requirement("mc_steel_standard", 2)
    :requirement("metal_punch", 1)
    :requirement("quench", 120)
    :book("textbook_weapwest", 8)
    :book("recipe_melee", 8)
    :byproduct("water", 120)
    :step {
        name = content.text("Heating steel and forge welding lumps for hammer head"),
        duration_moves = 360000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Cutting off excess and squaring the steel stock"),
        duration_moves = 900000,
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
        name = content.text("Carefully punching and drifting the eye"),
        duration_moves = 1080000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_toolsmithing" },
        },
    }
    :step {
        name = content.text("Drawing out and curving steel for the beak"),
        duration_moves = 660000,
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
        name = content.text("Drawing out langets and forge welding them to the head"),
        duration_moves = 600000,
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
        name = content.text("Forming the hammer face and chiseling grooves.  Chiseling your touchmark on the hammer"),
        duration_moves = 660000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "HAMMER", level = 3, count = 1 } },
            { { id = "CHISEL", level = 3, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_toolsmithing" },
        },
    }
    :step {
        name = content.text("Normalizing the hammer head"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
    }
    :step {
        name = content.text("Rough grinding and shaping the spike and face"),
        duration_moves = 900000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Heating and thorough-hardening hammer head"),
        duration_moves = 120000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Carefully grinding away forge scale to see temper colors while tempering"),
        duration_moves = 180000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Tempering"),
        duration_moves = 1620000,
        activity_level = NO_EXERCISE,
        qualities = {
            { { id = "TEMPER", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
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
        name = content.text("Sawing plank and shaping the wooden handle"),
        duration_moves = 360000,
        activity_level = ACTIVE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "SAW_W", level = 2, count = 1 } },
            { { id = "FILE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", skill_penalty = 0 },
        },
    }
    :step {
        name = content.text("Fitting and wedging the head to the handle.  Attaching langets"),
        duration_moves = 240000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        qualities = {
            { { id = "DRILL", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "ch_mace",
    result = "ch_mace",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 5)
    :requirement("quench", 120)
    :book("textbook_weapwest", 4)
    :book("recipe_melee", 4)
    :book("textbook_weparabic", 4)
    :book("textbook_armschina", 4)
    :byproduct("water", 120)
    :step {
        name = content.text("Heating steel, forging the steel handle, and splitting end for the flanges"),
        duration_moves = 1440000,
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
        name = content.text("Forging and shaping symmetrical flanges"),
        duration_moves = 1080000,
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
        name = content.text("Cutting slots in flanges"),
        duration_moves = 480000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "SAW_M", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Sliding flanges in handle divots and forge welding them together"),
        duration_moves = 360000,
        activity_level = BRISK_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Normalizing mace"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
    }
    :step {
        name = content.text("Rough grinding and filing the flanges"),
        duration_moves = 1080000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Carefully differentially hardening all flanges.  Hardening handle."),
        duration_moves = 720000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Final grind, shaping the flange edges, and removing scale"),
        duration_moves = 540000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Wrapping grip with leather"),
        duration_moves = 90000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_leatherworking_basic", skill_penalty = 0 },
        },
    }
)

content.add(content.Recipe {
    id = "qt_mace",
    result = "qt_mace",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component_any({
            { id = "fur", count = 3 },
            { id = "leather", count = 3 }
        })
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 5)
    :requirement("quench", 120)
    :book("textbook_weapwest", 5)
    :book("recipe_melee", 5)
    :book("textbook_weparabic", 5)
    :book("textbook_armschina", 5)
    :byproduct("water", 120)
    :step {
        name = content.text("Heating steel, forging the steel handle, pommel and splitting end for the flanges.  Etching your touchmark into the handle"),
        duration_moves = 1440000,
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
        name = content.text("Forging and shaping symmetrical flanges"),
        duration_moves = 1140000,
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
        name = content.text("Cutting slots in flanges"),
        duration_moves = 480000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "SAW_M", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Sliding flanges in handle divots and forge welding them together"),
        duration_moves = 360000,
        activity_level = BRISK_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Normalizing mace"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
    }
    :step {
        name = content.text("Rough grinding and filing the flanges"),
        duration_moves = 1080000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Thorough hardening mace"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Grinding scale off roughly to observe temper colours"),
        duration_moves = 180000,
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
            { { id = "TEMPER", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Final grind, shaping flange edges, and removing remaining scale"),
        duration_moves = 420000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Wrapping grip with leather"),
        duration_moves = 90000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_leatherworking_basic", skill_penalty = 0 },
        },
    }
)

-- Originator set difficulty to 5.  It's a carved, polished and oiled stick.  If you look at other recipes of
-- that general difficulty, they're all way more difficult crafting.
-- TODO: adjust crafting time down by 4 hours when it's possible to separate the oiling time from the
-- crafting time easily.
content.add(content.Recipe {
    id = "bo_from long stick",
    result = "bo",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("stick_long", 1)
    :requirement("wood_sealant_any", 1)
    :step {
        name = content.text("Sawing stick and shaping the staff"),
        duration_moves = 360000,
        activity_level = ACTIVE_EXERCISE,
        qualities = {
            { { id = "CUT", level = 2, count = 1 } },
            { { id = "SAW_W", level = 2, count = 1 } },
            { { id = "FILE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_carving", skill_penalty = 0.5 },
        },
    }
    :step {
        name = content.text("Oiling staff.  Watching the proverbial paint dry"),
        duration_moves = 1440000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
    }
)

content.add(content.Recipe {
    id = "ch_steel_staff",
    result = "ch_steel_staff",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("bo", 1)
    :component("glue_strong", 5)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("quench", 120)
    :book("textbook_weapwest", 3)
    :book("recipe_melee", 4)
    :byproduct("water", 120)
    :step {
        name = content.text("Drawing out steel and forging bands using drift as a mandrel"),
        duration_moves = 540000,
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
        name = content.text("Normalizing the steel rings"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Heating and quenching the caps and rings to harden them against impacts"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Grinding and filing the bands to remove scale and shape them"),
        duration_moves = 360000,
        activity_level = BRISK_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Lining bands with strong glue.  Wedging bands into wood.  Cold driving them in place"),
        duration_moves = 270000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "qt_steel_staff",
    result = "qt_steel_staff",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("bo", 1)
    :component("glue_strong", 5)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("quench", 120)
    :book("textbook_weapwest", 4)
    :book("recipe_melee", 5)
    :byproduct("water", 120)
    :step {
        name = content.text("Drawing out steel and forging bands using drift as a mandrel"),
        duration_moves = 540000,
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
        name = content.text("Normalizing the steel rings"),
        duration_moves = 240000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Heating and thorough quenching rings"),
        duration_moves = 180000,
        activity_level = NO_EXERCISE,
        proficiencies = {
            { id = "prof_hardening" },
        },
    }
    :step {
        name = content.text("Grinding scale off roughly to observe temper colours"),
        duration_moves = 180000,
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
        proficiencies = {
            { id = "prof_tempering" },
        },
    }
    :step {
        name = content.text("Grinding and filing the bands to remove scale and shape"),
        duration_moves = 360000,
        activity_level = BRISK_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Carefully chiseling bands to fit perfectly in the staff.  Chiseling intricate motifs on each band"),
        duration_moves = 360000,
        activity_level = MODERATE_EXERCISE,
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Lining bands with strong glue.  Wedging bands into wood.  Cold driving them in place"),
        duration_moves = 270000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
    }
)
