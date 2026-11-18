local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "crystallized_mana_using_alchemy",
    result = "crystallized_mana",
    category = "CC_ENCHANTED",
    subcategory = "CSC_ENCHANTED_OTHER",
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :component("crystallized_mana_raw", 1)
    :component("mana_energy_weak", 1, true)
    :component("mercury", 5)
    :component_any({
            { id = "chem_sulphur", count = 20 },
            { id = "chunk_sulfur", count = 1 }
        })
    :requires_skill("spellcraft", 6)
    :book("alchemy_master", 6)
    :book("alchemy_mana_processing", 4)
    :result_charges(8)
    :step {
        name = content.text("Calcinate the mana"),
        duration_moves = 120000,
        activity_level = LIGHT_EXERCISE,
        batch = { discount_percent = 40, at_batch = 3 },
        tools = {
            { { id = "surface_heat", charges = 10, requirement = true } },
        },
        qualities = {
            { { id = "SEPARATE", level = 1, count = 1 } },
            { { id = "CONTAIN", level = 1, count = 1 } },
            { { id = "CONCENTRATE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_alchemy", required = false },
        },
    }
    :step {
        name = content.text("Alchemical purification"),
        duration_moves = 240000,
        activity_level = LIGHT_EXERCISE,
        batch = { discount_percent = 40, at_batch = 3 },
        tools = {
            { { id = "surface_heat", charges = 10, requirement = true } },
        },
        qualities = {
            { { id = "FINE_DISTILL", level = 1, count = 1 } },
            { { id = "CONTAIN", level = 1, count = 1 } },
            { { id = "CONCENTRATE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_alchemy", required = false },
        },
    }
    :step {
        name = content.text("Focus the mana"),
        duration_moves = 1080000,
        activity_level = NO_EXERCISE,
        qualities = {
            { { id = "MANA_FOCUS", level = 1, count = 1 } },
        },
    }
)
