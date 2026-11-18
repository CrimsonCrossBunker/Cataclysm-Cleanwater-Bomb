local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "prac_computer_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_COMPUTERS",
    name = content.text("computer (beginner)"),
    description = content.text("Practice the basics of using a computing device."),
    skill = "computer",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
    flags = { "BLIND_EASY" },
}
    :tool_any({
            { id = "laptop", charges = 10 },
            { id = "eink_tablet_pc", charges = 1 },
            { id = "smart_phone", charges = 5 }
        })
    :learn_automatically("computer", 1)
    :book("mag_computer", 0)
    :book("howto_computer", 0)
)

content.add(content.Recipe {
    id = "prac_computer_int",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_COMPUTERS",
    name = content.text("computer (intermediate)"),
    description = content.text("Practice using the command line, writing and running scripts making use of common algorithms and data structures."),
    skill = "computer",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 4, skill_limit = 5 },
    autolearn = true,
    flags = { "BLIND_EASY" },
}
    :tool_charges("laptop", 50)
    :learn_automatically("computer", 4)
    :book("manual_computer", 2)
    :book("hackerman_computer", 2)
    :book("webbasics_computer", 3)
    :book("computer_science", 3)
)

content.add(content.Recipe {
    id = "prac_computer_adv",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_COMPUTERS",
    name = content.text("computer (advanced)"),
    description = content.text("Practice the use of software exploits to gain elevated privileges on computer systems."),
    skill = "computer",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 5, max_difficulty = 7 },
    autolearn = true,
    flags = { "BLIND_EASY" },
}
    :tool_charges("laptop", 50)
    :tool("software_hacking", 1)
    :learn_automatically("computer", 7)
    :book("SICP", 5)
    :book("textbook_computer", 6)
)
