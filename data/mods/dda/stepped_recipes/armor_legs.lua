local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "boy_shorts",
    result = "boy_shorts",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 2)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :byproduct("scrap_cotton", 28)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 60 },
        },
    }
)

content.add(content.Recipe {
    id = "xsboy_shorts",
    result = "xsboy_shorts",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 1)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :byproduct("scrap_cotton", 21)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 270000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 270000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 45 },
        },
    }
)

content.add(content.Recipe {
    id = "xlboy_shorts",
    result = "xlboy_shorts",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 3)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :byproduct("scrap_cotton", 35)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 450000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 450000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 75 },
        },
    }
)

content.add(content.Recipe {
    id = "boxer_briefs_boxer_brief_makeshift",
    result = "boxer_briefs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
    variant = "boxer_brief_makeshift",
}
    :requirement("tailoring_cotton_patchwork", 2)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :byproduct("scrap_cotton", 28)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 60 },
        },
    }
)

content.add(content.Recipe {
    id = "xsboxer_briefs",
    result = "xsboxer_briefs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 2)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :byproduct("scrap_cotton", 28)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 60 },
        },
    }
)

content.add(content.Recipe {
    id = "xlboxer_briefs",
    result = "xlboxer_briefs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 3)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :byproduct("scrap_cotton", 35)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 450000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 450000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 75 },
        },
    }
)

content.add(content.Recipe {
    id = "boxer_shorts_boxer_shorts_makeshift",
    result = "boxer_shorts",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
    variant = "boxer_shorts_makeshift",
}
    :requirement("tailoring_cotton_patchwork", 2)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :byproduct("scrap_cotton", 28)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 60 },
        },
    }
)

content.add(content.Recipe {
    id = "xsboxer_shorts",
    result = "xsboxer_shorts",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 2)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :byproduct("scrap_cotton", 28)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 60 },
        },
    }
)

content.add(content.Recipe {
    id = "xlboxer_shorts",
    result = "xlboxer_shorts",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 3)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :byproduct("scrap_cotton", 35)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 450000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 450000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 75 },
        },
    }
)

content.add(content.Recipe {
    id = "breeches",
    result = "breeches",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 15)
    :book("textbook_tailor", 2)
    :book("tailor_portfolio", 2)
    :byproduct("scrap_cotton", 5)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1080000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 1080000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 180 },
        },
    }
)

content.add(content.Recipe {
    id = "briefs",
    result = "briefs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 1)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :byproduct("scrap_cotton", 5)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 60 },
        },
    }
)

content.add(content.Recipe {
    id = "hakama",
    result = "hakama",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 15)
    :book("tailor_japanese", 3)
    :byproduct("cotton_patchwork", 5)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 540000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 540000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 90 },
        },
    }
)

content.add(content.Recipe {
    id = "canvas_pants_padded",
    result = "canvas_pants_padded",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("technician_pants_gray", 1)
    :requirement("tailoring_cotton", 15)
    :byproduct("scrap_cotton", 5)
    :byproduct("cotton_patchwork", 4)
    :step {
        name = content.text("Cutting the padding"),
        duration_moves = 120000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the padding to the pants"),
        duration_moves = 120000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 20 },
        },
        proficiencies = {
            { id = "prof_closures" },
        },
    }
)

content.add(content.Recipe {
    id = "skirt",
    result = "skirt",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = false,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 7)
    :requirement("fastener_small", 1)
    :book("textbook_tailor", 3)
    :book("tailor_portfolio", 5)
    :book("manual_tailor", 3)
    :book("survival_book", 3)
    :byproduct("scrap_cotton", 10)
    :byproduct("cotton_patchwork", 2)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1080000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 1080000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 180 },
        },
        proficiencies = {
            { id = "prof_closures" },
        },
    }
)

content.add(content.Recipe {
    id = "skirt_denim",
    result = "skirt_denim",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = false,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_denim_patchwork", 4)
    :requirement("fastener_small", 1)
    :book("textbook_tailor", 3)
    :book("tailor_portfolio", 5)
    :book("manual_tailor", 3)
    :book("survival_book", 3)
    :byproduct("scrap_denim", 8)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1080000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 1080000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 180 },
        },
        proficiencies = {
            { id = "prof_closures" },
        },
    }
)

