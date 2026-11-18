local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "gold_small_from_lead_with_alchemy",
    result = "gold_small",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
    flags = { "SECRET" },
    name = content.text("%s from lead"),
}
    :component("lead", 100)
    :component("chem_saltpetre", 10)
    :component("chem_borax", 10)
    :component("silver_small", 5)
    :component("scrap_moon_tears", 3)
    :component("scrap_dreamdross", 10)
    :component("coal_lump", 1)
    :component("oxy_powder", 5)
    :component("chem_nitric_acid", 3)
    :requires_skill("chemistry", 4)
    :book("alchemy_recipe_gold_from_lead", 6)
    :result_charges(50)
    :step {
        name = content.text("Grind coal and mix with borax and oxidizer powder"),
        duration_moves = 90000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FINE_GRIND", level = 1, count = 1 } },
            { { id = "CONTAIN", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Melting half of the lead alongside scrap dreamdross, moon's tear scrap, silver, and saltpeter powder in a forge"),
        duration_moves = 1080000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "forging_scrap", multiplier = 70 },
            { id = "metalworking_tongs_any", multiplier = 1 },
        },
        tools = {
            { { id = "crucible", count = 1 } },
        },
    }
    :step {
        name = content.text("Add in the rest of the lead and the mixed powder to the melted metal and continue melting it."),
        duration_moves = 1800000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "forging_scrap", multiplier = 120 },
            { id = "metalworking_tongs_any", multiplier = 1 },
        },
    }
    :step {
        name = content.text("Cast the melted metal onto sandcasting mold and let it rest in dark place"),
        duration_moves = 121140000,
        activity_level = BRISK_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal has finished resting."),
        tools = {
            { { id = "casting_mold", count = 1 } },
        },
    }
    :step {
        name = content.text("Clean the ingot and prepare it to be dipped with nitric acid"),
        duration_moves = 60000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FILE", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Dip the ingot into nitric acid"),
        duration_moves = 720000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The gold shows its golden color."),
        qualities = {
            { { id = "CONTAIN", level = 1, count = 1 } },
            { { id = "CHEM", level = 1, count = 1 } },
        },
    }
)
