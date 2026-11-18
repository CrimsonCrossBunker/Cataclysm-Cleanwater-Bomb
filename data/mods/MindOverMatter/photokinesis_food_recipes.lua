local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local EXTRA_EXERCISE = 10
local completion = "photokinesis_food_drain"

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler(completion, function(payload)
    local who = payload.character
    local drain = services.types.id("vitamin", "vitamin_psionic_drain")
    for _ = 1, payload.batch do
        local stored = checked(services.needs.get_vitamin(who, drain))
        -- The native vitamin setter truncates the sum toward zero.
        local amount = math.modf(stored + services.random.native_float(0, 2))
        checked(services.needs.set_vitamin(who, drain, amount))
    end
end, 1)

-- The player is presumed to be able to irradiate 40g of matter per second (round up time costs),
-- based on real world radiation levels required to do the same and the amount of energy the player
-- burns during extreme activity.
local foods = {
    { "rose_hips", 4 },
    { "elderberries", 4 },
    { "mulberries", 4 },
    { "huckleberries", 4 },
    { "raspberries", 4 },
    { "strawberries", 4 },
    { "blueberries", 4 },
    { "apple", 5 },
    { "banana", 4 },
    { "orange", 5 },
    { "lemon", 3 },
    { "grapefruit", 7 },
    { "pear", 5 },
    { "cherries", 4 },
    { "plums", 2 },
    { "grapes", 3 },
    { "pineapple", 23 },
    { "peach", 4 },
    { "watermelon", 113 },
    { "melon", 14 },
    { "blackberries", 4 },
    { "mango", 6 },
    { "pomegranate", 7 },
    { "papaya", 8 },
    { "guayaba", 2 },
    { "maracuya", 6 },
    { "kiwi", 2 },
    { "lulo", 3 },
    { "plantain", 3 },
    { "apricot", 4 },
    { "lettuce", 3 },
    { "cabbage", 3 },
    { "tomato", 7 },
    { "broccoli", 3 },
    { "zucchini", 6 },
    { "onion", 4 },
    { "carrot", 2 },
    { "corn", 18 },
    { "pumpkin", 57 },
    { "potato", 6 },
    { "cucumber", 5 },
    { "celery", 3 },
    { "rhubarb", 4 },
    { "eggplant", 5 },
}

for _, food in ipairs(foods) do
    local ingredient, seconds = table.unpack(food)
    local result = "irradiated_" .. ingredient
    content.add(content.Recipe {
        id = result,
        result = result,
        duration_moves = seconds * 100,
        activity_level = EXTRA_EXERCISE,
        category = "CC_*",
        subcategory = "CSC_*_NESTED",
        skill = "metaphysics",
        difficulty = 6,
        autolearn = false,
        flags = { "SECRET" },
    }
        :component(ingredient, 1)
        :on_complete(completion)
    )
end
