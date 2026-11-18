local ccb = require("ccb")
local services = ccb.services
local state = require("portal_storm_state")
local travel = require("dimension_travel")
local environment = services.gameplay.environment
local id = services.types.id

local function snippet(character, item, category, position)
    if not character or character.subtype ~= "avatar" then return end
    local text = services.snippets.native_random(category) or ""
    local context = { id = "mp3_on_reverberation", loc = position }
    text = state.checked(services.text.expand_for(text, character, item, nil, context, true))
    services.messages.add(text, "info")
end

local function morale(character, bonus, maximum)
    if character then
        state.checked(services.needs.add_morale(character, id("morale", "morale_music"), bonus,
            { maximum_bonus = maximum }))
    end
end

local function stop(item, character)
    return state.checked(services.items.transform(item, id("item", "mp3_reverberation"),
        { carrier = character, active = false })).handle
end

local function has_string(character)
    return state.checked(services.inventory.has_items(character, id("item", "inert_glowing_string"), 1, 0))
end

local function shallow_water(character)
    return environment.terrain_has_flag(state.position(character), "SHALLOW_WATER")
end

local function scarlet_storm()
    local weather = services.weather.current().weather.value
    return weather == "scarlet_storm_4" or weather == "scarlet_storm_5"
end

local function listener(character, item, position)
    local dimension = environment.dimension()
    if dimension == "radiosphere" then
        snippet(character, item, "mp3_reverberation_listener_radiosphere", position)
    elseif dimension == "cabins" then
        snippet(character, item, "mp3_reverberation_listener_cabins", position)
    end
end

local function locate(character, item, position)
    local warm_up = travel.number(item, "warm_up") - 1
    travel.set(item, "warm_up", warm_up)
    if warm_up <= 0 then
        travel.notice(character, services.translate("Its song drowns out the world."))
        item = stop(item, character)
        travel.set(item, "cooldown", services.time.now().turn + 86400 + 28800 * services.random.native_int(0, 4))
        if travel.reverberation_entry(character) then
            ccb.tasks.after_character_turn(character, 2, "portal_reverberation_enter_due")
        elseif scarlet_storm() then
            travel.scarlet(character)
        elseif shallow_water(character) then
            travel.highlands(character)
        elseif has_string(character) then
            travel.string_dimension(character)
        end
    elseif warm_up <= 3 then
        snippet(character, item, "<mp3_reverberation_locator_almost_there>", position)
        morale(character, 60, 40)
    elseif warm_up <= 6 then
        snippet(character, item, "<mp3_reverberation_locator_close>", position)
        morale(character, 40, 20)
    elseif warm_up < 10 then
        snippet(character, item, "<mp3_reverberation_locator_distant>", position)
    end
    return item
end

local function ping(character, item)
    if not character then return stop(item) end
    local position = state.position(character)
    local dimension = environment.dimension()
    if travel.reverberation_entry(character) or scarlet_storm()
        or (dimension ~= "string_dimension" and has_string(character))
        or (dimension ~= "highlands" and shallow_water(character)) then
        if travel.number(item, "cooldown") < services.time.now().turn then
            return locate(character, item, position)
        end
        snippet(character, item, "<mp3_reverberation_locator_cooldown>", position)
    else
        listener(character, item, position)
        travel.set(item, "warm_up", 10)
    end
    return item
end

ccb.runtime.handler("anomalous_mp3_tick", function(context)
    local character, item = context.character, context.item
    if services.random.native_int(0, 499) == 0 then snippet(character, item, "<anomalous_mp3_player_ambient_music>") end
    morale(character, 5, 5)
    local stored = state.checked(services.variables.get(item, "mp3_timer"))
    if stored.value ~= nil then
        local timer = travel.number(item, "mp3_timer")
        if timer < 0 then
            item = ping(character, item)
            travel.set(item, "mp3_timer", services.random.native_int(0, 10) + 10)
        else
            travel.set(item, "mp3_timer", timer - 1)
        end
    else
        travel.set(item, "mp3_timer", services.random.native_int(0, 10) + 10)
    end
    return 0
end)

local player = ccb.content.Item { id = "mp3_on_reverberation", copy_from = "mp3_on_reverberation" }
player:clear_tick_actions()
player:on_tick("anomalous_mp3_tick")
ccb.content.replace(player)
