local ccb = require("ccb")
local content = ccb.content

-- Native faction templates
do
local definition = content.Faction {
    id = "vampire_hunters",
    name = ccb.content.text("Vampire Hunters"),
    description = ccb.content.text("What remains of a group of vampire hunters.  They have many more concerns now, but they still want the end of all vampires."),
    likes = 30,
    respects = 30,
    known = false,
    size = 100,
    power = 100,
    wealth = 50000000,
    food_calories = 27000000,
    food_vitamins = { ["iron"] = 558000, ["calcium"] = 558000, ["vitC"] = 558000 },
    relations = {
        ["free_merchants"] = { "watch your back", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["old_guard"] = { "watch your back", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["tacoma_commune"] = { "watch your back", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["lobby_beggars"] = { "watch your back", "share public goods", "guard your stuff", "knows your voice" },
        ["wasteland_scavengers"] = { "watch your back", "guard your stuff", "knows your voice" },
        ["no_faction"] = { "share public goods", "knows your voice" },
        ["hells_raiders"] = { "kill on sight" },
    },
}
content.add(definition)
end
