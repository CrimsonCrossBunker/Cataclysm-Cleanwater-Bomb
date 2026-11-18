local ccb = require("ccb")
local services = ccb.services
local state = require("portal_storm_state")
local travel = require("dimension_travel")
local environment = services.gameplay.environment
local persistent = ccb.state.world
local id = services.types.id

local function snippet(character, category)
    if character.subtype ~= "avatar" then return end
    local text = services.snippets.native_random(category) or ""
    text = state.checked(services.text.expand_for(text, character, nil, nil, nil, true))
    services.messages.add(text, "neutral")
end

local function weather()
    return services.weather.current().weather.value
end

local function storm(current)
    return current == "distant_portal_storm" or current == "near_portal_storm" or current == "portal_storm"
end

local function occurrence(distant, near)
    local current = weather()
    local selected = (current == "distant_portal_storm" and services.random.native_probability(distant, 10))
        or (current == "near_portal_storm" and services.random.native_probability(near, 10))
        or current == "portal_storm"
    return selected and state.number("portal_dungeon_level") == 0
end

local function lifetime(minimum, maximum)
    return { minimum = services.time.duration(minimum, "turn"), maximum = services.time.duration(maximum, "turn") }
end

local function spawn_message(visible, singular, plural)
    if visible > 1 and plural then
        services.messages.add(services.translate(plural), "bad")
    elseif visible > 0 then
        services.messages.add(services.translate(singular), "bad")
    end
end

local function spawn(character, monster, count, hallucinations, minimum, maximum, min_radius, max_radius, singular, plural)
    local result = state.checked(services.spawns.population(id("monster", monster), state.position(character), {
        count = count, hallucinations = hallucinations, outdoor_only = true,
        min_radius = min_radius, max_radius = max_radius, lifespan = lifetime(minimum, maximum),
    }))
    spawn_message(result.visible, singular, plural)
end

local grass = ccb.content.TerrainTransform { id = "portal_grass_transform" }
grass:terrain { inputs = { "t_grass" }, results = { { "t_grass_alien", 1 } } }
ccb.content.add(grass)
local restored_grass = ccb.content.TerrainTransform { id = "portal_alien_grass_transform" }
restored_grass:terrain { inputs = { "t_grass_alien" }, results = { { "t_grass", 1 } } }
ccb.content.add(restored_grass)

local function grass_change(character)
    state.set("ps_transform_radius", state.number("ps_str") + 5)
    local location = services.world.find_location(state.position(character), nil,
        { min_radius = 1, max_radius = 15, outdoor_only = true })
    if location.found then state.set("grass_transform", location.position) end
    local center = state.point("grass_transform")
    local radius = math.tointeger(math.modf(state.number("ps_transform_radius", 5)))
    services.sound.emit(center, 60, "alert", services.translate("a high-pitched squeal."))
    state.checked(services.world.transform_radius(center, radius, id("terrain_furniture_transform", "portal_grass_transform")))
    local delay = services.time.duration(services.random.native_int(30, 300), "turn")
    state.checked(services.world.transform_radius(center, radius,
        id("terrain_furniture_transform", "portal_alien_grass_transform"), { delay = delay }))
end

local function light(character)
    local day = not environment.is_night()
    local maximum = math.tointeger(math.modf(state.number("ps_str") * 60))
    local duration = services.time.duration(services.random.native_int(60, maximum), "turn")
    state.checked(services.weather.append_light_event(day and 0 or 125, duration))
    if state.checked(services.creatures.snapshot(character)).outside then
        state.message(character, services.translate(day and "The sun is snuffed out like a candle."
            or "Some of the stars grow so bright that they hurt to look at."), "bad")
    end
end

local function people(character)
    local visible = 0
    local origin = state.position(character)
    for _ = 1, 2 do
        local result = services.spawns.npc(id("npc_template", "portal_person"), origin, {
            hallucination = true, outdoor_only = true, min_radius = 3, max_radius = 5,
            lifespan = lifetime(60, 180),
        })
        if result.ok then
            if result.value.visible then visible = visible + 1 end
        elseif result.error.code ~= "blocked" and result.error.code ~= "spawn_rejected"
            and result.error.code ~= "spawn_unavailable" then
            error(result.error.message)
        end
    end
    spawn_message(visible, "A person steps nearby from somewhere else.", "Several identical people walk nearby from nowhere.")
end

