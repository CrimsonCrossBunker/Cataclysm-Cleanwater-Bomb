local ccb = require("ccb")
local content = ccb.content

-- Native recipe categories
do
local definition = content.RecipeCategory {
    id = "CC_XEDRA",
    hidden = false,
    practice = false,
    building = false,
    wildcard = false,
}
definition:subcategory("CSC_ALL")
definition:subcategory("CSC_XEDRA_RESEARCH")
definition:subcategory("CSC_XEDRA_WEAPONS")
definition:subcategory("CSC_XEDRA_CASINGS")
definition:subcategory("CSC_XEDRA_ARMOR")
definition:subcategory("CSC_XEDRA_TOOLS")
definition:subcategory("CSC_XEDRA_CONSUMABLES")
definition:subcategory("CSC_XEDRA_ROBOTS")
definition:subcategory("CSC_XEDRA_MISC")
definition:subcategory("CSC_XEDRA_ALCHEMY")
definition:subcategory("CSC_XEDRA_GRACKEN")
definition:subcategory("CSC_XEDRA_ELEMENTAL")
definition:subcategory("CSC_XEDRA_BIONICS")
content.add(definition)
end
