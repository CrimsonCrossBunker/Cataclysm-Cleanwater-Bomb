local ccb = require("ccb")
local knacks_only = ccb.content.is_mod_active("mom_knacks_only")

-- Keep the global names read by the existing psychic learning actions.
local learning_times = {
    { "insight", 43200, 604800 },
    { "tier_one", 43200, 86400 },
    { "tier_two", 129600, 259200 },
    { "tier_three", 345600, 604800 },
}

local function write_learning_time(key, seconds)
    local result = ccb.services.variables.set_global(key, seconds, { include_before = false })
    if not result.ok then
        error(result.error.message)
    end
end

ccb.runtime.handler("initialize_psychic_learning_times", function()
    for _, tier in ipairs(learning_times) do
        local prefix = "global_" .. tier[1] .. "_power_learning_time_"
        write_learning_time(prefix .. "low", knacks_only and 1 or tier[2])
        write_learning_time(prefix .. "high", knacks_only and 1 or tier[3])
    end
end, 1)

-- Psychic Scream disables skill-based learning again on every entry into play.
ccb.runtime.on(knacks_only and "game:game_begin" or "game:game_start",
    "initialize_psychic_learning_times")
