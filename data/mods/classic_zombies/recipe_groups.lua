local ccb = require("ccb")
local content = ccb.content

-- Native recipe groups
do
local definition = content.RecipeGroup {
    id = "hack_recipes_general",
    building_type = "BASE",
}
definition:recipe("memory_card_unread_npc_hack", ccb.content.text(" Hack & Download: random data, SD-Memory card"))
content.replace(definition)
end
do
local definition = content.RecipeGroup {
    id = "hack_recipes_science",
    building_type = "BASE",
}
definition:recipe("memory_card_science_npc_hack", ccb.content.text(" Hack & Download: science data, SD-Memory card"))
content.replace(definition)
end
