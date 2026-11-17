local ccb = require("ccb")
local services = ccb.services

ccb.runtime.handler("initialize_exodii_reputation", function()
    local avatar = services.characters.avatar()
    local cyborg = services.mutations.has(avatar, services.types.id("mutation", "XEDRA_CYBORG"))
    if not cyborg.ok then
        error(cyborg.error.message)
    end
    if cyborg.value then
        local result = services.factions.set_reputation(services.types.id("faction", "exodii"), {
            likes = -100,
            respects = -100,
            trusts = -100,
        })
        if not result.ok then
            error(result.error.message)
        end
    end
end, 1)
ccb.runtime.on("game:game_begin", "initialize_exodii_reputation")

local starting_recipes = {
    {
        profession = "xe_inventor",
        groups = {
            { "software_math_inventor", "software_electronics_reference_inventor" },
            { "inventor_leg_weight", "inventor_jump_boots" },
            { "inventor_shotgun", "inventor_pistol" },
        },
    },
    {
        profession = "xe_dreamsmith",
        groups = {
            { "forged_dreamstuff_ingot" },
            { "dreamdross_bo", "dreamdross_knife", "dreamdross_club" },
            { "dreamdross_lump", "forged_dreamstuff_ingot" },
        },
    },
}

ccb.runtime.handler("grant_starting_recipes", function(event)
    local character = event.actors.avatar_id or services.characters.avatar()
    for _, entry in ipairs(starting_recipes) do
        local matches = services.characters.has_profession(character, entry.profession)
        if not matches.ok then
            error(matches.error.message)
        end
        if matches.value then
            for _, group in ipairs(entry.groups) do
                local ids = {}
                for index, recipe in ipairs(group) do
                    ids[index] = services.types.id("recipe", recipe)
                end
                local result = services.progression.grant_random_missing(character, "recipe", ids)
                if not result.ok then
                    error(result.error.message)
                end
            end
        end
    end
end, 1)
ccb.runtime.on("game:game_avatar_new", "grant_starting_recipes")

local timers = require("character_timers")
timers.register("inventor_recipe_timer", "inventor_recipe_due",
    function() return services.random.native_int(20 * 3600, 28 * 3600) end,
    function(character)
        local result = services.mutations.has_id_text(character, "INVENTOR")
        if not result.ok then
            error(result.error.message)
        end
        return result.value
    end,
    function(character)
        local recipe = services.types.id("recipe", "inventor_research_base_1")
        local result = services.progression.grant_random_missing(character, "recipe", { recipe })
        if not result.ok then
            error(result.error.message)
        end
    end)
