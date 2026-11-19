local ccb = require("ccb")
local services = ccb.services
local id = services.types.id

local realm_spell_id = "realm_qi_refining"
local realm_trait = id("mutation", "immortal_path_qi_cultivator")
local basic_pill_recipe = id("recipe", "immortal_path_qi_gathering_pill")
local qi_vit = id("vitamin", "qi")

local art_bindings = {
    {
        spell = "immortal_path_meditate_evergreen",
        trait = id("mutation", "immortal_path_body_evergreen"),
        recipe = id("recipe", "immortal_path_evergreen_pill"),
    },
    {
        spell = "immortal_path_meditate_blazing_sun",
        trait = id("mutation", "immortal_path_body_blazing_sun"),
    },
    {
        spell = "immortal_path_meditate_deep_earth",
        trait = id("mutation", "immortal_path_body_deep_earth"),
    },
    {
        spell = "immortal_path_meditate_true_metal",
        trait = id("mutation", "immortal_path_body_true_metal"),
    },
    {
        spell = "immortal_path_meditate_cold_pool",
        trait = id("mutation", "immortal_path_body_cold_pool"),
    },
    {
        spell = "immortal_path_meditate_blood_fiend",
        trait = id("mutation", "immortal_path_body_blood_fiend"),
    },
}

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function knows_spell(character, raw_id)
    return checked(services.spells.effective_level(character, raw_id)) > -1
end

local function has_trait(character, mut_id)
    return checked(services.mutations.has(character, mut_id))
end

local function ensure_realm_trait(character)
    if knows_spell(character, realm_spell_id) and not has_trait(character, realm_trait) then
        checked(services.mutations.replace(character, realm_trait))
    end
end

local function schedule_recurring(name)
    ccb.tasks.after_avatar_turn(services.random.native_int(30, 90), name)
end

ccb.runtime.handler("immortal_path_on_learn_spell", function(event)
    local actor = event.actors.character
    if not actor or not actor:is_valid() then return end

    ensure_realm_trait(actor)

    for _, art in ipairs(art_bindings) do
        if knows_spell(actor, art.spell) and not has_trait(actor, art.trait) then
            checked(services.mutations.replace(actor, art.trait))
            if art.recipe then
                checked(services.recipes.learn(actor, art.recipe))
            end
        end
    end
end)
ccb.runtime.on("game:character_learns_spell", "immortal_path_on_learn_spell")

ccb.runtime.handler("immortal_path_ensure_realm_trait_due", function(payload)
    local avatar = payload.character or services.characters.avatar()
    if avatar and avatar:is_valid() then
        ensure_realm_trait(avatar)
    end
    schedule_recurring("immortal_path_ensure_realm_trait_due")
end)

ccb.runtime.handler("immortal_path_ensure_basic_elixir_recipe_due", function(payload)
    local avatar = payload.character or services.characters.avatar()
    if avatar and avatar:is_valid() and knows_spell(avatar, realm_spell_id)
        and not checked(services.recipes.knows(avatar, basic_pill_recipe)) then
        checked(services.recipes.learn(avatar, basic_pill_recipe))
    end
    schedule_recurring("immortal_path_ensure_basic_elixir_recipe_due")
end)

ccb.runtime.handler("immortal_path_qi_clamp_due", function(payload)
    local avatar = payload.character or services.characters.avatar()
    if avatar and avatar:is_valid() then
        local cap = checked(services.characters.enchantment_value(avatar, "qi_max", 100))
        local current = checked(services.needs.get_vitamin(avatar, qi_vit))
        if current > cap then
            checked(services.needs.set_vitamin(avatar, qi_vit, math.modf(cap)))
        end
    end
    schedule_recurring("immortal_path_qi_clamp_due")
end)

local recurring_tasks = {
    "immortal_path_ensure_realm_trait_due",
    "immortal_path_ensure_basic_elixir_recipe_due",
    "immortal_path_qi_clamp_due",
}

ccb.runtime.handler("immortal_path_cultivation_ready", function(event)
    if event.actors.character.subtype ~= "avatar" then return end
    for _, task_name in ipairs(recurring_tasks) do
        if not ccb.tasks.has_avatar_turn(task_name) then
            schedule_recurring(task_name)
        end
    end
end)
ccb.runtime.on("character_ready", "immortal_path_cultivation_ready")
