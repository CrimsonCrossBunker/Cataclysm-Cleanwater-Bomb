local ccb = require("ccb")
local content = ccb.content

-- Native option sliders
do
local definition = content.OptionSlider {
    id = "world_cities",
    name = "Cities",
    context = "WORLDGEN",
    default_level = 3,
    levels = {
        {
            level = 0,
            name = "Remote",
            description = "Cities are basically non-existent.  Expect rural-only areas with rare tiny villages.",
            options = {
                { option = "CITY_SIZE", type = "int", value = 1 },
                { option = "CITY_SPACING", type = "int", value = 8 },
            },
        },
        {
            level = 1,
            name = "Rural",
            description = "Cities are half as large and twice as far apart.",
            options = {
                { option = "CITY_SIZE", type = "int", value = 4 },
                { option = "CITY_SPACING", type = "int", value = 8 },
            },
        },
        {
            level = 2,
            name = "Semirural",
            description = "Cities are 25% smaller and 50% farther apart.",
            options = {
                { option = "CITY_SIZE", type = "int", value = 6 },
                { option = "CITY_SPACING", type = "int", value = 6 },
            },
        },
        {
            level = 3,
            name = "Suburbia",
            description = "Cities use default size and distances, with small to large cities separated by large rural areas.",
            options = {
                { option = "CITY_SIZE", type = "int", value = 8 },
                { option = "CITY_SPACING", type = "int", value = 4 },
            },
        },
        {
            level = 4,
            name = "Townscape",
            description = "Cities are 50% larger.",
            options = {
                { option = "CITY_SIZE", type = "int", value = 12 },
                { option = "CITY_SPACING", type = "int", value = 4 },
            },
        },
        {
            level = 5,
            name = "Cityscape",
            description = "Cities are twice as large and 25% closer to each other.",
            options = {
                { option = "CITY_SIZE", type = "int", value = 16 },
                { option = "CITY_SPACING", type = "int", value = 3 },
            },
        },
        {
            level = 6,
            name = "Megacity",
            description = "Cities are nearly continuous, with minimal distance between them.",
            options = {
                { option = "CITY_SIZE", type = "int", value = 16 },
                { option = "CITY_SPACING", type = "int", value = 1 },
            },
        },
    },
}
content.add(definition)
end
do
local definition = content.OptionSlider {
    id = "world_difficulty",
    name = "Difficulty",
    context = "WORLDGEN",
    default_level = 2,
    levels = {
        {
            level = 0,
            name = "Cakewalk?",
            description = "Monsters are much easier to deal with, and plenty of items can be found.",
            options = {
                { option = "MONSTER_SPEED", type = "int", value = 90 },
                { option = "MONSTER_RESILIENCE", type = "int", value = 75 },
                { option = "SPAWN_DENSITY", type = "float", value = 0.80000000000000004 },
                { option = "EVOLUTION_INVERSE_MULTIPLIER", type = "float", value = 2 },
                { option = "ITEM_SPAWNRATE", type = "float", value = 1.5 },
            },
        },
        {
            level = 1,
            name = "Be nice to me",
            description = "Monsters are weaker, appear in smaller numbers, and evolve at a slower rate.",
            options = {
                { option = "MONSTER_SPEED", type = "int", value = 100 },
                { option = "MONSTER_RESILIENCE", type = "int", value = 85 },
                { option = "SPAWN_DENSITY", type = "float", value = 0.90000000000000002 },
                { option = "EVOLUTION_INVERSE_MULTIPLIER", type = "float", value = 1.5 },
                { option = "ITEM_SPAWNRATE", type = "float", value = 1 },
            },
        },
        {
            level = 2,
            name = "Cataclysm",
            description = "The default monster hunting and item collecting experience.",
            options = {
                { option = "MONSTER_SPEED", type = "int", value = 100 },
                { option = "MONSTER_RESILIENCE", type = "int", value = 100 },
                { option = "SPAWN_DENSITY", type = "float", value = 1 },
                { option = "EVOLUTION_INVERSE_MULTIPLIER", type = "float", value = 1 },
                { option = "ITEM_SPAWNRATE", type = "float", value = 1 },
            },
        },
        {
            level = 3,
            name = "Hurt me",
            description = "Monsters are stronger, appear 50% more often, and evolve faster.",
            options = {
                { option = "MONSTER_SPEED", type = "int", value = 100 },
                { option = "MONSTER_RESILIENCE", type = "int", value = 120 },
                { option = "SPAWN_DENSITY", type = "float", value = 1.5 },
                { option = "EVOLUTION_INVERSE_MULTIPLIER", type = "float", value = 0.91000000000000003 },
                { option = "ITEM_SPAWNRATE", type = "float", value = 1 },
            },
        },
        {
            level = 4,
            name = "Punish me",
            description = "Monsters are significantly tougher and faster, spawn more, and evolve faster.  Items are a bit rarer too.",
            options = {
                { option = "MONSTER_SPEED", type = "int", value = 110 },
                { option = "MONSTER_RESILIENCE", type = "int", value = 150 },
                { option = "SPAWN_DENSITY", type = "float", value = 2 },
                { option = "EVOLUTION_INVERSE_MULTIPLIER", type = "float", value = 0.88 },
                { option = "ITEM_SPAWNRATE", type = "float", value = 0.80000000000000004 },
            },
        },
        {
            level = 5,
            name = "Punish me more!",
            description = "Monsters are much tougher, extremely fast, and spawn 3x more.  Items are half as likely to spawn.",
            options = {
                { option = "MONSTER_SPEED", type = "int", value = 120 },
                { option = "MONSTER_RESILIENCE", type = "int", value = 200 },
                { option = "SPAWN_DENSITY", type = "float", value = 3 },
                { option = "EVOLUTION_INVERSE_MULTIPLIER", type = "float", value = 0.75 },
                { option = "ITEM_SPAWNRATE", type = "float", value = 0.5 },
            },
        },
    },
}
content.add(definition)
end
do
local definition = content.OptionSlider {
    id = "world_random_npcs",
    name = "Random NPCs",
    context = "WORLDGEN",
    default_level = 1,
    levels = {
        {
            level = 0,
            name = "Where is everyone?",
            description = "You are very unlikely to encounter random NPCs.",
            options = {
                { option = "NPC_SPAWNTIME", type = "float", value = 10 },
            },
        },
        {
            level = 1,
            name = "Lonely",
            description = "The default: NPCs are rare, but as expected in this ruined world.",
            options = {
                { option = "NPC_SPAWNTIME", type = "float", value = 4 },
            },
        },
        {
            level = 2,
            name = "Party time",
            description = "You are twice as likely to encounter random NPCs.",
            options = {
                { option = "NPC_SPAWNTIME", type = "float", value = 2 },
            },
        },
        {
            level = 3,
            name = "Crowded",
            description = "Random NPCs are fairly common.  Go meet some friends!",
            options = {
                { option = "NPC_SPAWNTIME", type = "float", value = 1 },
            },
        },
    },
}
content.add(definition)
end
