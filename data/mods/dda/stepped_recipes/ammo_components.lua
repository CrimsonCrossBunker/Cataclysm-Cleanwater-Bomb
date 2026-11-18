local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "9x18_steel_core",
    result = "9x18_steel_core",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("small_hc_steel_bar_round", 1)
    :result_charges(17)
    :byproduct("scrap", 33)
    :step {
        name = content.text("Lathe the bar to size"),
        duration_moves = 240000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "fake_lathe", charges = 25 } },
        },
        proficiencies = {
            { id = "prof_metalworking", time_multiplier = 1, skill_penalty = 0 },
            { id = "prof_machining_basic", time_multiplier = 1.5, skill_penalty = 0.5 },
        },
    }
    :step {
        name = content.text("Cut the stock into 17 bullets"),
        duration_moves = 240000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "tape_measure", count = 1 } },
        },
        qualities = {
            { { id = "SAW_M_FINE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking", time_multiplier = 1.5 },
        },
    }
    :step {
        name = content.text("Smooth out each bullet"),
        duration_moves = 300000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
    :step {
        name = content.text("Machine each bullet into a bullet shape"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "fake_lathe", charges = 40 } },
        },
        proficiencies = {
            { id = "prof_metalworking", time_multiplier = 1, skill_penalty = 0 },
            { id = "prof_machining_basic", time_multiplier = 2, skill_penalty = 0.7 },
        },
    }
)

content.add(content.Recipe {
    id = "3006_steel_core",
    result = "3006_steel_core",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("small_hc_steel_bar_round", 1)
    :result_charges(8)
    :byproduct("scrap", 32)
    :step {
        name = content.text("Lathe the bar to size"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "fake_lathe", charges = 20 } },
            { { id = "tape_measure", count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking", time_multiplier = 1, skill_penalty = 0 },
            { id = "prof_machining_basic", time_multiplier = 1.5, skill_penalty = 0.5 },
        },
    }
    :step {
        name = content.text("Cut the stock into 8 bullets"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "tape_measure", count = 1 } },
        },
        qualities = {
            { { id = "SAW_M_FINE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking", time_multiplier = 1.5 },
        },
    }
    :step {
        name = content.text("Smooth out each bullet"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
    :step {
        name = content.text("Machine each bullet into a bullet shape"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "fake_lathe", charges = 40 } },
            { { id = "tape_measure", count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking", time_multiplier = 1, skill_penalty = 0 },
            { id = "prof_machining_basic", time_multiplier = 2, skill_penalty = 0.7 },
        },
    }
)

content.add(content.Recipe {
    id = "123_steel_core",
    result = "123_steel_core",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("small_hc_steel_bar_round", 1)
    :result_charges(9)
    :byproduct("scrap", 32)
    :step {
        name = content.text("Lathe the bar to size"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "fake_lathe", charges = 20 } },
            { { id = "tape_measure", count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking", time_multiplier = 1, skill_penalty = 0 },
            { id = "prof_machining_basic", time_multiplier = 1.5, skill_penalty = 0.5 },
        },
    }
    :step {
        name = content.text("Cut the stock into 8 bullets"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "tape_measure", count = 1 } },
        },
        qualities = {
            { { id = "SAW_M_FINE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking", time_multiplier = 1.5 },
        },
    }
    :step {
        name = content.text("Smooth out each bullet"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
    :step {
        name = content.text("Machine each bullet into a bullet shape"),
        duration_moves = 360000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "fake_lathe", charges = 40 } },
            { { id = "tape_measure", count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking", time_multiplier = 1, skill_penalty = 0 },
            { id = "prof_machining_basic", time_multiplier = 2, skill_penalty = 0.7 },
        },
    }
)

content.add(content.Recipe {
    id = "545_steel_core",
    result = "545_steel_core",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("small_hc_steel_bar_round", 1)
    :result_charges(12)
    :byproduct("scrap", 32)
    :step {
        name = content.text("Lathe the bar to size"),
        duration_moves = 210000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "fake_lathe", charges = 20 } },
            { { id = "tape_measure", count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking", time_multiplier = 1, skill_penalty = 0 },
            { id = "prof_machining_basic", time_multiplier = 1.5, skill_penalty = 0.5 },
        },
    }
    :step {
        name = content.text("Cut the stock into 12 bullets"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "tape_measure", count = 1 } },
        },
        qualities = {
            { { id = "SAW_M_FINE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking", time_multiplier = 1.5 },
        },
    }
    :step {
        name = content.text("Smooth out each bullet"),
        duration_moves = 240000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
    :step {
        name = content.text("Machine each bullet into a bullet shape"),
        duration_moves = 480000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "fake_lathe", charges = 50 } },
            { { id = "tape_measure", count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking", time_multiplier = 1, skill_penalty = 0 },
            { id = "prof_machining_basic", time_multiplier = 2, skill_penalty = 0.7 },
        },
    }
)

content.add(content.Recipe {
    id = "50_steel_core",
    result = "50_steel_core",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("small_lc_steel_bar_round", 1)
    :result_charges(6)
    :byproduct("scrap", 32)
    :step {
        name = content.text("Lathe the bar to size"),
        duration_moves = 150000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "fake_lathe", charges = 15 } },
            { { id = "tape_measure", count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking", time_multiplier = 1, skill_penalty = 0 },
            { id = "prof_machining_basic", time_multiplier = 1.5, skill_penalty = 0.5 },
        },
    }
    :step {
        name = content.text("Cut the stock into 6 bullets"),
        duration_moves = 120000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "tape_measure", count = 1 } },
        },
        qualities = {
            { { id = "SAW_M_FINE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking", time_multiplier = 1.5 },
        },
    }
    :step {
        name = content.text("Smooth out each bullet"),
        duration_moves = 180000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FILE", level = 2, count = 1 } },
        },
    }
    :step {
        name = content.text("Machine each bullet into a bullet shape"),
        duration_moves = 480000,
        activity_level = LIGHT_EXERCISE,
        tools = {
            { { id = "fake_lathe", charges = 50 } },
            { { id = "tape_measure", count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking", time_multiplier = 1, skill_penalty = 0 },
            { id = "prof_machining_basic", time_multiplier = 2, skill_penalty = 0.7 },
        },
    }
)
