local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "apron_cotton",
    result = "apron_cotton",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 9)
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
    id = "apron_cotton_xl",
    result = "apron_cotton_xl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton", 12)
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
    }
)

content.add(content.Recipe {
    id = "apron_cotton_xs",
    result = "apron_cotton_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton", 4)
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
    id = "apron_cotton_maid_apron",
    result = "apron_cotton",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
    variant = "maid_apron",
}
    :requirement("tailoring_cotton_patchwork", 9)
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
    id = "apron_cotton_xl_maid_apron_xl",
    result = "apron_cotton_xl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
    variant = "maid_apron_xl",
}
    :requirement("tailoring_cotton", 12)
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
    }
)

content.add(content.Recipe {
    id = "apron_cotton_xs_maid_apron_xs",
    result = "apron_cotton_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
    variant = "maid_apron_xs",
}
    :requirement("tailoring_cotton", 4)
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
    id = "waist_apron_short",
    result = "waist_apron_short",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 4)
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
    id = "waist_apron_short_xl",
    result = "waist_apron_short_xl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton", 6)
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
    id = "waist_apron_short_xs",
    result = "waist_apron_short_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton", 2)
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
    id = "waist_apron_short_maid_apron",
    result = "waist_apron_short",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
    variant = "maid_apron",
}
    :requirement("tailoring_cotton_patchwork", 4)
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
    id = "waist_apron_short_xl_maid_apron_xl",
    result = "waist_apron_short_xl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
    variant = "maid_apron_xl",
}
    :requirement("tailoring_cotton", 6)
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
    id = "waist_apron_short_xs_maid_apron_xs",
    result = "waist_apron_short_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
    variant = "maid_apron_xs",
}
    :requirement("tailoring_cotton", 2)
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
    id = "waist_apron_long",
    result = "waist_apron_long",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 6)
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
    id = "waist_apron_long_xl",
    result = "waist_apron_long_xl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton", 9)
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
    id = "waist_apron_long_xs",
    result = "waist_apron_long_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton", 3)
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
            { id = "sewing_tool", multiplier = 90 },
        },
    }
)

content.add(content.Recipe {
    id = "waist_apron_long_maid_apron",
    result = "waist_apron_long",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
    variant = "maid_apron",
}
    :requirement("tailoring_cotton_patchwork", 6)
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
    id = "waist_apron_long_xl_maid_apron_xl",
    result = "waist_apron_long_xl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
    variant = "maid_apron_xl",
}
    :requirement("tailoring_cotton", 9)
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
    id = "waist_apron_long_xs_maid_apron_xs",
    result = "waist_apron_long_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
    variant = "maid_apron_xs",
}
    :requirement("tailoring_cotton", 3)
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
            { id = "sewing_tool", multiplier = 90 },
        },
    }
)

content.add(content.Recipe {
    id = "binder_top",
    result = "binder_top",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 5)
    :requirement("tailoring_lycra_patchwork", 3)
    :byproduct("scrap_cotton", 3)
    :byproduct("scrap_lycra", 3)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 270000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_elastics" },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 270000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 45 },
        },
        proficiencies = {
            { id = "prof_elastics" },
        },
    }
)

content.add(content.Recipe {
    id = "xl_binder_top",
    result = "xl_binder_top",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 8)
    :requirement("tailoring_lycra_patchwork", 5)
    :byproduct("scrap_cotton", 6)
    :byproduct("scrap_lycra", 5)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_elastics" },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 360000,
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
    id = "xs_binder_top",
    result = "xs_binder_top",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 3)
    :requirement("tailoring_lycra_patchwork", 2)
    :byproduct("scrap_cotton", 2)
    :byproduct("scrap_lycra", 2)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_elastics" },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 30 },
        },
        proficiencies = {
            { id = "prof_elastics" },
        },
    }
)

content.add(content.Recipe {
    id = "bikini_top",
    result = "bikini_top",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("sewing_standard", 10)
    :requirement("tailoring_lycra_patchwork", 1)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :byproduct("scrap_lycra", 3)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_elastics", time_multiplier = 1.5, skill_penalty = 0.15 },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 30 },
        },
        proficiencies = {
            { id = "prof_elastics", time_multiplier = 1.5, skill_penalty = 0.15 },
        },
    }
)