content.add(content.Recipe {
    id = "kilt",
    result = "kilt",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_felt_patchwork", 20)
    :requirement("strap_small", 1)
    :requirement("clasps", 1)
    :book("scots_tailor", 4)
    :book("scots_cookbook", 7)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1080000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 1080000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 180 },
        },
        proficiencies = {
            { id = "prof_closures" },
        },
    }
)

content.add(content.Recipe {
    id = "leg_warmers",
    result = "leg_warmers",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 2)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 270000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 270000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 45 },
        },
    }
)

content.add(content.Recipe {
    id = "leg_warmers_xs",
    result = "leg_warmers_xs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    reversible = false,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 1)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 30 },
        },
    }
)

content.add(content.Recipe {
    id = "leg_warmers_xl",
    result = "leg_warmers_xl",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    reversible = false,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 3)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 60 },
        },
    }
)

content.add(content.Recipe {
    id = "leggings",
    result = "leggings",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_lycra_patchwork", 6)
    :book("mag_tailor", 2)
    :book("manual_tailor", 2)
    :byproduct("lycra_patch", 5)
    :byproduct("scrap_lycra", 9)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 540000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 540000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 60 },
        },
        proficiencies = {
            { id = "prof_elastics" },
        },
    }
)

content.add(content.Recipe {
    id = "long_underpants",
    result = "long_underpants",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 3)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :byproduct("cotton_patchwork", 1)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 270000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 270000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 45 },
        },
    }
)

content.add(content.Recipe {
    id = "panties",
    result = "panties",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 1)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 30 },
        },
    }
)

content.add(content.Recipe {
    id = "pants_cargo",
    result = "pants_cargo",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 20)
    :requirement("fastener_small", 3)
    :learn_by_disassembly("tailor", 2)
    :book("textbook_tailor", 2)
    :book("manual_tailor", 2)
    :byproduct("cotton_patchwork", 5)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1440000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 1440000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 240 },
        },
        proficiencies = {
            { id = "prof_closures" },
        },
    }
)

content.add(content.Recipe {
    id = "shorts",
    result = "shorts",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 4)
    :requirement("fastener_small", 1)
    :byproduct("cotton_patchwork", 2)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 630000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 630000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 105 },
        },
        proficiencies = {
            { id = "prof_closures" },
        },
    }
)

content.add(content.Recipe {
    id = "shorts_cargo",
    result = "shorts_cargo",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 10)
    :requirement("fastener_small", 3)
    :book("manual_tailor", 1)
    :byproduct("cotton_patchwork", 2)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 810000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 810000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 135 },
        },
        proficiencies = {
            { id = "prof_closures" },
        },
    }
)

content.add(content.Recipe {
    id = "shorts_cargo_from_pants",
    result = "shorts_cargo",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
}
    :component("pants_cargo", 1)
    :requirement("sewing_standard", 12)
    :byproduct("cotton_patchwork", 4)
    :step {
        name = content.text("Sewing the pockets onto the shorts"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 30 },
        },
    }
)

content.add(content.Recipe {
    id = "shorts_denim_from_fabric",
    result = "shorts_denim",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_denim_patchwork", 4)
    :requirement("fastener_small", 1)
    :byproduct("denim_patch", 6)
    :byproduct("scrap_denim", 14)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 630000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 630000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 105 },
        },
        proficiencies = {
            { id = "prof_closures" },
        },
    }
)

content.add(content.Recipe {
    id = "stockings_tent_legs",
    result = "stockings_tent_legs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 9)
    :byproduct("cotton_patchwork", 3)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 540000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 540000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 90 },
        },
    }
)

content.add(content.Recipe {
    id = "under_armor_shorts",
    result = "under_armor_shorts",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_lycra_patchwork", 3)
    :book("mag_tailor", 2)
    :book("manual_tailor", 2)
    :byproduct("scrap_lycra", 2)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 540000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 540000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 90 },
        },
        proficiencies = {
            { id = "prof_elastics" },
        },
    }
)

content.add(content.Recipe {
    id = "gaiter_boot_makeshift",
    result = "gaiter_boot_makeshift",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("duct_tape", 150)
    :component("zipper_long_plastic", 1)
    :requirement("tailoring_cotton_patchwork", 3)
    :requires_skill("survival", 2)
    :requires_skill("fabrication", 1)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :step {
        name = content.text("Forming the gaiters"),
        duration_moves = 270000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the zippers"),
        duration_moves = 270000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 45 },
        },
    }
)
