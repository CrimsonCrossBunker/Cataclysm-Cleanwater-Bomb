local ccb = require("ccb")
local content = ccb.content

-- Native recipe categories
do
local definition = content.RecipeCategory {
    id = "CC_PSIONIC",
    hidden = false,
    practice = false,
    building = false,
    wildcard = false,
}
definition:subcategory("CSC_ALL")
definition:subcategory("CSC_PSIONIC_WEAPONS")
definition:subcategory("CSC_PSIONIC_ARMOR")
definition:subcategory("CSC_PSIONIC_MEDICAL")
definition:subcategory("CSC_PSIONIC_FOOD")
definition:subcategory("CSC_PSIONIC_TOOLS")
definition:subcategory("CSC_PSIONIC_PARTS")
definition:subcategory("CSC_PSIONIC_RITUALS")
definition:subcategory("CSC_PSIONIC_OTHER")
content.add(definition)
end