content.add(content.Recipe {
    id = "bikini_top_fur",
    result = "bikini_top_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_fur_patchwork", 1)
    :book("mag_animecon", 1)
    :byproduct("scrap_fur", 2)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_leatherworking_basic", time_multiplier = 1.25, skill_penalty = 0.25 },
            { id = "prof_furriery", time_multiplier = 1.5, skill_penalty = 0.15 },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 30 },
        },
        proficiencies = {
            { id = "prof_leatherworking_basic", time_multiplier = 1.25, skill_penalty = 0.25 },
            { id = "prof_furriery", time_multiplier = 1.5, skill_penalty = 0.15 },
        },
    }
)

content.add(content.Recipe {
    id = "blazer",
    result = "blazer",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("button_plastic", 2)
    :requirement("tailoring_felt_patchwork", 27)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1260000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_closures" },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 1260000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 210 },
        },
        proficiencies = {
            { id = "prof_closures" },
        },
    }
)

content.add(content.Recipe {
    id = "bra",
    result = "bra",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("lc_wire", 1)
    :requirement("tailoring_cotton_patchwork", 1)
    :requirement("fastener_small", 3)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_closures" },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 60 },
        },
        proficiencies = {
            { id = "prof_closures" },
        },
    }
)

content.add(content.Recipe {
    id = "xl_bra",
    result = "xl_bra",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("lc_wire", 2)
    :requirement("tailoring_cotton_patchwork", 2)
    :requirement("fastener_small", 5)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 540000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_closures" },
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
            { id = "prof_closures" },
        },
    }
)

content.add(content.Recipe {
    id = "xs_bra",
    result = "xs_bra",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("lc_wire", 1)
    :requirement("tailoring_cotton_patchwork", 1)
    :requirement("fastener_small", 1)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_closures" },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 30 },
        },
        proficiencies = {
            { id = "prof_closures" },
        },
    }
)

content.add(content.Recipe {
    id = "coat_fur",
    result = "coat_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_cotton_patchwork", 6)
    :requirement("tailoring_fur_patchwork", 6)
    :requirement("fastener_large", 1)
    :requires_skill("survival", 1)
    :book("textbook_survival", 1)
    :book("trappers_companion", 3)
    :book("survival_book", 2)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1080000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_closures" },
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
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
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
        },
    }
)

content.add(content.Recipe {
    id = "xs_coat_fur",
    result = "xs_coat_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_cotton_patchwork", 4)
    :requirement("tailoring_fur_patchwork", 4)
    :requirement("fastener_large", 1)
    :requires_skill("survival", 1)
    :book("textbook_survival", 1)
    :book("trappers_companion", 3)
    :book("survival_book", 2)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1080000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_closures" },
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
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
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
        },
    }
)

content.add(content.Recipe {
    id = "xl_coat_fur",
    result = "xl_coat_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_cotton_patchwork", 8)
    :requirement("tailoring_fur_patchwork", 8)
    :requirement("fastener_large", 1)
    :requires_skill("survival", 1)
    :book("textbook_survival", 1)
    :book("trappers_companion", 3)
    :book("survival_book", 2)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1260000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_closures" },
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 1260000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 210 },
        },
        proficiencies = {
            { id = "prof_closures" },
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
        },
    }
)

content.add(content.Recipe {
    id = "coat_faux_fur",
    result = "coat_faux_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 6)
    :requirement("tailoring_faux_fur_patchwork", 6)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 4)
    :book("tailor_portfolio", 3)
    :book("recipe_fauxfur", 3)
    :byproduct("faux_fur", 3)
    :byproduct("scrap_faux_fur", 5)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1080000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_closures" },
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
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
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
        },
    }
)

content.add(content.Recipe {
    id = "xs_coat_faux_fur",
    result = "xs_coat_faux_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 4)
    :requirement("tailoring_faux_fur_patchwork", 4)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 4)
    :book("tailor_portfolio", 3)
    :book("recipe_fauxfur", 3)
    :byproduct("faux_fur", 3)
    :byproduct("scrap_faux_fur", 5)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1080000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_closures" },
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
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
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
        },
    }
)

content.add(content.Recipe {
    id = "xl_coat_faux_fur",
    result = "xl_coat_faux_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 8)
    :requirement("tailoring_faux_fur_patchwork", 8)
    :requirement("fastener_large", 1)
    :book("textbook_tailor", 4)
    :book("tailor_portfolio", 3)
    :book("recipe_fauxfur", 3)
    :byproduct("faux_fur", 3)
    :byproduct("scrap_faux_fur", 5)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1260000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_closures" },
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 1260000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 210 },
        },
        proficiencies = {
            { id = "prof_closures" },
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
        },
    }
)

