local ccb = require("ccb")
local content = ccb.content

-- Native skill display categories
do
local definition = content.SkillDisplay {
    id = "display_melee",
    label = ccb.content.text("Melee skills"),
}
content.add(definition)
end
do
local definition = content.SkillDisplay {
    id = "display_ranged",
    label = ccb.content.text("Ranged skills"),
}
content.add(definition)
end
do
local definition = content.SkillDisplay {
    id = "display_crafting",
    label = ccb.content.text("Crafting skills"),
}
content.add(definition)
end
do
local definition = content.SkillDisplay {
    id = "display_interaction",
    label = ccb.content.text("Interaction skills"),
}
content.add(definition)
end
