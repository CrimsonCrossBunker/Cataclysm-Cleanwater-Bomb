local ccb = require("ccb")
local content = ccb.content

-- Native recipe categories
do
local definition = content.RecipeCategory {
    id = "CC_ENCHANTED",
    hidden = false,
    practice = false,
    building = false,
    wildcard = false,
}
definition:subcategory("CSC_ALL")
definition:subcategory("CSC_ENCHANTED_MATERIALS")
definition:subcategory("CSC_ENCHANTED_TOOLS")
definition:subcategory("CSC_ENCHANTED_WEAPONS")
definition:subcategory("CSC_ENCHANTED_AMMO")
definition:subcategory("CSC_ENCHANTED_ARMOR")
definition:subcategory("CSC_ENCHANTED_POTIONS")
definition:subcategory("CSC_ENCHANTED_RUNES")
definition:subcategory("CSC_ENCHANTED_MODS")
definition:subcategory("CSC_ENCHANTED_OTHER")
definition:subcategory("CSC_ENCHANTED_RESEARCH")
definition:subcategory("CSC_ENCHANTED_ENCHANTING")
content.add(definition)
end
