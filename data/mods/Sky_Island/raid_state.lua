local ccb = require("ccb")
local services = ccb.services
local variables = services.variables
local id = services.types.id
local M = {}

function M.checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

function M.number(key, fallback)
    local value = M.checked(variables.get_global_number(key)).value
    if value ~= nil then return value end
    return fallback or 0
end

function M.string(key)
    return M.checked(variables.get_global_string(key)).value or ""
end

function M.set(key, value)
    M.checked(variables.set_global(key, value, { include_before = false }))
end

function M.copy(source, destination)
    M.checked(variables.copy(nil, source, nil, destination))
end

function M.point(key)
    return M.checked(variables.get_global_tripoint(key)).value
        or services.coords.tripoint_abs_ms(0, 0, 0)
end

function M.position(character)
    return M.checked(services.creatures.snapshot(character)).position
end

function M.has_trait(character, trait)
    return M.checked(services.mutations.has_id_text(character, trait))
end

function M.add_trait(character, trait)
    M.checked(services.mutations.replace(character, id("mutation", trait)))
end

function M.add_effect(character, effect, turns, intensity, permanent)
    M.checked(services.effects.add(character, id("effect", effect),
        services.time.duration(math.tointeger(math.modf(turns)), "turn"),
        { intensity = intensity or 0, permanent = permanent or false }))
end

function M.text(character, text)
    return M.checked(services.text.expand_for(text, character))
end

function M.message(character, text, severity, popup)
    if M.checked(services.creatures.snapshot(character)).kind ~= "avatar" then return end
    text = M.text(character, text)
    if popup then
        ccb.presentation.notice(text)
        services.activities.offer_interruption("")
    end
    services.messages.add(text, severity or "neutral")
end

function M.assign_mission(character, name)
    local mission = M.checked(services.missions.reserve(id("mission", name)))
    M.checked(services.missions.assign(character, mission.token))
end

function M.find_location(character, terrain, match, options, reveal, local_terrain)
    local character_position = M.position(character)
    local selector = { terrain = terrain }
    if match then selector.match = services.enums.value("OtMatchType", match) end
    local target = services.overmap.find_target(character_position:project_to("omt"),
        selector, options)
    services.overmap.reveal_native(target, math.tointeger(math.modf(reveal)))
    local local_selector = local_terrain and { kind = "terrain", id = id("terrain", local_terrain) }
    local location = services.world.find_location(target:project_to("ms"), local_selector,
        local_terrain and { target_max_radius = 20, distance_origin = character_position } or nil)
    if location.found then M.set("OM_missionspot", location.position) end
end

function M.teleport(character, point, success, failure)
    local result = M.checked(services.relocation.teleport_character(character, point,
        { force_safe = true }))
    local message = result.accepted and success or failure
    if message then M.message(character, message) end
end

function M.nearby_npcs(character)
    local center = M.position(character)
    local result = {}
    for _, npc in ipairs(M.checked(services.npcs.loaded())) do
        if npc.position.z == center.z and center:game_distance(npc.position) <= 10 then
            result[#result + 1] = npc.handle
        end
    end
    return result
end

function M.teleport_followers(character, variable)
    for _, npc in ipairs(M.nearby_npcs(character)) do
        if M.checked(services.npcs.get(npc)).following then
            local point = M.point(variable)
            point = services.coords.tripoint_abs_ms(
                point.x + services.random.native_int(-2, 2),
                point.y + services.random.native_int(-2, 2), point.z)
            M.set(variable, point)
            M.teleport(npc, point, ccb.services.translate("Your followers teleport with you."),
                ccb.services.translate("It seems some of your followers couldn't teleport with you."))
        end
    end
end

return M
