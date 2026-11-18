local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local completion = "finish_druid_shapeshifting_ritual"
local forms = {}

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler(completion, function(payload)
    local character = payload.character
    local form = forms[payload.recipe_id]
    local mutation = id("mutation", form.mutation)
    for _ = 1, payload.batch do
        if not checked(services.mutations.has(character, mutation)) then
            checked(services.mutations.replace(character, mutation))
            if character.subtype ~= "npc" then
                services.messages.add(form.success(), "good")
            end
            checked(services.mutations.invoke_activation(character, mutation, true))
        end
    end
end, 1)

local function register(options)
    forms[options.id] = { mutation = options.mutation, success = options.success }
    content.add(content.Recipe {
        id = options.id,
        name = options.name,
        description = options.description,
        category = "CC_*",
        subcategory = "CSC_*_NESTED",
        skill = "spellcraft",
        difficulty = options.difficulty,
        duration_moves = 60 * 60 * 100,
        activity_level = 10,
        autolearn = false,
        flags = { "SECRET", "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
        scripted_output = true,
    }:book(options.book, options.book_skill)
        :component(options.remains, options.remains_count)
        :component("crystallized_mana", options.crystals)
        :proficiency(options.proficiency, { required = true })
        :on_complete(completion))
end

register {
    id = "druidic_shapeshifting_bear_finalize",
    name = content.text("ritual of the forest king"),
    description = content.text("With your new mastery of transformation, finalize the attunement of the form of the forest king."),
    difficulty = 7,
    remains = "skull_bear",
    remains_count = 1,
    crystals = 50,
    book = "druid_shapeshifting_learn_book_bear",
    book_skill = 7,
    proficiency = "prof_druid_transformation_bear",
    mutation = "DRUID_SHIFTER_BEAR_FORM",
    success = function()
        return services.translate("You've successfully mastered the art of transforming into a bear.")
    end,
}

register {
    id = "druidic_shapeshifting_cougar_finalize",
    name = content.text("ritual of the stalking hunter"),
    description = content.text("With your new mastery of transformation, finalize the attunement of the form of the stalking hunter."),
    difficulty = 6,
    remains = "skull_cougar",
    remains_count = 1,
    crystals = 35,
    book = "druid_shapeshifting_learn_book_cougar",
    book_skill = 6,
    proficiency = "prof_druid_transformation_cougar",
    mutation = "DRUID_SHIFTER_COUGAR_FORM",
    success = function()
        return services.translate("You've successfully mastered the art of transforming into a cougar.")
    end,
}

register {
    id = "druidic_shapeshifting_deer_finalize",
    name = content.text("ritual of the swift runner"),
    description = content.text("With your new mastery of transformation, finalize the attunement of the form of the swift runner."),
    difficulty = 5,
    remains = "skull_cervine",
    remains_count = 1,
    crystals = 25,
    book = "druid_shapeshifting_learn_book_deer",
    book_skill = 5,
    proficiency = "prof_druid_transformation_deer",
    mutation = "DRUID_SHIFTER_DEER_FORM",
    success = function()
        return services.translate("You've successfully mastered the art of transforming into a deer.")
    end,
}

register {
    id = "druidic_shapeshifting_raven_finalize",
    name = content.text("ritual of the soaring wings"),
    description = content.text("With your new mastery of transformation, finalize the attunement of the form of the soaring wings."),
    difficulty = 5,
    remains = "egg_raven",
    remains_count = 6,
    crystals = 40,
    book = "druid_shapeshifting_learn_book_raven",
    book_skill = 7,
    proficiency = "prof_druid_transformation_raven",
    mutation = "DRUID_SHIFTER_RAVEN_FORM",
    success = function()
        return services.translate("You've successfully mastered the art of transforming into a raven.")
    end,
}