content.add(content.Recipe {
    id = "duster",
    result = "duster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    disassembly_moves = 300000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_canvas_patchwork", 36)
    :requirement("fastener_large", 1)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1440000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_closures" },
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
    id = "xs_duster",
    result = "xs_duster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    disassembly_moves = 300000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_canvas_patchwork", 27)
    :requirement("fastener_large", 1)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1440000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_closures" },
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
    id = "xl_duster",
    result = "xl_duster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    disassembly_moves = 300000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_canvas_patchwork", 54)
    :requirement("fastener_large", 1)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1620000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_closures" },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 1620000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 270 },
        },
        proficiencies = {
            { id = "prof_closures" },
        },
    }
)

content.add(content.Recipe {
    id = "duster_fur",
    result = "duster_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    disassembly_moves = 300000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("sewing_standard", 60)
    :requirement("fabric_fur_pelt", 7)
    :requirement("fastener_large", 1)
    :requires_skill("survival", 1)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1800000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_closures" },
            { id = "prof_closures_waterproofing" },
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 1800000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 300 },
        },
        proficiencies = {
            { id = "prof_closures" },
            { id = "prof_closures_waterproofing" },
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
        },
    }
)

content.add(content.Recipe {
    id = "xs_duster_fur",
    result = "xs_duster_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    disassembly_moves = 300000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("sewing_standard", 45)
    :requirement("fabric_fur_pelt", 5)
    :requirement("fastener_large", 1)
    :requires_skill("survival", 1)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1800000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_closures" },
            { id = "prof_closures_waterproofing" },
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 1800000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 300 },
        },
        proficiencies = {
            { id = "prof_closures" },
            { id = "prof_closures_waterproofing" },
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
        },
    }
)

