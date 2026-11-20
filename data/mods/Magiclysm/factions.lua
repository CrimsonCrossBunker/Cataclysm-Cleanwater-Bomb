local ccb = require("ccb")
local content = ccb.content

-- Native faction templates
do
local definition = content.Faction {
    id = "wizards_ancient",
    name = ccb.content.text("The Ancient Ones"),
    description = ccb.content.text("The spellcrafters of old.  Hidden from the world until the Cataclysm, they have their own agenda and care little for you or yours."),
    likes = 0,
    respects = 0,
    known = false,
    size = 5,
    power = 100,
    wealth = 100000,
    limited_area = true,
    currency = "embued_coin",
    food_calories = 270000,
    food_vitamins = { ["iron"] = 8640, ["calcium"] = 8640, ["vitC"] = 8640 },
    relations = {
        ["lobby_beggars"] = { "share my stuff", "guard your stuff", "knows your voice" },
        ["free_merchants"] = { "knows your voice" },
        ["old_guard"] = { "knows your voice" },
        ["no_faction"] = { "knows your voice" },
        ["wasteland_scavengers"] = { "knows your voice" },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "healers_grey",
    name = ccb.content.text("The Grey Flame"),
    description = ccb.content.text("A collection of those cursed by the Cataclysm.  They have sworn to rid this world of its curse and will stop at nothing to accomplish their task."),
    likes = 10,
    respects = 10,
    known = false,
    size = 50,
    power = 50,
    wealth = 1000,
    limited_area = true,
    food_calories = 270000,
    food_vitamins = { ["iron"] = 8640, ["calcium"] = 8640, ["vitC"] = 8640 },
    relations = {
        ["lobby_beggars"] = { "share my stuff", "guard your stuff", "knows your voice" },
        ["free_merchants"] = { "knows your voice" },
        ["old_guard"] = { "knows your voice" },
        ["no_faction"] = { "knows your voice" },
        ["wasteland_scavengers"] = { "knows your voice" },
    },
}
content.add(definition)
end
do
local definition = content.Faction {
    id = "forge_lords",
    name = ccb.content.text("The Forge Lords"),
    description = ccb.content.text("Builders and merchants of magical wonders.  They expect to weather this Cataclysm through trade and innovation.  They will take any coin from any land."),
    likes = 0,
    respects = 0,
    known = false,
    size = 5,
    power = 100,
    wealth = 75000000,
    monster_faction = "wonder_forge",
    food_calories = 2700000,
    food_vitamins = { ["iron"] = 86400, ["calcium"] = 86400, ["vitC"] = 86400 },
    price_rules = {
        { item = "denarius", fixed_adjustment = 0, price = 2500 },
        { item = "dragon_blood", premium = 3 },
        { category = "drink", price = 0 },
        { category = "food", price = 0 },
        { category = "clothing", price = 0 },
        { category = "guns", premium = 0.1 },
        { category = "ammo", premium = 0.1 },
        { category = "artifacts", premium = 1000 },
        { group = "SUS_bathroom_sink", price = 0 },
        { group = "SUS_bathroom_medicine", price = 0 },
        { group = "SUS_toilet", price = 0 },
        { group = "SUS_bathroom_cabinet", price = 0 },
        { group = "SUS_dishes", price = 0 },
        { group = "SUS_cookware", price = 0 },
        { group = "SUS_utensils", price = 0 },
        { group = "SUS_junk_drawer", price = 0 },
        { group = "SUS_kitchen_sink", price = 0 },
        { group = "enchanted_rings_common", premium = 1 },
        { group = "enchanted_rings_uncommon", premium = 1 },
        { group = "enchanted_rings_rare", premium = 1 },
        { group = "enchanted_combat_items", premium = 1 },
        { group = "enchanted_misc", premium = 1 },
        { group = "enchanted_masks", premium = 1 },
        { group = "enchanted_worn_items", premium = 1 },
        { group = "enchanted_bracers_greater", premium = 1 },
        { group = "enchanted_cloaks_rare", premium = 1 },
        { group = "items_of_elvenkind", premium = 1 },
        { group = "potions_common", premium = 1 },
        { group = "potions_uncommon", premium = 1.1 },
        { group = "potions_rare", premium = 1.6 },
        { group = "potions_illegal", premium = 3 },
    },
    relations = {
        ["lobby_beggars"] = { "knows your voice" },
        ["free_merchants"] = { "knows your voice" },
        ["old_guard"] = { "knows your voice" },
        ["no_faction"] = { "knows your voice" },
        ["wasteland_scavengers"] = { "knows your voice" },
    },
}
content.add(definition)
end
