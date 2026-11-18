local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "gloves_studded",
    result = "gloves_studded",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "gloves_light", count = 1 },
            { id = "gloves_liner", count = 1 }
        })
    :component("gloves_leather", 1)
    :component("scrap", 4)
    :quality("LEATHER_AWL", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("sewing_standard", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "xl_gloves_studded",
    result = "xl_gloves_studded",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "gloves_light", count = 1 },
            { id = "gloves_liner", count = 1 }
        })
    :component("gloves_leather", 1)
    :component("scrap", 6)
    :quality("LEATHER_AWL", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("sewing_standard", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "xs_gloves_studded",
    result = "xs_gloves_studded",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_UNARMED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "gloves_light", count = 1 },
            { id = "gloves_liner", count = 1 }
        })
    :component("gloves_leather", 1)
    :component("scrap", 2)
    :quality("LEATHER_AWL", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("sewing_standard", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)
