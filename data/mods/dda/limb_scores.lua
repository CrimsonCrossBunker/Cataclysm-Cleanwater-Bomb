local ccb = require("ccb")
local content = ccb.content

-- Native limb-score definitions
do
local definition = content.LimbScore {
    id = "manip",
    name = "Manipulation",
    affected_by_wounds = true,
    affected_by_encumbrance = true,
}
content.add(definition)
end
do
local definition = content.LimbScore {
    id = "lift",
    name = "Lifting",
    affected_by_wounds = true,
    affected_by_encumbrance = false,
}
content.add(definition)
end
do
local definition = content.LimbScore {
    id = "grip",
    name = "Grip Strength",
    affected_by_wounds = true,
    affected_by_encumbrance = true,
}
content.add(definition)
end
do
local definition = content.LimbScore {
    id = "block",
    name = "Blocking",
    affected_by_wounds = true,
    affected_by_encumbrance = true,
}
content.add(definition)
end
do
local definition = content.LimbScore {
    id = "breathing",
    name = "Breathing",
    affected_by_wounds = true,
    affected_by_encumbrance = true,
}
content.add(definition)
end
do
local definition = content.LimbScore {
    id = "vision",
    name = "Vision",
    affected_by_wounds = true,
    affected_by_encumbrance = true,
}
content.add(definition)
end
do
local definition = content.LimbScore {
    id = "night_vis",
    name = "Night vision",
    affected_by_wounds = true,
    affected_by_encumbrance = true,
}
content.add(definition)
end
do
local definition = content.LimbScore {
    id = "reaction",
    name = "Reaction",
    affected_by_wounds = true,
    affected_by_encumbrance = true,
}
content.add(definition)
end
do
local definition = content.LimbScore {
    id = "move_speed",
    name = "Movement speed",
    affected_by_wounds = true,
    affected_by_encumbrance = true,
}
content.add(definition)
end
do
local definition = content.LimbScore {
    id = "balance",
    name = "Balance",
    affected_by_wounds = false,
    affected_by_encumbrance = true,
}
content.add(definition)
end
do
local definition = content.LimbScore {
    id = "footing",
    name = "Footing",
    affected_by_wounds = true,
    affected_by_encumbrance = true,
}
content.add(definition)
end
do
local definition = content.LimbScore {
    id = "consume_solid",
    name = "Consume (Solid)",
    affected_by_wounds = true,
    affected_by_encumbrance = false,
}
content.add(definition)
end
do
local definition = content.LimbScore {
    id = "consume_liquid",
    name = "Consume (Liquid)",
    affected_by_wounds = true,
    affected_by_encumbrance = false,
}
content.add(definition)
end
do
local definition = content.LimbScore {
    id = "swim",
    name = "Swimming",
    affected_by_wounds = true,
    affected_by_encumbrance = true,
}
content.add(definition)
end
do
local definition = content.LimbScore {
    id = "crawl",
    name = "Crawling",
    affected_by_wounds = true,
    affected_by_encumbrance = true,
}
content.add(definition)
end
