local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local tasks = ccb.tasks
local state = ccb.state.character

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function add_effect(character, effect_id, turns)
    local result = services.effects.add(character, id("effect", effect_id), services.time.duration_from_turns(turns))
    if not result.ok and result.error.code ~= "rejected" then
        checked(result)
    end
end

ccb.runtime.handler("activate_afs_combat_drug_production", function(context)
    add_effect(context.character, "afs_combat_stims", 10 * 60)
end)

local function activate_rad_response(character, deprivation_cost, message_text, effect_id, duration_turns)
    local sleep_deprivation = checked(services.needs.get(character)).sleep_deprivation
    if sleep_deprivation <= 14400 then
        checked(services.needs.set(character, { sleep_deprivation = sleep_deprivation + deprivation_cost }))
        if character.subtype == "avatar" then
            services.messages.add(services.translate(message_text), "good")
        end
        add_effect(character, effect_id, duration_turns)
    elseif character.subtype == "avatar" then
        services.messages.add(services.translate("You are too exhausted to focus your immune system."), "bad")
    end
end

ccb.runtime.handler("activate_migo_rad_adaption", function(context)
    activate_rad_response(context.character, 15 * 60,
        "You think about activating your immune system and your body warms with exertion.",
        "migo_rad_away", 5 * 60)
end)

ccb.runtime.handler("activate_migo_thresh_rad_flush", function(context)
    activate_rad_response(context.character, 35 * 60,
        "You think quite pointedly about activating your immune system and your body hums with exertion.",
        "migo_rad_flush", 15 * 60)
end)

local fast_blood_trait = id("mutation", "AFS_FAST_BLOOD_PRODUCTION")
local fast_blood_vitamins = { id("vitamin", "blood"), id("vitamin", "redcells") }
local fast_blood_state = "afs_fast_blood_production_state"
local fast_blood_handler = "process_afs_fast_blood_production"
local fast_blood_interval = 5 * 60

local function queue_fast_blood(character)
    tasks.after_character_turn(character, fast_blood_interval, fast_blood_handler)
    state.set(fast_blood_state, "scheduled")
end

ccb.runtime.handler(fast_blood_handler, function(task)
    local character = task.character
    if not checked(services.mutations.has(character, fast_blood_trait)) then
        state.set(fast_blood_state, "dormant")
        return
    end
    for _, vit in ipairs(fast_blood_vitamins) do
        local current = checked(services.needs.get_vitamin(character, vit))
        checked(services.needs.set_vitamin(character, vit, math.min(0, current + 50)))
    end
    queue_fast_blood(character)
end)

ccb.runtime.handler("initialize_afs_fast_blood_production", function(event)
    local character = event.actors.character
    if state.get(fast_blood_state) ~= "dormant" and not tasks.has_character_turn(character, fast_blood_handler) then
        queue_fast_blood(character)
    end
end)
ccb.runtime.on("character_ready", "initialize_afs_fast_blood_production")

ccb.runtime.handler("resume_afs_fast_blood_production", function(event)
    local character = event.actors.character
    if state.get(fast_blood_state) == "dormant" and checked(services.mutations.has(character, fast_blood_trait)) then
        queue_fast_blood(character)
    end
end)
ccb.runtime.on("character_conditions_changed", "resume_afs_fast_blood_production")
