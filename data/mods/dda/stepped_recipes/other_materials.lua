local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "10l_brass",
    result = "10l_brass",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "5l_brass", count = 2 },
            { id = "1l_brass", count = 10 },
            { id = "scrap_brass", count = 300 }
        })
    :requirement("smelting_standard", 46600)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "5l_brass",
    result = "5l_brass",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "1l_brass", count = 5 },
            { id = "scrap_brass", count = 150 }
        })
    :requirement("smelting_standard", 23300)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "1l_brass",
    result = "1l_brass",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("scrap_brass", 30)
    :requirement("smelting_standard", 4660)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "10l_silver",
    result = "10l_silver",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "5l_silver", count = 2 },
            { id = "1l_silver", count = 10 },
            { id = "silver_small", count = 10000 }
        })
    :requirement("smelting_standard", 34100)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "5l_silver",
    result = "5l_silver",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "1l_silver", count = 5 },
            { id = "silver_small", count = 5000 }
        })
    :requirement("smelting_standard", 17050)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "1l_silver",
    result = "1l_silver",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("silver_small", 1000)
    :requirement("smelting_standard", 3410)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "10l_gold",
    result = "10l_gold",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "5l_gold", count = 2 },
            { id = "1l_gold", count = 10 },
            { id = "gold_small", count = 10000 }
        })
    :requirement("smelting_standard", 38300)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "5l_gold",
    result = "5l_gold",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "1l_gold", count = 5 },
            { id = "gold_small", count = 5000 }
        })
    :requirement("smelting_standard", 19150)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "1l_gold",
    result = "1l_gold",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("gold_small", 1000)
    :requirement("smelting_standard", 3830)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "10l_lead",
    result = "10l_lead",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "5l_lead", count = 2 },
            { id = "1l_lead", count = 10 },
            { id = "lead", count = 22680 }
        })
    :requirement("smelting_standard", 6900)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "5l_lead",
    result = "5l_lead",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "1l_lead", count = 5 },
            { id = "lead", count = 11340 }
        })
    :requirement("smelting_standard", 3450)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "1l_lead",
    result = "1l_lead",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("lead", 2268)
    :requirement("smelting_standard", 690)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "10l_bronze",
    result = "10l_bronze",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "5l_bronze", count = 2 },
            { id = "1l_bronze", count = 10 },
            { id = "scrap_bronze", count = 260 }
        })
    :requirement("smelting_standard", 47100)
    :book("alloy_book", 2)
    :book("bronze_book", 2)
    :book("bronze_mag", 3)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "5l_bronze",
    result = "5l_bronze",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "1l_bronze", count = 5 },
            { id = "scrap_bronze", count = 130 }
        })
    :requirement("smelting_standard", 23550)
    :book("alloy_book", 2)
    :book("bronze_book", 2)
    :book("bronze_mag", 3)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

-- There is a slight loss here, but rounding up would mean you could create more magically.
content.add(content.Recipe {
    id = "1l_bronze",
    result = "1l_bronze",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("scrap_bronze", 26)
    :requirement("smelting_standard", 4710)
    :book("alloy_book", 2)
    :book("bronze_book", 2)
    :book("bronze_mag", 3)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "10l_copper",
    result = "10l_copper",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "5l_copper", count = 2 },
            { id = "1l_copper", count = 10 },
            { id = "scrap_copper", count = 360 }
        })
    :requirement("smelting_standard", 55100)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "5l_copper",
    result = "5l_copper",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "1l_copper", count = 5 },
            { id = "scrap_copper", count = 180 }
        })
    :requirement("smelting_standard", 27550)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "1l_copper",
    result = "1l_copper",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "scrap_copper", count = 36 },
            { id = "copper", count = 1800 }
        })
    :requirement("smelting_standard", 5510)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "10l_zinc",
    result = "10l_zinc",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "5l_zinc", count = 2 },
            { id = "1l_zinc", count = 10 },
            { id = "zinc_metal", count = 10000 }
        })
    :requirement("smelting_standard", 19000)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "5l_zinc",
    result = "5l_zinc",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "1l_zinc", count = 5 },
            { id = "zinc_metal", count = 5000 }
        })
    :requirement("smelting_standard", 9500)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "1l_zinc",
    result = "1l_zinc",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("zinc_metal", 1000)
    :requirement("smelting_standard", 1900)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "ash",
    result = "ash",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "survival",
}
    :component_any({
            { id = "splinter", count = 5 },
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :result_charges(10)
    :step {
        name = content.text("Let it burn"),
        duration_moves = 90000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The wood has completely burned."),
        tools = {
            { { id = "surface_heat", charges = 5, requirement = true } },
        },
    }
)

content.add(content.Recipe {
    id = "10l_aluminum",
    result = "10l_aluminum",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "5l_aluminum", count = 2 },
            { id = "1l_aluminum", count = 10 },
            { id = "scrap_aluminum", count = 540 }
        })
    :requirement("smelting_standard", 24100)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "5l_aluminum",
    result = "5l_aluminum",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "1l_aluminum", count = 5 },
            { id = "scrap_aluminum", count = 270 }
        })
    :requirement("smelting_standard", 12050)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

-- There is a slight loss here, but rounding up would mean you could create more magically.
content.add(content.Recipe {
    id = "1l_aluminum",
    result = "1l_aluminum",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("scrap_aluminum", 54)
    :requirement("smelting_standard", 2410)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "10l_tin",
    result = "10l_tin",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "5l_tin", count = 2 },
            { id = "1l_tin", count = 10 },
            { id = "scrap_tin", count = 1380 }
        })
    :requirement("smelting_standard", 8000)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "5l_tin",
    result = "5l_tin",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "1l_tin", count = 5 },
            { id = "scrap_tin", count = 690 }
        })
    :requirement("smelting_standard", 4000)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)

content.add(content.Recipe {
    id = "1l_tin",
    result = "1l_tin",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("scrap_tin", 138)
    :requirement("smelting_standard", 800)
    :book("metal_casting_book", 2)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the ingot is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
)
