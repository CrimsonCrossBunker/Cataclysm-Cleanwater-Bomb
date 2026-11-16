local ccb = require("ccb")
local services = ccb.services

local function apply_skill_bonus()
    local result = services.effects.add(services.characters.avatar(),
        services.types.id("effect", "skill_status_buff"),
        services.time.duration(1, "turn"), { permanent = true })
    if not result.ok then
        error(result.error.message)
    end
end

ccb.runtime.handler("apply_skill_bonus", apply_skill_bonus, 1)
ccb.runtime.on("game:game_start", "apply_skill_bonus")
ccb.runtime.on("game:game_begin", "apply_skill_bonus")
