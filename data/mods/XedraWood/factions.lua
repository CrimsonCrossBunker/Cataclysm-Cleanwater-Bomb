local ccb = require("ccb")
local content = ccb.content

-- Native faction templates
do
local definition = content.Faction {
    id = "hollow_ones_faction",
    name = ccb.content.text("The Hollow"),
    description = ccb.content.text("The inhabitants of the villages in the forest.  They look human, but there's something not right about them."),
    likes = 0,
    respects = 0,
    trusts = 0,
    known = false,
    size = 100,
    power = 100,
    wealth = 75000,
    lone_wolf = false,
    currency = "copper",
    monster_faction = "hollow_civilian",
    food_calories = 270000,
    food_vitamins = { ["iron"] = 8640, ["calcium"] = 8640, ["vitC"] = 8640 },
}
content.add(definition)
end
