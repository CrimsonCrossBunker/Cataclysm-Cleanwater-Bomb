local ccb = require("ccb")
local services = ccb.services

local function rune(handler, monster, count)
    ccb.runtime.handler(handler, function(hit)
        if not hit.creature then return true end
        local actor = services.creatures.snapshot(hit.creature)
        if not actor.ok then error(actor.error.message) end
        local result = services.spawns.population(services.types.id("monster", monster), actor.value.position,
            { min_radius = 1, max_radius = 1, count = count })
        if not result.ok then error(result.error.message) end
        return false
    end)
end

rune("summon_blades_trap", "mon_animated_blade_feral", function()
    return services.random.native_int(1, 2)
end)
rune("summon_krabgek_trap", "mon_krabgek", 1)
