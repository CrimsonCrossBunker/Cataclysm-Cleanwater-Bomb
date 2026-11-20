local ccb = require("ccb")
local content = ccb.content

-- Native faction templates
do
local definition = content.Faction {
    id = "swamper",
    name = ccb.content.text("Swampers Religious Community and Hotels and Casinos"),
    description = ccb.content.text("A prosperous but secretive group of churchgoers and entertainment moguls with an affection for dinosaurs.  They welcome all untainted humans."),
    likes = 30,
    respects = 20,
    known = false,
    size = 25,
    power = 20,
    wealth = 82500,
    limited_area = true,
    currency = "icon",
    food_calories = 2700000,
    food_vitamins = { ["iron"] = 86400, ["calcium"] = 86400, ["vitC"] = 86400 },
    relations = {
        ["free_merchants"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["old_guard"] = {  },
        ["tacoma_commune"] = { "watch your back", "share my stuff", "guard your stuff", "lets you in", "defends your space" },
        ["lobby_beggars"] = { "guard your stuff", "lets you in" },
        ["no_faction"] = { "lets you in", "knows your voice" },
        ["wasteland_scavengers"] = { "watch your back", "guard your stuff", "lets you in", "knows your voice" },
        ["isherwood_family"] = { "watch your back", "guard your stuff", "lets you in", "defends your space", "knows your voice" },
        ["hells_raiders"] = { "kill on sight" },
        ["marloss"] = { "kill on sight" },
    },
}
content.add(definition)
end