local effects = {
    grass_change,
    light,
    function(character)
        spawn(character, "mon_absence", 1, 0, 45, 300, 3, 20,
            "The very notion of empty space is made a cruel joke.  Nearby nothing becomes even less.")
    end,
    function(character)
        spawn(character, "mon_impossible_shape", 1, 1, 60, 180, 3, 20,
            "You cannot remember how the impossible shape came to be here.  The pain in your head suggests that that's a good thing.",
            "You cannot remember how the impossible shapes came to be here.  The pain in your head suggests that that's a good thing.")
    end,
    function(character)
        spawn(character, "mon_flatlander", 1, 1, 60, 180, 3, 20,
            "something glides into your field of vision out of thin air, slipping between the space between atoms.",
            "several things glide into your field of vision out of thin air, slipping between the spaces between atoms.")
    end,
    function(character)
        spawn(character, "mon_memory", 10, 10, 5, 120, 1, 10,
            "A flickering silhouette appears nearby.", "Human silhouettes appear and surround you.")
    end,
    function(character)
        spawn(character, "mon_giant_appendage", 1, 3, 5, 45, 3, 20,
            "A gigantic limb tears its way into reality.", "Gigantic limbs tear their way into reality around you.")
    end,
    people,
}

local timers = {
    {
        handler = "portal_center_dialogue_due", key = "portal_center_dialogue_timer", minimum = 45, maximum = 60,
        awake = function() return weather() == "portal_storm" end,
        eligible = function(character)
            return weather() == "portal_storm" and state.number("portal_dungeon_level") == 0
                and state.checked(services.creatures.snapshot(character)).outside
                and not state.checked(services.inventory.has_worn_flag(character, id("json_flag", "PORTAL_PROOF")))
                and state.number("talked_to_storm") ~= 1 and services.random.native_probability(7, 10)
        end,
        effect = function(character)
            state.checked(services.characters.open_topic(character, "TALK_PORTAL_STORM"))
            state.set("talked_to_storm", 1)
        end,
    },
    {
        handler = "portal_passive_effects_due", key = "portal_passive_effects_timer", minimum = 20, maximum = 55,
        awake = function() return weather() == "portal_storm" end,
        eligible = function() return occurrence(5, 8) end,
        effect = function(character)
            effects[services.random.weighted_index({ 10, 2, 4, 5, 5, 1, 1, 1 })](character)
        end,
    },
    {
        handler = "portal_ire_due", key = "portal_ire_timer", minimum = 5, maximum = 20,
        awake = function() return storm(weather()) end,
        eligible = function(character)
            return occurrence(3, 7) and state.checked(services.creatures.snapshot(character)).outside
                and not state.checked(services.inventory.has_worn_flag(character, id("json_flag", "PORTAL_PROOF")))
        end,
        effect = function(character)
            travel.set(character, "ire", travel.number(character, "ire") + 1)
            snippet(character, "PORTAL_STORM_WITNESSED")
        end,
    },
    {
        handler = "portal_early_messages_due", key = "portal_early_messages_timer", minimum = 60, maximum = 1800,
        awake = function() return weather() == "early_portal_storm" end,
        eligible = function(character)
            return weather() == "early_portal_storm"
                and state.checked(services.characters.snapshot(character, 0)).senses.can_see
                and state.checked(services.creatures.snapshot(character)).outside
                and not state.checked(services.effects.has(character, id("effect", "sleep")))
        end,
        effect = function(character)
            local distance = state.position(character):game_distance(state.point("portal_storm_center"))
            local strength = 3
            if distance >= state.number("portal_storm_distance", 50) then strength = 2 end
            if distance >= state.number("portal_storm_near_distance", 100) then strength = 1 end
            local category = environment.is_night() and "PORTAL_STORM_NIGHT_MESSAGES_" or "PORTAL_STORM_DAY_MESSAGES_"
            snippet(character, category .. strength)
        end,
    },
}

local function schedule(timer)
    ccb.tasks.after_avatar_turn(services.random.native_int(timer.minimum, timer.maximum), timer.handler)
    persistent.set(timer.key, "scheduled")
end

local function wake()
    for _, timer in ipairs(timers) do
        if persistent.get(timer.key) == "dormant" and timer.awake() then schedule(timer) end
    end
end

for _, timer in ipairs(timers) do
    ccb.runtime.handler(timer.handler, function(payload)
        local activated = timer.eligible(payload.character)
        if activated then timer.effect(payload.character) end
        if activated or timer.awake() then schedule(timer) else persistent.set(timer.key, "dormant") end
    end)
end

ccb.runtime.handler("portal_passive_effects_ready", function(event)
    if event.actors.character.subtype ~= "avatar" then return end
    for _, timer in ipairs(timers) do
        if ccb.tasks.has_avatar_turn(timer.handler) then
            persistent.set(timer.key, "scheduled")
        elseif event.new_character then
            schedule(timer)
        else
            persistent.set(timer.key, "dormant")
        end
    end
    wake()
end)
ccb.runtime.on("character_ready", "portal_passive_effects_ready")
ccb.runtime.handler("portal_passive_effects_weather", wake)
ccb.runtime.hook("on_weather_changed", "portal_passive_effects_weather")
ccb.runtime.handler("portal_passive_effects_conditions", function(event)
    if event.actors.character.subtype == "avatar" then wake() end
end)
ccb.runtime.on("character_conditions_changed", "portal_passive_effects_conditions")
