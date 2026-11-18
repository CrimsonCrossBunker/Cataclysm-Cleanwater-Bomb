local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function read_book(topic, knowledge_key, teach)
    return function(use)
        local character = use.character
        if not character then
            return 0
        end
        checked(services.characters.open_topic(character, topic))
        if checked(services.variables.get_string(character, knowledge_key)).value ~= "yes" then
            teach(character)
            checked(services.variables.set(character, knowledge_key, "yes"))
        end
        return 0
    end
end

local function teach_recipe(character, recipe)
    checked(services.recipes.learn(character, id("recipe", recipe)))
end

local function teach_if_unknown(character, recipe)
    checked(services.progression.grant_random_missing(character, "recipe", { id("recipe", recipe) }))
end

ccb.runtime.handler("read_vampire_mentor_book", read_book(
    "TALK_READ_VAMPIRE_MENTOR_BOOK", "you_know_vampire_mentor_recipes", function(character)
        teach_if_unknown(character, "stormwrought_blood")
        teach_recipe(character, "concentrated_underhill_essence")
        teach_recipe(character, "dream_drainer_catalyst")
        teach_recipe(character, "revenant_effigy")
        teach_if_unknown(character, "bait_abyssal_hunger")
    end))

ccb.runtime.handler("read_vampire_anathema_book", read_book(
    "TALK_READ_VAMPIRE_ANATHEMA_BOOK", "you_know_vampire_anathema_recipe", function(character)
        teach_recipe(character, "anathema_blood_catalyst_unready")
    end))

do
    local item = content.Item {
        id = "vampire_mentor_book",
        name = ccb.content.plural_text("Walking the shadowed path of Blood", "copies of Walking the shadowed path of Blood"),
        description = ccb.content.text("This handwritten book contains a very thorough detailing of all what a vampire needs to reach their full potential.  You already know most of it, but some parts have yet to be read."),
        mass_milligrams = 830000,
        volume_ml = 1320,
        price_cents = 100,
        looks_like = "cookbook",
        symbol = "?",
        color = "dark_gray",
    }
    item:material("paper", 1)
    item:tool()
    item:clear_use_actions()
    item:on_use("read_vampire_mentor_book", ccb.content.text("Activate"), ccb.content.text("Read the book."))
    content.add(item)
end

do
    -- As it is a unique item acquired in violent circumstances, I made it fireproof so the player can use fire without fearing the lost of this item.
    local item = content.Item {
        id = "vampire_anathema_book",
        name = ccb.content.plural_text("old leather-bound journal", "old leather-bound journals"),
        description = ccb.content.text("This handwritten book contains the detailed yet disorganized notes of a vampire who found how to consume other vampires for power.  Reading it might tell you how to do it, if it is what you want."),
        mass_milligrams = 830000,
        volume_ml = 1320,
        price_cents = 100,
        looks_like = "cookbook",
        symbol = "?",
        color = "dark_gray",
    }
    item:material("paper_fireproof", 1)
    item:tool()
    item:clear_use_actions()
    item:on_use("read_vampire_anathema_book", ccb.content.text("Activate"), ccb.content.text("Read the book."))
    content.add(item)
end
