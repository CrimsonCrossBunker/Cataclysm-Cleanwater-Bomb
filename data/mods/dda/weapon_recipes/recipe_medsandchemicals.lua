local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "chem_black_powder",
    result = "chem_black_powder",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_COMPONENTS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :component("chem_saltpetre", 10)
    :component("chem_sulphur", 23)
    :component("charcoal", 10)
    :quality("CONTAIN", 1, 1)
    :quality("FINE_GRIND", 1, 1)
    :book("textbook_anarch", 6)
    :book("recipe_labchem", 4)
    :book("textbook_chemistry", 5)
    :book("textbook_armschina", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :result_charges(470)
)
