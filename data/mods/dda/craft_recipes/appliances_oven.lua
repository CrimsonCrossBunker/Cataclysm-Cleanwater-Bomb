local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "oven",
    result = "oven",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("oven_stovetop", 1)
    :component("oven_cabinet", 1)
    :component("oven_controls", 1)
    :component("oven_door", 1)
    :component("oven_broiler_pan", 1)
    :component("heavy_wire_rack", 2)
    :component_any({
            { id = "element", count = 4 },
            { id = "crude_heating_element", count = 6 }
        })
    :component("cable", 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requires_skill("electronics", 1)
    :proficiency("prof_appliance_repair")
)
