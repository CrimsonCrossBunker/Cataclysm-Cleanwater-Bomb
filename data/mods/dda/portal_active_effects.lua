local ccb = require("ccb")
local services = ccb.services
local state = require("portal_storm_state")
local travel = require("dimension_travel")
local environment = services.gameplay.environment
local persistent = ccb.state.world
local id = services.types.id

local function portal_proof(character)
    return not state.checked(services.inventory.has_worn_flag(character, id("json_flag", "PORTAL_PROOF")))
end

local function outside(character)
    return state.checked(services.creatures.snapshot(character)).outside
end

local function sleeping(character)
    return state.checked(services.effects.has(character, id("effect", "sleep")))
end

local function driving(character)
    return state.checked(services.characters.snapshot(character, 0)).movement.driving
end

local function ire(character, change)
    travel.set(character, "ire", travel.number(character, "ire") + change)
end

local function snippet(character, category)
    if character.subtype ~= "avatar" then return end
    local text = services.snippets.native_random(category) or ""
    text = state.checked(services.text.expand_for(text, character, nil, nil, nil, true))
    services.messages.add(text, "neutral")
end

local function message(character)
    if not state.checked(services.characters.snapshot(character, 0)).senses.can_see or not portal_proof(character) then return end
    local distance = state.position(character):game_distance(state.point("portal_storm_center"))
    local strength = 3
    if distance >= state.number("portal_storm_distance", 50) then strength = 2 end
    if distance >= state.number("portal_storm_near_distance", 100) then strength = 1 end
    if outside(character) then
        snippet(character, "PORTAL_STORM_MESSAGES_" .. strength)
    elseif services.random.weighted_index({ 1, 1 }) == 1 then
        if portal_proof(character) and not sleeping(character) and services.random.native_probability(1, 30) then
            snippet(character, "PORTAL_STORM_INDOOR_MESSAGES_" .. strength)
        end
    elseif not sleeping(character) and (strength == 2 or services.random.native_probability(1, 30)) then
        snippet(character, "PORTAL_STORM_VOICES_" .. strength)
    end
end

local function sound(position, volume, category, description)
    services.sound.emit(position, volume, category, services.translate(description))
end

local function stuck(character)
    if driving(character) or not portal_proof(character) or state.number("portal_dungeon_level") ~= 0 then return end
    local point = state.checked(services.variables.get_tripoint(character, "stuck_teleport")).value
        or services.coords.tripoint_abs_ms(0, 0, 0)
    local result = state.checked(services.relocation.teleport_character(character, point))
    if result.accepted then
        state.message(character, services.translate("You feel an intense sense of deja vu."))
    end
    ccb.tasks.after_character_turn(character, services.random.native_int(3, 5), "portal_stuck_loop_due")
end

ccb.runtime.handler("portal_stuck_loop_due", function(payload)
    local character = payload.character
    if services.random.native_probability(3, 4) and not driving(character) then
        stuck(character)
    else
        local point = state.checked(services.variables.get_tripoint(character, "stuck_teleport")).value
            or services.coords.tripoint_abs_ms(0, 0, 0)
        sound(point, 80, "alert", "a loud tearing sound.")
    end
end)

local function population(character, monster, options, singular, plural)
    local result = state.checked(services.spawns.population(id("monster", monster), state.position(character), options))
    if result.visible > 1 and plural and plural ~= "" then
        services.messages.add(plural, "bad")
    elseif result.visible > 0 and singular and singular ~= "" then
        services.messages.add(singular, "bad")
    end
end

local function lifespan(minimum, maximum)
    return { minimum = services.time.duration(minimum, "turn"), maximum = services.time.duration(maximum, "turn") }
end

local actions = {}

function actions.stuck_start(character)
    if not portal_proof(character) or driving(character) then return end
    local anchor = services.world.find_location(state.position(character), nil, { min_radius = 0, max_radius = 0 })
    if anchor.found then travel.set(character, "stuck_teleport", anchor.position) end
    stuck(character)
    state.message(character, services.translate("The moment feels thick, as if it's not quite over."), "bad")
    ire(character, -2)
end

function actions.pain(character)
    if not outside(character) or not portal_proof(character) then return end
    state.message(character, services.translate("You awake with a start from what must have been a violent and horrifying daydream.  Your body aches as if the wounds were real."), "bad")
    state.checked(services.needs.modify_raw_pain(character, 10))
    environment.add_field_area(state.position(character), "fd_blood", { radius = 2 })
    ire(character, -3)
end

function actions.dimension(character)
    if not travel.can_leave(character) then return end
    local string = state.checked(services.inventory.has_items(character, id("item", "inert_glowing_string"), 1, 0))
    local church = false
    if not string then
        for _, terrain in ipairs {
            "xedra_rural_church_parking", "xedra_rural_church", "xedra_rural_church_steeple",
            "xedra_rural_church_steeple_roof", "xedra_rural_church_basement",
        } do
            if travel.at(character, terrain) then church = true; break end
        end
        if not church then
            church = services.overmap.matches_location_near(state.position(character):project_to("omt"), "xedra_rural_church", 2)
        end
    end
    if string or church then
        travel.string_dimension(character)
    elseif environment.terrain_has_flag(state.position(character), "SHALLOW_WATER") then
        travel.highlands(character)
    else
        travel.reverberation(character)
    end
end

