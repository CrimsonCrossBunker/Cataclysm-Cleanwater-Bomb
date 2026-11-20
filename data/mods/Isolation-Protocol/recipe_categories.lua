local ccb = require("ccb")
local content = ccb.content

-- Native recipe categories
do
local definition = content.RecipeCategory {
    id = "CC_OUROBOROS",
    hidden = false,
    practice = false,
    building = false,
    wildcard = false,
}
definition:subcategory("CSC_ALL")
definition:subcategory("CSC_OUROBOROS_RANGED")
definition:subcategory("CSC_OUROBOROS_AMMO")
definition:subcategory("CSC_OUROBOROS_MAGAZINES")
content.add(definition)
end
