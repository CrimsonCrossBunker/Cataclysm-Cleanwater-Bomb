local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local variables = services.variables
local coords = services.coords
local M = {}

function M.checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

function M.number(key, fallback)
    local value = M.checked(variables.get_global_number(key))
    if value.value ~= nil then return value.value end
    return fallback or 0
end

function M.set(key, value)
    M.checked(variables.set_global(key, value, { include_before = false }))
end

function M.point(key)
    return M.checked(variables.get_global_tripoint(key)).value
        or coords.tripoint_abs_ms(0, 0, 0)
end

function M.position(character)
    return M.checked(services.creatures.snapshot(character)).position
end

function M.message(character, text, severity, popup)
    if M.checked(services.creatures.snapshot(character)).kind ~= "avatar" then return end
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

function M.remove_mission(character, name)
    local offset = 0
    repeat
        local page = services.missions.active(character, { offset = offset, limit = 256 })
        for _, mission in ipairs(page.items) do
            if mission.id.value == name then
                M.checked(services.missions.abandon(character, mission.token))
                return
            end
        end
        offset = offset + page.returned
    until not page.has_more
end

function M.update_map(position, name)
    local target = M.checked(services.overmap.tile_token(position:project_to("omt")))
    local update = M.checked(services.mapgen.update_token(id("update_mapgen", name)))
    M.checked(services.mapgen.run_update(target, update))
end

function M.add_effect(character, effect, turns, intensity)
    local duration = services.time.duration(math.modf(turns), "turn")
    M.checked(services.effects.add(character, id("effect", effect), duration,
        { intensity = intensity or 0 }))
end

return M