function actions.hallucinator(character)
    if sleeping(character) and not portal_proof(character) then return end
    population(character, "mon_hallucinator", {
        count = 1, outdoor_only = true, min_radius = 40, max_radius = 50, lifespan = lifespan(720, 900),
    })
    ire(character, -4)
end

function actions.smoke(character)
    state.message(character, services.translate("A million tiny pinpricks in space open for an instant, and smoke fills the air."), "bad")
    environment.add_field_area(state.position(character), "fd_smoke", { radius = 150, outdoor_only = true })
    ire(character, -1)
end

function actions.yrax(character)
    if outside(character)
        and state.checked(services.variables.get_string(character, "general_yrax_u_met_apeirohedra")).value == "yes"
        and services.random.native_int(0, 399) == 0 then
        state.message(character, services.translate("An alien construct emerges from the storm."))
        population(character, "mon_yrax_quadraphract", { count = 1, min_radius = 10, max_radius = 15 })
    end
end

function actions.swarm(character)
    population(character, "mon_swarm_structure", {
        count = 1, outdoor_only = true, min_radius = 3, max_radius = 20, lifespan = lifespan(600, 1800),
    }, services.translate("The swarm structure was always here, right?"))
    ire(character, -4)
end

function actions.taunt(character)
    snippet(character, "PORTAL_STORM_VOICES_DRAW_ATTENTION")
    sound(state.position(character), 20, "combat", "The voice was loud, it might have drawn attention to you!")
end

function actions.shifting_mass(character)
    local count = math.tointeger(math.modf(math.max(state.number("ps_str") / 2, 1)))
    population(character, "mon_shifting_mass", {
        count = count, hallucinations = count, outdoor_only = true,
        min_radius = 3, max_radius = 20, lifespan = lifespan(5, 120),
    }, services.translate("Small gashes in reality open nearby, revealing an endless expanse of black water.  An alien being spills through before the portals close."),
        services.translate("Small gashes in reality open nearby, revealing an endless expanse of black water.  Several alien beings spill out before the portals close."))
end

function actions.artifact(character)
    if not outside(character) or not portal_proof(character) then return end
    local monster, singular, plural
    if state.number("ps_str") < 2 then
        monster = "mon_archunk_weak"
        singular, plural = services.translate("A chunk of reality gets loose and falls on the ground."), services.translate("Chunks of reality get loose and fall on the ground.")
    elseif state.number("ps_str") < 5 then
        monster = "mon_archunk_medium"
        singular, plural = services.translate("Reality twists and deforms as a wriggling chunk of it falls on the ground."), services.translate("Reality twists and deforms as wriggling chunks of it fall on the ground.")
    else
        monster = "mon_archunk_strong"
        singular, plural = services.translate("A chunk of reality tears itself asunder and takes shape on the ground."), services.translate("Chunks of reality tear themselves asunder and take shape on the ground.")
    end
    population(character, monster, {
        count = 1, hallucinations = 1, outdoor_only = true, min_radius = 3, max_radius = 20,
        lifespan = lifespan(420, 600), temporary_drop_items = true,
    }, singular, plural)
end

for name, action in pairs(actions) do ccb.runtime.handler("portal_active_" .. name, action) end

ccb.runtime.handler("portal_active_choose", function(character)
    local names = { "stuck_start", "pain", "dimension", "hallucinator", "smoke", "yrax", "swarm", "taunt", "shifting_mass", "artifact" }
    local choice = services.random.weighted_index({ 2, 2, 1, 2, 2, 1, 2, 1, 1, 1 })
    actions[names[choice]](character)
end)

local function weather()
    return services.weather.current().weather.value
end

local function schedule()
    ccb.tasks.after_avatar_turn(services.random.native_int(20, 50), "portal_active_effects_due")
    persistent.set("portal_active_effects_timer", "scheduled")
end

local function wake()
    if persistent.get("portal_active_effects_timer") == "dormant" and weather() == "portal_storm" then schedule() end
end

ccb.runtime.handler("portal_active_effects_due", function(payload)
    local character = payload.character
    local current = weather()
    local eligible = (current == "distant_portal_storm" and services.random.native_probability(5, 10))
        or (current == "near_portal_storm" and services.random.native_probability(7, 10))
        or current == "portal_storm"
    local activated = eligible and state.number("portal_dungeon_level") == 0 and travel.number(character, "ire") > 0
    if activated then
        message(character)
        ccb.runtime.call_character("portal_active_choose", character)
    end
    if activated or weather() == "portal_storm" then
        schedule()
    else
        persistent.set("portal_active_effects_timer", "dormant")
    end
end)

ccb.runtime.handler("portal_active_effects_ready", function(event)
    if event.actors.character.subtype ~= "avatar" then return end
    if ccb.tasks.has_avatar_turn("portal_active_effects_due") then
        persistent.set("portal_active_effects_timer", "scheduled")
    elseif event.new_character then
        schedule()
    else
        persistent.set("portal_active_effects_timer", "dormant")
        wake()
    end
end)
ccb.runtime.on("character_ready", "portal_active_effects_ready")

ccb.runtime.handler("portal_active_effects_weather", wake)
ccb.runtime.hook("on_weather_changed", "portal_active_effects_weather")
ccb.runtime.handler("portal_active_effects_conditions", function(event)
    if event.actors.character.subtype == "avatar" then wake() end
end)
ccb.runtime.on("character_conditions_changed", "portal_active_effects_conditions")
