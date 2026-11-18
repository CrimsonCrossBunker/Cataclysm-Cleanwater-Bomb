local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "veh_tools_kitchen",
    result = "veh_tools_kitchen",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 3,
}
    :component("frame", 1)
    :component("water_faucet", 1)
    :component("duct_tape", 100)
    :component("sheet_metal", 4)
    :component("pipe_fittings", 8)
    :component("pipe", 16)
    :component("hose", 2)
    :component("power_supply", 2)
    :component("cable", 14)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 10)
    :requires_skill("electronics", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_appliance_repair")
)

content.add(content.Recipe {
    id = "veh_tools_workshop",
    result = "veh_tools_workshop",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 3,
}
    :component("frame", 1)
    :component("duct_tape", 100)
    :component("sheet_metal", 4)
    :component("pipe_fittings", 4)
    :component("pipe", 16)
    :component("hose", 2)
    :component("power_supply", 4)
    :component("cable", 67)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 10)
    :requires_skill("electronics", 3)
)