content.add(content.Recipe {
    id = "xl_duster_fur",
    result = "xl_duster_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    disassembly_moves = 300000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("sewing_standard", 80)
    :requirement("fabric_fur_pelt", 9)
    :requirement("fastener_large", 1)
    :requires_skill("survival", 1)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1980000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_closures" },
            { id = "prof_closures_waterproofing" },
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 1980000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 330 },
        },
        proficiencies = {
            { id = "prof_closures" },
            { id = "prof_closures_waterproofing" },
            { id = "prof_leatherworking_basic" },
            { id = "prof_furriery" },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie",
    result = "hoodie",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "sheet_cotton", count = 40 },
            { id = "sheet_cotton_patchwork", count = 40 }
        })
    :component("filament", 200, true)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 720000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 120 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_shark",
    result = "hoodie",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "shark",
}
    :component_any({
            { id = "sheet_cotton", count = 40 },
            { id = "sheet_cotton_patchwork", count = 40 }
        })
    :component("filament", 200, true)
    :component("faux_fur", 6)
    :byproduct("scrap_faux_fur", 12)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 720000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 120 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_bear",
    result = "hoodie",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "bear",
}
    :component_any({
            { id = "sheet_cotton", count = 40 },
            { id = "sheet_cotton_patchwork", count = 40 }
        })
    :component("filament", 200, true)
    :component("faux_fur", 6)
    :byproduct("scrap_faux_fur", 12)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 720000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 120 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_cat",
    result = "hoodie",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "cat",
}
    :component_any({
            { id = "sheet_cotton", count = 40 },
            { id = "sheet_cotton_patchwork", count = 40 }
        })
    :component("filament", 200, true)
    :component("faux_fur", 6)
    :byproduct("scrap_faux_fur", 12)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 720000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 120 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_bunny",
    result = "hoodie",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "bunny",
}
    :component_any({
            { id = "sheet_cotton", count = 40 },
            { id = "sheet_cotton_patchwork", count = 40 }
        })
    :component("filament", 200, true)
    :component("faux_fur", 6)
    :byproduct("scrap_faux_fur", 12)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 720000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 120 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_wolf",
    result = "hoodie",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "wolf",
}
    :component_any({
            { id = "sheet_cotton", count = 40 },
            { id = "sheet_cotton_patchwork", count = 40 }
        })
    :component("filament", 200, true)
    :component("faux_fur", 6)
    :byproduct("scrap_faux_fur", 12)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 720000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 120 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_lizard",
    result = "hoodie",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "lizard",
}
    :component_any({
            { id = "sheet_cotton", count = 40 },
            { id = "sheet_cotton_patchwork", count = 40 }
        })
    :component("filament", 200, true)
    :component("faux_fur", 6)
    :byproduct("scrap_faux_fur", 12)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 720000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 120 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_dog",
    result = "hoodie",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "dog",
}
    :component_any({
            { id = "sheet_cotton", count = 40 },
            { id = "sheet_cotton_patchwork", count = 40 }
        })
    :component("filament", 200, true)
    :component("faux_fur", 6)
    :byproduct("scrap_faux_fur", 12)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 720000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 120 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_panda",
    result = "hoodie",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "panda",
}
    :component_any({
            { id = "sheet_cotton", count = 40 },
            { id = "sheet_cotton_patchwork", count = 40 }
        })
    :component("filament", 200, true)
    :component("faux_fur", 6)
    :byproduct("scrap_faux_fur", 12)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 720000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 120 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_frog",
    result = "hoodie",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "frog",
}
    :component_any({
            { id = "sheet_cotton", count = 40 },
            { id = "sheet_cotton_patchwork", count = 40 }
        })
    :component("filament", 200, true)
    :component("faux_fur", 6)
    :byproduct("scrap_faux_fur", 12)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 720000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 120 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_cropped",
    result = "hoodie_cropped",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "sheet_cotton", count = 30 },
            { id = "sheet_cotton_patchwork", count = 30 }
        })
    :component("filament", 150, true)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 630000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 105 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_cropped_shark",
    result = "hoodie_cropped",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "shark",
}
    :component_any({
            { id = "sheet_cotton", count = 30 },
            { id = "sheet_cotton_patchwork", count = 30 }
        })
    :component("filament", 150, true)
    :component("faux_fur", 4)
    :byproduct("scrap_faux_fur", 8)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 630000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 105 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_cropped_bear",
    result = "hoodie_cropped",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "bear",
}
    :component_any({
            { id = "sheet_cotton", count = 30 },
            { id = "sheet_cotton_patchwork", count = 30 }
        })
    :component("filament", 150, true)
    :component("faux_fur", 4)
    :byproduct("scrap_faux_fur", 8)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 630000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 105 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_cropped_cat",
    result = "hoodie_cropped",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "cat",
}
    :component_any({
            { id = "sheet_cotton", count = 30 },
            { id = "sheet_cotton_patchwork", count = 30 }
        })
    :component("filament", 150, true)
    :component("faux_fur", 4)
    :byproduct("scrap_faux_fur", 8)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 630000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 105 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_cropped_bunny",
    result = "hoodie_cropped",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "bunny",
}
    :component_any({
            { id = "sheet_cotton", count = 30 },
            { id = "sheet_cotton_patchwork", count = 30 }
        })
    :component("filament", 150, true)
    :component("faux_fur", 4)
    :byproduct("scrap_faux_fur", 8)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 630000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 105 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_cropped_wolf",
    result = "hoodie_cropped",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "wolf",
}
    :component_any({
            { id = "sheet_cotton", count = 30 },
            { id = "sheet_cotton_patchwork", count = 30 }
        })
    :component("filament", 150, true)
    :component("faux_fur", 4)
    :byproduct("scrap_faux_fur", 8)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 630000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 105 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_cropped_lizard",
    result = "hoodie_cropped",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "lizard",
}
    :component_any({
            { id = "sheet_cotton", count = 30 },
            { id = "sheet_cotton_patchwork", count = 30 }
        })
    :component("filament", 150, true)
    :component("faux_fur", 4)
    :byproduct("scrap_faux_fur", 8)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 630000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 105 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_cropped_dog",
    result = "hoodie_cropped",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "dog",
}
    :component_any({
            { id = "sheet_cotton", count = 30 },
            { id = "sheet_cotton_patchwork", count = 30 }
        })
    :component("filament", 150, true)
    :component("faux_fur", 4)
    :byproduct("scrap_faux_fur", 8)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 630000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 105 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_cropped_panda",
    result = "hoodie_cropped",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "panda",
}
    :component_any({
            { id = "sheet_cotton", count = 30 },
            { id = "sheet_cotton_patchwork", count = 30 }
        })
    :component("filament", 150, true)
    :component("faux_fur", 4)
    :byproduct("scrap_faux_fur", 8)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 630000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 105 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)

content.add(content.Recipe {
    id = "hoodie_cropped_frog",
    result = "hoodie_cropped",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
    variant = "frog",
}
    :component_any({
            { id = "sheet_cotton", count = 30 },
            { id = "sheet_cotton_patchwork", count = 30 }
        })
    :component("filament", 150, true)
    :component("faux_fur", 4)
    :byproduct("scrap_faux_fur", 8)
    :step {
        name = content.text("Cut the fabric"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1 },
        },
    }
    :step {
        name = content.text("Sew the pieces"),
        duration_moves = 630000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 105 },
        },
        proficiencies = {
            { id = "prof_furriery", time_multiplier = 1.2 },
        },
    }
)
