local ccb = require("ccb")
local services = ccb.services

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function intensity(creature, name, body_part)
    local part = body_part and services.types.id("body_part", body_part)
    return checked(services.effects.exact_intensity(creature, services.types.id("effect", name), part))
end

ccb.runtime.handler("allow_uica_imaginifer_police_gun", function(attack)
    return not (intensity(attack.attacker, "afs_weapon_disabled") ~= nil
        or intensity(attack.attacker, "blind") ~= nil)
end)

ccb.runtime.handler("allow_wraitheon_imaginifer_smash", function(attack)
    return intensity(attack.attacker, "afs_android_crawling") == nil
end)

ccb.runtime.handler("monster_attack_armed", function(attack)
    return intensity(attack.attacker, "maimed_arm") == nil
        and intensity(attack.attacker, "disarmed") == nil
end)
