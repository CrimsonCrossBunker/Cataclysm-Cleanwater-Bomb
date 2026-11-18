local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "machete",
    result = "machete",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :component_any({
            { id = "fur", count = 2 },
            { id = "leather", count = 2 }
        })
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :step {
        name = content.text("Forge welding & cutting steel"),
        duration_moves = 180000,
        activity_level = MODERATE_EXERCISE,
        tools = {
            {
                { id = "hotcut", count = 1 },
                { id = "hotcut_bronze", count = 1 },
            },
        },
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Forging profile and tang"),
        duration_moves = 900000,
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
        name = content.text("Forging bevels and tapering"),
        duration_moves = 420000,
        activity_level = BRISK_EXERCISE,
        tools = {
            { { id = "hammer", count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Truing the profile.  Flattening bevel."),
        duration_moves = 1080000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
            { id = "prof_bladesmith" },
        },
    }
    :step {
        name = content.text("Normalizing steel"),
        duration_moves = 270000,
        activity_level = NO_EXERCISE,
    }
    :step {
        name = content.text("Filing, sharpening, and polishing"),
        duration_moves = 1260000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_blacksmithing" },
        },
    }
    :step {
        name = content.text("Shaping and attaching handle"),
        duration_moves = 270000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
)

content.add(content.Recipe {
    id = "makeshift_steel_kiln",
    result = "makeshift_steel_kiln",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component("sheet_metal", 6)
    :component("fire_brick", 30)
    :component("thermometer", 2)
    :component("cable", 4)
    :component("mortar_build", 150)
    :component_any({
            { id = "water", count = 20 },
            { id = "water_clean", count = 20 }
        })
    :component("small_lcd_screen", 1)
    :component_any({
            { id = "element", count = 4 },
            { id = "crude_heating_element", count = 6 }
        })
    :component("hinge", 2)
    :component("amplifier", 1)
    :component("motor_micro", 1)
    :component("fanblade_metal", 1)
    :requirement("welding_standard", 60)
    :requirement("soldering_standard", 10)
    :requirement("steel_standard", 2)
    :requires_skill("electronics", 3)
    :book("textbook_fabrication", 4)
    :book("manual_electronics", 2)
    :step {
        name = content.text("Mixing the mortar and carefully lining the fire bricks."),
        duration_moves = 480000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Cutting and welding the hinges and sheet metal to form outer shell"),
        duration_moves = 300000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "SAW_M", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_welding_basic" },
        },
    }
    :step {
        name = content.text("Grinding grooves for the heating elements"),
        duration_moves = 360000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "GRIND", level = 2, count = 1 } },
        },
    }
    :step {
        name = content.text("Inserting thermometers in the heating chamber.  Installing the fan."),
        duration_moves = 120000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "DRILL", level = 2, count = 1 } },
        },
    }
    :step {
        name = content.text("Soldering connections for PID temperature controller and fan"),
        duration_moves = 300000,
        activity_level = MODERATE_EXERCISE,
        proficiencies = {
            { id = "prof_elec_soldering" },
            { id = "prof_welding_basic" },
        },
    }
    :step {
        name = content.text("Making small control box to protect electronics."),
        duration_moves = 240000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "SAW_M", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_welding_basic" },
        },
    }
    :step {
        name = content.text("Fit shell over forge.  Assembling door, and performing a low-temp burn to cure the mortar."),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        proficiencies = {
            { id = "prof_welding_basic" },
        },
    }
)
