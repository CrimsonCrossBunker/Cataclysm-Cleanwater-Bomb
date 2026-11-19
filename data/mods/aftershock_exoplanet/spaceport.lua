local ccb = require("ccb")
local variables = ccb.services.variables
local discovery_key = "know_spaceport"

ccb.runtime.handler("mark_spaceport_discovered", function()
    local discovery = variables.get_global(discovery_key)
    if not discovery.ok then
        error(discovery.error.message)
    end
    if discovery.value.value == nil then
        local written = variables.set_global(discovery_key, 1, { include_before = false })
        if not written.ok then
            error(written.error.message)
        end
    end
end, 1)
